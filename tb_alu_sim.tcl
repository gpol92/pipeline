vcom -work work C:/intelFPGA/pipeline/tb_alu.vhd
vsim work.tb_alu

proc checkSignal { signalName expectedVal } {
	set val [examine -binary $signalName]
	if {$val != $expectedVal} {
		echo "ERROR: $signalName=$val (expected=$expectedVal)"
	} else {
		echo "$signalName has value correct"
	}
}

# Aggiungere le onde per il debugging
add wave  \
sim:/tb_alu/clk \
sim:/tb_alu/reset \
sim:/tb_alu/uut_RF/RB_IN \
sim:/tb_alu/uut_RF/RB_OUT \
sim:/tb_alu/uut_ALU/ALU_IN \
sim:/tb_alu/uut_ALU/ALU_OUT \
sim:/tb_alu/uut_ALU/ALUresult \
sim:/tb_alu/uut_ALU/tmp

# Acquisire i valori iniziali
set ALUout [examine -binary sim:/tb_alu/uut_ALU/ALU_OUT.ALUout]
set readData1 [examine -binary sim:/tb_alu/uut_RF/RB_OUT.read_data1]


# Impostare valori iniziali
set readData1 [format "%0*b" 32 0]
set ALU_IN_ALUop [format "%0*b" 4 1]
set ALU_IN_opA $readData1
set ALU_IN_opB [format "%0*b" 32 4]
set RB_IN_RegWrite 1


# Forzare i segnali con valori iniziali
force ALU_IN.opA $ALU_IN_opA -deposit
force ALU_IN.opB $ALU_IN_opB -deposit
force ALU_IN.ALUop $ALU_IN_ALUop -deposit
force RB_IN.RegWrite $RB_IN_RegWrite -deposit
force RB_IN.write_data $ALUout -deposit

# Controllare i segnali forzati
checkSignal ALU_IN.ALUop [format "%0*b" 4 1]
checkSignal ALU_IN.opA [format "%0*b" 32 0]
checkSignal ALU_IN.opB [format "%0*b" 32 4]
checkSignal RB_IN.write_data [format "%0*b" 32 4]

# Eseguire la simulazione per 100 ns con aggiornamenti ogni 10 ns
# set totalTime 100
# for {set time 0} {$time < $totalTime} {incr time 10} {
	# run 10 ns
	
	# Aggiornare i valori nel tempo (se necessario)
	# force sim:/tb_alu/uut_ALU/ALU_IN.opA $ALU_IN_opA
	# force sim:/tb_alu/uut_RF/RB_IN.write_data $ALUout

	# Controllare nuovamente i segnali
	# checkSignal sim:/tb_alu/uut_ALU/ALU_IN/opA [format "%0*b" 32 0]
	# checkSignal sim:/tb_alu/uut_ALU/ALU_IN/opB [format "%0*b" 32 4]
	# checkSignal sim:/tb_alu/uut_RF/RB_IN/write_data [format "%0*b" 32 4]
# }
