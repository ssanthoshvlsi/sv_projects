onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/clock
add wave -noupdate /tb/dut/rd
add wave -noupdate /tb/dut/wr
add wave -noupdate /tb/dut/full
add wave -noupdate /tb/dut/empty
add wave -noupdate /tb/dut/data_in
add wave -noupdate /tb/dut/data_out
add wave -noupdate /tb/dut/rst
add wave -noupdate /tb/dut/wr_ptr
add wave -noupdate /tb/dut/rd_ptr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1 us}
