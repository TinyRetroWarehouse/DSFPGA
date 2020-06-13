using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Diagnostics;
using System.IO;
using System.Threading;

namespace Software
{
    public partial class MainWindow : Form
    {
        Form monitor;
        Form controller;
        Form coretools;
        Form filemng;

        public MainWindow()
        {
            InitializeComponent();
        }


        private void MainWindow_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (monitor != null)
            {
                monitor.Close();
            }
            if (coretools != null)
            {
                coretools.Close();
            }
            if (filemng != null)
            {
                filemng.Close();
            }
        }

        private void button_Monitor_Click(object sender, EventArgs e)
        {
            monitor = new MonitorWindow();
            monitor.Show();
        }

        private void button_controller_Click(object sender, EventArgs e)
        {
            controller = new Controller();
            controller.Show();
        }

        private void execute_with_console(string commandtext, string filename)
        {
            richTextBox_console.Text += "##################################################\n";
            richTextBox_console.Text += "######  " + commandtext +"\n";
            richTextBox_console.Text += "##################################################\n";

            Process myProcess = new Process();
            ProcessStartInfo myProcessStartInfo = new ProcessStartInfo(filename);
            myProcessStartInfo.UseShellExecute = false;
            myProcessStartInfo.WindowStyle = ProcessWindowStyle.Minimized;
            myProcessStartInfo.CreateNoWindow = true;
            myProcessStartInfo.RedirectStandardOutput = true;
            myProcess.StartInfo = myProcessStartInfo;
            myProcess.Start();
            StreamReader myStreamReader = myProcess.StandardOutput;
            while (!myStreamReader.EndOfStream)
            {
                richTextBox_console.Text += myStreamReader.ReadLine() + "\n";
                richTextBox_console.SelectionLength = 0;
                richTextBox_console.SelectionStart = richTextBox_console.TextLength;
                richTextBox_console.ScrollToCaret();
                richTextBox_console.Select();
            }
            myProcess.WaitForExit();
            myProcess.Close();

            richTextBox_console.Text += "##################################################\n";
            richTextBox_console.Text += "######  done \n";

            richTextBox_console.SelectionLength = 0;
            richTextBox_console.SelectionStart = richTextBox_console.TextLength;
            richTextBox_console.ScrollToCaret();
            richTextBox_console.Select();
        }

        private void button_regmap_Click(object sender, EventArgs e)
        {
            execute_with_console("Generate Regmap Lua", "lua_reg_all.bat");
        }

        private void button_regmap_csharp_Click(object sender, EventArgs e)
        {
            execute_with_console("Generate Regmap C#", "regmapcsharp.exe");
        }

        private void button_compilevhdl_Click(object sender, EventArgs e)
        {
            execute_with_console("Map Libraries", "vmap_all.bat");
            execute_with_console("Compile VHDL", "vcom_all.bat");
        }

        private void button_Vsimquiet_Click(object sender, EventArgs e)
        {
            VSim.open_vsim(true);
        }

        private void button_vsimgui_Click(object sender, EventArgs e)
        {
            VSim.open_vsim(false);
        }

        private void button_rs232fileconnect_Click(object sender, EventArgs e)
        {
            Process.Start("rs232comm.exe");
            Regs.iotxt_connect.filepointer = 0;
        }

        private void button_testspeed_Click(object sender, EventArgs e)
        {
            UInt32 testlength;
            TimeSpan diff;
            UInt64 ms;

            richTextBox_console.Text += "########## Running Communication Speedtest #############\n";
            DateTime start;

            testlength = 2;
            ms = 0;
            while (ms < 1000)
            {
                testlength *= 2;
                start = DateTime.Now;
                for (UInt32 i = 0; i < testlength; i++)
                {
                    Regs.StatRegs.regs.ddrram.Reg_Data.read(i % 1024);
                }
                diff = DateTime.Now - start;
                ms = (UInt32)diff.TotalMilliseconds;
            }
            richTextBox_console.Text += "Targetreads: " + (testlength * 1000 / ms).ToString() + "/s" + "\n";

            testlength = 2;
            ms = 0;
            while (ms < 1000)
            {
                testlength *= 2;
                start = DateTime.Now;
                Regs.StatRegs.regs.ddrram.Reg_Data.read_block(0, testlength);
                diff = DateTime.Now - start;
                ms = (UInt32)diff.TotalMilliseconds;
            }
            richTextBox_console.Text += "Targetreads(Blocksize): " + (testlength * 1000 / ms).ToString() + "/s" + "\n";

            testlength = 2;
            ms = 0;
            while (ms < 1000)
            {
                testlength *= 2;
                start = DateTime.Now;
                for (UInt32 i = 0; i < testlength; i++)
                {
                    Regs.StatRegs.regs.ddrram.Reg_Data.write(i % 1024, i % 1024);
                }
                diff = DateTime.Now - start;
                ms = (UInt32)diff.TotalMilliseconds;
            }
            richTextBox_console.Text += "Targetwrites: " + (testlength * 1000 / ms).ToString() + "/s" + "\n";
        }

