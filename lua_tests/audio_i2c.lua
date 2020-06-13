package.path = package.path .. ";./../lualib/?.lua"
require("vsim_comm")
require("luareg")

c1 = 261,626 
d1 = 293,665 
e1 = 329,628 
f1 = 349,228
g1 = 391,995 
a1 = 440,000 
h1 = 493,883 
c2 = 523,251

function sample(length, freq, pause)

   square_duration = 100000000 / freq
   reg_set(square_duration, audio.REG_Audio_SquarePeriod)
   reg_set(2, audio.REG_Audio_Source)

   sleep(length / 1000.0)
   reg_set(0, audio.REG_Audio_Source)
   sleep(pause / 1000.0)

end

--sample(100, c1, 50)
--sample(100, d1, 50)
--sample(100, e1, 50)
--sample(100, f1, 50)
--sample(100, g1, 50)
--sample(100, a1, 50)
--sample(100, h1, 50)
--sample(100, c2, 50)

sample(200, d1, 50)
sample(200, e1, 50)
sample(200, f1, 50)
sample(200, g1, 50)
sample(400, a1, 50)
sample(400, a1, 150)

sample(200, h1, 50)
sample(200, h1, 50)
sample(200, h1, 50)
sample(200, h1, 50)
sample(400, a1, 150)

sample(200, h1, 50)
sample(200, h1, 50)
sample(200, h1, 50)
sample(200, h1, 50)
sample(400, a1, 150)

sample(200, g1, 50)
sample(200, g1, 50)
sample(200, g1, 50)
sample(200, g1, 50)
sample(400, f1, 50)
sample(400, f1, 150)

sample(200, a1, 50)
sample(200, a1, 50)
sample(200, a1, 50)
sample(200, a1, 50)
sample(400, d1, 50)