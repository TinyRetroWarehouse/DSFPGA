using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using Software;

namespace regmap
{
    class Program
    {
        static List<Regs.Section> sectionlist = new List<Regs.Section>();

        static Regs.Section convert_file(string filename)
        {
            string spacename = filename;

            while (spacename.Contains("/"))
            {
                spacename = spacename.Substring(spacename.IndexOf("/") + 1, spacename.Length - spacename.IndexOf("/") - 1);
            }
            while (spacename.Contains("\\"))
            {
                spacename = spacename.Substring(spacename.IndexOf("\\") + 1, spacename.Length - spacename.IndexOf("\\") - 1);
            }

            spacename = spacename.Substring(spacename.IndexOf("_") + 1, spacename.IndexOf(".") - spacename.IndexOf("_") - 1);
            Regs.Section new_space = new Regs.Section(spacename);

            StreamReader input = new StreamReader(filename);

            while (!input.EndOfStream)
            {
                string line = input.ReadLine();

                line = line.Trim();
                if (line.StartsWith("constant"))
                {
                    line = line.Substring(8, line.Length - 8);
                    line = line.Trim();
                    string name = line.Substring(0, line.IndexOf(" "));
                    string content = line.Substring(line.IndexOf("(") + 1, line.Length - line.IndexOf("(") - 1);
                    content = content.Substring(0, content.IndexOf(")"));
                    string[] values = content.Split(',');
                    for (int i = 0; i < values.Length; i++)
                    {
                        values[i] = values[i].Trim();
                    }

                    UInt32[] values_uint = new UInt32[5];
                    for (int i = 0; i < values_uint.Length; i++)
                    {
                        if (values[i].Contains("+"))
                        {
                            string[] parts = values[i].Split('+');
                            values_uint[i] = Convert.ToUInt32(parts[0]) + Convert.ToUInt32(parts[1]);
                        }
                        else
                        {
                            values_uint[i] = Convert.ToUInt32(values[i]);
                        }
                    }

                    new_space.Add_Register(name, values_uint[0], values_uint[1], values_uint[2], values_uint[3], values_uint[4], values[5]);
                }
            }
            input.Close();

            return new_space;
        }

        static void Write_cs(string outputfilename)
        {
            output = new StreamWriter(outputfilename);

            // Header
            output.WriteLine("using System;");
            output.WriteLine("using System.Collections.Generic;");
            output.WriteLine("using System.Text;");
            output.WriteLine("");
            output.WriteLine("namespace Regs");
            output.WriteLine("{");
            output.WriteLine("    public class Regs_FPGA");
            output.WriteLine("    {");
            output.WriteLine("        public readonly List<Section> Sectionlist;");
            output.WriteLine("");

            // Init Sections
            foreach (Regs.Section sect in sectionlist)
            {
                output.WriteLine("        public readonly c_" + sect.Name + " " + sect.Name + " = new c_" + sect.Name + "(\"" + sect.Name + "\");");
                output.WriteLine("");
            }

            // Create Sectionlist and Init Parent
            output.WriteLine("        public Regs_FPGA()");
            output.WriteLine("        {");
            output.WriteLine("            Sectionlist = new List<Section>();");
            foreach (Regs.Section sect in sectionlist)
            {
                output.WriteLine("            Sectionlist.Add(" + sect.Name + ");");
            }
            output.WriteLine("        }");
            output.WriteLine("");

            // Sectioncontents
            foreach (Regs.Section sect in sectionlist)
            {
                output.WriteLine("        public class c_" + sect.Name + " : Section");
                output.WriteLine("        {");
                output.WriteLine("            public c_" + sect.Name + "(string Name)");
                output.WriteLine("                : base(Name)");
                output.WriteLine("            {");
                foreach (Regs.Register reg in sect.Reglist)
                {
                    output.WriteLine("                " + reg.Name + " = new Register(this, \"" + reg.Name + "\", " + reg.Address + ", " + reg.Msb + ", " + reg.Lsb + ", " + reg.Count + ", " + reg.Defaultvalue + ", \"" + reg.Accesstype + "\");");
                }
                output.WriteLine("");
                foreach (Regs.Register reg in sect.Reglist)
                {
                    output.WriteLine("                Reglist.Add(" + reg.Name + ");");
                }
                output.WriteLine("            }");
                output.WriteLine("");

                foreach (Regs.Register reg in sect.Reglist)
                {
                    output.WriteLine("            public readonly Register " + reg.Name + ";");
                }

                output.WriteLine("        }");
                output.WriteLine("");
            }

            output.WriteLine("    }");
            output.WriteLine("}");

            output.Close();
        }

        static StreamWriter output;
        static void Main(string[] args)
        {
            string[] files = new string[0];
            string outputfilename;

            files = Directory.GetFiles(Environment.CurrentDirectory + "\\src\\reg_map\\");
            outputfilename = Environment.CurrentDirectory + "\\Software\\Software\\Regs.cs";

            if (args.Length == 1)
            {
                files = Directory.GetFiles(Environment.CurrentDirectory + args[0]);
            }
            else if (args.Length == 2)
            {
                outputfilename = Environment.CurrentDirectory + "\\" + args[1];
            }

            for (int i = 0; i < files.Length; i++)
            {
                if (files[i].Contains("\\reg_") && files[i].Substring(files[i].Length - 3, 3) == "vhd")
                {
                    Console.WriteLine(files[i]);
                    sectionlist.Add(convert_file(files[i]));
                }
            }

            Write_cs(outputfilename);
        }
    }
}
