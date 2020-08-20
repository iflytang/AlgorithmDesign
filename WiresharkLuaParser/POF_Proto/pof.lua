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
            pof_queryall_fin
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
