quit -sim
vcom -work work C:/intelFPGA/pipeline/InstructionMemory.vhd
vcom -reportprogress 300 -work work C:/intelFPGA/pipeline/MEM_WB_signals.vhd
vcom -reportprogress 300 -work work C:/intelFPGA/pipeline/MEM_WB.vhd
vcom -reportprogress 300 -work work C:/intelFPGA/pipeline/EX_MEM_signals.vhd
vcom -reportprogress 300 -work work C:/intelFPGA/pipeline/EX_MEM.vhd
vcom -work work C:/intelFPGA/pipeline/RegisterBankSignals.vhd
vcom -reportprogress 300 -work work C:/intelFPGA/pipeline/RegisterFile.vhd
vcom -reportprogress 300 -work work C:/intelFPGA/pipeline/ID_EX_signals.vhd
vcom -work work C:/intelFPGA/pipeline/ID_EX.vhd
vcom -work work C:/intelFPGA/pipeline/ControlUnitSignals.vhd
vcom -work work C:/intelFPGA/pipeline/ControlUnit.vhd
vcom -reportprogress 300 -work work C:/intelFPGA/pipeline/IF_ID_signals.vhd
vcom -reportprogress 300 -work work C:/intelFPGA/pipeline/IF_ID.vhd
vcom -work work C:/intelFPGA/pipeline/PCsignals.vhd
vcom -work work C:/intelFPGA/pipeline/PC.vhd
vcom -reportprogress 300 -work work C:/intelFPGA/pipeline/tb_cpu.vhd

# vcom -work work C:/Users/gpoli/pipeline/InstructionMemory.vhd
# vcom -work work C:/Users/gpoli/pipeline/tb_cpu.vhd

vsim work.tb_cpu

add wave  \
sim:/tb_cpu/clk \
sim:/tb_cpu/reset \
sim:/tb_cpu/pcSrc \
sim:/tb_cpu/IF_ID_IN \
sim:/tb_cpu/IF_ID_OUT \
sim:/tb_cpu/addressMem \
sim:/tb_cpu/instructionMem \
sim:/tb_cpu/PC_IN \
sim:/tb_cpu/PC_OUT \
sim:/tb_cpu/RB_IN \
sim:/tb_cpu/RB_OUT \
sim:/tb_cpu/ALU_IN \
sim:/tb_cpu/ALU_OUT \
sim:/tb_cpu/ID_EX_IN \
sim:/tb_cpu/ID_EX_OUT \
sim:/tb_cpu/CU_IN \
sim:/tb_cpu/CU_OUT \
sim:/tb_cpu/EX_MEM_IN \
sim:/tb_cpu/EX_MEM_OUT \
sim:/tb_cpu/uut_CU/currentState \
sim:/tb_cpu/MEM_WB_IN \
sim:/tb_cpu/MEM_WB_OUT
run 600 ns