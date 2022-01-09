onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_t/top_u/sys_clk
add wave -noupdate /top_t/top_u/result_data
add wave -noupdate /top_t/result_rdy
add wave -noupdate /top_t/result_taken
add wave -noupdate /top_t/input_available
add wave -noupdate /top_t/top_u/input_ready
add wave -noupdate -radix decimal /top_t/top_u/U_calc/sub_out
add wave -noupdate /top_t/top_u/U_state_ctrl/state
add wave -noupdate /top_t/top_u/U_state_ctrl/next_state
add wave -noupdate /top_t/top_u/A_en
add wave -noupdate /top_t/top_u/B_en
add wave -noupdate -radix binary /top_t/top_u/A_mux_sel
add wave -noupdate -radix binary /top_t/top_u/B_mux_sel
add wave -noupdate /top_t/top_u/B_zero
add wave -noupdate /top_t/top_u/A_lt_B
add wave -noupdate -radix decimal /top_t/top_u/U_calc/A_mux_InSub
add wave -noupdate /top_t/top_u/U_calc/A_mux_InA
add wave -noupdate -radix decimal /top_t/top_u/U_calc/A_mux_InB
add wave -noupdate -radix decimal /top_t/top_u/U_calc/A_mux_out
add wave -noupdate -radix decimal /top_t/top_u/U_calc/DA_out
add wave -noupdate -radix decimal /top_t/top_u/U_calc/B_mux_InA
add wave -noupdate /top_t/top_u/U_calc/B_mux_InB
add wave -noupdate -radix decimal /top_t/top_u/U_calc/B_mux_out
add wave -noupdate -radix decimal /top_t/top_u/U_calc/DB_out
add wave -noupdate /top_t/A_line
add wave -noupdate /top_t/B_line
add wave -noupdate /top_t/result_line
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15130193 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 251
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
configure wave -timelineunits ps
update
WaveRestoreZoom {14995209 ps} {15705105 ps}
