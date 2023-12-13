#compilation
vlog apb_ram_tb.sv
#vlog tb filename with include
#elaboration
vsim -voptargs=+acc tb 
#vsim tb_module_name
add wave sim:/tb/dut/*
run -all
