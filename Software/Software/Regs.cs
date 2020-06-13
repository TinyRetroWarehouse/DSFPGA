using System;
using System.Collections.Generic;
using System.Text;

namespace Regs
{
    public class Regs_FPGA
    {
        public readonly List<Section> Sectionlist;

        public readonly c_audio audio = new c_audio("audio");

        public readonly c_ddrram ddrram = new c_ddrram("ddrram");

        public readonly c_ds ds = new c_ds("ds");

        public readonly c_external external = new c_external("external");

        public readonly c_gameboy gameboy = new c_gameboy("gameboy");

        public readonly c_gpu gpu = new c_gpu("gpu");

        public readonly c_test test = new c_test("test");

        public Regs_FPGA()
        {
            Sectionlist = new List<Section>();
            Sectionlist.Add(audio);
            Sectionlist.Add(ddrram);
            Sectionlist.Add(ds);
            Sectionlist.Add(external);
            Sectionlist.Add(gameboy);
            Sectionlist.Add(gpu);
            Sectionlist.Add(test);
        }

        public class c_audio : Section
        {
            public c_audio(string Name)
                : base(Name)
            {
                REG_Audio_Source = new Register(this, "REG_Audio_Source", 8980, 1, 0, 1, 0, "readwrite");
                REG_Audio_Value = new Register(this, "REG_Audio_Value", 8981, 15, 0, 1, 0, "readwrite");
                REG_Audio_SquarePeriod = new Register(this, "REG_Audio_SquarePeriod", 8982, 23, 0, 1, 0, "readwrite");

                Reglist.Add(REG_Audio_Source);
                Reglist.Add(REG_Audio_Value);
                Reglist.Add(REG_Audio_SquarePeriod);
            }

            public readonly Register REG_Audio_Source;
            public readonly Register REG_Audio_Value;
            public readonly Register REG_Audio_SquarePeriod;
        }

        public class c_ddrram : Section
        {
            public c_ddrram(string Name)
                : base(Name)
            {
                Reg_Data = new Register(this, "Reg_Data", 134217728, 31, 0, 134217728, 0, "readwrite");
                Softmap_DS_WRAM = new Register(this, "Softmap_DS_WRAM", 134217728, 31, 0, 1048576, 0, "readwrite");
                Softmap_DS_Firmware = new Register(this, "Softmap_DS_Firmware", 136314880, 31, 0, 65536, 0, "readwrite");
                Softmap_DS_SaveRam = new Register(this, "Softmap_DS_SaveRam", 138412032, 31, 0, 1048576, 0, "readwrite");
                Softmap_DS_SaveState = new Register(this, "Softmap_DS_SaveState", 140509184, 31, 0, 2097152, 0, "readwrite");
                Softmap_DS_Gamerom = new Register(this, "Softmap_DS_Gamerom", 201326592, 31, 0, 67108864, 0, "readwrite");
                Softmap_Exchange = new Register(this, "Softmap_Exchange", 192937984, 31, 0, 4194304, 0, "readwrite");

                Reglist.Add(Reg_Data);
                Reglist.Add(Softmap_DS_WRAM);
                Reglist.Add(Softmap_DS_Firmware);
                Reglist.Add(Softmap_DS_SaveRam);
                Reglist.Add(Softmap_DS_SaveState);
                Reglist.Add(Softmap_DS_Gamerom);
                Reglist.Add(Softmap_Exchange);
            }

            public readonly Register Reg_Data;
            public readonly Register Softmap_DS_WRAM;
            public readonly Register Softmap_DS_Firmware;
            public readonly Register Softmap_DS_SaveRam;
            public readonly Register Softmap_DS_SaveState;
            public readonly Register Softmap_DS_Gamerom;
            public readonly Register Softmap_Exchange;
        }

