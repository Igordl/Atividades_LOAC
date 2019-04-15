// DESCRIPTION: Verilator: Systemverilog example module
// with interface to switch buttons, LEDs, LCD and register display

parameter NINSTR_BITS = 32;
parameter NBITS_TOP = 8, NREGS_TOP = 32;
module top(input  logic clk_2,
           input  logic [NBITS_TOP-1:0] SWI,
           output logic [NBITS_TOP-1:0] LED,
           output logic [NBITS_TOP-1:0] SEG,
           output logic [NINSTR_BITS-1:0] lcd_instruction,
           output logic [NBITS_TOP-1:0] lcd_registrador [0:NREGS_TOP-1],
           output logic [NBITS_TOP-1:0] lcd_pc, lcd_SrcA, lcd_SrcB,
             lcd_ALUResult, lcd_Result, lcd_WriteData, lcd_ReadData, 
           output logic lcd_MemWrite, lcd_Branch, lcd_MemtoReg, lcd_RegWrite);

  always_comb begin
    LED <= SWI;
    SEG <= SWI;
    lcd_WriteData <= SWI;
    lcd_pc <= 'h12;
    lcd_instruction <= 'h34567890;
    lcd_SrcA <= 'hab;
    lcd_SrcB <= 'hcd;
    lcd_ALUResult <= 'hef;
    lcd_Result <= 'h11;
    lcd_ReadData <= 'h33;
    lcd_MemWrite <= SWI[0];
    lcd_Branch <= SWI[1];
    lcd_MemtoReg <= SWI[2];
    lcd_RegWrite <= SWI[3];
    for(int i=0; i<NREGS_TOP; i++) lcd_registrador[i] <= i+i*16;
  end


logic signed[2:0] as,bs;
logic [2:0] a,b;
logic[5:0] result;
always_comb begin
	sudo apt-get update
sudo apt-get install libfltk1.3-dev make g++ libpng-dev zlib1g-dev verilator git
	unique case(SWI[4:3]) begin
	0: result <= a + b;
	1: result <= a - b;
	2: result <= a * b;
	3: result <= as * bs;	
	endcase
	
	case(result) begin
	-4: SEG[7:0] <= 8'b11100110;
	-3: SEG[7:0] <= 8'b11001111;
	-2: SEG[7:0] <= 8'b11011011;
	-1: SEG[7:0] <= 8'b10000110;
	 0: SEG[7:0] <= 8'b00111111;
	 1: SEG[7:0] <= 8'b00000110;
	 2: SEG[7:0] <= 8'b01011011;	
	 3: SEG[7:0] <= 8'b00100111;
	 4: SEG[7:0] <= 8'b01100110;
	 5: SEG[7:0] <= 8'b01101101;
	 6: SEG[7:0] <= 8'b01111101;
	 7: SEG[7:0] <= 8'b00000111;
	 8: SEG[7:0] <= 8'b01111111;
	 9: SEG[7:0] <= 8'b01101111;
	 default: SEG[7:0] <= 8'b01000000;
	endcase
	
	LED[7:0] <= result;
end
endmodule
