.main clear
quit -sim
proc compile {file_path} {
	set command "vcom -work work $file_path "
	eval exec $command
}
compile "C:/Users/gpoli/pipeline/ForwardingUnit.vhd"
compile "C:/Users/gpoli/pipeline/InstructionMemory.vhd"
compile "C:/Users/gpoli/pipeline/ALUSignals.vhd"
compile "C:/Users/gpoli/pipeline/ALU.vhd"
compile "C:/Users/gpoli/pipeline/MEM_WB_signals.vhd" 
compile "C:/Users/gpoli/pipeline/MEM_WB.vhd"
compile "C:/Users/gpoli/pipeline/EX_MEM_signals.vhd"
compile "C:/Users/gpoli/pipeline/EX_MEM.vhd"
compile "C:/Users/gpoli/pipeline/RegisterBankSignals.vhd" 
compile "C:/Users/gpoli/pipeline/RegisterFile.vhd" 
compile "C:/Users/gpoli/pipeline/ID_EX_signals.vhd" 
compile "C:/Users/gpoli/pipeline/ID_EX.vhd" 
compile "C:/Users/gpoli/pipeline/ControlUnitSignals.vhd"
compile "C:/Users/gpoli/pipeline/ControlUnit.vhd" 
compile "C:/Users/gpoli/pipeline/IF_ID_signals.vhd"
compile "C:/Users/gpoli/pipeline/IF_ID.vhd"
compile "C:/Users/gpoli/pipeline/PCsignals.vhd"
compile "C:/Users/gpoli/pipeline/PC.vhd"
compile "C:/Users/gpoli/pipeline/DataMemorySignals.vhd"
compile "C:/Users/gpoli/pipeline/DataMemory.vhd" 
compile "C:/Users/gpoli/pipeline/tb_cpu.vhd"
compile "C:/Users/gpoli/pipeline/MEM_WB_MUX.vhd"
compile "C:/Users/gpoli/pipeline/opAmux.vhd"

vsim work.tb_cpu

proc checkSignal { signalName expectedVal } {
	set val [examine $signalName]
	if {$val != $expectedVal} {
		printMsg "ERROR: $signalName=$val (expected=$expectedVal)"
	}
}

proc runClockCycles { count } {
	variable clockPeriod
	variable timeUnits
	set t [expr {$clockPeriod * $count}]
	run $t $timeUnits
}

variable clockPeriod [examine clk_period]
echo $clockPeriod
variable clockPeriod [string trim $clockPeriod "{}"]
echo $clockPeriod

variable timeUnits [lindex $clockPeriod 1]
variable clockPeriod [lindex $clockPeriod 0]
variable pcOut [examine PC_OUT.pcOut]
variable addressMem [examine addressMem]
echo $addressMem
echo $pcOut
force -deposit $addressMem $pcOut 

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
sim:/tb_cpu/uut_RB/registers(15) \
sim:/tb_cpu/uut_RB/registers(16) \
sim:/tb_cpu/uut_RB/registers(17) \
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
sim:/tb_cpu/MEM_WB_OUT \
sim:/tb_cpu/uut_MW_MUX/MemToReg \
sim:/tb_cpu/uut_MW_MUX/MemDataOut \
sim:/tb_cpu/uut_MW_MUX/ALUresult \
sim:/tb_cpu/uut_MW_MUX/MUXout \
sim:/tb_cpu/uut_FU/ID_EX_RegAddr1 \
sim:/tb_cpu/uut_FU/ID_EX_RegAddr2 \
sim:/tb_cpu/uut_FU/EX_MEM_DestReg \
sim:/tb_cpu/uut_FU/MEM_WB_DestReg \
sim:/tb_cpu/uut_FU/forwardA \
sim:/tb_cpu/uut_FU/forwardB

runClockCycles 10