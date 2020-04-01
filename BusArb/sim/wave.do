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
add wave -noupdate /client_ram_test/RAM/rq_d
add wave -noupdate -divider CLIENT
add wave -noupdate /client_ram_test/CLIENT/clk
add wave -noupdate /client_ram_test/CLIENT/reset
add wave -noupdate /client_ram_test/CLIENT/address
add wave -noupdate /client_ram_test/CLIENT/rq
add wave -noupdate /client_ram_test/CLIENT/ack
add wave -noupdate /client_ram_test/CLIENT/wr_ni
add wave -noupdate /client_ram_test/CLIENT/dataW
add wave -noupdate /client_ram_test/CLIENT/dataR
add wave -noupdate /client_ram_test/CLIENT/counter_1
add wave -noupdate /client_ram_test/CLIENT/counter_2
add wave -noupdate /client_ram_test/CLIENT/dataR_reg
add wave -noupdate /client_ram_test/CLIENT/enable_address_counter
add wave -noupdate /client_ram_test/CLIENT/enable_data_counter
add wave -noupdate /client_ram_test/CLIENT/enable_lfsr
add wave -noupdate /client_ram_test/CLIENT/request_wire
add wave -noupdate -divider LFSR
add wave -noupdate /client_ram_test/CLIENT/LFSR/enable
add wave -noupdate /client_ram_test/CLIENT/LFSR/rq
add wave -noupdate /client_ram_test/CLIENT/LFSR/bit_1
add wave -noupdate /client_ram_test/CLIENT/LFSR/bit_2
add wave -noupdate /client_ram_test/CLIENT/LFSR/bit_3
add wave -noupdate /client_ram_test/CLIENT/LFSR/bit_4
add wave -noupdate /client_ram_test/CLIENT/LFSR/bit_5
add wave -noupdate -divider {CONTROL LOGIC}
add wave -noupdate /client_ram_test/CLIENT/CONTROL_LOGIC/clk
add wave -noupdate /client_ram_test/CLIENT/CONTROL_LOGIC/rst
add wave -noupdate /client_ram_test/CLIENT/CONTROL_LOGIC/ack
add wave -noupdate /client_ram_test/CLIENT/CONTROL_LOGIC/rq
add wave -noupdate /client_ram_test/CLIENT/CONTROL_LOGIC/enable_address_counter
add wave -noupdate /client_ram_test/CLIENT/CONTROL_LOGIC/enable_data_counter
add wave -noupdate /client_ram_test/CLIENT/CONTROL_LOGIC/enable_lfsr
add wave -noupdate /client_ram_test/CLIENT/CONTROL_LOGIC/wr_ni
add wave -noupdate /client_ram_test/CLIENT/CONTROL_LOGIC/state
add wave -noupdate /client_ram_test/CLIENT/CONTROL_LOGIC/next_state
add wave -noupdate /client_ram_test/CLIENT/CONTROL_LOGIC/wr_ni_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18841600 ns} 0}
configure wave -namecolwidth 340
configure wave -valuecolwidth 170
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
WaveRestoreZoom {0 ns} {223805440 ns}
