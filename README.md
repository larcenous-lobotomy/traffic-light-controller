# Problem Statement

Write a behavioral Verilog module for a modified form of traffic light controller FSM. It has 2 sensor inputs TA and TB and 6 traffic light outputs – 3 per lane  (and a clock CLK and reset RST).  The FSM behaves similar to the TLC FSM described in _Digital Design & Computer Architecture_ by Harris and Harris, with the difference that a YELLOW signal condition for a lane is for 2 cycles. Therefore the total number of states is 6 (S0 – S5). 

Write a test-bench that covers the usual traffic conditions. 
