quit -sim
vcom -work work C:/intelFPGA/pipeline/ForwardingUnit.vhd -quiet
vcom -work work C:/intelFPGA/pipeline/MEM_WB_MUX.vhd -quiet
vcom -work work C:/intelFPGA/pipeline/InstructionMemory.vhd -quiet
vcom -work work C:/intelFPGA/pipeline/MEM_WB_signals.vhd -quiet
vcom -work work C:/intelFPGA/pipeline/MEM_WB.vhd -quiet
vcom -work work C:/intelFPGA/pipeline/EX_MEM_signals.vhd
vcom -work work C:/intelFPGA/pipeline/EX_MEM.vhd
vcom -work work C:/intelFPGA/pipeline/RegisterBankSignals.vhd
vcom -work work C:/intelFPGA/pipeline/RegisterFile.vhd
vcom -work work C:/intelFPGA/pipeline/ID_EX_signals.vhd
vcom -work work C:/intelFPGA/pipeline/ID_EX.vhd
vcom -work work C:/intelFPGA/pipeline/ControlUnitSignals.vhd
vcom -work work C:/intelFPGA/pipeline/ControlUnit.vhd
vcom -work work C:/intelFPGA/pipeline/IF_ID_signals.vhd
vcom -work work C:/intelFPGA/pipeline/IF_ID.vhd
vcom -work work C:/intelFPGA/pipeline/PCsignals.vhd
vcom -work work C:/intelFPGA/pipeline/PC.vhd
vcom -work work C:/intelFPGA/pipeline/tb_cpu.vhd

# vcom -work work C:/Users/gpoli/pipeline/InstructionMemory.vhd
# vcom -work work C:/Users/gpoli/pipeline/tb_cpu.vhd

vsim work.tb_cpu
if {[file exists wave.do]} {
	do wave.do
}

variable clockPeriod [examine clk_period]
echo $clockPeriod
variable clockPeriod [string trim $clockPeriod "{}"]
echo $clockPeriod
# set enableIF_ID 1
# set enableIM 0
# set enablePC 0
# set enableRB 0
# set enableALU 0
# set enableID_EX 0
# set enableCU 0
# set enableEX_MEM 0
# set enableMEM_WB 0
# set enableDM 0

# if {$enableIF_ID == 1} {
	# add wave IF_ID_IN
	# add wave IF_ID_OUT
# }

# if {$enableIM == 1} {
	# add wave addressMem
	# add wave instructionMem
# }

# if {$enablePC == 1} {
	# add wave PC_IN
	# add wave PC_OUT
# }

# if {$enableRB == 1} {
	# add wave RB_IN
	# add wave RB_OUT
# }

# if {$enableALU == 1} {
	# add wave ALU_IN
	# add wave ALU_OUT
# }
# run 1.5 us

# add wave  \
# sim:/tb_cpu/clk \
# sim:/tb_cpu/reset \
# sim:/tb_cpu/pcSrc \
# sim:/tb_cpu/addressMem \
# sim:/tb_cpu/instructionMem \
# sim:/tb_cpu/PC_IN \
# sim:/tb_cpu/PC_OUT \
# sim:/tb_cpu/RB_IN \
# sim:/tb_cpu/RB_OUT \
# sim:/tb_cpu/uut_RB/registers \
# sim:/tb_cpu/ALU_IN \
# sim:/tb_cpu/ALU_OUT \
# sim:/tb_cpu/ID_EX_IN \
# sim:/tb_cpu/ID_EX_OUT \
# sim:/tb_cpu/CU_IN \
# sim:/tb_cpu/CU_OUT \
# sim:/tb_cpu/EX_MEM_IN \
# sim:/tb_cpu/EX_MEM_OUT \
# sim:/tb_cpu/uut_CU/currentState \
# sim:/tb_cpu/MEM_WB_IN \
# sim:/tb_cpu/MEM_WB_OUT \
# sim:/tb_cpu/DM_IN \
# sim:/tb_cpu/DM_OUT \
# sim:/tb_cpu/ID_EX_RegAddr1 \
# sim:/tb_cpu/ID_EX_RegAddr2 \
# sim:/tb_cpu/EX_MEM_DestReg \
# sim:/tb_cpu/MEM_WB_DestReg \
# sim:/tb_cpu/forwardA \
# sim:/tb_cpu/forwardB \
# sim:/tb_cpu/MemToReg \
# sim:/tb_cpu/MemDataOut \
# sim:/tb_cpu/ALUresult \
# sim:/tb_cpu/MUXout \
# sim:/tb_cpu/RegWrite
# run 1.5 us