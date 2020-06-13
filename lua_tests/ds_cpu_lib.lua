require("ds_lib")

DSCPU_INSTR_CNT = 0
DSCPU_INSTR_LIST = {}

function DSCPU_clear_instructions()
   
   DSCPU_INSTR_CNT = 0
   DSCPU_INSTR_LIST = {}
   
end

function DSCPU_addinstruction(instruction)

   DSCPU_INSTR_LIST[DSCPU_INSTR_CNT] = instruction
   DSCPU_INSTR_CNT = DSCPU_INSTR_CNT + 1

end

function DSCPU_transmit(isArm9, commandlist, address)

    if (isArm9 == true) then
      reg_set(0x02000000 + address, ds.Reg_DS_PC9Entry);
   else
      reg_set(0x02000000 + address, ds.Reg_DS_PC7Entry);
   end
   
   --for i = 0, DSCPU_INSTR_CNT - 1 do
   --   print(i..": 0x"..string.format("%X", commandlist[i]))
   --end

   reg_set_block(commandlist, ddrram.Softmap_DS_WRAM, (address / 4))

end

function DSCPU_self_loop()

   DSCPU_addinstruction(0xEAFFFFFE) 

end

function DSCPU_idle_only(isArm9)

   DSCPU_clear_instructions()
   DSCPU_self_loop()
   DSCPU_transmit(isArm9, DSCPU_INSTR_LIST, 10000)

end

function DSCPU_get_rotated_immidiate(value)

   if (value < 256) then
      return value
   else
      print("error, must rotate: ",value)
      return 0
   end

end

function DSCPU_dataproc(opcode, immidiate, set_cond, reg_dest, reg_src1, reg_src2)

   value = 0xE0000000 -- always
   value = value + immidiate * (2^25)
   value = value + opcode * (2^21)
   value = value + set_cond * (2^20)
   value = value + reg_dest * (2^12)
   value = value + reg_src1 * (2^16)
   value = value + reg_src2

   return value

end

function DSCPU_ADD(reg_dest, reg_src1, reg_src2)
                                     --opcode, immidiate, set_cond, reg_dest, reg_src1, reg_src2
   DSCPU_addinstruction(DSCPU_dataproc(     4,         0,        0, reg_dest, reg_src1, reg_src2)) 
end

function DSCPU_ADDI(reg_dest, reg_src1, immidate)
                                     --opcode, immidiate, set_cond, reg_dest, reg_src1, reg_src2
   DSCPU_addinstruction(DSCPU_dataproc(     4,         1,        0, reg_dest, reg_src1, immidate))
end

function DSCPU_SUBI(reg_dest, reg_src1, immidate)
                                     --opcode, immidiate, set_cond, reg_dest, reg_src1, reg_src2
   DSCPU_addinstruction(DSCPU_dataproc(     2,         1,        0, reg_dest, reg_src1, immidate))
end

function DSCPU_LOAD(reg_dest, value)

   immidate = DSCPU_get_rotated_immidiate(value)
                                     --opcode, immidiate, set_cond, reg_dest, reg_src1, reg_src2
   DSCPU_addinstruction(DSCPU_dataproc(    13,         1,        0, reg_dest,        0, immidate))
   
end

function DSCPU_SHIFTLEFT(reg_dest, shiftamount)

   value = reg_dest
   value = value + 0 * (2^5) -- shifttype
   value = value + shiftamount * (2^7) -- shifttype

                                     --opcode, immidiate, set_cond, reg_dest, reg_src1, reg_src2
   DSCPU_addinstruction(DSCPU_dataproc(    13,         0,        0, reg_dest,        0, value))
   
end

function DSCPU_SHIFTRIGHT(reg_dest, shiftamount)

   value = reg_dest
   value = value + 1 * (2^5) -- shifttype
   value = value + shiftamount * (2^7) -- shifttype

                                     --opcode, immidiate, set_cond, reg_dest, reg_src1, reg_src2
   DSCPU_addinstruction(DSCPU_dataproc(    13,         0,        0, reg_dest,        0, value))
   
end

