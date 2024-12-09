quit -sim
vcom -work work C:/intelFPGA/pipeline/ALU.vhd
vcom -work work C:/intelFPGA/pipeline/tb_cpu.vhd

vsim work.tb_cpu

add wave  \
sim:/tb_cpu/clk \
sim:/tb_cpu/reset \
sim:/tb_cpu/pcSrc \
sim:/tb_cpu/IF_ID_IN \
sim:/tb_cpu/IF_ID_OUT \
sim:/tb_cpu/addressMem \
sim:/tb_cpu/instructionMem \
sim:/tb_cpu/PCin \
sim:/tb_cpu/PCout \
sim:/tb_cpu/PC_ID_EX_OUT \
sim:/tb_cpu/jumpPC \
sim:/tb_cpu/RB_IN \
sim:/tb_cpu/RB_OUT \
sim:/tb_cpu/ALU_IN \
sim:/tb_cpu/ALU_OUT \
sim:/tb_cpu/ID_EX_IN \
sim:/tb_cpu/ID_EX_OUT \
sim:/tb_cpu/CU_IN \
sim:/tb_cpu/CU_OUT

run 200 ns