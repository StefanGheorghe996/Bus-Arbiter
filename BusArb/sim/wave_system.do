onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider ARBITER
add wave -noupdate /system_test/ARBITER/clk
add wave -noupdate /system_test/ARBITER/reset
add wave -noupdate /system_test/ARBITER/client_1_address
add wave -noupdate /system_test/ARBITER/client_1_rq
add wave -noupdate /system_test/ARBITER/client_1_ack
add wave -noupdate /system_test/ARBITER/client_1_wr_ni
add wave -noupdate /system_test/ARBITER/client_1_dataW
add wave -noupdate /system_test/ARBITER/client_1_dataR
add wave -noupdate /system_test/ARBITER/client_2_address
add wave -noupdate /system_test/ARBITER/client_2_rq
add wave -noupdate /system_test/ARBITER/client_2_ack
add wave -noupdate /system_test/ARBITER/client_2_wr_ni
add wave -noupdate /system_test/ARBITER/client_2_dataW
add wave -noupdate /system_test/ARBITER/client_2_dataR
add wave -noupdate /system_test/ARBITER/client_3_address
add wave -noupdate /system_test/ARBITER/client_3_rq
add wave -noupdate /system_test/ARBITER/client_3_ack
add wave -noupdate /system_test/ARBITER/client_3_wr_ni
add wave -noupdate /system_test/ARBITER/client_3_dataW
add wave -noupdate /system_test/ARBITER/client_3_dataR
add wave -noupdate /system_test/ARBITER/client_4_address
add wave -noupdate /system_test/ARBITER/client_4_rq
add wave -noupdate /system_test/ARBITER/client_4_ack
add wave -noupdate /system_test/ARBITER/client_4_wr_ni
add wave -noupdate /system_test/ARBITER/client_4_dataW
add wave -noupdate /system_test/ARBITER/client_4_dataR
add wave -noupdate /system_test/ARBITER/client_1_priority
add wave -noupdate /system_test/ARBITER/client_2_priority
add wave -noupdate /system_test/ARBITER/client_3_priority
add wave -noupdate /system_test/ARBITER/client_4_priority
add wave -noupdate -divider {CLIENT 1}
add wave -noupdate /system_test/CLIENT_1/clk
add wave -noupdate /system_test/CLIENT_1/reset
add wave -noupdate /system_test/CLIENT_1/address
add wave -noupdate /system_test/CLIENT_1/rq
add wave -noupdate /system_test/CLIENT_1/ack
add wave -noupdate /system_test/CLIENT_1/wr_ni
add wave -noupdate /system_test/CLIENT_1/dataW
add wave -noupdate /system_test/CLIENT_1/dataR
add wave -noupdate /system_test/CLIENT_1/counter_1
add wave -noupdate /system_test/CLIENT_1/counter_2
add wave -noupdate /system_test/CLIENT_1/dataR_reg
add wave -noupdate -divider {CLIENT 2}
add wave -noupdate /system_test/CLIENT_2/clk
add wave -noupdate /system_test/CLIENT_2/reset
add wave -noupdate /system_test/CLIENT_2/address
add wave -noupdate /system_test/CLIENT_2/rq
add wave -noupdate /system_test/CLIENT_2/ack
add wave -noupdate /system_test/CLIENT_2/wr_ni
add wave -noupdate /system_test/CLIENT_2/dataW
add wave -noupdate /system_test/CLIENT_2/dataR
add wave -noupdate -divider {CLIENT 3}
add wave -noupdate /system_test/CLIENT_3/clk
add wave -noupdate /system_test/CLIENT_3/reset
add wave -noupdate /system_test/CLIENT_3/address
add wave -noupdate /system_test/CLIENT_3/rq
add wave -noupdate /system_test/CLIENT_3/ack
add wave -noupdate /system_test/CLIENT_3/wr_ni
add wave -noupdate /system_test/CLIENT_3/dataW
add wave -noupdate /system_test/CLIENT_3/dataR
add wave -noupdate -divider {CLIENT 4}
add wave -noupdate /system_test/CLIENT_4/clk
add wave -noupdate /system_test/CLIENT_4/reset
add wave -noupdate /system_test/CLIENT_4/address
add wave -noupdate /system_test/CLIENT_4/rq
add wave -noupdate /system_test/CLIENT_4/ack
add wave -noupdate /system_test/CLIENT_4/wr_ni
add wave -noupdate /system_test/CLIENT_4/dataW
add wave -noupdate /system_test/CLIENT_4/dataR
add wave -noupdate -divider {SP LOGIC}
add wave -noupdate /system_test/ARBITER/SP_LOGIC/clk
add wave -noupdate /system_test/ARBITER/SP_LOGIC/reset
add wave -noupdate /system_test/ARBITER/SP_LOGIC/client_1_priority
add wave -noupdate /system_test/ARBITER/SP_LOGIC/client_1_rq
add wave -noupdate /system_test/ARBITER/SP_LOGIC/client_2_priority
add wave -noupdate /system_test/ARBITER/SP_LOGIC/client_2_rq
add wave -noupdate /system_test/ARBITER/SP_LOGIC/client_3_priority
add wave -noupdate /system_test/ARBITER/SP_LOGIC/client_3_rq
add wave -noupdate /system_test/ARBITER/SP_LOGIC/client_4_priority
add wave -noupdate /system_test/ARBITER/SP_LOGIC/client_4_rq
add wave -noupdate /system_test/ARBITER/SP_LOGIC/server_ack
add wave -noupdate /system_test/ARBITER/SP_LOGIC/address_to_be_served
add wave -noupdate /system_test/ARBITER/SP_LOGIC/first_priority_channel_addr
add wave -noupdate /system_test/ARBITER/SP_LOGIC/second_priority_channel_addr
add wave -noupdate /system_test/ARBITER/SP_LOGIC/third_priority_channel_addr
add wave -noupdate /system_test/ARBITER/SP_LOGIC/fourth_priority_channel_addr
add wave -noupdate -divider SERVER
add wave -noupdate /system_test/RAM/clk
add wave -noupdate /system_test/RAM/reset
add wave -noupdate /system_test/RAM/address
add wave -noupdate /system_test/RAM/rq
add wave -noupdate /system_test/RAM/ack
add wave -noupdate /system_test/RAM/wr_ni
add wave -noupdate /system_test/RAM/dataW
add wave -noupdate /system_test/RAM/dataR
add wave -noupdate /system_test/RAM/rq_d
add wave -noupdate /system_test/RAM/delay_counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {75 ns} 0}
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
