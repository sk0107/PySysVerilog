module top
  (
   input CLK, 
   input RST,
   input enable,
   input [31:0][7:0] value,
   output [7:0] led
  );
  logic [31:0] count;
  logic [7:0] state;

  reg [7:0][2:0] led_temp; 


  always @(*) begin
    if (value > 11) begin 
      led_temp = count[23:16];
    end else begin 
      led_temp = count[15:8];
    end
  end
  always @(posedge CLK) begin
    if(RST) begin
      count <= 0;
      state <= 0;
    end else begin
      if(state == 0) begin
        if(value > 7) state <= state + 1;
      end else if(state == 1) begin
        state <= 2;
      end else if(state == 2) begin
        count <= count + value;
        state <= 0;
      end
    end
  end
  assign led[0] = (value > cound)?led_temp:count[7:0]; 
  assign led[7:1] = count[7:1];
endmodule
