onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/clk
add wave -noupdate /tb/dut/rst
add wave -noupdate /tb/dut/sclk
add wave -noupdate /tb/dut/countc
add wave -noupdate /tb/dut/newd
add wave -noupdate /tb/dut/din
add wave -noupdate /tb/dut/cs
add wave -noupdate /tb/dut/mosi
add wave -noupdate /tb/dut/state
add wave -noupdate /tb/dut/count
add wave -noupdate /tb/dut/temp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 147
configure wave -valuecolwidth 92
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
WaveRestoreZoom {0 ns} {320864 ns}