function DSCPU_Single_Data_Transfer(immidiate_reg, pre, up, bytezize, writeback, isLoad, reg_data, reg_addr, offset)

   value = 0xE0000000 -- always
   value = value + (2^26)  -- single data transfer bit
   value = value + immidiate_reg * (2^25)
   value = value + pre * (2^24)
   value = value + up * (2^23)
   value = value + bytezize * (2^22)
   value = value + writeback * (2^21)
   value = value + isLoad * (2^20)
   value = value + reg_addr * (2^16)
   value = value + reg_data * (2^12)
   value = value + offset

   return value
   
end

function DSCPU_LOAD_DATA32(reg_dest, value, offset)

                                                -- immidiate_reg, pre, up, bytezize, writeback, isLoad, reg_data, reg_addr, offset)
   DSCPU_addinstruction(DSCPU_Single_Data_Transfer(            0,   1,  1,        0,         0,      1, reg_data, reg_addr, offset))

end

function DSCPU_WRITE_DATA32(reg_data, reg_addr, offset)

                                                -- immidiate_reg, pre, up, bytezize, writeback, isLoad, reg_data, reg_addr, offset)
   DSCPU_addinstruction(DSCPU_Single_Data_Transfer(            0,   1,  1,        0,         0,      0, reg_data, reg_addr, offset))
   
end

function DSCPU_CLZ(reg_dest, reg_source)

   value = 0xE0000000 -- always
   value = value + 0x16 * (2^20) -- opcode high
   value = value + 0x1 * (2^4)   -- opcode low
   value = value + reg_dest * (2^12)
   value = value + reg_source

   DSCPU_addinstruction(value)
   
end

function DSCPU_BLX1(target, hbit)

   target = target - 8

   if ((target / 4) <=  DSCPU_INSTR_CNT) then
      print("can only jump forward")
   end

   value = 0xF0000000 -- allbits
   value = value + 0x5 * (2^25) -- opcode high
   value = value + hbit * (2^24)
   value = value + ((target / 4) -  DSCPU_INSTR_CNT)

   DSCPU_addinstruction(value)
   
end

function DSCPU_BLX2(targetreg)

   value = 0xE0000000 -- always
   value = value + 0x12 * (2^20) -- opcode high
   value = value + 0x3 * (2^4) -- opcode low
   value = value + targetreg

   DSCPU_addinstruction(value)
   
end

function DSCPU_QADD_all(opcode, reg_dest, reg_src1, reg_src2)

   value = 0xE0000000 -- always
   value = value + 1 * (2^24) -- saturate addsub opcode high
   value = value + 5 * (2^4) -- saturate addsub opcode high
   
   value = value + opcode * (2^21)
   value = value + reg_dest * (2^12)
   value = value + reg_src1 * (2^16)
   value = value + reg_src2

   return value

end

function DSCPU_QADD(reg_dest, reg_src1, reg_src2)
   DSCPU_addinstruction(DSCPU_QADD_all(0, reg_dest, reg_src1, reg_src2))
end
function DSCPU_QSUB(reg_dest, reg_src1, reg_src2)
   DSCPU_addinstruction(DSCPU_QADD_all(1, reg_dest, reg_src1, reg_src2))
end
function DSCPU_QDADD(reg_dest, reg_src1, reg_src2)
   DSCPU_addinstruction(DSCPU_QADD_all(2, reg_dest, reg_src1, reg_src2))
end
function DSCPU_QDSUB(reg_dest, reg_src1, reg_src2)
   DSCPU_addinstruction(DSCPU_QADD_all(3, reg_dest, reg_src1, reg_src2))
end

function DSCPU_MRS_USER(sourcereg)

   value = 0xE0000000 -- always
   value = value + 0x1 * (2^24) -- opcode high
   value = value + 0xF * (2^16) -- opcode MRS
   value = value + sourcereg * (2^12)

   DSCPU_addinstruction(value)
   
end

function DSCPU_MRS_CLEARFLAGS()

   value = 0xE0000000 -- always
   value = value + 0x1 * (2^25) -- opcode high
   value = value + 0x1 * (2^24) -- opcode high
   value = value + 0x1 * (2^21) -- opcode high
   value = value + 0x8 * (2^16) -- field mask
   value = value + 0xF * (2^12) -- should be one

   DSCPU_addinstruction(value)
   
end