        public class c_ds : Section
        {
            public c_ds(string Name)
                : base(Name)
            {
                Reg_DS_on = new Register(this, "Reg_DS_on", 1064960, 0, 0, 1, 0, "readwrite");
                Reg_DS_lockspeed = new Register(this, "Reg_DS_lockspeed", 1064961, 0, 0, 1, 0, "readwrite");
                Reg_DS_freerunclock = new Register(this, "Reg_DS_freerunclock", 1064962, 0, 0, 1, 0, "readwrite");
                Reg_DS_enablecpu = new Register(this, "Reg_DS_enablecpu", 1064963, 0, 0, 1, 0, "readwrite");
                Reg_DS_bootloader = new Register(this, "Reg_DS_bootloader", 1064964, 0, 0, 1, 0, "readwrite");
                Reg_DS_PC9Entry = new Register(this, "Reg_DS_PC9Entry", 1064965, 31, 0, 1, 0, "readwrite");
                Reg_DS_PC7Entry = new Register(this, "Reg_DS_PC7Entry", 1064966, 31, 0, 1, 0, "readwrite");
                Reg_DS_ChipID = new Register(this, "Reg_DS_ChipID", 1064967, 31, 0, 1, 0, "readwrite");
                Reg_DS_CyclePrecalc = new Register(this, "Reg_DS_CyclePrecalc", 1064971, 15, 0, 1, 100, "readwrite");
                Reg_DS_CyclesMissing = new Register(this, "Reg_DS_CyclesMissing", 1064972, 31, 0, 1, 0, "readonly");
                Reg_DS_Bus9Addr = new Register(this, "Reg_DS_Bus9Addr", 1064980, 27, 0, 1, 0, "readwrite");
                Reg_DS_Bus9RnW = new Register(this, "Reg_DS_Bus9RnW", 1064980, 28, 28, 1, 0, "readwrite");
                Reg_DS_Bus9ACC = new Register(this, "Reg_DS_Bus9ACC", 1064980, 30, 29, 1, 0, "readwrite");
                Reg_DS_Bus9WriteData = new Register(this, "Reg_DS_Bus9WriteData", 1064981, 31, 0, 1, 0, "readwrite");
                Reg_DS_Bus9ReadData = new Register(this, "Reg_DS_Bus9ReadData", 1064982, 31, 0, 1, 0, "readonly");
                Reg_DS_Bus7Addr = new Register(this, "Reg_DS_Bus7Addr", 1064983, 27, 0, 1, 0, "readwrite");
                Reg_DS_Bus7RnW = new Register(this, "Reg_DS_Bus7RnW", 1064983, 28, 28, 1, 0, "readwrite");
                Reg_DS_Bus7ACC = new Register(this, "Reg_DS_Bus7ACC", 1064983, 30, 29, 1, 0, "readwrite");
                Reg_DS_Bus7WriteData = new Register(this, "Reg_DS_Bus7WriteData", 1064984, 31, 0, 1, 0, "readwrite");
                Reg_DS_Bus7ReadData = new Register(this, "Reg_DS_Bus7ReadData", 1064985, 31, 0, 1, 0, "readonly");
                Reg_DS_VsyncSpeed9 = new Register(this, "Reg_DS_VsyncSpeed9", 1064986, 31, 0, 1, 0, "readwrite");
                Reg_DS_VsyncSpeed7 = new Register(this, "Reg_DS_VsyncSpeed7", 1064987, 31, 0, 1, 0, "readwrite");
                Reg_DS_VsyncIdle9 = new Register(this, "Reg_DS_VsyncIdle9", 1064988, 31, 0, 1, 0, "readwrite");
                Reg_DS_VsyncIdle7 = new Register(this, "Reg_DS_VsyncIdle7", 1064989, 31, 0, 1, 0, "readwrite");
                Reg_DS_KeyUp = new Register(this, "Reg_DS_KeyUp", 1064990, 0, 0, 1, 0, "readwrite");
                Reg_DS_KeyDown = new Register(this, "Reg_DS_KeyDown", 1064990, 1, 1, 1, 0, "readwrite");
                Reg_DS_KeyLeft = new Register(this, "Reg_DS_KeyLeft", 1064990, 2, 2, 1, 0, "readwrite");
                Reg_DS_KeyRight = new Register(this, "Reg_DS_KeyRight", 1064990, 3, 3, 1, 0, "readwrite");
                Reg_DS_KeyA = new Register(this, "Reg_DS_KeyA", 1064990, 4, 4, 1, 0, "readwrite");
                Reg_DS_KeyB = new Register(this, "Reg_DS_KeyB", 1064990, 5, 5, 1, 0, "readwrite");
                Reg_DS_KeyL = new Register(this, "Reg_DS_KeyL", 1064990, 6, 6, 1, 0, "readwrite");
                Reg_DS_KeyR = new Register(this, "Reg_DS_KeyR", 1064990, 7, 7, 1, 0, "readwrite");
                Reg_DS_KeyStart = new Register(this, "Reg_DS_KeyStart", 1064990, 8, 8, 1, 0, "readwrite");
                Reg_DS_KeySelect = new Register(this, "Reg_DS_KeySelect", 1064990, 9, 9, 1, 0, "readwrite");
                Reg_DS_KeyX = new Register(this, "Reg_DS_KeyX", 1064990, 10, 10, 1, 0, "readwrite");
                Reg_DS_KeyY = new Register(this, "Reg_DS_KeyY", 1064990, 11, 11, 1, 0, "readwrite");
                Reg_DS_Touch = new Register(this, "Reg_DS_Touch", 1064990, 12, 12, 1, 0, "readwrite");
                Reg_DS_TouchX = new Register(this, "Reg_DS_TouchX", 1064990, 23, 16, 1, 0, "readwrite");
                Reg_DS_TouchY = new Register(this, "Reg_DS_TouchY", 1064990, 31, 24, 1, 0, "readwrite");
                Reg_DS_cputurbo = new Register(this, "Reg_DS_cputurbo", 1064995, 0, 0, 1, 0, "readwrite");
                Reg_DS_SaveState = new Register(this, "Reg_DS_SaveState", 1064996, 0, 0, 1, 0, "Pulse");
                Reg_DS_LoadState = new Register(this, "Reg_DS_LoadState", 1064997, 0, 0, 1, 0, "Pulse");
                Reg_DS_DebugCycling = new Register(this, "Reg_DS_DebugCycling", 1065000, 31, 0, 1, 0, "readonly");
                Reg_DS_DebugCPU9 = new Register(this, "Reg_DS_DebugCPU9", 1065001, 31, 0, 1, 0, "readonly");
                Reg_DS_DebugCPU7 = new Register(this, "Reg_DS_DebugCPU7", 1065002, 31, 0, 1, 0, "readonly");
                Reg_DS_DebugDMA9 = new Register(this, "Reg_DS_DebugDMA9", 1065003, 31, 0, 1, 0, "readonly");
                Reg_DS_DebugDMA7 = new Register(this, "Reg_DS_DebugDMA7", 1065004, 31, 0, 1, 0, "readonly");

                Reglist.Add(Reg_DS_on);
                Reglist.Add(Reg_DS_lockspeed);
                Reglist.Add(Reg_DS_freerunclock);
                Reglist.Add(Reg_DS_enablecpu);
                Reglist.Add(Reg_DS_bootloader);
                Reglist.Add(Reg_DS_PC9Entry);
                Reglist.Add(Reg_DS_PC7Entry);
                Reglist.Add(Reg_DS_ChipID);
                Reglist.Add(Reg_DS_CyclePrecalc);
                Reglist.Add(Reg_DS_CyclesMissing);
                Reglist.Add(Reg_DS_Bus9Addr);
                Reglist.Add(Reg_DS_Bus9RnW);
                Reglist.Add(Reg_DS_Bus9ACC);
                Reglist.Add(Reg_DS_Bus9WriteData);
                Reglist.Add(Reg_DS_Bus9ReadData);
                Reglist.Add(Reg_DS_Bus7Addr);
                Reglist.Add(Reg_DS_Bus7RnW);
                Reglist.Add(Reg_DS_Bus7ACC);
                Reglist.Add(Reg_DS_Bus7WriteData);
                Reglist.Add(Reg_DS_Bus7ReadData);
                Reglist.Add(Reg_DS_VsyncSpeed9);
                Reglist.Add(Reg_DS_VsyncSpeed7);
                Reglist.Add(Reg_DS_VsyncIdle9);
                Reglist.Add(Reg_DS_VsyncIdle7);
                Reglist.Add(Reg_DS_KeyUp);
                Reglist.Add(Reg_DS_KeyDown);
                Reglist.Add(Reg_DS_KeyLeft);
                Reglist.Add(Reg_DS_KeyRight);
                Reglist.Add(Reg_DS_KeyA);
                Reglist.Add(Reg_DS_KeyB);
                Reglist.Add(Reg_DS_KeyL);
                Reglist.Add(Reg_DS_KeyR);
                Reglist.Add(Reg_DS_KeyStart);
                Reglist.Add(Reg_DS_KeySelect);
                Reglist.Add(Reg_DS_KeyX);
                Reglist.Add(Reg_DS_KeyY);
                Reglist.Add(Reg_DS_Touch);
                Reglist.Add(Reg_DS_TouchX);
                Reglist.Add(Reg_DS_TouchY);
                Reglist.Add(Reg_DS_cputurbo);
                Reglist.Add(Reg_DS_SaveState);
                Reglist.Add(Reg_DS_LoadState);
                Reglist.Add(Reg_DS_DebugCycling);
                Reglist.Add(Reg_DS_DebugCPU9);
                Reglist.Add(Reg_DS_DebugCPU7);
                Reglist.Add(Reg_DS_DebugDMA9);
                Reglist.Add(Reg_DS_DebugDMA7);
            }

