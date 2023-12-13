vlog i2c_tb.sv
vsim -voptargs=+acc tb 
#do wave.do
add wave sim:/tb/dut/*
run -all
