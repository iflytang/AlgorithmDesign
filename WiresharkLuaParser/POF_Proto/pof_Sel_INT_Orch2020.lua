-- original pof protocol parse scripts
-- pof protocol stack: https://github.com/iflytang/floodlightpof/tree/floodlightpof-ovs

do
    --[[

    pof_proto(name, desc)
    name: displayed in the column of “Protocol” in the packet list
    desc: displayed as the dissection tree root in the packet details
    --]]
	local pof_proto = Proto("pof","POF Protocol")
	--[[
	   ProtoField:
             to be used when adding items to the dissection tree
	--]]
	local pof_protocol_version = ProtoField.uint8("Version","Version",base.HEX)
	local pof_protocol_type = ProtoField.uint8("Type", "Type", base.HEX)
    local pof_msg_len = ProtoField.uint16("Length", "Length", base.DEC)
	local pof_transaction_id = ProtoField.uint32("Transaction_ID","Transaction_ID",base.DEC)
	local pof_detail = ProtoField.bytes("Details","Details",base.NONE)
    local pof_hello= ProtoField.bytes("Hello","Hello",base.NONE)
    local pof_erro = ProtoField.bytes("Error","Error",base.NONE)
    local pof_echo_request= ProtoField.bytes("EchoRequest","EchoRequest",base.NONE)
    local pof_echo_reply= ProtoField.bytes("EchoReply","EchoReply",base.NONE)
    local pof_experimenter= ProtoField.bytes("Experimenter","Experimenter",base.NONE)
    local pof_features_request=ProtoField.bytes("FeaturesRequest","FeaturesRequest",base.NONE)
    local pof_features_reply=ProtoField.bytes("FeaturesReply","FeaturesReply",base.NONE)
    local pof_get_config_request = ProtoField.bytes("ConfigRequest","ConfigRequest",base.NONE)
    local pof_get_config_reply = ProtoField.bytes("ConfigReply","ConfigReply",base.NONE)
    local pof_set_config = ProtoField.bytes("SetConfig","SetConfig",base.NONE)
    local pof_packet_in = ProtoField.bytes("PacketIn","PacketIn",base.NONE)
    local pof_flow_removed = ProtoField.bytes("FlowRemoved","FlowRemoved",base.NONE)
    local pof_port_status=  ProtoField.bytes("PortStatus","PortStatus",base.NONE)
    local pof_resource_report= ProtoField.bytes("ResourceReport","ResourceReport",base.NONE)
    local pof_packet_out = ProtoField.bytes("PacketOut","PacketOut",base.NONE)
    local pof_flow_mod = ProtoField.bytes("FlowMod","FlowMod",base.NONE)
    local pof_group_mod = ProtoField.bytes("GroupMod","GoupMod",base.NONE)
    local pof_port_mod =ProtoField.bytes("PortMod","PortMod",base.NONE)
    local pof_table_mod=ProtoField.bytes("TableMod","TableMod",base.NONE)
    local pof_multipart_request= ProtoField.bytes("MultipartRequest","MultipartRequest",base.NONE)
    local pof_multipart_reply = ProtoField.bytes("MultipartReply","MultipartReply",base.NONE)
    local pof_barrier_request = ProtoField.bytes("BarrierRequest","BarrierRequest",base.NONE)
    local pof_barrier_reply = ProtoField.bytes("BarrierReply","BarrierReply",base.NONE)
    local pof_queue_get_config_request= ProtoField.bytes("Queue_get_config_request","Queue_get_config_request",base.NONE)
    local pof_queue_get_config_reply=ProtoField.bytes("Queue_get_config_reply","Queue_get_config_reply",base.NONE)
    local pof_role_request= ProtoField.bytes("RoleRequest","RoleRequest",base.NONE)
    local pof_role_reply= ProtoField.bytes("RoleReply","RoleReply",base.NONE)
    local pof_get_async_request= ProtoField.bytes("Get_aync_request","Get_aync_request",base.NONE)
    local pof_get_async_reply= ProtoField.bytes("Get_aync_reply","Get_aync_reply",base.NONE)
    local pof_set_async = ProtoField.bytes("SetAsync","SetAsync",base.NONE)
    local pof_meter_mod = ProtoField.bytes("MeterMod","MeterMod",base.NONE)
    local pof_counter_mod = ProtoField.bytes("CounterMod","CounterMod",base.NONE)
    local pof_counter_request= ProtoField.bytes("CounterRequest","CounterRequest",base.NONE)
    local pof_counter_reply= ProtoField.bytes("CounterReply","CounterReply",base.NONE)
    local pof_queryall_request= ProtoField.bytes("QueryallRequst","QueryallRequst",base.NONE)
    local pof_queryall_fin = ProtoField.bytes("QueryallFin","QueryallFin",base.NONE)

    -- flow mod members
    local flowMod_command = ProtoField.uint8("FlowMod.Command", "Command", base.HEX)
    local flowMod_matchFieldNum = ProtoField.uint8("FlowMod.MatchFieldNum", "MatchFieldNum", base.DEC)
    local flowMod_instructionNum = ProtoField.uint8("FlowMod.InstructionNum", "InstructionNum", base.DEC)
    local flowMod_counterId = ProtoField.uint32("FlowMod.CounterId", "CounterId", base.DEC)
    local flowMod_cookie = ProtoField.uint64("FlowMod.Cookie", "Cookie", base.DEC)
    local flowMod_cookieMask = ProtoField.uint64("FlowMod.CookieMask", "CookieMask", base.DEC)
    local flowMod_tableId = ProtoField.uint8("FlowMod.TableId", "TableId", base.DEC)
    local flowMod_tableType = ProtoField.uint8("FlowMod.TableType", "TableType", base.DEC)
    local flowMod_idleTimeout = ProtoField.uint16("FlowMod.IdleTimeout", "IdleTimeout", base.DEC)
    local flowMod_hardTimeout = ProtoField.uint16("FlowMod.HardTimeout", "HardTimeout", base.DEC)
    local flowMod_priority = ProtoField.uint16("FlowMod.Priority", "Priority", base.DEC)
    local flowMod_index = ProtoField.uint32("FlowMod.Index", "Index", base.DEC)

    local flowMod_POFMatchX = ProtoField.bytes("FlowMod.POFMatchX","POFMatchX",base.NONE)
    local flowMod_fieldId = ProtoField.uint16("FlowMod.FieldId", "FieldId", base.DEC)
    local flowMod_offset = ProtoField.uint16("FlowMod.Offset", "Offset", base.DEC)
    local flowMod_length = ProtoField.uint16("FlowMod.Length", "Length", base.DEC)
    local flowMod_value = ProtoField.bytes("FlowMod.Value", "Value", base.NONE)
    local flowMod_mask = ProtoField.bytes("FlowMod.Mask", "Mask", base.NONE)

    local flowMod_instruction = ProtoField.bytes("FlowMod.Instruction", "Instruction", base.NONE)
    local flowMod_instruction_type = ProtoField.uint16("FlowMod.Type", "Type", base.HEX)
    local flowMod_instruction_length = ProtoField.uint16("FlowMod.Length", "Length", base.DEC)

    local flowMod_applyAction = ProtoField.bytes("FlowMod.ApplyActions", "ApplyActions", base.None)
    local flowMod_applyAction_actionNum = ProtoField.uint8("FlowMod.ActionNum", "ActionNum", base.DEC)

    local flowMod_action_class = ProtoField.bytes("FlowMod.Action", "Action", base.NONE)
    local flowMod_act_type = ProtoField.uint16("FlowMod.Type", "Type", base.HEX)
    local flowMod_act_length = ProtoField.uint16("FlowMod.Length", "Length", base.DEC)
    local flowMod_act_fieldId = ProtoField.uint16("FlowMod.FieldId", "FieldId", base.HEX)
    local flowMod_act_fieldOffset = ProtoField.uint16("FlowMod.FieldOffset", "FieldOffset", base.DEC)
    local flowMod_act_fieldLength = ProtoField.uint32("FlowMod.FieldLength", "FieldLength", base.DEC)
    local flowMod_act_orchestration_mode = ProtoField.uint16("FlowMod.OrchestrationMode", "OrchestrationMode", base.HEX)
    local flowMod_act_sampling_ratio = ProtoField.uint16("FlowMod.SamplingRatio", "SamplingRatio", base.DEC)
    local flowMod_act_mapInfo = ProtoField.uint16("FlowMod.MapInfo", "MapInfo", base.HEX)
    local flowMod_act_fieldValue = ProtoField.bytes("FlowMod.FieldValue", "FieldValue", base.NONE)

    local flowMod_act_output_portIdType = ProtoField.uint8("FlowMod.PortIdType", "PortIdType", base.DEC)
    local flowMod_act_output_metadataOffset = ProtoField.uint16("FlowMod.MetadataOffset", "MetadataOffset", base.DEC)
    local flowMod_act_output_metadataLength = ProtoField.uint16("FlowMod.MetadataLength", "MetadataLength", base.DEC)
    local flowMod_act_output_packetOffset = ProtoField.uint16("FlowMod.PacketOffset", "PacketOffset", base.DEC)
    local flowMod_act_output_portId = ProtoField.uint32("FlowMod.PortId", "PortId", base.DEC)

    -- fields byte length
    local flowMod_command_len = 1
    local flowMod_matchFieldNum_len = 1
    local flowMod_instructionNum_len = 1
    -- pad_zeros[1]
    local flowMod_counterId_len = 4
    local flowMod_cookie_len = 8
    local flowMod_cookieMask_len = 8
    local flowMod_tableId_len = 1
    local flowMod_tableType_len = 1
    local flowMod_idleTimeout_len = 2
    local flowMod_hardTimeout_len = 2
    local flowMod_priority_len = 2
    local flowMod_index_len = 4
    -- pad_zeros[4]

    local flowMod_fieldId_len = 2
    local flowMod_offset_len = 2
    local flowMod_length_len = 2
    -- pad_zeros[4]
    local flowMod_value_len = 16
    local flowMod_mask_len = 16
    local flowMod_POFMatchX_len = 40  -- sum above match fields

    local flowMod_instruction_len = 304 + 8
    local flowMod_instruction_type_len = 2
    local flowMod_instruction_length_len = 2
    -- pad_zeros[4]

    local flowMod_applyAction_len = 304
    local flowMod_applyAction_actionNum_len = 1
    -- pad_zeros[7]

    local flowMod_action_class_len = 48
    local flowMod_act_type_len = 2
    local flowMod_act_length_len = 2
    local flowMod_act_fieldId_len = 2
    local flowMod_act_fieldOffset_len = 2
    local flowMod_act_fieldLength_len = 4
    local flowMod_act_orchestration_mode_len = 2
    local flowMod_act_sampling_ratio_len = 2
    local flowMod_act_mapInfo_len = 2
    local flowMod_act_fieldValue_len = 16
    -- pad_zeros[4]

    local flowMod_act_output_portIdType_len = 1
    -- pad_zeros[1]
    local flowMod_act_output_metadataOffset_len = 2
    local flowMod_act_output_metadataLength_len = 2
    local flowMod_act_output_packetOffset_len = 2
    local flowMod_act_output_portId_len = 4


    pof_proto.fields = {
            pof_protocol_version,
            pof_protocol_type,
            pof_msg_len,
            pof_transaction_id,
            pof_detail,
            pof_hello,
            pof_erro,
            pof_echo_request,
            pof_echo_reply,
            pof_experimenter,
            pof_features_request,
            pof_features_reply,
            pof_get_config_request,
            pof_get_config_reply,
            pof_set_config,
            pof_packet_in,
	        pof_flow_removed,
            pof_port_status,
            pof_resource_report,
            pof_packet_out,
            pof_flow_mod,
	        pof_group_mod,
            pof_port_mod,
            pof_table_mod,
            pof_multipart_request,
            pof_multipart_reply,
            pof_barrier_request,
            pof_barrier_reply,
            pof_queue_get_config_request,
            pof_queue_get_config_reply,
	        pof_role_request,
            pof_role_reply,
            pof_get_async_request,
            pof_get_async_reply,
            pof_set_async,
            pof_meter_mod,
            pof_counter_mod ,
            pof_counter_request,
            pof_counter_reply,
            pof_queryall_request,
            pof_queryall_fin,

            -- added by tsf
            flowMod_command,   --header
            flowMod_matchFieldNum,
            flowMod_instructionNum,
            flowMod_counterId,
            flowMod_cookie,
            flowMod_cookieMask,
            flowMod_tableId,
            flowMod_tableType,
            flowMod_idleTimeout,
            flowMod_hardTimeout,
            flowMod_priority,
            flowMod_index,

            flowMod_POFMatchX,  -- match
            flowMod_fieldId,
            flowMod_offset,
            flowMod_length,
            flowMod_value,
            flowMod_mask,

            flowMod_instruction,  -- ins
            flowMod_instruction_type,
            flowMod_instruction_length,

            flowMod_applyAction,
            flowMod_applyAction_actionNum,
            flowMod_action_class,
            flowMod_act_type,
            flowMod_act_length,
            flowMod_act_fieldId,
            flowMod_act_fieldOffset,
            flowMod_act_fieldLength,
            flowMod_act_orchestration_mode,
            flowMod_act_sampling_ratio,
            flowMod_act_mapInfo,
            flowMod_act_fieldValue,

            flowMod_act_output_portIdType,
            flowMod_act_output_metadataOffset,
            flowMod_act_output_metadataLength,
            flowMod_act_output_packetOffset,
            flowMod_act_output_portId,
    }
     
	local data_dis = Dissector.get("data") 

    local function pof_msg_type_display(m_type,pkt)
        if (m_type==0) then pkt.cols.info:set("Type:POFT_HELLO")
        elseif (m_type==1) then pkt.cols.info:set("Type:POFT_ERROR")
        elseif (m_type==2) then pkt.cols.info:set("Type:POFT_ECHO_REQUEST")
        elseif (m_type==3) then pkt.cols.info:set("Type:POFT_ECHO_REPLY")
        elseif (m_type==4) then pkt.cols.info:set("Type:POFT_EXPERIMENTER")
        elseif (m_type==5) then pkt.cols.info:set("Type:POFT_FEATURES_REQUEST")
        elseif (m_type==6) then pkt.cols.info:set("Type:POFT_FEATURES_REPLY")
        elseif (m_type==7) then pkt.cols.info:set("Type:POFT_GET_CONFIG_REQUEST")
        elseif (m_type==8) then pkt.cols.info:set("Type:POFT_GET_CONFIG_REPLY")
        elseif (m_type==9) then pkt.cols.info:set("Type:POFT_SET_CONFIG")
        elseif (m_type==10) then pkt.cols.info:set("Type:POFT_PACKET_IN")
        elseif (m_type==11) then pkt.cols.info:set("Type:POFT_FLOW_REMOVED")
        elseif (m_type==12) then pkt.cols.info:set("Type:POFT_PORT_STATUS")
        elseif (m_type==13) then pkt.cols.info:set("Type:POFT_RESOURCE_REPORT")
        elseif (m_type==14) then pkt.cols.info:set("Type:POFT_PACKET_OUT")
        elseif (m_type==15) then pkt.cols.info:set("Type:POFT_FLOW_MOD")
        elseif (m_type==16) then pkt.cols.info:set("Type:POFT_GROUP_MOD")
        elseif (m_type==17) then pkt.cols.info:set("Type:POFT_PORT_MOD")
        elseif (m_type==18) then pkt.cols.info:set("Type:POFT_TABLE_MOD")
        elseif (m_type==19) then pkt.cols.info:set("Type:POFT_MULTIPART_REQUEST")
        elseif (m_type==20) then pkt.cols.info:set("Type:POFT_MULTIPART_REPLY")
        elseif (m_type==21) then pkt.cols.info:set("Type:POFT_BARRIER_REQUEST")
        elseif (m_type==22) then pkt.cols.info:set("Type:POFT_BARRIER_REPLY")
        elseif (m_type==23) then pkt.cols.info:set("Type:POFT_QUEUE_GET_CONFIG_REQUEST")
        elseif (m_type==24) then pkt.cols.info:set("Type:POFT_QUEUE_GET_CONFIG_REPLY")
        elseif (m_type==25) then pkt.cols.info:set("Type:POFT_ROLE_REQUEST")
        elseif (m_type==26) then pkt.cols.info:set("Type:POFT_ROLE_REPLY")
        elseif (m_type==27) then pkt.cols.info:set("Type:POFT_GET_ASYNC_REQUEST")
        elseif (m_type==28) then pkt.cols.info:set("Type:POFT_GET_ASYNC_REPLY")
        elseif (m_type==29) then pkt.cols.info:set("Type:POFT_SET_ASYNC")
        elseif (m_type==30) then pkt.cols.info:set("Type:POFT_METER_MOD")
        elseif (m_type==31) then pkt.cols.info:set("Type:POFT_COUNTER_MOD")
        elseif (m_type==32) then pkt.cols.info:set("Type:POFT_COUNTER_REQUEST")
        elseif (m_type==33) then pkt.cols.info:set("Type:POFT_COUNTER_REPLY")
        elseif (m_type==34) then pkt.cols.info:set("Type:POFT_QUERYALL_REQUEST")
        elseif (m_type==35) then pkt.cols.info:set("Type:POFT_QUERYALL_FIN")
        end
     end

    local function pof_dispaly_remain_msg(msg_type,buf,root,current,msg_len,t)
        if(msg_type==0) then t:add(pof_hello,buf(current,msg_len))
        elseif(msg_type==1) then t:add(pof_erro,buf(current,msg_len))
        elseif(msg_type==2) then t:add(pof_echo_request,buf(current,msg_len))
        elseif(msg_type==3) then t:add(pof_echo_reply,buf(current,msg_len))
        elseif(msg_type==4) then t:add(pof_experimenter,buf(current,msg_len))
        elseif(msg_type==5) then t:add(pof_features_request,buf(current,msg_len))
        elseif(msg_type==6) then t:add(pof_features_reply,buf(current,msg_len))
        elseif(msg_type==7) then t:add(pof_get_config_request,buf(current,msg_len))
        elseif(msg_type==8) then t:add(pof_get_config_reply,buf(current,msg_len))
        elseif(msg_type==9) then t:add(pof_set_onfig,buf(current,msg_len))
        elseif(msg_type==10) then t:add(pof_packet_in,buf(current,msg_len))
        elseif(msg_type==11) then t:add(pof_flow_removed,buf(current,msg_len))
        elseif(msg_type==12) then t:add(pof_port_status,buf(current,msg_len))
        elseif(msg_type==13) then t:add(pof_resource_report,buf(current,msg_len))
        elseif(msg_type==14) then t:add(pof_packet_out,buf(current,msg_len))
        elseif(msg_type==15) then
            --t:add(pof_flow_mod,buf(current,msg_len))

            -- added by tsf
            local base = current
            -- fields
            local rt_fm = t:add(pof_flow_mod,buf(current,msg_len))
            rt_fm:set_text("POF FlowMod")

            local v_flowMod_command = buf(base, flowMod_command_len)
            base = base + flowMod_command_len
            rt_fm:add(flowMod_command, v_flowMod_command)

            local v_flowMod_matchFieldNum = buf(base, flowMod_matchFieldNum_len)
            base = base + flowMod_matchFieldNum_len
            rt_fm:add(flowMod_matchFieldNum, v_flowMod_matchFieldNum)

            local v_flowMod_instructionNum = buf(base, flowMod_instructionNum_len)
            base = base + flowMod_instructionNum_len
            rt_fm:add(flowMod_instructionNum, v_flowMod_instructionNum)

            -- pad one zero
            base = base + 1

            local v_flowMod_counterId = buf(base, flowMod_counterId_len)
            base = base + flowMod_counterId_len
            rt_fm:add(flowMod_counterId, v_flowMod_counterId)

            local v_flowMod_cookie = buf(base, flowMod_cookie_len)
            base = base + flowMod_cookie_len
            rt_fm:add(flowMod_cookie, v_flowMod_cookie)

            local v_flowMod_cookieMask = buf(base, flowMod_cookieMask_len)
            base = base + flowMod_cookieMask_len
            rt_fm:add(flowMod_cookieMask, v_flowMod_cookieMask)

            local v_flowMod_tableId = buf(base, flowMod_tableId_len)
            base = base + flowMod_tableId_len
            rt_fm:add(flowMod_tableId, v_flowMod_tableId)

            local v_flowMod_tableType = buf(base, flowMod_tableType_len)
            base = base + flowMod_tableType_len
            local string_flowMod_tableType
            if v_flowMod_tableType:uint() == 0 then
                string_flowMod_tableType = "POF_MM_TABLE"
            elseif  v_flowMod_tableType:uint() == 1 then
                string_flowMod_tableType = "POF_LPM_TABLE"
            elseif  v_flowMod_tableType:uint() == 2 then
                string_flowMod_tableType = "POF_EM_TABLE"
            elseif  v_flowMod_tableType:uint() == 3 then
                string_flowMod_tableType = "POF_LINEAR_TABLE"
            elseif  v_flowMod_tableType:uint() == 4 then
                string_flowMod_tableType = "POF_MAX_TABLE_TYPE"
            end
            local rt_table_type = rt_fm:add(flowMod_tableType, v_flowMod_tableType)
            rt_table_type:set_text("TableType: " .. string_flowMod_tableType)

            local v_flowMod_idleTimeout = buf(base, flowMod_idleTimeout_len)
            base = base + flowMod_idleTimeout_len
            rt_fm:add(flowMod_idleTimeout, v_flowMod_idleTimeout)

            local v_flowMod_hardTimeout = buf(base, flowMod_hardTimeout_len)
            base = base + flowMod_hardTimeout_len
            rt_fm:add(flowMod_hardTimeout, v_flowMod_hardTimeout)

            local v_flowMod_priority = buf(base, flowMod_priority_len)
            base = base + flowMod_priority_len
            rt_fm:add(flowMod_priority, v_flowMod_priority)

            local v_flowMod_index = buf(base, flowMod_index_len)
            base = base + flowMod_index_len
            rt_fm:add(flowMod_index, v_flowMod_index)

            -- pad 4 zero
            base = base + 4

            -- OFMatchX
            local rt_ofm = rt_fm:add(flowMod_POFMatchX, buf(base, flowMod_POFMatchX_len))
            rt_ofm:set_text("POF Match Field")

            local v_flowMod_fieldId = buf(base, flowMod_fieldId_len)
            base = base + flowMod_fieldId_len
            rt_ofm:add(flowMod_fieldId, v_flowMod_fieldId)

            local v_flowMod_offset = buf(base, flowMod_offset_len)
            base = base + flowMod_offset_len
            rt_ofm:add(flowMod_offset, v_flowMod_offset)

            local v_flowMod_length = buf(base, flowMod_length_len)
            base = base + flowMod_length_len
            rt_ofm:add(flowMod_length, v_flowMod_length)

            -- pad 2 zero
            base = base + 2

            local v_flowMod_value = buf(base, flowMod_value_len)
            local v_flowMod_value_ip = buf(base, 4)
            base = base + flowMod_value_len
            local rt_ofm_value = rt_ofm:add(flowMod_value, v_flowMod_value)
            rt_ofm_value:set_text("Value: 0x" .. string.format("%08x",  v_flowMod_value_ip:uint()))

            local v_flowMod_mask = buf(base, flowMod_mask_len)
            local v_flowMod_mask_ip = buf(base, 4)
            base = base + flowMod_mask_len
            local rt_ofm_mask = rt_ofm:add(flowMod_value, v_flowMod_mask)
            rt_ofm_mask:set_text("Mask: 0x" .. string.format("%08x",  v_flowMod_mask_ip:uint()))

            -- jump to instruction (omit remained 7 matchX, total 8)
            base = base + 7 * flowMod_POFMatchX_len

            local v_flowMod_instruction = buf(base, flowMod_instruction_len)
            local rt_ins = rt_fm:add(flowMod_instruction, v_flowMod_instruction)
            rt_ins:set_text("POF Instructions")

            local v_flowMod_instruction_type = buf(base, flowMod_instruction_type_len)
            base = base + flowMod_instruction_type_len
            rt_ins:add(flowMod_instruction_type, v_flowMod_instruction_type)

            local v_flowMod_instruction_length = buf(base, flowMod_instruction_length_len)
            base = base + flowMod_instruction_length_len
            rt_ins:add(flowMod_instruction_length, v_flowMod_instruction_length)

            -- pad 4 zero
            base = base + 4

            local v_flowMod_applyAction = buf(base, flowMod_applyAction_len)
            local rt_app_act = rt_ins:add(flowMod_applyAction, v_flowMod_applyAction)
            rt_app_act:set_text("POF Apply Actions")

            local v_flowMod_applyAction_actionNum = buf(base, flowMod_applyAction_actionNum_len)
            base = base + flowMod_applyAction_actionNum_len
            rt_app_act:add(flowMod_applyAction_actionNum, v_flowMod_applyAction_actionNum)

            -- pad 7 zero
            base = base + 7

            local v_flowMod_add_int_field = buf(base, flowMod_action_class_len)
            local rt_act_add_int_field = rt_app_act:add(flowMod_action_class, v_flowMod_add_int_field)
            rt_act_add_int_field:set_text("AddINTField")

            local v_flowMod_act_type = buf(base, flowMod_act_type_len)
            base = base + flowMod_act_type_len
            rt_act_add_int_field:add(flowMod_act_type, v_flowMod_act_type)

            local v_flowMod_act_length = buf(base, flowMod_act_length_len)
            base = base + flowMod_act_length_len
            rt_act_add_int_field:add(flowMod_act_length, v_flowMod_act_length)

            local v_flowMod_act_fieldId = buf(base, flowMod_act_fieldId_len)
            base = base + flowMod_act_fieldId_len
            rt_act_add_int_field:add(flowMod_act_fieldId, v_flowMod_act_fieldId)

            local v_flowMod_act_fieldOffset = buf(base, flowMod_act_fieldOffset_len)
            base = base + flowMod_act_fieldOffset_len
            rt_act_add_int_field:add(flowMod_act_fieldOffset, v_flowMod_act_fieldOffset)

            --local v_flowMod_act_fieldLength = buf(base, flowMod_act_fieldLength_len)
            --base = base + flowMod_act_fieldLength_len
            --rt_act_add_int_field:add(flowMod_act_fieldLength, v_flowMod_act_fieldLength)

            local v_flowMod_act_orchestration_mode = buf(base, flowMod_act_orchestration_mode_len)
            base = base + flowMod_act_orchestration_mode_len
            local rt_act_orchestration_mode = rt_act_add_int_field:add(flowMod_act_orchestration_mode, v_flowMod_act_orchestration_mode)
            local string_flowMod_act_orchestration_mode
            if v_flowMod_act_orchestration_mode:uint() == 0 then
                string_flowMod_act_orchestration_mode = "SamplingRatio"
            elseif v_flowMod_act_orchestration_mode:uint() == 1 then
                string_flowMod_act_orchestration_mode = "ApproximationCompression"
            end
            rt_act_orchestration_mode:set_text("OrchestrationScheme: " .. string_flowMod_act_orchestration_mode)

            local v_flowMod_act_sampling_ratio = buf(base, flowMod_act_sampling_ratio_len)
            base = base + flowMod_act_sampling_ratio_len
            local rt_act_sampling_ratio = rt_act_add_int_field:add(flowMod_act_sampling_ratio, v_flowMod_act_sampling_ratio)
            local string_flowMod_act_sampling_ratio = "1/" .. string.format("%d", v_flowMod_act_sampling_ratio:uint()/8)
            rt_act_sampling_ratio:set_text("SamplingRatio: " .. string_flowMod_act_sampling_ratio)

            --local v_flowMod_act_fieldValue = buf(base, flowMod_act_fieldValue_len)
            --base = base + flowMod_act_fieldValue_len
            --rt_act_add_int_field:add(flowMod_act_fieldValue, v_flowMod_act_fieldValue)

            local v_flowMod_act_mapInfo = buf(base, flowMod_act_mapInfo_len)
            base = base + flowMod_act_mapInfo_len
            rt_act_add_int_field:add(flowMod_act_mapInfo, v_flowMod_act_mapInfo)

            base = base + 34

            local v_flowMod_output = buf(base, flowMod_action_class_len)
            local rt_act_output = rt_app_act:add(flowMod_action_class, v_flowMod_output)
            rt_act_output:set_text("Output")

            local v_flowMod_act_output_type = buf(base, flowMod_act_type_len)
            base = base + flowMod_act_type_len
            rt_act_output:add(flowMod_act_type, v_flowMod_act_output_type)

            local v_flowMod_act_output_length = buf(base, flowMod_act_length_len)
            base = base + flowMod_act_length_len
            rt_act_output:add(flowMod_act_length, v_flowMod_act_output_length)

            local v_flowMod_act_output_portIdType = buf(base, flowMod_act_output_portIdType_len)
            base = base + flowMod_act_output_portIdType_len
            rt_act_output:add(flowMod_act_output_portIdType, v_flowMod_act_output_portIdType)

            base = base + 1

            local v_flowMod_act_output_metadataOffset = buf(base, flowMod_act_output_metadataOffset_len)
            base = base + flowMod_act_output_metadataOffset_len
            rt_act_output:add(flowMod_act_output_metadataOffset, v_flowMod_act_output_metadataOffset)

            local v_flowMod_act_output_metadataLength = buf(base, flowMod_act_output_metadataLength_len)
            base = base + flowMod_act_output_metadataLength_len
            rt_act_output:add(flowMod_act_output_metadataLength, v_flowMod_act_output_metadataLength)

            local v_flowMod_act_output_packetOffset = buf(base, flowMod_act_output_packetOffset_len)
            base = base + flowMod_act_output_packetOffset_len
            rt_act_output:add(flowMod_act_output_packetOffset, v_flowMod_act_output_packetOffset)

            local v_flowMod_act_output_portId = buf(base, flowMod_act_output_portId_len)
            base = base + flowMod_act_output_portId_len
            rt_act_output:add(flowMod_act_output_portId, v_flowMod_act_output_portId)

        elseif(msg_type==16) then t:add(pof_group_mod,buf(current,msg_len))
        elseif(msg_type==17) then t:add(pof_port_mod,buf(current,msg_len))
        elseif(msg_type==18) then t:add(pof_table_mod,buf(current,msg_len))
        elseif(msg_type==19) then t:add(pof_multipart_request,buf(current,msg_len))
        elseif(msg_type==20) then t:add(pof_multipart_reply,buf(current,msg_len))
        elseif(msg_type==21) then t:add(pof_barrier_request,buf(current,msg_len))
        elseif(msg_type==22) then t:add(pof_barrier_reply,buf(current,msg_len))
        elseif(msg_type==23) then t:add(pof_queue_get_config_request,buf(current,msg_len))
        elseif(msg_type==24) then t:add(pof_queue_get_config_reply,buf(current,msg_len))
        elseif(msg_type==25) then t:add(pof_role_request,buf(current,msg_len))
        elseif(msg_type==26) then t:add(pof_role_reply,buf(current,msg_len))
        elseif(msg_type==27) then t:add(pof_get_async_request,buf(current,msg_len))
        elseif(msg_type==28) then t:add(pof_get_async_reply,buf(current,msg_len))
        elseif(msg_type==29) then t:add(pof_set_async,buf(current,msg_len))
        elseif(msg_type==30) then t:add(pof_meter_mod,buf(current,msg_len))
        elseif(msg_type==31) then t:add(pof_counter_mod,buf(current,msg_len))
        elseif(msg_type==32) then t:add(pof_counter_request,buf(current,msg_len))
        elseif(msg_type==33) then t:add(pof_counter_reply,buf(current,msg_len))
        elseif(msg_type==34) then t:add(pof_queryall_request,buf(current,msg_len))
        elseif(msg_type==35) then t:add(pof_queryall_fin,buf(current,msg_len))
        end
        return true
    end

    local function pof_msg_split(buf,current_len,pkt,remain_len,root,t)
        if (remain_len<8 and buf(current_len,1):uint()~=4 and buf(current_len+1,1):uint()>=36) then return false end
        if (buf(current_len+2,2):uint()==remain_len) then
            pof_dispaly_remain_msg(buf(current_len+1,1):uint(),buf,root,current_len,remain_len,t) return true
        else
            pof_dispaly_remain_msg(buf(current_len+1,1):uint(),buf,root,current_len,buf(current_len+2,2):uint(),t)
            current_len=current_len+buf(current_len+2,2):uint()
            remain_len=buf:len()-current_len
            return pof_msg_split(buf,current_len,pkt,remain_len,root,t)
        end
     end

	local function pof_dissector(buf,pkt,root)
	    local buf_len = buf:len();
		if buf_len < 8 then return false end
		local msg_version = buf(0,1)
		local msg_type = buf(1,1)
		local msg_len = buf(2,2)
		local msg_id = buf(4,4)
		if(msg_type:uint()>=36 or msg_version:uint()~=4) then return false end

        local t= root:add(pof_proto,buf)

		t:add(pof_protocol_version,buf(0,1))
		t:add(pof_protocol_type,buf(1,1))
		t:add(pof_msg_len,msg_len:uint())
		t:add(pof_transaction_id,msg_id:uint())
		if buf_len>=8 then
            pkt.cols.protocol:set("POF")
            local m_type = msg_type:uint()
            pof_msg_type_display(m_type,pkt)
            if buf_len==msg_len:uint() then
               --t:add(pof_detail,buf(8,buf_len-8))
               pof_dispaly_remain_msg(m_type,buf,root,8,buf_len-8,t)
            else
               pof_dispaly_remain_msg(m_type,buf,root,0,msg_len:uint(),t)
               remain_len=buf_len-msg_len:uint()
               pof_msg_split(buf,msg_len:uint(),pkt,remain_len,root,t)
            end
        end
        return true
	end
		  
    function pof_proto.dissector(tvb,pinfo,treeitem)
        if pof_dissector(tvb,pinfo,treeitem) then
            -- do nothing
       else
            data_dis:call(tvb,pinfo,treeitem)
        end
    end

    local tcp_port_table = DissectorTable.get("tcp.port")
    tcp_port_table:add(6643, pof_proto)
 end
