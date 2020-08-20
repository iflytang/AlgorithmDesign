do
    --Э������ΪDT����Packet Details������ʾΪNselab.Zachary DT
    local p_DT = Proto("Spec","SpcetrumCollection")
    --Э��ĸ����ֶ�
    local f_identifier = ProtoField.bytes("Spec.Report","Report",base.NONE)
    local f_num = ProtoField.uint8("Spec.numbers","Num",base.None)
    local f_pos = ProtoField.uint8("Spec.position","Position",base.None)
    local f_type= ProtoField.uint8("Spec.type","Type",base.None)
    local f_degree = ProtoField.uint8("Spec.degree","Degree",base.None)
    --�����base����ʾ��ʱ��Ľ��ƣ���ϸ�ɲο�https://www.wireshark.org/docs/wsdg_html_chunked/lua_module_Proto.html#lua_class_ProtoField
    --local f_speed = ProtoField.uint8("DT.speed", "Speed", base.HEX)

    --�����DTЭ���ȫ���ֶζ��ӵ�p_DT���������fields�ֶ���
    p_DT.fields = {f_identifier, f_num, f_pos, f_type, f_degree}
    
    --�����ǻ�ȡdata���������
    local data_dis = Dissector.get("data")
    
    local function DT_dissector(buf,pkt,root)
        local buf_len = buf:len();
        if buf_len < 10 then
            return false
        else
            pkt.cols.protocol = "Collection"
            local t = root:add(p_DT,buf)
            t:set_text("Compressed_Spectrum")
            pkt.cols.info:set("Compressed Spectrum Vectors")
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
    udp_encap_table:add(10254, p_DT)
end