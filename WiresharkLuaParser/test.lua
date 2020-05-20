--
-- Created by IntelliJ IDEA.
-- User: tsf
-- Date: 20-5-19
-- Time: 下午2:23
-- version lua5.2
-- To change this template use File | Settings | File Templates.
--


require("bit32")

print ('test')

if (bit32.band(0xff, 0xff) == 0xff) then      -- must contain device_id
    print ("xxx")
else
    print ("yyyy")
end

for i=1,3 do
    print (i)
end

local v_int_h_mapInfo = 0x001f;
local bit_one = 0x01;
if (bit32.band(v_int_h_mapInfo, bit_one)) then      -- must contain device_id
    print("test")
else
    return false
end
