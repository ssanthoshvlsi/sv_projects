#compilation

vlog spi_tb.sv

#vlog tb filename with include


#elaboration

vsim -voptargs=+acc tb 

#vsim tb_module_name
add wave sim:/tb/dut/*
#add wave vsim:/tb/*
#add wave.do
#add wave sim:/tb/*
#do wave.do

run -all
