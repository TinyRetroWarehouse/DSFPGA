using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Software
{
    public static class reg_view
    {
        public static void treeview_generate(TreeView tnc)
        {
            tnc.Nodes.Clear();

            foreach (Regs.Section sect in Regs.StatRegs.regs.Sectionlist)
            {
                tnc.Nodes.Add(sect.Name);
                add_regs(tnc.Nodes[tnc.Nodes.Count - 1], sect);
            }
        }

        public static string update_node(Regs.Register reg)
        {
            UInt32 value = reg.read(0);
            return reg.Name + " => " + value.ToString() + "(0x" + value.ToString("X8") + ")";
        }

        private static void add_regs(TreeNode node, Regs.Section sect)
        {
            foreach (Regs.Register reg in sect.Reglist)
            {
                node.Nodes.Add(reg.Name);
                node.Nodes[node.Nodes.Count - 1].Tag = reg;
            }
        }


        public static void datagrid_details(DataGridView grid, Regs.Register reg, UInt32 regindex)
        {
            grid.Rows.Clear();

            if (reg.Count == 1)
            {
                grid.Rows.Add("Name", reg.Name);
            }
            else
            {
                grid.Rows.Add("Name", reg.Name + "[" + regindex.ToString() + "]");
            }

            UInt32 value = reg.read(regindex);
            grid.Rows.Add("Content", value.ToString() + "(0x" + value.ToString("X8") + ")");
            grid.Rows.Add("Address", reg.Address.ToString());
            grid.Rows.Add("Count", reg.Count);
            grid.Rows.Add("Msb", reg.Msb);
            grid.Rows.Add("Lsb", reg.Lsb);
            grid.Rows.Add("Default", reg.Defaultvalue);
            grid.Rows.Add("Accesstype", reg.Accesstype);
        }

        public static UInt32[] get_datablock(Regs.Register reg, UInt32 length)
        {
            return Regs.iotxt_connect.reg_getblock(reg, 0, length);
        }


    }
}
