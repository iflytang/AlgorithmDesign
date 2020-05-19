-- @brief INT dissector plugin
-- @author tsf
-- @date 2020-05-18
-- @version lua5.3
-- @description: 1. vim /usr/share/wireshark/init.lua
--               2. disable_lua=false
--               3. dofile("~/INT_PKT.lua")
--               4. use 'wireshark' cli to start wireshark, if there's problem, following below commands and restart:
--                  root@IPL230:~$ setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
--                  root@IPL230:~$ getcap /usr/bin/dumpcap  

-- create a new dissector
do

    -- supported mapInfo
    local CPU_BASED_MAPINFO = 0x02ff            -- ovs-pof
    local NP_BASED_MAPINFO = 0x031f             -- Tofino

    -- INT header byte {offset, length}
    local INT_h_base = 34           -- INT header base
    local INT_h_len = 5             -- type (2B) + len (1B) + mapInfo (2B)

    local INT_h_type_len = 2
    local INT_h_len_len = 1
    local INT_h_mapInfo_len = 2

    -- INT data byte {offset, length}
    local INT_d_dpid_len = 4
    local INT_d_in_port_len = 4
    local INT_d_out_port_len = 4
    local INT_d_ingress_time_len = 8
    local INT_d_hop_latency_len = 4
    local INT_d_bandwidth_len = 4
    local INT_d_n_packets_len = 8
    local INT_d_n_bytes_len = 8
    local INT_d_queue_len = 4
    local INT_d_fwd_acts_len = 4

    -- INT type value
    local INT_type_val = 0x0908

    -- register protocol
    local proto_name = "INT"
    local proto_desc = "INT Protocol"
    local INT_proto = Proto(proto_name, proto_desc)

    -- define proto fields
    local int_h_type = ProtoField.bytes("INT.int_type", "int_type", base.HEX)
    local int_h_len = ProtoField.bytes("INT.int_ttl", "int_ttl", base.DEC)
    local int_h_mapInfo = ProtoField.bytes("INT.mapInfo", "mapInfo", base.HEX)
    local int_d_dpid = ProtoField.bytes("INT.device_id", "device_id", base.HEX)
    local int_d_in_port = ProtoField.bytes("INT.in_port", "in_port", base.DEC)
    local int_d_out_port = ProtoField.bytes("INT.out_port", "out_port", base.DEC)
    local int_d_ingress_time = ProtoField.bytes("INT.ingress_time", "ingress_time", base.DEC)
    local int_d_hop_latency = ProtoField.bytes("INT.hop_latency", "hop_latency", base.DEC)
    local int_d_bandwidth = ProtoField.bytes("INT.bandwidth", "bandwidth", base.DEC)
    local int_d_n_packets = ProtoField.bytes("INT.n_packets", "n_packets", base.DEC)
    local int_d_n_bytes = ProtoField.bytes("INT.n_bytes", "n_bytes", base.DEC)
    local int_d_queue = ProtoField.bytes("INT.queue", "queue", base.DEC)        -- not supported by ovs-pof
    local int_d_fwd_acts = ProtoField.bytes("INT.fwd_acts", "fwd_acts", base.HEX)

    -- proto fields
    INT_proto.fields = {
        int_h_type,
        int_h_len,
        int_h_mapInfo,
        int_d_dpid,
        int_d_in_port,
        int_d_out_port,
        int_d_ingress_time,
        int_d_hop_latency,
        int_d_bandwidth,
        int_d_n_packets,
        int_d_n_bytes,
        int_d_queue,           -- not supported by ovs-pof
        int_d_fwd_acts
    }

    local data_dis = Dissector.get("data")

    local function dissector(buf, pkt, root)
        local base = INT_h_base
        local bit_one = 0x01
        local switch_mask = 0xff000000

        local t = root:add(INT_proto, buf)
        t:set_text(proto_desc)

        local v_int_h_type = buf(base, INT_h_type_len)    -- buf(off, len)
        base = base + INT_h_type_len

        -- check int type
        if v_int_h_type ~= INT_type_val then
            return false
        end
        t:add(int_h_type, v_int_h_type)

        pkt.cols.protocol:set(proto_name)
        pkt.cols.info:set("INT Packet")

        local v_int_h_len = buf(base, INT_h_len_len)
        t:add(int_h_len, v_int_h_len)
        base = base + INT_h_len_len

        local v_int_h_mapInfo = buf(base, INT_h_mapInfo_len)
        t:add(int_h_mapInfo, v_int_h_mapInfo)
        base = base + INT_h_mapInfo_len

        if (v_int_h_mapInfo & bit_one) then      -- must contain device_id
            local v_int_d_dpid = buf(base, INT_d_dpid_len)
            t:add(int_d_dpid, v_int_d_dpid)
            base = base + INT_d_dpid_len
        else
            return false
        end

        local hop = v_int_h_len:uint()
        t:set_text("Hop " .. hop)

        -- ovs-pof and tofino, distinguished by device_id
        if (v_int_d_dpid & switch_mask == 0x00) then   -- ovs-pof
            local switch_mapInfo = v_int_h_mapInfo & CPU_BASED_MAPINFO

            if (switch_mapInfo & (bit_one << 1)) then
                local v_int_d_in_port = buf(base, INT_d_in_port_len)
                t:add(int_d_in_port, v_int_d_in_port)
                base = base + INT_d_in_port_len
            end

            if (switch_mapInfo & (bit_one << 2)) then
                local v_int_d_out_port = buf(base, INT_d_out_port_len)
                t:add(int_d_out_port, v_int_d_out_port)
                base = base + INT_d_out_port_len
            end

            if (switch_mapInfo & (bit_one << 3)) then
                local v_int_d_ingress_time = buf(base, INT_d_ingress_time_len)
                t:add(int_d_ingress_time, v_int_d_ingress_time)
                base = base + INT_d_ingress_time_len
            end

            if (switch_mapInfo & (bit_one << 4)) then
                local v_int_d_hop_latency = buf(base, INT_d_hop_latency_len)
                t:add(int_d_hop_latency, v_int_d_hop_latency)
                base = base + INT_d_hop_latency_len
            end

            if (switch_mapInfo & (bit_one << 5)) then
                local v_int_d_bandwidth = buf(base, INT_d_bandwidth_len)
                t:add(int_d_bandwidth, v_int_d_bandwidth)
                base = base + INT_d_bandwidth_len
            end

            if (switch_mapInfo & (bit_one << 6)) then
                local v_int_d_n_packets = buf(base, INT_d_n_packets_len)
                t:add(int_d_n_packets, v_int_d_n_packets)
                base = base + INT_d_n_packets_len
            end

            if (switch_mapInfo & (bit_one << 7)) then
                local v_int_d_n_bytes = buf(base, INT_d_n_bytes_len)
                t:add(int_d_n_bytes, v_int_d_n_bytes)
                base = base + INT_d_n_bytes_len
            end

            if (switch_mapInfo & (bit_one << 8)) then    -- not supported by ovs-pof
                local v_int_d_queue = buf(base, INT_d_queue_len)
                t:add(int_d_queue, v_int_d_queue)
                base = base + INT_d_queue_len
            end

            if (switch_mapInfo & (bit_one << 9)) then
                local v_int_d_fwd_acts = buf(base, INT_d_fwd_acts_len)
                t:add(int_d_fwd_acts, v_int_d_fwd_acts)
                base = base + INT_d_fwd_acts_len
            end
        else                                         -- tofino
            local switch_mapInfo = v_int_h_mapInfo & NP_BASED_MAPINFO

            if (switch_mapInfo & (bit_one << 1)) then
                local v_int_d_in_port = buf(base, INT_d_in_port_len)
                t:add(int_d_in_port, v_int_d_in_port)
                base = base + INT_d_in_port_len
            end

            if (switch_mapInfo & (bit_one << 2)) then
                local v_int_d_out_port = buf(base, INT_d_out_port_len)
                t:add(int_d_out_port, v_int_d_out_port)
                base = base + INT_d_out_port_len
            end

            if (switch_mapInfo & (bit_one << 3)) then
                local v_int_d_ingress_time = buf(base, INT_d_ingress_time_len)
                t:add(int_d_ingress_time, v_int_d_ingress_time)
                base = base + INT_d_ingress_time_len
            end

            if (switch_mapInfo & (bit_one << 4)) then
                local v_int_d_hop_latency = buf(base, INT_d_hop_latency_len)
                t:add(int_d_hop_latency, v_int_d_hop_latency)
                base = base + INT_d_hop_latency_len
            end

            if (switch_mapInfo & (bit_one << 5)) then
                local v_int_d_bandwidth = buf(base, INT_d_bandwidth_len)
                t:add(int_d_bandwidth, v_int_d_bandwidth)
                base = base + INT_d_bandwidth_len
            end

            if (switch_mapInfo & (bit_one << 6)) then
                local v_int_d_n_packets = buf(base, INT_d_n_packets_len)
                t:add(int_d_n_packets, v_int_d_n_packets)
                base = base + INT_d_n_packets_len
            end

            if (switch_mapInfo & (bit_one << 7)) then
                local v_int_d_n_bytes = buf(base, INT_d_n_bytes_len)
                t:add(int_d_n_bytes, v_int_d_n_bytes)
                base = base + INT_d_n_bytes_len
            end

            if (switch_mapInfo & (bit_one << 8)) then    -- not supported by ovs-pof
                local v_int_d_queue = buf(base, INT_d_queue_len)
                t:add(int_d_queue, v_int_d_queue)
                base = base + INT_d_queue_len
            end

            if (switch_mapInfo & (bit_one << 9)) then
                local v_int_d_fwd_acts = buf(base, INT_d_fwd_acts_len)
                t:add(int_d_fwd_acts, v_int_d_fwd_acts)
                base = base + INT_d_fwd_acts_len
            end

        end
    end

    function INT.dissector(buf, pkt, root)
        if dissector(buf, pkt, root) then
            --do nothing
        else
            data_dis:call(buf, pkt, root)
        end

    end

    -- register this dissector
    DissectorTable.get("ethertype"):add("0x0800", INT)
end