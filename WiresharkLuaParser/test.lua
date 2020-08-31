--
-- Created by IntelliJ IDEA.
-- User: tsf
-- Date: 20-5-19
-- Time: 下午2:23
-- version lua5.2
-- To change this template use File | Settings | File Templates.
--

-- usage: lua test.lua

require("bit32")

--print ('test')
--
--if (bit32.band(0xff, 0xff) == 0xff) then      -- must contain device_id
--    print ("xxx")
--else
--    print ("yyyy")
--end
--
--for i=1,3 do
--    print (i)
--end
--
--local v_int_h_mapInfo = 0x001f;
--local bit_one = 0x01;
--if (bit32.band(v_int_h_mapInfo, bit_one)) then      -- must contain device_id
--    print("test")
--else
--    return false
--end


local v_int_h_mapInfo = 0x003f;
local CPU_BASED_MAPINFO = 0x02ff            -- ovs-pof
local bit_one = 0x01

local switch_mapInfo = bit32.band(v_int_h_mapInfo, CPU_BASED_MAPINFO)

print("v_int_h_mapInfo: " .. v_int_h_mapInfo)
print("switch_mapInfo: " .. switch_mapInfo .. "\n")


if (bit32.band(switch_mapInfo, bit32.lshift(bit_one, 1)) ~= 0x00) then
    print(string.format("%04x\t %04x\t = %04x", switch_mapInfo, bit32.lshift(bit_one, 1), bit32.band(switch_mapInfo, bit32.lshift(bit_one, 1))))
    print("test 1: " .. bit32.band(switch_mapInfo, bit32.lshift(bit_one, 1)) .. "\n")
end

if (bit32.band(switch_mapInfo, bit32.lshift(bit_one, 2)) ~= 0x00) then
    print(string.format("%04x\t & %04x\t = %04x", switch_mapInfo, bit32.lshift(bit_one, 2), bit32.band(switch_mapInfo, bit32.lshift(bit_one, 2))))
    print("test 2: " .. bit32.band(switch_mapInfo, bit32.lshift(bit_one, 2)) .. "\n")
end

if (bit32.band(switch_mapInfo, bit32.lshift(bit_one, 3)) ~= 0x00) then
    print(string.format("%04x\t %04x\t = %04x", switch_mapInfo, bit32.lshift(bit_one, 3), bit32.band(switch_mapInfo, bit32.lshift(bit_one, 3))))
    print("test 3: " .. bit32.band(switch_mapInfo, bit32.lshift(bit_one, 3)) .. "\n")
end

if (bit32.band(switch_mapInfo, bit32.lshift(bit_one, 4)) ~= 0x00) then
    print(string.format("%04x\t %04x\t = %04x", switch_mapInfo, bit32.lshift(bit_one, 4), bit32.band(switch_mapInfo, bit32.lshift(bit_one, 4))))
    print("test 4: " .. bit32.band(switch_mapInfo, bit32.lshift(bit_one, 4)) .. "\n")
end

if (bit32.band(switch_mapInfo, bit32.lshift(bit_one, 5)) ~= 0x00) then
    print(string.format("%04x\t %04x\t = %04x", switch_mapInfo, bit32.lshift(bit_one, 5), bit32.band(switch_mapInfo, bit32.lshift(bit_one, 5))))
    print("test 5: " .. bit32.band(switch_mapInfo, bit32.lshift(bit_one, 5)) .. "\n")
end

if (bit32.band(switch_mapInfo, bit32.lshift(bit_one, 6)) ~= 0x00) then
    print(string.format("%04x\t %04x\t = %04x", switch_mapInfo, bit32.lshift(bit_one, 6), bit32.band(switch_mapInfo, bit32.lshift(bit_one, 6))))
    print("test 6: " .. bit32.band(switch_mapInfo, bit32.lshift(bit_one, 6)) .. "\n")
end

if (bit32.band(switch_mapInfo, bit32.lshift(bit_one, 7)) ~= 0x00) then
    print(string.format("%04x\t %04x\t = %04x", switch_mapInfo, bit32.lshift(bit_one, 7), bit32.band(switch_mapInfo, bit32.lshift(bit_one, 7))))
    print("test 7: " .. bit32.band(switch_mapInfo, bit32.lshift(bit_one, 7)) .. "\n")
end

if (bit32.band(switch_mapInfo, bit32.lshift(bit_one, 8)) ~= 0x00) then    -- not supported by ovs-pof
    print(string.format("%04x\t %04x\t = %04x", switch_mapInfo, bit32.lshift(bit_one, 8), bit32.band(switch_mapInfo, bit32.lshift(bit_one, 8))))
    print("test 8: " .. bit32.band(switch_mapInfo, bit32.lshift(bit_one, 8)) .. "\n")
end

if (bit32.band(switch_mapInfo, bit32.lshift(bit_one, 9)) ~= 0x00) then
    print(string.format("%04x\t %04x\t = %04x", switch_mapInfo, bit32.lshift(bit_one, 9), bit32.band(switch_mapInfo, bit32.lshift(bit_one, 9))))
    print("test 9: " .. bit32.band(switch_mapInfo, bit32.lshift(bit_one, 9)) .. "\n")
end

local v_test = math.ceil(12.3 / 2)
print(v_test)

local function get_order_of_ber(ber)
   return math.ceil(math.abs(math.log(ber, 10)))
end

local order = get_order_of_ber(4021)
print(order)
