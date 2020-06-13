using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;

namespace Software
{
    public static class VSim
    {
        public static void open_vsim(bool quiet)
        {
            if (quiet)
            {
                Process.Start("vsim_start_quiet.bat");  
            }
            else
            {
                Process.Start("vsim_start.bat");  
            }
            Regs.iotxt_connect.filepointer = 0;
        }
    }
}
