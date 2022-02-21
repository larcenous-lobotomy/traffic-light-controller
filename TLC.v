module MealyFSM(input CLK, RST, Ta, Tb, output reg [5:0] L, output [2:0] Current_State, count);

    reg [2:0] Current_State, Next_State, count;

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    parameter S5 = 3'b101;

    //Sequential Register Logic
    always @(posedge CLK, posedge RST)  
        if(RST) Current_State <= S0;
       
        else Current_State <= Next_State;

    //Combinational Next State Logic
    always @(*) 
        case (Current_State)
            S0 : Next_State = (Ta) ? S0 : S1;
            S1 : Next_State = S4;
            S2 : Next_State = (Tb) ? S2 : S3;
            S3 : Next_State = S5;
            S4 : if (count < 3'b10) begin
                    Next_State = S1;
                    count = count + 1;
                 end
                 else begin
                    Next_State = S3;
                    count = 2'b00;
                 end
            S5 : if (count < 3'b10) begin
                    Next_State = S3;
                    count = count + 1;
                 end
                 else begin
                    Next_State = S0;
                    count = 2'b00;
                 end
            default : Next_State = S0;
        endcase

    //Combinational Output Logic - in order - GYR and La and Lb
    always @(*)
        case(Current_State)
            S0 : L = {3'b100, 3'b001};
            S1 : L = {3'b010, 3'b001};
            S4 : L = {3'b010, 3'b001};
            S2 : L = {3'b001, 3'b100};
            S3 : L = {3'b001, 3'b010};
            S5 : L = {3'b001, 3'b010};
        endcase
    endmodule

`timescale 1ns/1ps
module tb();
    //inputs
    reg CLK, RST, Ta, Tb;
    //outputs
    wire [5:0] L;
    wire [2:0] Current_State, count;

    MealyFSM uut(CLK, RST, Ta, Tb, L, Current_State, count);

    initial begin
    $dumpfile ("TLC.vcd"); 
    $dumpvars(0,tb);

        CLK = 0;
        RST = 0; 
        Ta = 0;
        Tb = 0;
        end

    always #30 CLK = ~CLK;

    always begin
        Ta = 0;
        Tb = 0;
        #45 Ta = 1;
        #45
        #45
        Ta = 0;
        Tb = 1;
        #45
        #45 Ta = 1;
        #300
        RST = ~RST;
    end

endmodule
