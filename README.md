# DSFPGA

DS Implementation in VHDL for FPGA based on the GBA core.

# Target Boards
1. Nexys Video (done)
2. Terasic DE-10 Nano(Mister) (todo)

# Project schedule
- 3D in emulator (DSFPGApp)
- 3D in VHDL/FPGA
- ARM9 redesign
- Port to DE10-Nano
- rarely used missing features(e.g. video and audio capture)

# Status: 

### Overall
- most Games that use the 3D engine are either broken(e.g. hang up) or are unplayable
- from all other games, about 50% of the ones I tried run without major issues 

### CPU
- All instructions for Arm7 and Arm9 are implemented and should be correct (Testroms fulfilled)
- Caches are implemented, but only work for Mainram. If other Memories are to use Cache, they should just get fast Timing, as the internal Memories are fast anyway.
- CO15 is only implemented for the most important features
- Caches use Snoop Unit for coherence, instead of CO15 commands to update them

### CPU Speed
The ARM9 core is using the old ARM7 design from the GBA core and is too slow with it, which results in games having slowdown when they need 100% cpu performance. For most games this only happens when loading something, but some also need it ingame or even crash.
The ARM9 therefore needs a redesign, which is scheduled when 3D is working.

### Graphics
- Most 2D modes are implemented
- Large Bitmap mode is missing, as i haven't found any game or testrom yet that uses it
- Video capture is not implemented
- 3D rendering is completly missing, but 3D backdrop is already implemented and working

### Sound
- All soundchannels and soundmodes are working, except:
- Soundcapture is not implemented as i haven't found a game where it's really required.

Sound uses a timemultiplexed design instead of 16 independent channels. The reason is the ressource consumption(4000 Luts vs 17000 Luts, 6 DSP instead of 66 DSP Slices). It works and sounds the same as far as I tested, but may lead to problems, as the possible maximum frequency is now lower. With all channels on, it could be down to ~500Khz, but that should still be enough. The main problem would be if a game sets the freqency higher(most likely due to bugs) and it still somehow sounded correct. I haven't come across such a case.

### Touch
- The core receives the touchposition as x/y coordinates, which is by the framework
- Touch pressure is currently not implemented, as i haven't seen a game using it

### Known problems
- Turbo mode crashes in some games, probably due to the ARM9 being to slow. For ARM9, turbo mode is effectivly a underclocked mode instead of overclocked currently.
- In normal mode, the core is too slow for 100% speed, so gameplay and audio is very bad
- One sprite addressing mode is not fully understood and therefore wrong. Cannot fix it until i find a game using it.

# BIOS and Firmware
Both are not provided, but required. A LUA script exists to generate the BIOS files from binary data so both are build directly into the FPGA core as BROM.
Firmware is downloaded together with the ROM.

# Simulation
The simulation framework is made to be used with Modelsim. I haven't tested on any other simulator.
Features:
- script(LUA) based testing
- direct, live video output of both screens and/or combined image
- automatic regression tests for large parts of the core
- basic tests for graphic and video
- savestate currently supports only loading memory and Registers, so it can only be used for checking rendering of still images

# Synthesis
The whole project for Vivado 19.2 is checked in, including the generated DDR3 controller from Xilinx, as well as HDMI and Audio from other sources.
- HDMI: https://github.com/fcayci/vhdl-hdmi-out
- Audio: https://github.com/Digilent/NexysVideo/tree/master/Projects/Looper