            public readonly Register Reg_DS_on;
            public readonly Register Reg_DS_lockspeed;
            public readonly Register Reg_DS_freerunclock;
            public readonly Register Reg_DS_enablecpu;
            public readonly Register Reg_DS_bootloader;
            public readonly Register Reg_DS_PC9Entry;
            public readonly Register Reg_DS_PC7Entry;
            public readonly Register Reg_DS_ChipID;
            public readonly Register Reg_DS_CyclePrecalc;
            public readonly Register Reg_DS_CyclesMissing;
            public readonly Register Reg_DS_Bus9Addr;
            public readonly Register Reg_DS_Bus9RnW;
            public readonly Register Reg_DS_Bus9ACC;
            public readonly Register Reg_DS_Bus9WriteData;
            public readonly Register Reg_DS_Bus9ReadData;
            public readonly Register Reg_DS_Bus7Addr;
            public readonly Register Reg_DS_Bus7RnW;
            public readonly Register Reg_DS_Bus7ACC;
            public readonly Register Reg_DS_Bus7WriteData;
            public readonly Register Reg_DS_Bus7ReadData;
            public readonly Register Reg_DS_VsyncSpeed9;
            public readonly Register Reg_DS_VsyncSpeed7;
            public readonly Register Reg_DS_VsyncIdle9;
            public readonly Register Reg_DS_VsyncIdle7;
            public readonly Register Reg_DS_KeyUp;
            public readonly Register Reg_DS_KeyDown;
            public readonly Register Reg_DS_KeyLeft;
            public readonly Register Reg_DS_KeyRight;
            public readonly Register Reg_DS_KeyA;
            public readonly Register Reg_DS_KeyB;
            public readonly Register Reg_DS_KeyL;
            public readonly Register Reg_DS_KeyR;
            public readonly Register Reg_DS_KeyStart;
            public readonly Register Reg_DS_KeySelect;
            public readonly Register Reg_DS_KeyX;
            public readonly Register Reg_DS_KeyY;
            public readonly Register Reg_DS_Touch;
            public readonly Register Reg_DS_TouchX;
            public readonly Register Reg_DS_TouchY;
            public readonly Register Reg_DS_cputurbo;
            public readonly Register Reg_DS_SaveState;
            public readonly Register Reg_DS_LoadState;
            public readonly Register Reg_DS_DebugCycling;
            public readonly Register Reg_DS_DebugCPU9;
            public readonly Register Reg_DS_DebugCPU7;
            public readonly Register Reg_DS_DebugDMA9;
            public readonly Register Reg_DS_DebugDMA7;
        }

