vcom -work work C:/Users/gpoli/pipeline/tb_alu.vhd
#vcom -work work C:/intelFPGA/pipeline/tb_alu.vhd
vsim work.tb_alu

proc checkSignal { signalName expectedVal } {
	set val [examine $signalName]
	if {$val != $expectedVal} {
		echo "ERROR: $signalName=$val (expected=$expectedVal)"
	} else {
		echo "$signalName has value correct"
	}
}

add wave  \
sim:/tb_alu/clk \
sim:/tb_alu/reset \
sim:/tb_alu/uut_RF/RB_IN \
sim:/tb_alu/uut_RF/RB_OUT \
sim:/tb_alu/uut_ALU/ALU_IN \
sim:/tb_alu/uut_ALU/ALU_OUT \
sim:/tb_alu/uut_ALU/ALUresult \
sim:/tb_alu/uut_ALU/tmp

set totalTime 100
for {set time 0} {$time < $totalTime} {incr time 10} {
	run 10 ns
	checkSignal ALU_IN.opA [format "%0*b" 32 0]
	checkSignal ALU_IN.opB [format "%0*b" 32 4]
}