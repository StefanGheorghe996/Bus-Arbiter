vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {../src/rtl/client_control_logic.v}
vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {../src/rtl/priority_sort.v}
vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {../src/rtl/bus_arbiter.v}
vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {../src/tb/monitor_bus_arbiter.v}
vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {../src/rtl/client.v}
vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {../src/rtl/lfsr.v}
vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {../src/rtl/strict_priority_logic.v}
vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {../src/rtl/round_robin_logic.v}
vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {../src/rtl/ram.v}
vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {../src/tb/clock_rst_gen.v}
vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {../src/tb/system_test.v}

vsim -novopt work.system_test

do wave_system.do

run 410 ns