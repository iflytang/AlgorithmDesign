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

    local TCP_PORT = 9999

    -- register protocol
    local proto_name = "OCMC"
    local proto_desc = "OCMCollection"
    local proto_DT = Proto(proto_name, proto_desc)

    -- define proto fields
    local proto_reply_cur_ocm_vector = ProtoField.bytes("OCM.ReplyCurrentDataVector", "ReplyCurrentDataVector", base.NONE)

    local proto_request_ocm_start_freq = ProtoField.double("OCM.RequestStartFrequency", "RequestStartFrequency", base.DOUBLE)
    local proto_request_ocm_watch_win = ProtoField.double("OCM.RequestWatchWindow", "RequestWatchWindow", base.DOUBLE)
    local proto_request_ocm_slice = ProtoField.double("OCM.RequestSlice", "RequestSlice", base.DOUBLE)

    -- proto fields
    proto_DT.fields = {
        proto_reply_cur_ocm_vector, -- variable vectors

        proto_request_ocm_start_freq,
        proto_request_ocm_watch_win,
        proto_request_ocm_slice,
    }

    local proto_fields_len = 8  -- bytes
    local proto_request_field_len = 8
    --local proto_cur_sec_len = 4
    local proto_cur_ocm_data_len = 8  -- double, 8B, normal: 20 points, medium: 80 points, severe: 160 points

    local normal_link_level_vector_request_len = 20
    local normal_request_ocm_start_freq_len = 7
    local normal_pad_zero_1_len = 1
    local normal_request_ocm_watch_win_len = 4
    local normal_pad_zero_2_len = 1
    local normal_request_ocm_slice_len = 6
    local normal_pad_zero_3_len = 1

    local medium_link_level_vector_request_len = 21
    local medium_request_ocm_start_freq_len = 7
    local medium_pad_zero_1_len = 1
    local medium_request_ocm_watch_win_len = 4
    local medium_pad_zero_2_len = 1
    local medium_request_ocm_slice_len = 7
    local medium_pad_zero_3_len = 1

    local severe_link_level_vector_request_len = 22
    local severe_request_ocm_start_freq_len = 7
    local severe_pad_zero_1_len = 1
    local severe_request_ocm_watch_win_len = 4
    local severe_pad_zero_2_len = 1
    local severe_request_ocm_slice_len = 8
    local severe_pad_zero_3_len = 1

    local normal_link_level_vector_len = 160
    local medium_link_level_vector_len = 640
    local severe_link_level_vector_len = 1280

    local data_dis = Dissector.get("data")

    local function dissector(buf, pkt, root)
        local base = 0 -- proto_h_base

        -- frame filter
        local buf_len = buf:len()
        if buf_len < proto_fields_len then
            -- do not parse ack packet
            return false
        end

        -- request frame
        if buf_len == normal_link_level_vector_request_len then
            pkt.cols.protocol = "OCM Request"

            local rt = root:add(proto_DT, buf)
            rt:set_text("OCM_Data_Request")

            local v_proto_request_ocm_start_freq = buf(base, normal_request_ocm_start_freq_len)
            base = base + normal_request_ocm_start_freq_len + normal_pad_zero_1_len
            rt:add(proto_request_ocm_start_freq, v_proto_request_ocm_start_freq:string())

            local v_proto_request_ocm_watch_win = buf(base, normal_request_ocm_watch_win_len)
            base = base + normal_request_ocm_watch_win_len + normal_pad_zero_2_len
            rt:add(proto_request_ocm_watch_win, v_proto_request_ocm_watch_win:string())

            local v_proto_request_ocm_slice = buf(base, normal_request_ocm_slice_len)
            base = base + normal_request_ocm_slice_len + normal_pad_zero_3_len
            rt:add(proto_request_ocm_slice, v_proto_request_ocm_slice:string())

            pkt.cols.info:set("Type: Power, Frequency: " .. v_proto_request_ocm_start_freq:string()
                    .. "THz, Window: " .. v_proto_request_ocm_watch_win:string()
                    .. "THz, Slice: " .. v_proto_request_ocm_slice:string() .. "THz")

        elseif buf_len == medium_link_level_vector_request_len then
            pkt.cols.protocol = "OCM Request"

            local rt = root:add(proto_DT, buf)
            rt:set_text("OCM_Data_Request")

            local v_proto_request_ocm_start_freq = buf(base, medium_request_ocm_start_freq_len)
            base = base + medium_request_ocm_start_freq_len + medium_pad_zero_1_len
            rt:add(proto_request_ocm_start_freq, v_proto_request_ocm_start_freq:string())

            local v_proto_request_ocm_watch_win = buf(base, medium_request_ocm_watch_win_len)
            base = base + medium_request_ocm_watch_win_len + medium_pad_zero_2_len
            rt:add(proto_request_ocm_watch_win, v_proto_request_ocm_watch_win:string())

            local v_proto_request_ocm_slice = buf(base, medium_request_ocm_slice_len)
            base = base + medium_request_ocm_slice_len + medium_pad_zero_3_len
            rt:add(proto_request_ocm_slice, v_proto_request_ocm_slice:string())

            pkt.cols.info:set("Type: Power, Frequency: " .. v_proto_request_ocm_start_freq:string()
                    .. "THz, Window: " .. v_proto_request_ocm_watch_win:string()
                    .. "THz, Slice: " .. v_proto_request_ocm_slice:string() .. "THz")

        elseif buf_len == severe_link_level_vector_request_len then
            pkt.cols.protocol = "OCM Request"

            local rt = root:add(proto_DT, buf)
            rt:set_text("OCM_Data_Request")

            local v_proto_request_ocm_start_freq = buf(base, severe_request_ocm_start_freq_len)
            base = base + severe_request_ocm_start_freq_len + severe_pad_zero_1_len
            rt:add(proto_request_ocm_start_freq, v_proto_request_ocm_start_freq:string())

            local v_proto_request_ocm_watch_win = buf(base, severe_request_ocm_watch_win_len)
            base = base + severe_request_ocm_watch_win_len + severe_pad_zero_2_len
            rt:add(proto_request_ocm_watch_win, v_proto_request_ocm_watch_win:string())

            local v_proto_request_ocm_slice = buf(base, severe_request_ocm_slice_len)
            base = base + severe_request_ocm_slice_len + severe_pad_zero_3_len
            rt:add(proto_request_ocm_slice, v_proto_request_ocm_slice:string())

            pkt.cols.info:set("Type: Power, Frequency: " .. v_proto_request_ocm_start_freq:string()
                    .. "THz, Window: " .. v_proto_request_ocm_watch_win:string()
                    .. "THz, Slice: " .. v_proto_request_ocm_slice:string() .. "THz")
        end

        -- reply frame
        if buf_len == normal_link_level_vector_len then
            pkt.cols.protocol = "OCM Reply"
            pkt.cols.info:set("Normal Link State, Type: Power, Points: " .. 20 .. ", Period: " .. 5 .. "s")

            local rt = root:add(proto_DT, buf)
            rt:set_text("OCM_Power_Reply")

            local v_proto_cur_ocm_vector = buf(base, normal_link_level_vector_len)
            base = base + normal_link_level_vector_len
            rt:add(proto_reply_cur_ocm_vector, v_proto_cur_ocm_vector)

        elseif buf_len == medium_link_level_vector_len then
            pkt.cols.protocol = "OCM Reply"
            pkt.cols.info:set("Medium Link State, Type: Power, Points: " .. 80 .. ", Period: " .. 2 .. "s")

            local rt = root:add(proto_DT, buf)
            rt:set_text("OCM_Power_Reply")

            local v_proto_cur_ocm_vector = buf(base, medium_link_level_vector_len)
            base = base + medium_link_level_vector_len
            rt:add(proto_reply_cur_ocm_vector, v_proto_cur_ocm_vector)

        elseif  buf_len == severe_link_level_vector_len then
            pkt.cols.protocol = "OCM Reply"
            pkt.cols.info:set("Severe Link State, Type: Power, Points: " .. 160 .. ", Period: " .. 1 .. "s")

            local rt = root:add(proto_DT, buf)
            rt:set_text("OCM_Power_Reply")

            local v_proto_cur_ocm_vector = buf(base, severe_link_level_vector_len)
            base = base + severe_link_level_vector_len
            rt:add(proto_reply_cur_ocm_vector, v_proto_cur_ocm_vector)
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