        public class c_external : Section
        {
            public c_external(string Name)
                : base(Name)
            {
                Reg_Switches = new Register(this, "Reg_Switches", 8192, 7, 0, 1, 0, "readonly");
                Reg_Keys = new Register(this, "Reg_Keys", 8193, 4, 0, 1, 0, "readonly");
                Reg_LED = new Register(this, "Reg_LED", 8200, 7, 0, 1, 0, "readwrite");

                Reglist.Add(Reg_Switches);
                Reglist.Add(Reg_Keys);
                Reglist.Add(Reg_LED);
            }

            public readonly Register Reg_Switches;
            public readonly Register Reg_Keys;
            public readonly Register Reg_LED;
        }

        public class c_gameboy : Section
        {
            public c_gameboy(string Name)
                : base(Name)
            {
                Reg_GBA_on = new Register(this, "Reg_GBA_on", 1056768, 0, 0, 1, 0, "readwrite");
                Reg_GBA_lockspeed = new Register(this, "Reg_GBA_lockspeed", 1056769, 0, 0, 1, 0, "readwrite");
                Reg_GBA_flash_1m = new Register(this, "Reg_GBA_flash_1m", 1056770, 0, 0, 1, 0, "readwrite");
                Reg_GBA_CyclePrecalc = new Register(this, "Reg_GBA_CyclePrecalc", 1056771, 15, 0, 1, 100, "readwrite");
                Reg_GBA_CyclesMissing = new Register(this, "Reg_GBA_CyclesMissing", 1056772, 31, 0, 1, 0, "readonly");
                Reg_GBA_BusAddr = new Register(this, "Reg_GBA_BusAddr", 1056773, 27, 0, 1, 0, "readwrite");
                Reg_GBA_BusRnW = new Register(this, "Reg_GBA_BusRnW", 1056773, 28, 28, 1, 0, "readwrite");
                Reg_GBA_BusACC = new Register(this, "Reg_GBA_BusACC", 1056773, 30, 29, 1, 0, "readwrite");
                Reg_GBA_BusWriteData = new Register(this, "Reg_GBA_BusWriteData", 1056774, 31, 0, 1, 0, "readwrite");
                Reg_GBA_BusReadData = new Register(this, "Reg_GBA_BusReadData", 1056775, 31, 0, 1, 0, "readonly");
                Reg_GBA_MaxPakAddr = new Register(this, "Reg_GBA_MaxPakAddr", 1056776, 24, 0, 1, 0, "readwrite");
                Reg_GBA_VsyncSpeed = new Register(this, "Reg_GBA_VsyncSpeed", 1056777, 31, 0, 1, 0, "readwrite");
                Reg_GBA_KeyUp = new Register(this, "Reg_GBA_KeyUp", 1056778, 0, 0, 1, 0, "readwrite");
                Reg_GBA_KeyDown = new Register(this, "Reg_GBA_KeyDown", 1056778, 1, 1, 1, 0, "readwrite");
                Reg_GBA_KeyLeft = new Register(this, "Reg_GBA_KeyLeft", 1056778, 2, 2, 1, 0, "readwrite");
                Reg_GBA_KeyRight = new Register(this, "Reg_GBA_KeyRight", 1056778, 3, 3, 1, 0, "readwrite");
                Reg_GBA_KeyA = new Register(this, "Reg_GBA_KeyA", 1056778, 4, 4, 1, 0, "readwrite");
                Reg_GBA_KeyB = new Register(this, "Reg_GBA_KeyB", 1056778, 5, 5, 1, 0, "readwrite");
                Reg_GBA_KeyL = new Register(this, "Reg_GBA_KeyL", 1056778, 6, 6, 1, 0, "readwrite");
                Reg_GBA_KeyR = new Register(this, "Reg_GBA_KeyR", 1056778, 7, 7, 1, 0, "readwrite");
                Reg_GBA_KeyStart = new Register(this, "Reg_GBA_KeyStart", 1056778, 8, 8, 1, 0, "readwrite");
                Reg_GBA_KeySelect = new Register(this, "Reg_GBA_KeySelect", 1056778, 9, 9, 1, 0, "readwrite");
                Reg_GBA_cputurbo = new Register(this, "Reg_GBA_cputurbo", 1056780, 0, 0, 1, 0, "readwrite");
                Reg_GBA_SramFlashEna = new Register(this, "Reg_GBA_SramFlashEna", 1056781, 0, 0, 1, 0, "readwrite");
                Reg_GBA_MemoryRemap = new Register(this, "Reg_GBA_MemoryRemap", 1056782, 0, 0, 1, 0, "readwrite");
                Reg_GBA_SaveState = new Register(this, "Reg_GBA_SaveState", 1056783, 0, 0, 1, 0, "Pulse");
                Reg_GBA_LoadState = new Register(this, "Reg_GBA_LoadState", 1056784, 0, 0, 1, 0, "Pulse");
                Reg_GBA_FrameBlend = new Register(this, "Reg_GBA_FrameBlend", 1056785, 0, 0, 1, 0, "readwrite");
                Reg_GBA_Pixelshade = new Register(this, "Reg_GBA_Pixelshade", 1056786, 2, 0, 1, 0, "readwrite");
                Reg_GBA_Rewind_on = new Register(this, "Reg_GBA_Rewind_on", 1056787, 0, 0, 1, 0, "readwrite");
                Reg_GBA_Rewind_active = new Register(this, "Reg_GBA_Rewind_active", 1056788, 0, 0, 1, 0, "readwrite");
                Reg_GBA_DEBUG_CPU_PC = new Register(this, "Reg_GBA_DEBUG_CPU_PC", 1056800, 31, 0, 1, 0, "readonly");
                Reg_GBA_DEBUG_CPU_MIX = new Register(this, "Reg_GBA_DEBUG_CPU_MIX", 1056801, 31, 0, 1, 0, "readonly");
                Reg_GBA_DEBUG_IRQ = new Register(this, "Reg_GBA_DEBUG_IRQ", 1056802, 31, 0, 1, 0, "readonly");
                Reg_GBA_DEBUG_DMA = new Register(this, "Reg_GBA_DEBUG_DMA", 1056803, 31, 0, 1, 0, "readonly");
                Reg_GBA_DEBUG_MEM = new Register(this, "Reg_GBA_DEBUG_MEM", 1056804, 31, 0, 1, 0, "readonly");
                Reg_GBA_CHEAT_FLAGS = new Register(this, "Reg_GBA_CHEAT_FLAGS", 1056810, 31, 0, 1, 0, "readwrite");
                Reg_GBA_CHEAT_ADDRESS = new Register(this, "Reg_GBA_CHEAT_ADDRESS", 1056811, 31, 0, 1, 0, "readwrite");
                Reg_GBA_CHEAT_COMPARE = new Register(this, "Reg_GBA_CHEAT_COMPARE", 1056812, 31, 0, 1, 0, "readwrite");
                Reg_GBA_CHEAT_REPLACE = new Register(this, "Reg_GBA_CHEAT_REPLACE", 1056813, 31, 0, 1, 0, "readwrite");
                Reg_GBA_CHEAT_RESET = new Register(this, "Reg_GBA_CHEAT_RESET", 1056814, 0, 0, 1, 0, "Pulse");

                Reglist.Add(Reg_GBA_on);
                Reglist.Add(Reg_GBA_lockspeed);
                Reglist.Add(Reg_GBA_flash_1m);
                Reglist.Add(Reg_GBA_CyclePrecalc);
                Reglist.Add(Reg_GBA_CyclesMissing);
                Reglist.Add(Reg_GBA_BusAddr);
                Reglist.Add(Reg_GBA_BusRnW);
                Reglist.Add(Reg_GBA_BusACC);
                Reglist.Add(Reg_GBA_BusWriteData);
                Reglist.Add(Reg_GBA_BusReadData);
                Reglist.Add(Reg_GBA_MaxPakAddr);
                Reglist.Add(Reg_GBA_VsyncSpeed);
                Reglist.Add(Reg_GBA_KeyUp);
                Reglist.Add(Reg_GBA_KeyDown);
                Reglist.Add(Reg_GBA_KeyLeft);
                Reglist.Add(Reg_GBA_KeyRight);
                Reglist.Add(Reg_GBA_KeyA);
                Reglist.Add(Reg_GBA_KeyB);
                Reglist.Add(Reg_GBA_KeyL);
                Reglist.Add(Reg_GBA_KeyR);
                Reglist.Add(Reg_GBA_KeyStart);
                Reglist.Add(Reg_GBA_KeySelect);
                Reglist.Add(Reg_GBA_cputurbo);
                Reglist.Add(Reg_GBA_SramFlashEna);
                Reglist.Add(Reg_GBA_MemoryRemap);
                Reglist.Add(Reg_GBA_SaveState);
                Reglist.Add(Reg_GBA_LoadState);
                Reglist.Add(Reg_GBA_FrameBlend);
                Reglist.Add(Reg_GBA_Pixelshade);
                Reglist.Add(Reg_GBA_Rewind_on);
                Reglist.Add(Reg_GBA_Rewind_active);
                Reglist.Add(Reg_GBA_DEBUG_CPU_PC);
                Reglist.Add(Reg_GBA_DEBUG_CPU_MIX);
                Reglist.Add(Reg_GBA_DEBUG_IRQ);
                Reglist.Add(Reg_GBA_DEBUG_DMA);
                Reglist.Add(Reg_GBA_DEBUG_MEM);
                Reglist.Add(Reg_GBA_CHEAT_FLAGS);
                Reglist.Add(Reg_GBA_CHEAT_ADDRESS);
                Reglist.Add(Reg_GBA_CHEAT_COMPARE);
                Reglist.Add(Reg_GBA_CHEAT_REPLACE);
                Reglist.Add(Reg_GBA_CHEAT_RESET);
            }

