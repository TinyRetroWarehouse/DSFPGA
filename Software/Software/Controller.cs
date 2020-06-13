using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Software
{
    public partial class Controller : Form
    {
        public Controller()
        {
            InitializeComponent();
        }

        private void Controller_KeyDown(object sender, KeyEventArgs e)
        {
            switch (e.KeyData)
            {
                case Keys.A: Regs.StatRegs.regs.ds.Reg_DS_KeyA.write(1); break;
                case Keys.S: Regs.StatRegs.regs.ds.Reg_DS_KeyB.write(1); break;
                case Keys.Q: Regs.StatRegs.regs.ds.Reg_DS_KeyL.write(1); break;
                case Keys.W: Regs.StatRegs.regs.ds.Reg_DS_KeyR.write(1); break;
                case Keys.X: Regs.StatRegs.regs.ds.Reg_DS_KeyX.write(1); break;
                case Keys.Y: Regs.StatRegs.regs.ds.Reg_DS_KeyY.write(1); break;
                case Keys.D: Regs.StatRegs.regs.ds.Reg_DS_KeyStart.write(1); break;
                case Keys.F: Regs.StatRegs.regs.ds.Reg_DS_KeySelect.write(1); break;
                case Keys.Up: Regs.StatRegs.regs.ds.Reg_DS_KeyUp.write(1); break;
                case Keys.Down: Regs.StatRegs.regs.ds.Reg_DS_KeyDown.write(1); break;
                case Keys.Left: Regs.StatRegs.regs.ds.Reg_DS_KeyLeft.write(1); break;
                case Keys.Right: Regs.StatRegs.regs.ds.Reg_DS_KeyRight.write(1); break;

                case Keys.Space: Regs.StatRegs.regs.ds.Reg_DS_lockspeed.write(0); break;

                case Keys.Escape: Cursor.Clip = Rectangle.Empty; this.Close(); break;
            }
        }

        private void Controller_KeyUp(object sender, KeyEventArgs e)
        {
            switch (e.KeyData)
            {
                case Keys.A: Regs.StatRegs.regs.ds.Reg_DS_KeyA.write(0); break;
                case Keys.S: Regs.StatRegs.regs.ds.Reg_DS_KeyB.write(0); break;
                case Keys.Q: Regs.StatRegs.regs.ds.Reg_DS_KeyL.write(0); break;
                case Keys.W: Regs.StatRegs.regs.ds.Reg_DS_KeyR.write(0); break;
                case Keys.X: Regs.StatRegs.regs.ds.Reg_DS_KeyX.write(0); break;
                case Keys.Y: Regs.StatRegs.regs.ds.Reg_DS_KeyY.write(0); break;
                case Keys.D: Regs.StatRegs.regs.ds.Reg_DS_KeyStart.write(0); break;
                case Keys.F: Regs.StatRegs.regs.ds.Reg_DS_KeySelect.write(0); break;
                case Keys.Up: Regs.StatRegs.regs.ds.Reg_DS_KeyUp.write(0); break;
                case Keys.Down: Regs.StatRegs.regs.ds.Reg_DS_KeyDown.write(0); break;
                case Keys.Left: Regs.StatRegs.regs.ds.Reg_DS_KeyLeft.write(0); break;
                case Keys.Right: Regs.StatRegs.regs.ds.Reg_DS_KeyRight.write(0); break;

                case Keys.Space: Regs.StatRegs.regs.ds.Reg_DS_lockspeed.write(1); break;
            }
        }

        private void Controller_MouseEnter(object sender, EventArgs e)
        {
            Cursor.Clip = this.Bounds;
        }

        private void Controller_MouseMove(object sender, MouseEventArgs e)
        {
            Regs.StatRegs.regs.ds.Reg_DS_TouchX.write((uint)e.X / 2);
            Regs.StatRegs.regs.ds.Reg_DS_TouchY.write((uint)e.Y / 2);
        }

        private void Controller_MouseDown(object sender, MouseEventArgs e)
        {
            Regs.StatRegs.regs.ds.Reg_DS_Touch.write(1);
        }
        private void Controller_MouseUp(object sender, MouseEventArgs e)
        {
            Regs.StatRegs.regs.ds.Reg_DS_Touch.write(0);
        }
    }
}
