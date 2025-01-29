vcom -work work C:/intelFPGA/pipeline/tb_alu.vhd
vsim work.tb_alu

proc checkSignal { signalName expectedVal } {
	set val [examine $signalName]
	if {$val != $expectedVal} {
		echo "ERROR: $signalName=$val (expected=$expectedVal)"
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


checkSignal ALU_IN.opA 4 
run 100 ns