            public readonly Register Reg_GBA_on;
            public readonly Register Reg_GBA_lockspeed;
            public readonly Register Reg_GBA_flash_1m;
            public readonly Register Reg_GBA_CyclePrecalc;
            public readonly Register Reg_GBA_CyclesMissing;
            public readonly Register Reg_GBA_BusAddr;
            public readonly Register Reg_GBA_BusRnW;
            public readonly Register Reg_GBA_BusACC;
            public readonly Register Reg_GBA_BusWriteData;
            public readonly Register Reg_GBA_BusReadData;
            public readonly Register Reg_GBA_MaxPakAddr;
            public readonly Register Reg_GBA_VsyncSpeed;
            public readonly Register Reg_GBA_KeyUp;
            public readonly Register Reg_GBA_KeyDown;
            public readonly Register Reg_GBA_KeyLeft;
            public readonly Register Reg_GBA_KeyRight;
            public readonly Register Reg_GBA_KeyA;
            public readonly Register Reg_GBA_KeyB;
            public readonly Register Reg_GBA_KeyL;
            public readonly Register Reg_GBA_KeyR;
            public readonly Register Reg_GBA_KeyStart;
            public readonly Register Reg_GBA_KeySelect;
            public readonly Register Reg_GBA_cputurbo;
            public readonly Register Reg_GBA_SramFlashEna;
            public readonly Register Reg_GBA_MemoryRemap;
            public readonly Register Reg_GBA_SaveState;
            public readonly Register Reg_GBA_LoadState;
            public readonly Register Reg_GBA_FrameBlend;
            public readonly Register Reg_GBA_Pixelshade;
            public readonly Register Reg_GBA_Rewind_on;
            public readonly Register Reg_GBA_Rewind_active;
            public readonly Register Reg_GBA_DEBUG_CPU_PC;
            public readonly Register Reg_GBA_DEBUG_CPU_MIX;
            public readonly Register Reg_GBA_DEBUG_IRQ;
            public readonly Register Reg_GBA_DEBUG_DMA;
            public readonly Register Reg_GBA_DEBUG_MEM;
            public readonly Register Reg_GBA_CHEAT_FLAGS;
            public readonly Register Reg_GBA_CHEAT_ADDRESS;
            public readonly Register Reg_GBA_CHEAT_COMPARE;
            public readonly Register Reg_GBA_CHEAT_REPLACE;
            public readonly Register Reg_GBA_CHEAT_RESET;
        }

