using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Regs
{
    public class Section
    {
        public string Name;
        public List<Register> Reglist;

        public Section(string Name)
        {
            this.Name = Name;
            Reglist = new List<Register>();
        }

        public void Add_Register(String Name, UInt32 Address, UInt32 Msb, UInt32 Lsb, UInt32 Count, UInt32 Defaultvalue, String Accesstype)
        {
            Reglist.Add(new Register(this, Name, Address, Msb, Lsb, Count, Defaultvalue, Accesstype));
        }

    }
}
