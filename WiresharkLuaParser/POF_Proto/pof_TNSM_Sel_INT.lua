-- TNSM's pof revision: Sel-INT: A Runtime-Programmable Selective In-Band Network Telemetry System

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

    -- group mod members
    local group_command = ProtoField.uint8("group_mod.group_command", "group_command", base.HEX)  -- group_mod
    local group_type = ProtoField.uint8("group_mod.group_type", "group_type", base.HEX)
    local bucket_num = ProtoField.uint8("group_mod.bucket_num", "bucket_num", base.DEC)
    local group_id = ProtoField.uint32("group_mod.group_id", "group_id", base.DEC)
    local counter_id = ProtoField.uint32("group_mod.counter_id", "counter_id", base.DEC)
    local slot_id = ProtoField.uint16("group_mod.slot_id", "slot_id", base.DEC)
    local action_num = ProtoField.uint16("bucket.action_num", "action_num", base.DEC)             -- bucket
    local weight = ProtoField.uint16("bucket.weight", "weight", base.DEC)
    local watch_slot_id = ProtoField.uint16("bucket.watch_slot_id", "watch_slot_id", base.HEX)
    local watch_port = ProtoField.uint8("bucket.watch_port", "watch_port", base.HEX)
    local watch_group = ProtoField.uint32("bucket.watch_group", "watch_group", base.HEX)           -- action header
    local action_type = ProtoField.uint16("actions.action_type", "action_type", base.HEX)
    local action_len = ProtoField.uint16("actions.action_len", "action_len", base.Hex)
	local port_id_type = ProtoField.uint8("output.port_id_type", "port_id_type", base.HEX)         -- output
	local metadata_offset = ProtoField.uint16("output.metadata_offset", "metadata_offset", base.DEC)
	local metadata_len = ProtoField.uint16("output.metadata_len", "metadata_len", base.DEC)
	local packet_offset = ProtoField.uint32("output.packet_offset", "packet_offset", base.DEC)
	local out_port = ProtoField.uint32("output.out_port", "out_port", base.DEC)
	local field_id = ProtoField.uint16("add_int_field.field_id", "field_id", base.HEX)              -- add_int_field
	local offset = ProtoField.uint16("add_int_field.offset", "offset", base.DEC)
	local length = ProtoField.uint32("add_int_field.length", "length", base.DEC)
	local mapInfo = ProtoField.uint8("add_int_field.mapInfo", "mapInfo", base.HEX)
	local increment = ProtoField.uint32("modify_field.increment", "increment", base.DEC)            -- modify_field
 
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

    -- parse pof group mod
        group_command,
        group_type,
        bucket_num,
        group_id,
        counter_id,
        slot_id,
	-- parse pof buckets in the group mod, array
        action_num,
        weight,
        watch_slot_id,
        watch_port,
        watch_group,
	-- parse actions in the buckets, followed with action_data[], array
        action_type,
        action_len,
	-- action:output
		port_id_type,
		metadata_offset,
		metadata_len,
		packet_offset,
		out_port,
	-- action: add_int_field
		field_id,
		offset,
		length,
		mapInfo,
	-- action: modify_field
		increment
	}

	local data_dis = Dissector.get("data") 

    local function pof_msg_type_display(m_type,pkt, buf, root, current, msg_len, t)
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
        elseif (m_type==16) then
            pkt.cols.info:set("Type:POFT_GROUP_MOD")
            local base = current + 8; -- group mod base location, remove header
            -- struct ofp11_pof_group_mod
            t = t:add(pof_transaction_id, buf(4, 4))
            t:set_text("SelGroupMod")
            t:add(group_command, buf(base, 1))    -- uint8
            t:add(group_type, buf(base+1, 1))     -- uint8
            t:add(bucket_num, buf(base+2, 1))     -- uint8
            -- pad 1B zero
            t:add(group_id, buf(base+4, 4))       -- uint32
            t:add(counter_id, buf(base+8, 4))     -- uint32
            t:add(slot_id, buf(base+12, 2))
            -- pad 2B zeros
            t1 = t:add(slot_id, buf(base+12, 2))
            t2 = t:add(slot_id, buf(base+12, 2))

            -- struct ofp11_pof_bucket, array[6], 304B * 6

            -- parse bucket0: action=output
            t1:set_text("bucket0")
            t1:add(action_num, buf(base+16, 2))    -- uint16
            t1:add(weight, buf(base+18, 2))        -- uint16
            t1:add(watch_slot_id, buf(base+20, 2)) -- uint16
            t1:add(watch_port, buf(base+22, 1))    -- uint8
            -- pad 1B zero
            t1:add(watch_group, buf(base+24, 4))
            t1 = t1:add(watch_group, buf(base+24, 4))   -- uint32
            -- pad 4B zeros
            -- parse action: only output here
            t1:set_text("actionList")
            t1 = t1:add(action_type, buf(base+32, 2))    -- uint16
            t1:add(action_type, buf(base+32, 2))        -- uint32
            t1:set_text("output")
            t1:add(action_len, buf(base+34, 2))     -- uint16
            t1:add(port_id_type, buf(base+36, 1))   -- uint8
            -- pad 1B zero
            t1:add(metadata_offset, buf(base+38, 2))
            t1:add(metadata_len, buf(base+40, 2))
            t1:add(packet_offset, buf(base+42, 2))
            t1:add(out_port, buf(base+44, 4))
            -- pad 8B zeros + 24B + 48B * 5 = 272

            -- parse bucket1: action=add_int_field + modify_field + output
            t2:set_text("bucket1")
            t2:add(action_num, buf(base+320, 2))  -- 272+44+4 = 320
            t2:add(weight, buf(base+322, 2))
            t2:add(watch_slot_id, buf(base+324, 2))
            t2:add(watch_port, buf(base+326, 1))
            -- pad 1B zero
            t2:add(watch_group, buf(base+328, 4))
            -- pad 4B zeros

            -- parse bucket1.actions
            t2 = t2:add(watch_group, buf(base+328, 4))
            t2:set_text("actionList")
            add_int_field = t2:add(action_type, buf(base+336, 2))
            modify_field = t2:add(action_type, buf(base+336, 2))
            output = t2:add(action_type, buf(base+336, 2))

            add_int_field:add(action_type, buf(base+336, 2))   -- add_int_field
            add_int_field:set_text("add_int_field")
            add_int_field:add(action_len, buf(base+338, 2))
            add_int_field:add(field_id, buf(base+340, 2))
            add_int_field:add(offset, buf(base+342, 2))
            add_int_field:add(length, buf(base+344, 4))
            -- get tag_value[0]
            add_int_field:add(mapInfo, buf(base+348, 1))
            -- pad 4B

            modify_field:set_text("modify_field")   -- modify_field
            modify_field:add(action_type, buf(base+384, 2))
            modify_field:add(action_len, buf(base+386, 2))
            modify_field:add(field_id, buf(base+388, 2))
            modify_field:add(offset, buf(base+390, 2))
            modify_field:add(length, buf(base+392, 2))
            -- pad 2B
            modify_field:add(increment, buf(base+396, 4))

            output:set_text("output")             -- output
            output:add(action_type, buf(base+432, 2))
            output:add(action_len, buf(base+434, 2))
            output:add(port_id_type, buf(base+436, 1))
            -- pad 1B
            output:add(metadata_offset, buf(base+438, 2))
            output:add(metadata_len, buf(base+440, 2))
            output:add(packet_offset, buf(base+442, 2))
            output:add(out_port, buf(base+444, 4))
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
        elseif(msg_type==15) then t:add(pof_flow_mod,buf(current,msg_len))
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
                t:add(pof_detail,buf(8,buf_len-8))
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
