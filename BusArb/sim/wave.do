onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider MEMORY
add wave -noupdate /client_ram_test/RAM/clk
add wave -noupdate /client_ram_test/RAM/address
add wave -noupdate /client_ram_test/RAM/rq
add wave -noupdate /client_ram_test/RAM/ack
add wave -noupdate /client_ram_test/RAM/wr_ni
add wave -noupdate /client_ram_test/RAM/dataW
add wave -noupdate /client_ram_test/RAM/dataR
add wave -noupdate -divider CLIENT
add wave -noupdate /client_ram_test/CLIENT/reset
add wave -noupdate /client_ram_test/CLIENT/address
add wave -noupdate /client_ram_test/CLIENT/rq
add wave -noupdate /client_ram_test/CLIENT/ack
add wave -noupdate /client_ram_test/CLIENT/wr_ni
add wave -noupdate /client_ram_test/CLIENT/dataW
add wave -noupdate /client_ram_test/CLIENT/dataR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {153 ns} 0}
configure wave -namecolwidth 340
configure wave -valuecolwidth 170
configure wave -justifyvalue left
configure wave -signalnamewidth 2
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
WaveRestoreZoom {0 ns} {981 ns}
