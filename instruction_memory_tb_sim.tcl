.main clear

vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/InstructionMemory.vhd
vcom -reportprogress 300 -work work C:/Users/gpoli/pipeline/InstructionMemory_tb.vhd

vsim work.instructionmemory_tb

add wave  \
sim:/instructionmemory_tb/uut_IM/clk \
sim:/instructionmemory_tb/uut_IM/addressMem \
sim:/instructionmemory_tb/uut_IM/instructionMem \
sim:/instructionmemory_tb/uut_IM/instr_mem


run 120 ns