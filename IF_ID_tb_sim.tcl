vcom -reportprogress 300 -work work C:/intelFPGA/pipeline/IF_ID_signals.vhd -quiet
vcom -reportprogress 300 -work work C:/intelFPGA/pipeline/IF_ID.vhd -quiet
vcom -reportprogress 300 -work work C:/intelFPGA/pipeline/IF_ID_tb.vhd -quiet

vsim work.if_id_tb

add wave  \
sim:/if_id_tb/IF_ID_IN \
sim:/if_id_tb/IF_ID_OUT \
sim:/if_id_tb/clk \
sim:/if_id_tb/reset


run 100 ns