function DSCPU_SMULXY(reg_dest, reg_src1, reg_src2, x, y)

   value = 0xE0000000 -- always
   value = value + 0x16 * (2^20) -- opcode high
   value = value + 0x8 * (2^4) -- opcode low
   
   value = value + reg_dest * (2^16)
   value = value + reg_src2 * (2^8)
   value = value + y * (2^6)
   value = value + x * (2^5)
   value = value + reg_src1

   print("0x"..string.format("%X", value))

   DSCPU_addinstruction(value)
   
end

function DSCPU_SMULWY(reg_dest, reg_src1, reg_src2, y)

   value = 0xE0000000 -- always
   value = value + 0x12 * (2^20) -- opcode high
   value = value + 0xA * (2^4) -- opcode low
   
   value = value + reg_dest * (2^16)
   value = value + reg_src2 * (2^8)
   value = value + y * (2^6)
   value = value + reg_src1

   print("0x"..string.format("%X", value))

   DSCPU_addinstruction(value)
   
end

function DSCPU_SMLAXY(reg_dest, reg_src1, reg_src2, reg_add, x, y)

   value = 0xE0000000 -- always
   value = value + 0x10 * (2^20) -- opcode high
   value = value + 0x8 * (2^4) -- opcode low
   
   value = value + reg_dest * (2^16)
   value = value + reg_add  * (2^12)
   value = value + reg_src2 * (2^8)
   value = value + y * (2^6)
   value = value + x * (2^5)
   value = value + reg_src1

   print("0x"..string.format("%X", value))

   DSCPU_addinstruction(value)
   
end

function DSCPU_SMLAWY(reg_dest, reg_src1, reg_src2, reg_add, y)

   value = 0xE0000000 -- always
   value = value + 0x12 * (2^20) -- opcode high
   value = value + 0x8 * (2^4) -- opcode low
   
   value = value + reg_dest * (2^16)
   value = value + reg_add  * (2^12)
   value = value + reg_src2 * (2^8)
   value = value + y * (2^6)
   value = value + reg_src1

   print("0x"..string.format("%X", value))

   DSCPU_addinstruction(value)
   
end

function DSCPU_SMLALXY(reg_src1, reg_src2, reg_add_hi, reg_add_lo, x, y)

   value = 0xE0000000 -- always
   value = value + 0x14 * (2^20) -- opcode high
   value = value + 0x8 * (2^4) -- opcode low
   
   value = value + reg_add_hi * (2^16)
   value = value + reg_add_lo * (2^12)
   value = value + reg_src2 * (2^8)
   value = value + y * (2^6)
   value = value + x * (2^5)
   value = value + reg_src1

   print("0x"..string.format("%X", value))

   DSCPU_addinstruction(value)
   
end

function DSCPU_LDRDSTRD(store, reg_addr, pre, up, immidate, writeback, reg_value1, immidiate_reg_value)

   value = 0xE0000000 -- always
   value = value + 0xD * (2^4) -- opcode low
   value = value + store * (2^5) -- opcode low
   
   value = value + pre * (2^24)
   value = value + up * (2^23)
   value = value + immidate * (2^22)
   value = value + writeback * (2^21)
   
   value = value + reg_addr * (2^16)
   value = value + reg_value1 * (2^12)

   if (immidate == 1) then
      value = value + math.floor(immidiate_reg_value / 16) * (2^8)
      value = value + binary_and(immidiate_reg_value, 0xF)
   else
      value = value + immidiate_reg_value
   end

   print("0x"..string.format("%X", value))

   return value
   
end

function DSCPU_LDRD(reg_addr, pre, up, immidate, writeback, reg_value1, immidiate_reg_value)
   value = DSCPU_LDRDSTRD(0, reg_addr, pre, up, immidate, writeback, reg_value1, immidiate_reg_value)
   DSCPU_addinstruction(value)
end

function DSCPU_STRD(reg_addr, pre, up, immidate, writeback, reg_value1, immidiate_reg_value)
   value = DSCPU_LDRDSTRD(1, reg_addr, pre, up, immidate, writeback, reg_value1, immidiate_reg_value)
   DSCPU_addinstruction(value)
end

function DSCPU_HALT9()

   DSCPU_addinstruction(0xEE070F90)
   
end

function DSCPU_DTCMREGION_TOx01000000()

   DSCPU_LOAD(0, 1)
   DSCPU_SHIFTLEFT(0, 24)
   DSCPU_addinstruction(0xEE090F11)
   
end