        private void button_testconnection_Click(object sender, EventArgs e)
        {
            richTextBox_console.Text += "########## Running Communication Selftest #############\n";
            Application.DoEvents();

            const int blocksize = 8192 * 4;

            uint cntvalue = 2;
            int errors = 0;
            int runs = 20;

            while (errors == 0 && runs > 0)
            {
                runs--;

                UInt32[] writeblock = new UInt32[blocksize];
                for (uint i = 0; i < blocksize; i++)
                {
                    writeblock[i] = cntvalue;
                    cntvalue++;
                }
                Regs.StatRegs.regs.ddrram.Softmap_Exchange.write(writeblock);
                //Regs.StatRegs.regs.sdram.Reg_Data.write(writeblock);

                UInt32[] readblock = Regs.StatRegs.regs.ddrram.Softmap_Exchange.read_block(0, blocksize);
                //UInt32[] readblock = Regs.StatRegs.regs.sdram.Reg_Data.read_block(0, blocksize);

                for (uint i = 0; i < blocksize; i++)
                {
                    if (readblock[i] != writeblock[i])
                    {
                        errors++;
                    }
                }
                richTextBox_console.Text += blocksize + " DWords done, Errors: " + errors + "\n";
                Application.DoEvents();
            }

            richTextBox_console.Text += "########## Communication Selftest Done #############\n";
        }

        private void download_file(string filename)
        {
            if (filename.EndsWith(".mp3"))
            {
                if (File.Exists("audioconvert/convert.mp3"))
                {
                    File.Delete("audioconvert/convert.mp3");
                }
                File.Copy(filename, "audioconvert/convert.mp3");

                Process myProcess = new Process();
                ProcessStartInfo myProcessStartInfo = new ProcessStartInfo("audioconvert/ffmpeg.exe");
                myProcessStartInfo.Arguments = "-i convert.mp3 -ac 1 -ar 24000 -y convert.wav";
                myProcessStartInfo.WorkingDirectory = "audioconvert";
                myProcessStartInfo.UseShellExecute = false;
                myProcessStartInfo.WindowStyle = ProcessWindowStyle.Minimized;
                myProcessStartInfo.CreateNoWindow = true;
                myProcess.StartInfo = myProcessStartInfo;
                myProcess.Start();
                myProcess.WaitForExit();
                filename = Path.Combine("audioconvert", Path.GetFileNameWithoutExtension(filename) + ".rwa");

                FileStream fs_wav = new FileStream("audioconvert/convert.wav", FileMode.Open);
                byte[] content = new byte[fs_wav.Length];
                fs_wav.Read(content, 0, (int)fs_wav.Length);
                fs_wav.Close();

                List<byte> rawdata = new List<byte>();
                for (int i = 45; i < content.Length; i += 2)
                {
                    SByte value = (SByte)content[i];
                    rawdata.Add(content[i]);
                }
                File.WriteAllBytes(filename, rawdata.ToArray());
            }

            FileInfo fi = new FileInfo(filename);

            string shortname = Path.GetFileName(filename);

            if (shortname.Length > 30)
            {
                shortname = Path.GetFileNameWithoutExtension(shortname).Substring(0, 25) + Path.GetExtension(shortname);
            }
            uint datasize = (uint)(fi.Length + 3) / 4;
            uint[] data = new uint[2 + shortname.Length + 1 + datasize];
            data[0] = datasize;
            for (int i = 0; i < shortname.Length; i++)
            {
                data[2 + i] = shortname[i];
            }
            data[2 + shortname.Length] = 0;

            int dataindex = 3 + shortname.Length;

            File.SetAttributes(filename, FileAttributes.Normal);
            FileStream fs = new FileStream(filename, FileMode.Open);
            for (int i = 0; i < datasize; i++)
            {
                uint value = 0;
                for (int b = 0; b < 4; b++)
                {
                    if (fs.Position < fs.Length)
                    {
                        value |= (uint)(fs.ReadByte() << ((3 - b) * 8));
                    }
                }
                data[dataindex + i] = value;
            }
            fs.Close();

            Int32 checksum = 0;
            for (int i = 0; i < data.Length; i++)
            {
                checksum = checksum + (Int32)data[i];
            }
            checksum = 0 - checksum;
            data[1] = (UInt32)checksum;

            Regs.StatRegs.regs.ddrram.Softmap_Exchange.write(data, 1);
            Regs.StatRegs.regs.ddrram.Softmap_Exchange.write(1, 0);
        }