        public class c_gpu : Section
        {
            public c_gpu(string Name)
                : base(Name)
            {
                Reg_Framebuffer_PosX = new Register(this, "Reg_Framebuffer_PosX", 16410, 9, 0, 1, 0, "readwrite");
                Reg_Framebuffer_PosY = new Register(this, "Reg_Framebuffer_PosY", 16410, 25, 16, 1, 0, "readwrite");
                Reg_Framebuffer_SizeX = new Register(this, "Reg_Framebuffer_SizeX", 16411, 8, 0, 1, 0, "readwrite");
                Reg_Framebuffer_SizeY = new Register(this, "Reg_Framebuffer_SizeY", 16411, 16, 9, 1, 0, "readwrite");
                Reg_Framebuffer_Scale = new Register(this, "Reg_Framebuffer_Scale", 16411, 20, 17, 1, 0, "readwrite");
                Reg_Framebuffer_LCD = new Register(this, "Reg_Framebuffer_LCD", 16411, 21, 21, 1, 0, "readwrite");
                Reg_Framebuffer2_PosX = new Register(this, "Reg_Framebuffer2_PosX", 16420, 9, 0, 1, 0, "readwrite");
                Reg_Framebuffer2_PosY = new Register(this, "Reg_Framebuffer2_PosY", 16420, 25, 16, 1, 0, "readwrite");
                Reg_Framebuffer2_SizeX = new Register(this, "Reg_Framebuffer2_SizeX", 16421, 8, 0, 1, 0, "readwrite");
                Reg_Framebuffer2_SizeY = new Register(this, "Reg_Framebuffer2_SizeY", 16421, 16, 9, 1, 0, "readwrite");
                Reg_Framebuffer2_Scale = new Register(this, "Reg_Framebuffer2_Scale", 16421, 20, 17, 1, 0, "readwrite");
                Reg_Framebuffer2_LCD = new Register(this, "Reg_Framebuffer2_LCD", 16421, 21, 21, 1, 0, "readwrite");

                Reglist.Add(Reg_Framebuffer_PosX);
                Reglist.Add(Reg_Framebuffer_PosY);
                Reglist.Add(Reg_Framebuffer_SizeX);
                Reglist.Add(Reg_Framebuffer_SizeY);
                Reglist.Add(Reg_Framebuffer_Scale);
                Reglist.Add(Reg_Framebuffer_LCD);
                Reglist.Add(Reg_Framebuffer2_PosX);
                Reglist.Add(Reg_Framebuffer2_PosY);
                Reglist.Add(Reg_Framebuffer2_SizeX);
                Reglist.Add(Reg_Framebuffer2_SizeY);
                Reglist.Add(Reg_Framebuffer2_Scale);
                Reglist.Add(Reg_Framebuffer2_LCD);
            }

