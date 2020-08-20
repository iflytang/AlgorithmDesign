do
    --Э������ΪDT����Packet Details������ʾΪNselab.Zachary DT
    local p_DT = Proto("AR","AnomalyReport")
    --Э��ĸ����ֶ�
    local f_identifier = ProtoField.bytes("AR.Report","Report",base.NONE)
    local f_num = ProtoField.uint8("AR.numbers","Lighpaht_ID",base.None)
    local f_pos = ProtoField.uint8("AR.position","Position",base.None)
    local f_type= ProtoField.uint8("AR.type","Type",base.None)
    local f_degree = ProtoField.uint8("AR.degree","Severity",base.None)
    --�����base����ʾ��ʱ��Ľ��ƣ���ϸ�ɲο�https://www.wireshark.org/docs/wsdg_html_chunked/lua_module_Proto.html#lua_class_ProtoField
    --local f_speed = ProtoField.uint8("DT.speed", "Speed", base.HEX)

    --�����DTЭ���ȫ���ֶζ��ӵ�p_DT���������fields�ֶ���
    p_DT.fields = {f_identifier, f_num, f_pos, f_type, f_degree}
    
    --�����ǻ�ȡdata���������
    local data_dis = Dissector.get("data")
    
    local function DT_dissector(buf,pkt,root)
        local buf_len = buf:len();
        if buf_len < 2 then
            return false
        elseif buf_len > 400 then
            pkt.cols.protocol = "Lightpath"

            local t = root:add(p_DT,buf)
            t:set_text("Spectrum")
            pkt.cols.info:set("Lightpath data")
            return true
        else
            pkt.cols.protocol = "Anomaly"

            local t = root:add(p_DT,buf)
            t:set_text("Anomaly_Report")
            local parse_base = 0

            --��֤һ��identifier����ֶ��ǲ���0x12,������ǵĻ�����Ϊ������Ҫ������packet
            local v_identifier = buf(parse_base, 7)
            local v_f_number = buf(parse_base+19, 1)
            local v_f_pos = buf(parse_base+30, 1)
            local v_f_type = buf(parse_base+37, 1)
            local v_f_degree = buf(parse_base+46, 1)
    --        local base = 0x30:uint()
            pkt.cols.info:set("Anomaly: "..v_f_number:string())
            --if (v_identifier:uint() ~= 0x12)
            --then return false end

            --ȡ�������ֶε�ֵ
            --local v_speed = buf(1, 1)

            --����֪�����ҵ�Э���ˣ����Ĵ����Packet Details
    --        local t = root:add(p_DT,buf)
            --��Packet List�����Protocol�п���չʾ��Э�������
    --        pkt.cols.protocol = "Anomaly_Report"
            --�����ǰѶ�Ӧ���ֶε�ֵ��д��ȷ��ֻ��t:add���ĲŻ���ʾ��Packet Details��Ϣ��. ������֮ǰ����fields��ʱ��Ҫ�����п��ܳ��ֵĶ�д�ϣ�����ʵ�ʽ�����ʱ�����ĳЩ�ֶ�û���֣��Ͳ�Ҫ������add
    --        t:add(f_identifier,v_identifier)
            t:add(f_num,v_f_number:string())
            t:add(f_pos,v_f_pos:string())
            t:add(f_type,v_f_type:string())
            t:add(f_degree,v_f_degree:string())

            return true
        end
    end
    
    --��δ�����Ŀ��Packet��������ʱ����Wireshark�Զ����õģ���p_DT�ĳ�Ա����
    function p_DT.dissector(buf,pkt,root) 
        if DT_dissector(buf,pkt,root) then
            --valid DT diagram
        else
            --data���dissector�����Ǳز����ٵģ������ֲ����ҵ�Э��ʱ����Ӧ�õ���data
            data_dis:call(buf,pkt,root)
        end
    end
    
    local udp_encap_table = DissectorTable.get("tcp.port")
    --��Ϊ���ǵ�DTЭ��Ľ��ܶ˿ڿ϶���50002����������ֻ��Ҫ��ӵ�"udp.port"���DissectorTable�����ָ��ֵΪ50002���ɡ�
    udp_encap_table:add(10023, p_DT)
end