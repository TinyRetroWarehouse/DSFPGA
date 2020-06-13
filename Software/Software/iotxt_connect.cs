using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;
using System.Threading;

namespace Regs
{
    public static class iotxt_connect
    {
        public static uint index = 1;
        public static uint proc_id = (uint)Math.Abs((short)DateTime.Now.Ticks);
        public static long filepointer = 0;

        public static UInt32 last_dma_packet_id = 0;

        public static UInt32[] reg_getblock(Register reg, UInt32 regindex, UInt32 count)
        {
            const int blocksize = 256;
            UInt32[] result = new UInt32[count];
            UInt32 index = regindex;

            uint readcount = 0;
            uint readleft = count;
            while (readleft > 0)
            {
                UInt32 readsize = Math.Min(blocksize, readleft);
                UInt32 address = reg.get_addr(index);
                string command = "get # " + index + " # " + proc_id + " # " + 1 + " # " + readsize + " # " + address;
                UInt32[] result_part = read_one(command);
                for (int i = 0; i < result_part.Length; i++)
                {
                    result[readcount] = result_part[i];
                    readcount++;
                }
                readleft -= readsize;
                index += readsize;
            }
            return result;
        }

        public static UInt32 reg_get(Register reg, UInt32 regindex)
        {
            UInt32 address = reg.get_addr(regindex);
            string command = "get # " + index + " # " + proc_id + " # " + 1 + " # " + 1 + " # " + address;
            UInt32 result = read_one(command)[0];
            return result;
        }

        public static void reg_setblock(UInt32[] new_values, Register reg, UInt32 regindex)
        {
            const int blocksize = 256;

            int length = new_values.Length;
            UInt32 address = reg.get_addr(regindex);
            string command = "set # " + index + " # " + proc_id + " # " + 1 + " # " + Math.Min(blocksize, length) + " # " + address;
            int writecount = 0;
            for (int i = 0; i < new_values.Length; i++)
            {
                Int64 sign_value = new_values[i];
                if (sign_value > 2147483647)
                {
                    sign_value = sign_value - (2 * (Int64)2147483648);
                }
                command = command + " # " + sign_value;
                writecount++;
                if (writecount == blocksize)
                {
                    write_one(command);
                    writecount = 0;
                    address += blocksize;
                    length -= blocksize;
                    command = "set # " + index + " # " + proc_id + " # " + 1 + " # " + Math.Min(blocksize, length) + " # " + address;
                }
            }
            if (length > 0)
            {
                write_one(command);
            }
        }

        public static void reg_set(UInt32 new_value, Register reg, UInt32 regindex)
        {
            UInt32[] block = new UInt32[1];
            block[0] = new_value;
            reg_setblock(block, reg, regindex);
        }

        private static UInt32 filter_para(UInt32 value, Register reg)
        {
            UInt32 filter = 0;
            for (UInt32 i = reg.Lsb; i <= reg.Msb; i++)
            {
                filter = filter + (UInt32)Math.Pow(2, i);
            }

            value = value & filter;
            value = value / (UInt32)(Math.Pow(2, reg.Lsb));
            return value;
        }

        public static void wait_ns(Int32 time)
        {
            string command = "wtn # " + index + " # " + proc_id + " # " + time.ToString();
            write_one(command);
        }

        public static void print(string printstring)
        {
            string command = "prt # " + printstring + "&";
            write_one(command);
        }

        public static void stop()
        {
            string command = "brk # &";
            write_one(command);
        }

        private static void write_one(string command)
        {
            using (var file = new FileStream("input.txt", FileMode.Append, FileAccess.Write, FileShare.Read))
            using (var writer = new StreamWriter(file))
            {
                writer.WriteLine(command + "&");
            }

            index++;

            while (true)
            {
                using (var file = new FileStream("output.txt", FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                using (var reader = new StreamReader(file))
                {
                    reader.BaseStream.Position = filepointer;
                    while (!reader.EndOfStream)
                    {
                        string line = reader.ReadLine();
                        string[] parts = line.Split('#');
                        if (parts[2].Trim() == proc_id.ToString())
                        {
                            filepointer = reader.BaseStream.Position;
                            return;
                        }
                    }
                }
            }
        }

        private static UInt32[] read_one(string command)
        {
            using (var file = new FileStream("input.txt", FileMode.Append, FileAccess.Write, FileShare.Read))
            using (var writer = new StreamWriter(file))
            {
                writer.WriteLine(command + "&");
            }
            
            index++;

            while (true)
            {
                using (var file = new FileStream("output.txt", FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                using (var reader = new StreamReader(file))
                {
                    reader.BaseStream.Position = filepointer;
                    while (!reader.EndOfStream)
                    {
                        string line = reader.ReadLine();
                        while (!line.EndsWith("&"))
                        {
                            line += reader.ReadLine();
                        }
                        line = line.Substring(0, line.Length - 1);
                        string[] parts = line.Split('#');
                        if (parts[2].Trim() == proc_id.ToString())
                        {
                            filepointer = reader.BaseStream.Position;
                            uint length = Convert.ToUInt32(parts[4]);
                            UInt32[] result = new UInt32[length];
                            for (uint i = 0; i < length; i++)
                            {
                                Int64 newval = Convert.ToInt64(parts[6 + i]);
                                if (newval < 0)
                                {
                                    newval = (2147483647 + (2147483649 - ((newval * (-1)))));
                                }
                                result[i] = (UInt32)newval;
                            }
                            return result;
                        }
                    }
                }
            }
        }





    }
}
