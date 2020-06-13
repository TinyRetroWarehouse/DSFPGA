using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Threading;

namespace Software
{
    public partial class MonitorWindow : Form
    {
        public MonitorWindow()
        {
            InitializeComponent();

            Regs.iotxt_connect.wait_ns(1000);

            reg_view.treeview_generate(treeView_regs);
        }

        private void update_infos(Regs.Register reg, UInt32 regindex)
        {
            treeView_regs.SelectedNode.Text = reg_view.update_node(reg);
            reg_view.datagrid_details(dataGridView_paradetail, reg, regindex);
            webBrowser_doc.DocumentText = "";
        }


        private void treeView_regs_AfterSelect(object sender, TreeViewEventArgs e)
        {
            textBox_regindex.Text = "0";
            textBox_regindex.ReadOnly = true;

            if (treeView_regs.SelectedNode != null)
            {
                if (treeView_regs.SelectedNode.Tag != null)
                {
                    Regs.Register sel_reg = (Regs.Register)treeView_regs.SelectedNode.Tag;

                    update_infos(sel_reg, 0);

                    if (sel_reg.Count > 1)
                    {
                        textBox_regindex.ReadOnly = false;
                    }
                }
            }
            
        }

        private void button_loadblock_Click(object sender, EventArgs e)
        {
            if (treeView_regs.SelectedNode != null)
            {
                if (treeView_regs.SelectedNode.Tag != null)
                {
                    UInt32[] content = reg_view.get_datablock((Regs.Register)treeView_regs.SelectedNode.Tag, 40);

                    string text = "Address    |  Values \n";
                    text += "------------------------------------------------------------";

                    UInt32 addr = ((Regs.Register)treeView_regs.SelectedNode.Tag).Address;

                    for (int i = 0; i < content.Length; i++)
                    {
                        if (i % 4 == 0)
                        {
                            text += "\n";
                            text += "0x" + addr.ToString("X8") + " | ";
                        }
                        else
                        {
                            text += "  ";
                        }
                        addr += 1;
                        text += "0x" + content[i].ToString("X8");
                    }
                    richTextBox_arrayview.Text = text;
                }
            }
        }

        private void button_writevalue_Click(object sender, EventArgs e)
        {
            if (treeView_regs.SelectedNode != null)
            {
                if (treeView_regs.SelectedNode.Tag != null)
                {
                    try
                    {
                        UInt32 value = Convert.ToUInt32(textBox_newvalue.Text);

                        UInt32 regindex = Convert.ToUInt32(textBox_regindex.Text);

                        ((Regs.Register)treeView_regs.SelectedNode.Tag).write(value, regindex);
                        update_infos((Regs.Register)treeView_regs.SelectedNode.Tag, regindex);
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                }
            }
        }

        private void textBox_regindex_Leave(object sender, EventArgs e)
        {
            regindex_changed();
        }

        private void textBox_regindex_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter)
            {
                regindex_changed();
            }
        }

        private void regindex_changed()
        {
            UInt32 index = 0;

            if (UInt32.TryParse(textBox_regindex.Text, out index))
            {
                try
                {
                    update_infos((Regs.Register)treeView_regs.SelectedNode.Tag, index);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
            else
            {
                textBox_regindex.Text = "0";
            }
        }

        private void timer_autoupdate_Tick(object sender, EventArgs e)
        {
            if (checkBox_autoupdate.Checked)
            {
                if (treeView_regs.SelectedNode != null)
                {
                    if (treeView_regs.SelectedNode.Tag.GetType() == typeof(Regs.Register))
                    {
                        update_infos((Regs.Register)treeView_regs.SelectedNode.Tag, 0);
                    }
                }
            }
        }
    }
}