        private void receive_file()
        {
            uint request = Regs.StatRegs.regs.ddrram.Softmap_Exchange.read(0);
            if (request == 1)
            {
                uint datasize = Regs.StatRegs.regs.ddrram.Softmap_Exchange.read(1);
                uint dataptr = 2;
                string filename = "";
                while (true)
                {
                    uint namedw = Regs.StatRegs.regs.ddrram.Softmap_Exchange.read(dataptr);
                    dataptr++;
                    if (namedw != 0)
                    {
                        filename += (char)namedw;
                    }
                    else
                    {
                        break;
                    }
                }
                uint[] data = Regs.StatRegs.regs.ddrram.Softmap_Exchange.read_block(dataptr, datasize);

                FileStream fs = new FileStream(Path.Combine("ReceivedData", filename), FileMode.Create);
                for (int i = 0; i < datasize; i++)
                {
                    uint value = data[i];
                    for (int b = 0; b < 4; b++)
                    {
                        fs.WriteByte((byte)(value >> 24));
                        value = value << 8;
                    }
                }
                fs.Close();
            }
            Regs.StatRegs.regs.ddrram.Softmap_Exchange.write(0, 0);
        }

        private void MainWindow_DragDrop(object sender, DragEventArgs e)
        {
            string[] files = (string[])e.Data.GetData(DataFormats.FileDrop);

            download_file(files[0]);
        }

        private void MainWindow_DragEnter(object sender, DragEventArgs e)
        {
            e.Effect = DragDropEffects.Copy;
        }

        private void timer_datareceive_Tick(object sender, EventArgs e)
        {
            if (checkBox_receivedata.Checked)
            {
                receive_file();
            }
        }

        private void comboBox_screenmode_SelectedIndexChanged(object sender, EventArgs e)
        {
            uint Framebuffer_Posx   = 384;
            uint Framebuffer_PosY   =  60;
            uint Framebuffer_SizeX  = 256;
            uint Framebuffer_SizeY  = 192;
            uint Framebuffer_Scale  = 2;  
            uint Framebuffer2_PosX  = 512;
            uint Framebuffer2_PosY  = 450;
            uint Framebuffer2_SizeX = 256;
            uint Framebuffer2_SizeY = 192;
            uint Framebuffer2_Scale = 1;

            switch (comboBox_screenmode.SelectedIndex)
            {
                case 1:
                    Framebuffer_Posx   = 512;
                    Framebuffer_PosY   = 100;
                    Framebuffer_Scale  = 1;
                    Framebuffer2_PosX  = 512;
                    Framebuffer2_PosY  = 292;
                    Framebuffer2_Scale = 1;
                    break;

                case 2:
                    Framebuffer_Posx = 1;
                    Framebuffer_PosY = 120;
                    Framebuffer_Scale = 3;
                    Framebuffer2_PosX = 767;
                    Framebuffer2_PosY = 200;
                    Framebuffer2_Scale = 2;
                    break;

                case 3:
                    Framebuffer2_PosX = 1;
                    Framebuffer2_PosY = 120;
                    Framebuffer2_Scale = 3;
                    Framebuffer_Posx = 767;
                    Framebuffer_PosY = 200;
                    Framebuffer_Scale = 2;
                    break;
            }

            Regs.StatRegs.regs.gpu.Reg_Framebuffer_PosX.write(Framebuffer_Posx);
            Regs.StatRegs.regs.gpu.Reg_Framebuffer_PosY.write(Framebuffer_PosY);
            Regs.StatRegs.regs.gpu.Reg_Framebuffer_SizeX.write(Framebuffer_SizeX);
            Regs.StatRegs.regs.gpu.Reg_Framebuffer_SizeY.write(Framebuffer_SizeY);
            Regs.StatRegs.regs.gpu.Reg_Framebuffer_Scale.write(Framebuffer_Scale);
            Regs.StatRegs.regs.gpu.Reg_Framebuffer2_PosX.write(Framebuffer2_PosX);
            Regs.StatRegs.regs.gpu.Reg_Framebuffer2_PosY.write(Framebuffer2_PosY);
            Regs.StatRegs.regs.gpu.Reg_Framebuffer2_SizeX.write(Framebuffer2_SizeX);
            Regs.StatRegs.regs.gpu.Reg_Framebuffer2_SizeY.write(Framebuffer2_SizeY);
            Regs.StatRegs.regs.gpu.Reg_Framebuffer2_Scale.write(Framebuffer2_Scale);
        }
    }
}
