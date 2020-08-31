-- @brief to capture tcp sock packet
-- @author tsf
-- @date 2020-08-30
-- @version lua5.2

-- DA221 to OCMCollector216, the tcp port is 2018.
-- pcap files collected at OCM collector 216
-- pcap file: DA221_to_OCMCOLLECTOR216_and_OCMCOLLECTOR216_dual_direct_to_OCM126.pcap

require "bit32"     -- bit operation

-- create new dissectors
do

    local TCP_PORT = 2018

    -- register protocol
    local proto_name = "BERC"
    local proto_desc = "BERCollection"
    local proto_DT = Proto(proto_name, proto_desc)

    -- define proto fields
    --local proto_cur_sec = ProtoField.bytes("BERC.CurrentTime", "CurrentTime (s)", base.NONE)
    local proto_cur_ber_vector = ProtoField.bytes("BERC.CurrentBERVector", "CurrentBERVector", base.NONE)

    -- proto fields
    proto_DT.fields = {
        --proto_cur_sec, -- int, 4
        proto_cur_ber_vector, -- 3 nodes, double, 3 * 8 = 24
    }

    local proto_fields_len = 24  -- bytes
    --local proto_cur_sec_len = 4
    local proto_cur_ber_vector_len = 24

    local data_dis = Dissector.get("data")

    local function dissector(buf, pkt, root)
        local base = 0 -- proto_h_base

        local buf_len = buf:len()
        if buf_len < proto_fields_len then
            -- do not parse ack packet
            return false
        else
            pkt.cols.protocol = "BER Collection"
            pkt.cols.info:set("Collected BER Vectors")

            local rt = root:add(proto_DT, buf)
            rt:set_text("BER_Vectors")

            --local v_proto_cur_sec = buf(base, proto_cur_sec_len)
            --base = base + proto_cur_sec_len
            --rt:add(proto_cur_sec, v_proto_cur_sec)

            local v_proto_cur_ber_vector = buf(base, proto_cur_ber_vector_len)
            base = base + proto_cur_ber_vector_len
            rt:add(proto_cur_ber_vector, v_proto_cur_ber_vector)

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