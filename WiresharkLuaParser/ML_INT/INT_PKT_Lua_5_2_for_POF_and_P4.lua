-- @brief INT dissector plugin
-- @author tsf
-- @date 2020-05-18
-- @version lua5.2
-- @description: 1. vim /usr/share/wireshark/init.lua
--               2. disable_lua=false
--               3. dofile("Your_Directory/INT_PKT_Lua_5_2.lua")
--               4. use 'wireshark' cli to start wireshark, if there's problem, following below commands and restart:
--                  root@IPL230:~$ setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
--                  root@IPL230:~$ getcap /usr/bin/dumpcap

require "bit32"     -- bit operation

-- create a new dissector
do

    -- supported mapInfo
    local CPU_BASED_MAPINFO = 0x02ff            -- ovs-pof
    local NP_BASED_MAPINFO = 0x031f             -- Tofino

    -- INT header byte {offset, length}
    local INT_h_base = 34-14           -- INT header base
    local INT_h_len = 5             -- type (2B) + len (1B) + mapInfo (2B)

    local INT_h_type_len = 2
    local INT_h_len_len = 1
    local INT_h_mapInfo_len = 2

    -- INT data byte {offset, length}
    local INT_d_dpid_len = 4
    local INT_d_in_port_len = 4
    local INT_d_out_port_len = 4
    local INT_d_ingress_time_len = 8
    local INT_d_ingress_time_tofino_len = 4
    local INT_d_hop_latency_len = 4
    local INT_d_hop_latency_tofino_len = 2
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
    local int_h_type = ProtoField.uint16("INT.int_type", "int_type", base.HEX)
    local int_h_len = ProtoField.uint8("INT.int_ttl", "int_ttl", base.DEC)
    local int_h_mapInfo = ProtoField.uint16("INT.mapInfo", "mapInfo", base.HEX)

    local int_h_hop = ProtoField.uint8("INT.Hop", "Hop", base.DEC)

    local int_d_dpid = ProtoField.uint32("INT.device_id", "device_id", base.HEX)
    local int_d_dpid_ovs_pof = ProtoField.uint32("INT.device_id", "device_id (ovs-pof)", base.HEX)
    local int_d_dpid_tofino = ProtoField.uint32("INT.device_id", "device_id (tofino)", base.HEX)

    local int_d_in_port = ProtoField.uint32("INT.in_port", "in_port", base.DEC)
    local int_d_out_port = ProtoField.uint32("INT.out_port", "out_port", base.DEC)

    --local int_d_ingress_time = ProtoField.uint64("INT.ingress_time", "ingress_time", base.HEX)
    local int_d_ingress_time = ProtoField.uint64("INT.ingress_time", "ingress_time (us)", base.HEX)
    local int_d_ingress_time_tofino_hign = ProtoField.uint32("INT.ingress_time_high", "ingress_time_high", base.HEX)
    local int_d_ingress_time_tofino_low = ProtoField.uint32("INT.ingress_time", "ingress_time", base.HEX)

    local int_d_hop_latency = ProtoField.uint32("INT.hop_latency", "hop_latency", base.DEC)
    local int_d_hop_latency_ovs_pof = ProtoField.uint32("INT.hop_latency", "hop_latency (us)", base.DEC)
    local int_d_hop_latency_tofino_high = ProtoField.uint16("INT.hop_latency_high", "hop_latency_high (ns)", base.DEC)
    local int_d_hop_latency_tofino_low = ProtoField.uint16("INT.hop_latency", "hop_latency (ns)", base.DEC)

    local int_d_bandwidth = ProtoField.float("INT.bandwidth", "bandwidth (Mbps)", base.FLOAT)
    local int_d_n_packets = ProtoField.uint64("INT.n_packets", "n_packets", base.DEC)
    local int_d_n_bytes = ProtoField.uint64("INT.n_bytes", "n_bytes", base.DEC)
    local int_d_queue = ProtoField.uint32("INT.queue", "queue", base.DEC)        -- not supported by ovs-pof
    local int_d_fwd_acts = ProtoField.uint32("INT.fwd_acts", "fwd_acts", base.HEX)

    -- proto fields
    INT_proto.fields = {
        int_h_type,
        int_h_len,
        int_h_mapInfo,

        int_d_dpid,
        int_d_dpid_ovs_pof,
        int_d_dpid_tofino,

        int_d_in_port,
        int_d_out_port,

        --int_d_ingress_time,
        int_d_ingress_time,
        int_d_ingress_time_tofino_low,

        int_d_hop_latency,
        int_d_hop_latency_ovs_pof,
        int_d_hop_latency_tofino_low,

        int_d_bandwidth,
        int_d_n_packets,
        int_d_n_bytes,
        int_d_queue,                  -- not supported by ovs-pof
        int_d_fwd_acts
    }

    local data_dis = Dissector.get("data")

    local function dissector(buf, pkt, root)
        local base = INT_h_base
        local byte_one = 0x01
        local byte_zero = 0x00
        local switch_mask = 0xff000000
 
        local fourb_check = 0x7fffffff

        local rt = root:add(INT_proto, buf)
        rt:set_text(proto_desc)

        local v_int_h_type = buf(base, INT_h_type_len)    -- buf(off, len)
        base = base + INT_h_type_len

        -- check int type
        if v_int_h_type:uint() ~= INT_type_val then
            return false
        end
        rt:add(int_h_type, v_int_h_type)

        pkt.cols.protocol:set("INT Protocol")

        local v_int_h_len = buf(base, INT_h_len_len)
        rt:add(int_h_len, v_int_h_len)
        base = base + INT_h_len_len

        local hop = v_int_h_len:uint()
        pkt.cols.info:set("INT Packet, Hops: " .. hop)

        local v_int_h_mapInfo = buf(base, INT_h_mapInfo_len)
        rt:add(int_h_mapInfo, v_int_h_mapInfo)
        base = base + INT_h_mapInfo_len

        local t
        for i=1,hop do

            t = rt:add(int_h_hop, " " .. i)
            t:set_text("Hop " .. (hop+1 - i))

            local v_int_d_dpid = 0
            if (bit32.band(v_int_h_mapInfo:uint(), bit32.lshift(byte_one, 0))) then      -- must contain device_id
                v_int_d_dpid = buf(base, INT_d_dpid_len)
                base = base + INT_d_dpid_len
            else
                --return false
            end

            -- ovs-pof and tofino, distinguished by device_id
            if (bit32.band(v_int_d_dpid:uint(), switch_mask) == switch_mask) then   -- ovs-pof
                local switch_mapInfo = bit32.band(v_int_h_mapInfo:uint(), CPU_BASED_MAPINFO)

                t:add(int_d_dpid, v_int_d_dpid)

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 1)) ~= byte_zero) then
                    local v_int_d_in_port = buf(base, INT_d_in_port_len)
                    t:add(int_d_in_port, v_int_d_in_port)
                    base = base + INT_d_in_port_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 2)) ~= byte_zero) then
                    local v_int_d_out_port = buf(base, INT_d_out_port_len)
                    t:add(int_d_out_port, v_int_d_out_port)
                    base = base + INT_d_out_port_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 3)) ~= byte_zero) then
                    local v_int_d_ingress_time = buf(base, INT_d_ingress_time_len)
                    t:add(int_d_ingress_time, v_int_d_ingress_time)
                    base = base + INT_d_ingress_time_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 4)) ~= byte_zero) then
                    local v_int_d_hop_latency = buf(base, INT_d_hop_latency_len)
                    t:add(int_d_hop_latency_ovs_pof, v_int_d_hop_latency)
                    base = base + INT_d_hop_latency_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 5)) ~= byte_zero) then
                    local v_int_d_bandwidth = buf(base, INT_d_bandwidth_len):le_float()
                    t:add(int_d_bandwidth, v_int_d_bandwidth)
                    base = base + INT_d_bandwidth_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 6)) ~= byte_zero) then
                    local v_int_d_n_packets = buf(base, INT_d_n_packets_len)
                    t:add(int_d_n_packets, v_int_d_n_packets)
                    base = base + INT_d_n_packets_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 7)) ~= byte_zero) then
                    local v_int_d_n_bytes = buf(base, INT_d_n_bytes_len)
                    t:add(int_d_n_bytes, v_int_d_n_bytes)
                    base = base + INT_d_n_bytes_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 8)) ~= byte_zero) then    -- not supported by ovs-pof
                    local v_int_d_queue = buf(base, INT_d_queue_len)
                    t:add(int_d_queue, v_int_d_queue)
                    base = base + INT_d_queue_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 9)) ~= byte_zero) then
                    local v_int_d_fwd_acts = buf(base, INT_d_fwd_acts_len)
                    t:add(int_d_fwd_acts, v_int_d_fwd_acts)
                    base = base + INT_d_fwd_acts_len
                end
            else                                         -- tofino
                local switch_mapInfo = bit32.band(v_int_h_mapInfo:uint(), NP_BASED_MAPINFO)

                t:add(int_d_dpid_tofino, v_int_d_dpid)

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 1)) ~= byte_zero) then
                    local v_int_d_in_port = buf(base, INT_d_in_port_len)
                    v_int_d_in_port = bit32.band(v_int_d_in_port:uint(), fourb_check)
                    t:add(int_d_in_port,v_int_d_in_port)
                    base = base + INT_d_in_port_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 2)) ~= byte_zero) then
                    local v_int_d_out_port = buf(base, INT_d_out_port_len)
                    v_int_d_out_port = bit32.band(v_int_d_out_port:uint(), fourb_check)
                    t:add(int_d_out_port, v_int_d_out_port)
                    base = base + INT_d_out_port_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 3)) ~= byte_zero) then
                    local v_int_d_ingress_time_high = buf(base, INT_d_ingress_time_tofino_len)
                    base = base + INT_d_ingress_time_tofino_len
                    local v_int_d_ingress_time_low = buf(base, INT_d_ingress_time_tofino_len)
                    v_int_d_ingress_time_low  = bit32.band(v_int_d_ingress_time_low:uint(), fourb_check)
                    t:add(int_d_ingress_time_tofino_low, v_int_d_ingress_time_low)
                    base = base + INT_d_ingress_time_tofino_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 4)) ~= byte_zero) then
                    local v_int_d_hop_latency_high = buf(base, INT_d_hop_latency_tofino_len)
                    base = base + INT_d_hop_latency_tofino_len
                    local v_int_d_hop_latency_low = buf(base, INT_d_hop_latency_tofino_len)
                    t:add(int_d_hop_latency_tofino_low, v_int_d_hop_latency_low)
                    base = base + INT_d_hop_latency_tofino_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 5)) ~= byte_zero) then
                    local v_int_d_bandwidth = buf(base, INT_d_bandwidth_len):le_float()
                    t:add(int_d_bandwidth, v_int_d_bandwidth)
                    base = base + INT_d_bandwidth_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 6)) ~= byte_zero) then
                    local v_int_d_n_packets = buf(base, INT_d_n_packets_len)
                    t:add(int_d_n_packets, v_int_d_n_packets)
                    base = base + INT_d_n_packets_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 7)) ~= byte_zero) then
                    local v_int_d_n_bytes = buf(base, INT_d_n_bytes_len)
                    t:add(int_d_n_bytes, v_int_d_n_bytes)
                    base = base + INT_d_n_bytes_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 8)) ~= byte_zero) then    -- not supported by ovs-pof
                    local v_int_d_queue = buf(base, INT_d_queue_len)
                    v_int_d_queue  = bit32.band(v_int_d_queue:uint(), fourb_check)
                    t:add(int_d_queue, v_int_d_queue)
                    base = base + INT_d_queue_len
                end

                if (bit32.band(switch_mapInfo, bit32.lshift(byte_one, 9)) ~= byte_zero) then
                    local v_int_d_fwd_acts = buf(base, INT_d_fwd_acts_len)
                    v_int_d_fwd_acts  = bit32.band(v_int_d_fwd_acts:uint(), fourb_check)
                    t:add(int_d_fwd_acts, v_int_d_fwd_acts)
                    base = base + INT_d_fwd_acts_len
                end
            end

        end
    end

    function INT_proto.dissector(buf, pkt, root)
        if dissector(buf, pkt, root) then
            --do nothing
        else
            data_dis:call(buf, pkt, root)
        end

    end

    -- register this dissector
    DissectorTable.get("ethertype"):add("0x0908", INT_proto)
end
