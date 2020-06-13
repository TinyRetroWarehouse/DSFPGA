using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Regs
{
    public class Register
    {
        public Section Parent_Section;

        public String Name;
        public UInt32 Address;
        public UInt32 Msb;
        public UInt32 Lsb;
        public UInt32 Count;
        public UInt32 Defaultvalue;
        public String Accesstype;

        public Register(Section Parent_Section, String Name, UInt32 Address, UInt32 Msb, UInt32 Lsb, UInt32 Count, UInt32 Defaultvalue, String Accesstype)
        {
            this.Parent_Section = Parent_Section;
            this.Name = Name;
            this.Address = Address;
            this.Msb = Msb;
            this.Lsb = Lsb;
            this.Count = Count;
            this.Defaultvalue = Defaultvalue;
            this.Accesstype = Accesstype;
        }

        private UInt32 filter(UInt32 value_in)
        {
            UInt32 filter = ((((UInt32)Math.Pow(2, this.Msb + 1)) - 1) - (((UInt32)Math.Pow(2, this.Lsb)) - 1));
            UInt32 value = (value_in & filter) / (UInt32)Math.Pow(2, this.Lsb);
            return value;
        }

        public UInt32[] read_block(UInt32 regindex, UInt32 length)
        {
            UInt32[] results = new UInt32[length];
            for (int i = 0; i < length; i++)
            {
                results[i] = 0;
            }

            if (regindex + length <= Count)
            {
                UInt32[] hw_value = iotxt_connect.reg_getblock(this, regindex, length);
                for (int i = 0; i < length; i++)
                {
                    hw_value[i] = filter(hw_value[i]);
                }
                results = hw_value;
            }
            else
            {
                MessageBox.Show("Regindex not available");
                return results;
            }

            return results;
        }

        public UInt32 read(UInt32 regindex)
        {
            UInt32[] result = read_block(regindex, 1);
            return result[0];
        }

        public UInt32 read()
        {
            return read(0);
        }

        public UInt32[] read_whole()
        {
            return read_block(0, this.Count);
        }

        public void write(UInt32[] values, UInt32 regindex)
        {
            for (UInt32 i = 0; i < values.Length; i++)
            {
                values[i] = values[i] * (UInt32)Math.Pow(2, this.Lsb);
                values[i] = filter(values[i]);
                values[i] = values[i] * (UInt32)Math.Pow(2, this.Lsb);
            }
            iotxt_connect.reg_setblock(values, this, regindex);
        }

        public void write(UInt32[] values)
        {
            write(values, 0);
        }

        public void write(UInt32 value, UInt32 regindex)
        {
            List<Register> regs = new List<Register>();

            if (Parent_Section != null)
            {
                regs = Parent_Section.Reglist.FindAll(o => o.Address <= Address && ((o.Address + o.Count - 1) >= Address));
            }

            uint old_value = 0;
            if (regs.Count > 1)
            {
                old_value = iotxt_connect.reg_getblock(this, regindex, 1)[0];
                UInt32 filter = ~((((UInt32)Math.Pow(2, this.Msb + 1)) - 1) - (((UInt32)Math.Pow(2, this.Lsb)) - 1));
                old_value = old_value & filter;
            }

            value = value * (UInt32)Math.Pow(2, this.Lsb);
            value = filter(value);
            value = value * (UInt32)Math.Pow(2, this.Lsb);
            value |= old_value;
            iotxt_connect.reg_set(value, this, regindex);
        }

        public void write(UInt32 value)
        {
            write(value, 0);
        }

        public void setBit(int bit, bool value)
        {
            uint oldvalue = read(0);
            uint newvalue = oldvalue;
            if (value)
            {
                newvalue = newvalue | (uint)(1 << bit);
            }
            else
            {
                newvalue = newvalue & ~((uint)(1 << bit));
            }
            write(newvalue);
        }

        public UInt32 get_addr(UInt32 regindex)
        {
            return this.Address + regindex;
        }

        public Int32 get_index(UInt32 address)
        {
            Int32 index = -1;

            if ((this.Address <= address) && ((this.Address + this.Count - 1) >= address))
            {
                index = (int)(address - this.Address);
            }

            return index;
        }

    }
}
