-- @brief to capture tcp sock packet
-- @author tsf
-- @date 2020-08-20
-- @version lua5.2

-- DA221 to DL226, tcp port is 2020
-- pcap file: DA221_to_DL226_and_DL226_to_ONOS216_at_EON226.pcap

require "bit32"     -- bit operation

-- create new dissectors
do

    local TCP_PORT = 2020

    -- register protocol
    local proto_name = "BWC"
    local proto_desc = "BandwidthCollection"
    local proto_DT = Proto(proto_name, proto_desc)

    -- define proto fields
    local proto_cur_sec = ProtoField.bytes("BWC.CurrentTime", "CurrentTime (s)", base.NONE)
    local proto_cur_bw_vector = ProtoField.bytes("BWC.CurrentBandwidthVector", "CurrentBandwidthVector", base.NONE)

    -- proto fields
    proto_DT.fields = {
        proto_cur_sec, -- int
        proto_cur_bw_vector, -- 3 nodes, float, 3* 4 = 12
    }

    local proto_fields_len = 16  -- bytes
    local proto_cur_sec_len = 4
    local proto_cur_bw_vector_len = 12

    local data_dis = Dissector.get("data")

    local function dissector(buf, pkt, root)
        local base = 0 -- proto_h_base

        local buf_len = buf:len()
        if buf_len < proto_fields_len then
            -- do not parse ack packet
            return false
        else
            pkt.cols.protocol = "Collection"
            pkt.cols.info:set("Collected Bandwidth Vectors")

            local rt = root:add(proto_DT, buf)
            rt:set_text("Bandwidth_Vectors")

            local v_proto_cur_sec = buf(base, proto_cur_sec_len)
            base = base + proto_cur_sec_len
            rt:add(proto_cur_sec, v_proto_cur_sec)

            local v_proto_cur_bw_vector = buf(base, proto_cur_bw_vector_len)
            base = base + proto_cur_bw_vector_len
            rt:add(proto_cur_bw_vector, v_proto_cur_bw_vector)

            return true
        end

    end

    function proto_DT.dissector(buf, pkt, root)
        if dissector(buf, pkt, root) then
            --do nothing
        else
            data_dis:call(buf, pkt, root)
        end

    end

    -- register this dissector
    DissectorTable.get("tcp.port"):add(TCP_PORT, proto_DT)
end