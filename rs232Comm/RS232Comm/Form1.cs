using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using System.IO;
using FTD2XX_NET;

namespace Debugsw
{
    public partial class Form1 : Form
    {
        FTDI ftdi = new FTDI();
        Thread exchanger;
        string transmit_text = "";
        string receive_text = "";

        public Form1()
        {
            if (File.Exists("input.txt")){ File.Delete("input.txt"); }
            StreamWriter sw = new StreamWriter("input.txt");
            sw.Close();

            if (File.Exists("output.txt")) { File.Delete("output.txt"); }
            StreamWriter sw2 = new StreamWriter("output.txt");
            sw2.Close();

            InitializeComponent();

            timer1_rec.Start();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            uint deviceCount = 0;
            ftdi.GetNumberOfDevices(ref deviceCount);
            FTDI.FT_DEVICE_INFO_NODE[] devices = new FTDI.FT_DEVICE_INFO_NODE[deviceCount];
            ftdi.GetDeviceList(devices);
            listBox_devices.Items.Clear();
            for (uint i = 0; i < devices.Length; i++)
            {
                listBox_devices.Items.Add(devices[i].Description);
                if (devices[i].Type == FTD2XX_NET.FTDI.FT_DEVICE.FT_DEVICE_2232H)
                {
                    open_connection(i);
                    connectiontest(100);
                    break;
                }
            }
        }

        private void button_open_Click(object sender, EventArgs e)
        {
            if (listBox_devices.SelectedIndex >= 0)
            {
                open_connection((uint)listBox_devices.SelectedIndex);
            }
        }

        private void Form1_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (exchanger != null)
            {
                exchanger.Abort();
            }
            //FTDI.FT_STATUS ftStatus = ftdi.SetBitMode(0xFF, 0x00); //reset mode
            ftdi.Close();
        }


        private void button_testconnection_Click(object sender, EventArgs e)
        {
            connectiontest(10000);
        }

        private void button_speedtest_Click(object sender, EventArgs e)
        {
            int bytecount = 2000;

            DateTime start = DateTime.Now;
            uint[] datablock = new uint[1];
            for (int i = 0; i < bytecount; i++)
            {
                write_block(1, datablock);
            }
            DateTime end = DateTime.Now;
            double ms = (end - start).TotalMilliseconds;
            uint DWordsPerSecond = (uint)Math.Floor(bytecount * 1000 / ms);
            richTextBox_send.Text += "Write DWords/s: " + DWordsPerSecond + " = " + DWordsPerSecond * 4 / 1024 + " Kbyte/s \n";

            bytecount = 50;
            start = DateTime.Now;
            for (int i = 0; i < bytecount; i++)
            {
                read_block(1, 1);
            }
            end = DateTime.Now;
            ms = (end - start).TotalMilliseconds;
            DWordsPerSecond = (uint)Math.Floor(bytecount * 1000 / ms);
            richTextBox_send.Text += "Read DWords/s: " + DWordsPerSecond + " = " + DWordsPerSecond * 4 + " Byte/s \n";

            uint blockcount = 20;
            uint blocksize = 128;
            start = DateTime.Now;
            datablock = new uint[blocksize];
            for (int i = 0; i < blockcount; i++)
            {
                write_block(128, datablock);
            }
            end = DateTime.Now;
            ms = (end - start).TotalMilliseconds;
            uint blocksPerSecond = (uint)Math.Floor(blockcount * 1000 / ms);
            richTextBox_send.Text += "Write " + blocksize + " DWord Blocks/s: " + blocksPerSecond + " = " + blocksPerSecond * 4 * blocksize / 1024 + " Kbyte/s \n";
            
            blockcount = 10;
            start = DateTime.Now;
            for (int i = 0; i < blockcount; i++)
            {
                read_block(128, blocksize);
            }
            end = DateTime.Now;
            ms = (end - start).TotalMilliseconds;
            blocksPerSecond = (uint)Math.Floor(blockcount * 1000 / ms);
            richTextBox_send.Text += "Read " + blocksize + " DWord Blocks/s: " + blocksPerSecond + " = " + blocksPerSecond * 4 * blocksize / 1024 + " Kbyte/s \n";
        }

