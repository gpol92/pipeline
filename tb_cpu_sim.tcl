

.main clear
quit -sim
vcom -work work C:/Users/gpoli/pipeline/InstructionMemory.vhd
vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/ALUSignals.vhd 
vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/ALU.vhd 
vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/MEM_WB_signals.vhd
vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/MEM_WB.vhd
vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/EX_MEM_signals.vhd
vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/EX_MEM.vhd
vcom -work work C:/Users/gpoli/pipeline/RegisterBankSignals.vhd
vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/RegisterFile.vhd
vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/ID_EX_signals.vhd
vcom -work work C:/Users/gpoli/pipeline/ID_EX.vhd
vcom -work work C:/Users/gpoli/pipeline/ControlUnitSignals.vhd
vcom -work work C:/Users/gpoli/pipeline/ControlUnit.vhd
vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/IF_ID_signals.vhd
vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/IF_ID.vhd
vcom -work work C:/Users/gpoli/pipeline/PCsignals.vhd
vcom -work work C:/Users/gpoli/pipeline/PC.vhd
vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/tb_cpu.vhd


# vcom -work work C:/intelFPGA/pipeline/ForwardingUnit.vhd -quiet
# vcom -work work C:/intelFPGA/pipeline/MEM_WB_MUX.vhd -quiet
# vcom -work work C:/intelFPGA/pipeline/InstructionMemory.vhd -quiet
# vcom -work work C:/intelFPGA/pipeline/MEM_WB_signals.vhd -quiet
# vcom -work work C:/intelFPGA/pipeline/MEM_WB.vhd -quiet
# vcom -work work C:/intelFPGA/pipeline/EX_MEM_signals.vhd
# vcom -work work C:/intelFPGA/pipeline/EX_MEM.vhd
# vcom -work work C:/intelFPGA/pipeline/RegisterBankSignals.vhd
# vcom -work work C:/intelFPGA/pipeline/RegisterFile.vhd
# vcom -work work C:/intelFPGA/pipeline/ID_EX_signals.vhd
# vcom -work work C:/intelFPGA/pipeline/ID_EX.vhd
# vcom -work work C:/intelFPGA/pipeline/ControlUnitSignals.vhd
# vcom -work work C:/intelFPGA/pipeline/ControlUnit.vhd
# vcom -work work C:/intelFPGA/pipeline/IF_ID_signals.vhd
# vcom -work work C:/intelFPGA/pipeline/IF_ID.vhd
# vcom -work work C:/intelFPGA/pipeline/PCsignals.vhd
# vcom -work work C:/intelFPGA/pipeline/PC.vhd
# vcom -work work C:/intelFPGA/pipeline/tb_cpu.vhd

# vcom -work work C:/Users/gpoli/pipeline/InstructionMemory.vhd
# vcom -work work C:/Users/gpoli/pipeline/tb_cpu.vhd

vsim work.tb_cpu

proc checkSignal { signalName expectedVal } {
	set val [examine $signalName]
	if {$val != $expectedVal} {
		echo "ERROR: $signalName=$val (expected=$expectedVal)"
	} else {
		echo "$signalName has correct value"
	}
}

# proc runClockCycles { count } {
	# variable clockPeriod
	# variable timeUnits
	# set t [expr {$clockPeriod * $count}]
	# run $t $timeUnits
# }

# variable clockPeriod [examine clk_period]
# echo $clockPeriod
# variable clockPeriod [string trim $clockPeriod "{}"]
# echo $clockPeriod

# variable timeUnits [lindex $clockPeriod 1]
# variable clockPeriod [lindex $clockPeriod 0]
force PC_IN.PCin [format "%0*b" 32 0] -deposit
force PC_OUT.PCOut [format "%0*b" 32 0] -deposit
set totalTime 20
set count 0
for {set time 0} {$time < $totalTime} {incr time 10} {
	run 10 ns
	
	checkSignal PC_IN.PCin [format "%0*b" 32 $count]
	checkSignal PC_OUT.PCout [format "%0*b" 32 $count]
	set pcOut [examine PC_OUT.PCout]
	echo $pcIn
	echo $count
	incr count 1
}



add wave  \
sim:/tb_cpu/clk \
sim:/tb_cpu/reset \
sim:/tb_cpu/pcSrc \
sim:/tb_cpu/addressMem \
sim:/tb_cpu/instructionMem \
sim:/tb_cpu/IF_ID_IN \
sim:/tb_cpu/IF_ID_OUT \
sim:/tb_cpu/PC_IN \
sim:/tb_cpu/PC_OUT \
sim:/tb_cpu/RB_IN \
sim:/tb_cpu/RB_OUT \
sim:/tb_cpu/uut_RB/registers \
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
sim:/tb_cpu/MEM_WB_OUT \
sim:/tb_cpu/DM_IN \
sim:/tb_cpu/DM_OUT \
sim:/tb_cpu/ID_EX_RegAddr1 \
sim:/tb_cpu/ID_EX_RegAddr2 \
sim:/tb_cpu/EX_MEM_DestReg \
sim:/tb_cpu/MEM_WB_DestReg \
sim:/tb_cpu/forwardA \
sim:/tb_cpu/forwardB \
sim:/tb_cpu/MemToReg \
sim:/tb_cpu/MemDataOut \
sim:/tb_cpu/ALUresult \
sim:/tb_cpu/MUXout \
sim:/tb_cpu/RegWrite

run 30 us
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


# run 1.5 us