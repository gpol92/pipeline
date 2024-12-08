vcom -work work C:/Users/gpoli/pipeline/ID_EX_signals.vhd
vcom -work work C:/Users/gpoli/pipeline/ID_EX.vhd
vcom -work work C:/Users/gpoli/pipeline/ID_EX_tb.vhd

vsim work.id_ex_tb
add wave  \
sim:/id_ex_tb/uut/clk \
sim:/id_ex_tb/uut/reset \
sim:/id_ex_tb/uut/ID_EX_IN \
sim:/id_ex_tb/uut/ID_EX_OUT

run 100 ns