            public readonly Register Reg_Framebuffer_PosX;
            public readonly Register Reg_Framebuffer_PosY;
            public readonly Register Reg_Framebuffer_SizeX;
            public readonly Register Reg_Framebuffer_SizeY;
            public readonly Register Reg_Framebuffer_Scale;
            public readonly Register Reg_Framebuffer_LCD;
            public readonly Register Reg_Framebuffer2_PosX;
            public readonly Register Reg_Framebuffer2_PosY;
            public readonly Register Reg_Framebuffer2_SizeX;
            public readonly Register Reg_Framebuffer2_SizeY;
            public readonly Register Reg_Framebuffer2_Scale;
            public readonly Register Reg_Framebuffer2_LCD;
        }

        public class c_test : Section
        {
            public c_test(string Name)
                : base(Name)
            {
                Reg_Testreg = new Register(this, "Reg_Testreg", 1, 31, 0, 1, 0, "readwrite");
                Reg_Errorflags = new Register(this, "Reg_Errorflags", 2, 31, 0, 1, 0, "readonly");
                Reg_Simu = new Register(this, "Reg_Simu", 3, 0, 0, 1, 0, "readonly");
                Reg_DDRLatency = new Register(this, "Reg_DDRLatency", 16, 15, 0, 1, 0, "readonly");
                Reg_Testblock = new Register(this, "Reg_Testblock", 128, 0, 0, 128, 0, "readwrite");

                Reglist.Add(Reg_Testreg);
                Reglist.Add(Reg_Errorflags);
                Reglist.Add(Reg_Simu);
                Reglist.Add(Reg_DDRLatency);
                Reglist.Add(Reg_Testblock);
            }

            public readonly Register Reg_Testreg;
            public readonly Register Reg_Errorflags;
            public readonly Register Reg_Simu;
            public readonly Register Reg_DDRLatency;
            public readonly Register Reg_Testblock;
        }

    }
}
