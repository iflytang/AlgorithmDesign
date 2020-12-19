-- @brief to capture tcp sock packet
-- @author tsf
-- @date 2020-08-20
-- @version lua5.2

-- DL226 to ONOS216, tcp port is 2019
-- pcap file: DL226_to_ONOS216_and_ONOS216_to_OVS223_at_EON216.pcap

require "bit32"     -- bit operation

-- create new dissectors
do

    local TCP_PORT = 2019

    -- register protocol
    local proto_name = "BWP"
    local proto_desc = "BandwidthPrediction"
    local proto_DT = Proto(proto_name, proto_desc)

    -- define proto fields
    local proto_cur_bw_vector = ProtoField.bytes("BWP.CurrentBandwidthVector", "CurrentBandwidthVector", base.NONE)
    --local proto_fur_bw_vector = ProtoField.bytes("BWP.PredictedBandwidthVector", "PredictedBandwidthVector", base.NONE)
    local proto_fur_bw_vector = ProtoField.bytes("BWP.Predicted_bandwidth", "Predicted_bandwidth", base.NONE)

    -- proto fields
    proto_DT.fields = {
        proto_cur_bw_vector, -- 3 nodes, float, 3* 4 = 12
        proto_fur_bw_vector, -- 24 points, float
    }

    local proto_fields_len = 108  -- bytes
    local proto_cur_bw_vector_len = 12
    local proto_fur_bw_vector_len = 96
    local proto_fur_bw_len = 4

    local data_dis = Dissector.get("data")

    local function dissector(buf, pkt, root)
        local base = 0 -- proto_h_base

        local buf_len = buf:len()
        if buf_len < proto_fields_len then
            -- do not parse ack packet
            return false
        else
            pkt.cols.protocol = "Prediction"
            pkt.cols.info:set("Predicted Bandwidth Vectors")

            local rt = root:add(proto_DT, buf)
            --rt:set_text("Bandwidth_Vectors")
            rt:set_text("Normalized Predicted Bandwidth Vectors")

            local v_proto_cur_bw_vector = buf(base, proto_cur_bw_vector_len)
            base = base + proto_cur_bw_vector_len
            --rt:add(proto_cur_bw_vector, v_proto_cur_bw_vector)

            local rt_bw
            --local v_proto_fur_bw_vector = {}  -- array

            -- display in single one
            --for i = 1, 24 do
            --        --local v_proto_fur_bw_vector = buf(base, proto_fur_bw_vector_len)
            --        --base = base + proto_fur_bw_vector_len
            --        --rt:add(proto_fur_bw_vector, v_proto_fur_bw_vector)
            --        local v_proto_fur_bw_vector = buf(base, proto_fur_bw_len)
            --        base = base + proto_fur_bw_len
            --        rt_bw = rt:add(proto_fur_bw_vector, v_proto_fur_bw_vector)
            --        rt_bw:set_text(i .. ":" .. string.format("%.2f", v_proto_fur_bw_vector:le_float()))
            --end

            -- display in vector
            for i = 1, 4 do
                local string_v_proto_fur_bw = ""
                for j = 1, 6 do
                    --local v_proto_fur_bw_vector = buf(base, proto_fur_bw_vector_len)
                    --base = base + proto_fur_bw_vector_len
                    --rt:add(proto_fur_bw_vector, v_proto_fur_bw_vector)
                    local v_proto_fur_bw_vector = buf(base, proto_fur_bw_len)
                    base = base + proto_fur_bw_len
                    if j < 6 then
                        string_v_proto_fur_bw = string_v_proto_fur_bw .. string.format("%.2f", v_proto_fur_bw_vector:le_float()) .. ", "
                    else
                        string_v_proto_fur_bw = string_v_proto_fur_bw .. string.format("%.2f", v_proto_fur_bw_vector:le_float())
                    end
                end
                rt_bw = rt:add(proto_fur_bw_vector, string_v_proto_fur_bw)
                rt_bw:set_text(((i-1)*6+1) .. "-" .. i*6 .. ": [" .. string_v_proto_fur_bw .. "]")
            end

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