

.main clear
quit -sim
vcom -work work C:/Users/gpoli/pipeline/InstructionMemory.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/ALUSignals.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/ALU.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/MEM_WB_signals.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/MEM_WB.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/EX_MEM_signals.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/EX_MEM.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/RegisterBankSignals.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/RegisterFile.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/ID_EX_signals.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/ID_EX.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/ControlUnitSignals.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/ControlUnit.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/IF_ID_signals.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/IF_ID.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/PCsignals.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/PC.vhd -quiet
vcom -work work C:/Users/gpoli/pipeline/tb_cpu.vhd -quiet


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
		echo "$signalName has correct value $expectedVal"
	}
}

proc printSignal { signalName } {
	set val [examine $signalName]
	echo "$signalName has value $val"
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


# Inizializzazione dei segnali
force clk 0 -deposit
force reset 1 -deposit
force PC_IN.PCin [format "%0*b" 32 0] -deposit
force PC_OUT.PCout [format "%0*b" 32 0] -deposit
force addressMem [format "%0*b" 32 0] -deposit
force instructionMem [format "%0*b" 32 0] -deposit
force IF_ID_IN.instruction [format "%0*b" 32 0] -deposit
force IF_ID_OUT.instruction [format "%0*b" 32 0] -deposit
force CU_IN.opcode [format "%0*b" 6 0] -deposit
force CU_OUT.ALUsrc 0 -deposit
force CU_OUT.ALUop [format "%0*b" 4 0] -deposit
force CU_OUT.RegDst 0 -deposit
force CU_OUT.RegWrite 0 -deposit
force CU_OUT.MemRead 0 -deposit
force CU_OUT.MemToReg 0 -deposit
force CU_OUT.MemWrite 0 -deposit 
force CU_OUT.Branch 0 -deposit
force ID_EX_IN.PC [format "%0*b" 32 0] -deposit
force ID_EX_IN.ReadData1 [format "%0*b" 32 0] -deposit
force ID_EX_IN.ReadData2 [format "%0*b" 32 0] -deposit

force RB_IN.read_address1 [format "%0*b" 5 0] -deposit
force RB_IN.read_address2 [format "%0*b" 5 0] -deposit
force RB_IN.RegWrite 0 -deposit
force RB_IN.write_address [format "%0*b" 5 0] -deposit
force ALU_IN.opA [format "%0*b" 32 0] -deposit
force ALU_IN.opB [format "%0*b" 32 0] -deposit
force ALU_IN.ALUop [format "%0*b" 4 0] -deposit



# Esaminazione iniziale dei segnali
set CLK [examine clk]
set RESET [examine reset]
set PCin [examine PC_IN.PCin]
set addrMem [examine addressMem]
set instrMem [examine instructionMem]

# Configurazione delle variabili di simulazione
set totalTime 20  ;# Aumentato per vedere più cicli di FETCH
set count 0
set lastPCin 0   ;# Valore attuale di PC_IN.PCin
set prevPCin 0   ;# Valore che sarà assegnato a PC_OUT.PCout

# Ciclo di simulazione
for {set time 0} {$time < $totalTime} {incr time 1} {
    run 1 us
    set CLK [examine clk]
    set RESET [examine reset]

    # Aggiorniamo PC_IN.PCin solo nei cicli di FETCH (multipli di 5)
    if {[expr $time % 5] == 0} {
        set lastPCin $count
        incr count 1
    }

    # Il registro PC introduce un ritardo di 1 ciclo
    set prevPCin $lastPCin

    # Forziamo i segnali
    force PC_IN.PCin [format "%0*b" 32 $lastPCin] -deposit
    # force PC_OUT.PCout [format "%0*b" 32 $prevPCin] -deposit
    force addressMem [format "%0*b" 32 $prevPCin] -deposit
	force IF_ID_IN.instruction [examine instructionMem] -deposit
	
	# Estrai il valore di IF_ID_OUT.instruction
	set instruction [examine IF_ID_OUT.instruction]

	# Prendi i bit da 31 a 26 (ovvero i primi 6 caratteri della stringa binaria)
	set opcode_bin [string range $instruction 0 5]

	# Converte la stringa binaria in intero per evitare errori di lunghezza
	set opcode_dec [expr "0b$opcode_bin"]

	# Forza il valore sul segnale CU_IN.opcode
	force CU_IN.opcode [format "%0*b" 6 $opcode_dec] -deposit

	force RB_IN.read_address1 [format "%0*b" 5 [string range $instruction 6 10]] -deposit
	
    # Output dei segnali
    echo "----------------------------------"
    echo "Time: $time us | Clk: $CLK | Reset: $RESET"
    echo "PC_IN.PCin   = $lastPCin"
    echo "PC_OUT.PCout = $prevPCin"
    echo "addressMem   = $prevPCin"


    # Stampa segnali
    printSignal PC_IN.PCin
    printSignal PC_OUT.PCout
    printSignal addressMem
	printSignal instructionMem
	printSignal IF_ID_IN.instruction
	printSignal IF_ID_OUT.instruction
	printSignal CU_IN.opcode
	printSignal CU_OUT.ALUsrc
	printSignal CU_OUT.ALUop
	printSignal CU_OUT.RegDst
	printSignal CU_OUT.RegWrite
	printSignal CU_OUT.MemRead
	printSignal CU_OUT.MemToReg
	printSignal CU_OUT.MemWrite
	printSignal RB_IN.read_address1
	printSignal RB_IN.read_address2
	printSignal RB_IN.write_address
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

# run 30 us
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


# force instructionMem [format "%032b" 0] -deposit
# echo "Reading instructionMem" 
# set instruction [examine instructionMem]

# force IF_ID_IN.instruction [format "%032b" 0] -deposit
# echo "Reading IF_ID_IN.instruction"
# set instructionIFIDIN [examine IF_ID_IN.instruction]

# force IF_ID_OUT.instruction [format "%0*b" 32 0] -deposit
# echo "Reading IF_ID_OUT.instruction"
# set instructionIFIDOUT [examine IF_ID_OUT.instruction]

# force ID_EX_OUT.PC [format "%032b" 0] -deposit
# echo "Reading ID_EX_OUT.PC"
# set idex_PCout [examine ID_EX_OUT.PC]

# force EX_MEM_OUT.zero 0 -deposit
# echo "Reading EX_MEM_OUT.zero"
# set zeroEXMEM [examine EX_MEM_OUT.zero]

# force EX_MEM_OUT.Branch 0 -deposit
# echo "Reading EX_MEM_OUT.Branch"
# set branchEXMEM [examine EX_MEM_OUT.Branch]

# force pcSrc 0 -deposit
# set PCsrc 0

# force CU_IN.opcode [format "%0*b" 6 0] -deposit
# set opcodeCU [examine CU_IN.opcode]

# force PC_IN.PCin [format "%0*b" 32 0] -deposit
# force PC_OUT.PCout [format "%0*b" 32 0] -deposit
# set pcIn [examine PC_IN.PCin]
# set pcOut [examine PC_OUT.PCout]

# force addressMem [format "%0*b" 32 0] -deposit
# set addr3ssMem [examine addressMem]

# set totalTime 10
# set count 0

# for {set time 0} {$time < $totalTime} {incr time 1} {
    # run 1 us
    
    # # Aggiorna opcode in base all'istruzione
    # set opcodeCU [string range $instructionIFIDOUT 26 31]
	# echo "IF_ID_OUT.instruction $instructionIFIDOUT"
	# echo "Opcode $opcodeCU"
    # force CU_IN.opcode [format "%0*b" 6 $opcodeCU] -deposit
    
    # # Verifica condizione di branch
    # if {$opcodeCU == 6} {
        # if {[examine ALU_OUT.ALUout] == 0} {
            # set zeroEXMEM 1
            # set branchEXMEM 1
            # force EX_MEM_OUT.zero $zeroEXMEM -deposit
            # force EX_MEM_OUT.Branch $branchEXMEM -deposit
            # set PCsrc [expr {$zeroEXMEM && $branchEXMEM}]
        # }
    # }
    
    # # Controlla i segnali
    # checkSignal PC_IN.PCin [format "%032b" $count]
    # checkSignal PC_OUT.PCout [format "%032b" $count]
    # checkSignal addressMem [format "%032b" $count]
    # checkSignal ID_EX_OUT.PC [format "%032b" $idex_PCout]
    
    # # Mostra il contatore
    # echo "Count is $count"
    
    # if {$PCsrc == 0} {
        # incr idex_PCout 1
        # force PC_IN.PCin [format "%032b" $idex_PCout] -deposit
        # force PC_OUT.PCout [format "%032b" $idex_PCout] -deposit
        # force addressMem [format "%032b" $idex_PCout] -deposit
        # incr count 1
    # } else {
        # set jumpAddress [string range $instruction 25 0]
        # incr idex_PCout [expr {$jumpAddress}]
        
        # force PC_IN.PCin [format "%032b" $idex_PCout] -deposit
        # force PC_OUT.PCout [format "%032b" $idex_PCout] -deposit
		# force ID_EX_OUT.PC [format "%0*b" 32 $idex_PCout] -deposit
        # force addressMem [format "%032b" $idex_PCout] -deposit
        # set count $idex_PCout
    # }
# }