        private void open_connection(uint index)
        {
            ftdi.OpenByIndex(index);
            //ftdi.SetBaudRate(460800);
            //ftdi.SetBaudRate(3000000);

            //FTDI.FT_STATUS ftStatus = ftdi.SetBitMode(0xFF, 0x40); //Sync FIFO mode // disconnects vivado! 

            exchanger = new Thread(exchange_process);
            exchanger.Start();
        }

        private void exchange_process()
        {
            using (var file = new FileStream("input.txt", FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
            using (var reader = new StreamReader(file))
            {
                DateTime lasttransmit = DateTime.Now;
                while (true)
                { 
                    if (!reader.EndOfStream)
                    {
                        string line = reader.ReadLine();
                        if (line != "")
                        {
                            while (!line.EndsWith("&"))
                            {
                                line += reader.ReadLine();
                            }
                        }
                        line = line.Substring(0, line.Length - 1);
                        send_command(line);
                        lasttransmit = DateTime.Now;
                    }
                    else if ((DateTime.Now - lasttransmit).TotalMilliseconds > 1000)
                    {
                        Thread.Sleep(1);
                    }
                }
            }

        }

        private void timer1_rec_Tick(object sender, EventArgs e)
        {
            if (checkBox_autotest.Checked)
            {
                if (!connectiontest(10000))
                {
                    checkBox_autotest.Checked = false;
                }
            }

            richTextBox_send.Text += transmit_text;
            richTextBox_receive.Text += receive_text;
            transmit_text = "";
            receive_text = "";
        }

        private void send_command(string command)
        {
            string[] returned = send(command, transmit_text, receive_text);
            transmit_text = returned[0];
            receive_text = returned[1];
        }

        public bool connectiontest(int runs)
        {
            bool retval = true;

            string[] to_return = new string[2];
            to_return[0] = "";
            to_return[1] = "";

            uint numBytesWritten = 0;
            uint[] writeblock = new uint[1];
            writeblock[0] = 0x12345678;
            write_block(1, writeblock);

            byte[] sendbytes = new byte[4];
            sendbytes[0] = 0x01; // addr 1 = 32bit testreg
            sendbytes[1] = 0x00; //
            sendbytes[2] = 0;
            sendbytes[3] = 64;

            for (int run = 0; run < runs; run++)
            {
                ftdi.Write(sendbytes, 4, ref numBytesWritten);
            }

            for (int i = sendbytes.Length - 1; i >= 0; i--)
            {
                to_return[0] += sendbytes[i].ToString("x2") + " ";
            }
            to_return[0] += " (x" + runs + ")\n";

            int ok = 0;
            int failed = 0;

            Thread.Sleep(100);

            uint count = 0;
            ftdi.GetRxBytesAvailable(ref count);

            byte[] recbytes_all = new byte[4 * runs];

            if (count == 4 * runs)
            {
                uint numBytesRead = 0;
                ftdi.Read(recbytes_all, 4 * (uint)runs, ref numBytesRead);

                for (int run = 0; run < runs; run++)
                {
                    byte[] recbytes = new byte[4];
                    for (int b = 0; b < 4; b++)
                    {
                        recbytes[b] = recbytes_all[b + run * 4];
                    }

                    if (recbytes[3] == 0x12 && recbytes[2] == 0x34 && recbytes[1] == 0x56 && recbytes[0] == 0x78)
                    {
                        ok++;
                    }
                    else
                    {
                        failed++;
                    }
                }

                to_return[1] += "OK: " + ok + " | Failed: " + failed + "\n";

                writeblock[0] = 0xA5;
                write_block(8200, writeblock);
            }
            else
            {
                to_return[1] += count + " instead of " + (4 * runs) + " Bytes received  \n";
                retval = false;
            }

            transmit_text = to_return[0];
            receive_text = to_return[1];

            return retval;
        }

        public void write_block(uint addr, uint[] values)
        {
            //uint bytesWritten = 0;
            //byte[] sendbytes = new byte[1];
            //sendbytes[0] = 0xAA;
            //ftdi.Write(sendbytes, sendbytes.Length, ref bytesWritten);
            //ftdi.Write(sendbytes, sendbytes.Length, ref bytesWritten);
            //ftdi.Write(sendbytes, sendbytes.Length, ref bytesWritten);
            //ftdi.Write(sendbytes, sendbytes.Length, ref bytesWritten);
            //ftdi.Write(sendbytes, sendbytes.Length, ref bytesWritten);
            //ftdi.Write(sendbytes, sendbytes.Length, ref bytesWritten);
            //ftdi.Write(sendbytes, sendbytes.Length, ref bytesWritten);

            uint bytesWritten = 0;
            byte[] sendbytes;
            if (values.Length > 1)
            {
                sendbytes = new byte[5 + 4 * values.Length];
            }
            else
            {
                sendbytes = new byte[4 + 4 * values.Length];
            }

            sendbytes[3] = (byte)((addr >> 24) & 0xF);
            sendbytes[2] = (byte)((addr >> 16) & 0xFF);
            sendbytes[1] = (byte)((addr >> 8) & 0xFF);
            sendbytes[0] = (byte)(addr & 0xFF);

            int index = 4;
            if (values.Length > 1)
            {
                sendbytes[3] |= 128;
                sendbytes[4] = (byte)(values.Length - 1);
                index = 5;
                if (values.Length > 256)
                {
                    MessageBox.Show("Write block above 256 length not allowed");
                }
            }

            for (int i = 0; i < values.Length; i++)
            {
                sendbytes[index + 3] = (byte)((values[i] & 4278190080) >> 24);
                sendbytes[index + 2] = (byte)((values[i] & 16711680) >> 16);
                sendbytes[index + 1] = (byte)((values[i] & 65280) >> 8);
                sendbytes[index + 0] = (byte)((values[i] & 255) >> 0);
                index += 4;
            }
            ftdi.Write(sendbytes, sendbytes.Length, ref bytesWritten);
        }

        public uint[] read_block(uint addr, uint size)
        {
            uint bytesWritten = 0;
            uint bytesRead = 0;
            byte[] sendbytes;
            if (size > 1)
            {
                sendbytes = new byte[5];
            }
            else
            {
                sendbytes = new byte[4];
            }

            sendbytes[3] = (byte)(64 + ((addr >> 24) & 0xF));
            sendbytes[2] = (byte)((addr >> 16) & 0xFF);
            sendbytes[1] = (byte)((addr >> 8) & 0xFF);
            sendbytes[0] = (byte)(addr & 0xFF);

            if (size > 1)
            {
                sendbytes[3] |= 128;
                sendbytes[4] = (byte)(size - 1);
                if (size > 256)
                {
                    MessageBox.Show("Read block above 256 length not allowed");
                }
            }

            ftdi.Write(sendbytes, sendbytes.Length, ref bytesWritten);

            uint count = 0;
            DateTime start = DateTime.Now;
            while (count < size * 4)
            {
                ftdi.GetRxBytesAvailable(ref count);
                if (count == size * 4)
                {
                    break;
                }
                DateTime now = DateTime.Now;
                double ms = (DateTime.Now - start).TotalMilliseconds;
                if (ms >= 100 + 10 * size)
                {
                    //receive_text += "Timeout for: " + command + "\n";
                    break;
                }
            }

            uint[] returnvalues = new uint[size];
            if (count >= size * 4)
            {
                byte[] recbytes = new byte[size * 4];
                ftdi.Read(recbytes, size * 4, ref bytesRead);

                for (int b = 0; b < size; b++)
                {
                    uint returnvalue = 0;
                    for (int i = 0; i < 4; i++)
                    {
                        returnvalue += (uint)(recbytes[b * 4 + i] << (i * 8));
                    }
                    returnvalues[b] = returnvalue;
                }
                //receive_text += command + " # " + returnvalue + "\n";
            }

            return returnvalues;
        }

        public string[] send(string command, string transmit_text, string receive_text)
        {
            string[] to_return = new string[2];
            to_return[0] = transmit_text;
            to_return[1] = receive_text;

            string[] commandlist = command.Split('#');

            for (int i = 0; i < commandlist.Length; i++)
            {
                commandlist[i] = commandlist[i].Trim();
            }

            switch (commandlist[0])
            {
                case "set":
                    UInt32 valuecount = Convert.ToUInt32(commandlist[4]);
                    UInt32 addr = Convert.ToUInt32(commandlist[5]);
                    UInt32[] values = new UInt32[valuecount];
                    for (uint i = 0; i < valuecount; i++)
                    {
                        values[i] = (UInt32)Convert.ToInt32(commandlist[6 + i]);
                        //write_dword(addr + i, (UInt32)Convert.ToInt32(commandlist[6 + i]));
                    }
                    write_block(addr, values);
                    using (var file = new FileStream("output.txt", FileMode.Append, FileAccess.Write, FileShare.Read))
                    using (var reader = new StreamWriter(file))
                    {
                        reader.WriteLine(command + " # &");
                    }
                    break;

                case "get":
                    uint count = Convert.ToUInt32(commandlist[4]);

                    string result = "";
                    uint[] results = read_block(Convert.ToUInt32(commandlist[5]), count);
                    for (uint i = 0; i < count; i++)
                    {
                        result += results[i].ToString() + "#";
                    }

                    using (var file = new FileStream("output.txt", FileMode.Append, FileAccess.Write, FileShare.Read))
                    using (var reader = new StreamWriter(file))
                    {
                        reader.WriteLine(command + " # " + result + "&");
                    }

                    break;

                case "fil":
                    UInt32 addrptr = Convert.ToUInt32(commandlist[4]);
                    UInt32 endianess = Convert.ToUInt32(commandlist[3]);

                    FileStream fs = new FileStream(commandlist[5], FileMode.Open);
                    byte[] content = new byte[fs.Length];
                    fs.Read(content, 0, (int)fs.Length);
                    fs.Close();

                    UInt32[] dw_content = new UInt32[content.Length / 4];
                    if (endianess == 0)
                    {
                        for (int i = 0; i < dw_content.Length; i++)
                        {
                            UInt32 value = content[i * 4];
                            value += (UInt32)(content[(i * 4 + 1)] << 8);
                            value += (UInt32)(content[(i * 4 + 2)] << 16);
                            value += (UInt32)(content[(i * 4 + 3)] << 24);
                            dw_content[i] = value;
                        }
                    }
                    else
                    {
                        for (int i = 0; i < dw_content.Length; i++)
                        {
                            UInt32 value = content[(i * 4 + 3)];
                            value += (UInt32)(content[(i * 4 + 2)] << 8);
                            value += (UInt32)(content[(i * 4 + 1)] << 16);
                            value += (UInt32)(content[(i * 4 + 0)] << 24);
                            dw_content[i] = value;
                        }
                    }

                    int writeptr = 0;
                    while (writeptr < dw_content.Length)
                    {
                        uint blocksize = Math.Min(128, (uint)(dw_content.Length - writeptr));
                        UInt32[] datablock = new uint[blocksize];
                        for (int i = 0; i < blocksize; i++)
                        {
                            datablock[i] = dw_content[writeptr];
                            writeptr++;
                        }
                        write_block(addrptr, datablock);
                        addrptr += blocksize;
                    }

                    using (var file = new FileStream("output.txt", FileMode.Append, FileAccess.Write, FileShare.Read))
                    using (var reader = new StreamWriter(file))
                    {
                        reader.WriteLine(command + " # &");
                    }
                    break;

                case "wtn":
                    Thread.Sleep(100);
                    using (var file = new FileStream("output.txt", FileMode.Append, FileAccess.Write, FileShare.Read))
                    using (var reader = new StreamWriter(file))
                    {
                        reader.WriteLine(command + " # &");
                    }
                    break;
            }

            return to_return;
        }
    }
}
