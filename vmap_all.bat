RMDIR /s /q sim
MKDIR sim

vlib sim/mem
vmap mem sim/mem

vlib sim/procbus
vmap procbus sim/procbus

vlib sim/reg_map
vmap reg_map sim/reg_map

vlib sim/hdmi
vmap hdmi sim/hdmi

vlib sim/audio
vmap audio sim/audio

vlib sim/ds
vmap ds sim/ds

vlib sim/top
vmap top sim/top

vlib sim/tb
vmap tb sim/tb

