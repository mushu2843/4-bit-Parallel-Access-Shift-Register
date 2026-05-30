`timescale 1ns/1ps

module shift_register_tb;

reg clk;
reg rst;
reg [1:0] mode;
reg [3:0] parallel_in;
reg serial_left;
reg serial_right;

wire [3:0] q;

shift_register uut (
    .clk(clk),
    .rst(rst),
    .mode(mode),
    .parallel_in(parallel_in),
    .serial_left(serial_left),
    .serial_right(serial_right),
    .q(q)
);

// Clock generation
always #5 clk = ~clk;

initial
begin
    // Initialize signals
    clk = 0;
    rst = 1;
    mode = 2'b00;
    parallel_in = 4'b0000;
    serial_left = 0;
    serial_right = 0;

    // Test Case 1 : Reset
    #10 rst = 0;

    // Test Case 2 : Parallel Load 1010
    mode = 2'b11;
    parallel_in = 4'b1010;
    #10;

    // Test Case 3 : Hold
    mode = 2'b00;
    #10;

    // Test Case 4 : Shift Right with serial input 1
    mode = 2'b01;
    serial_left = 1;
    #10;

    // Test Case 5 : Shift Right with serial input 0
    serial_left = 0;
    #10;

    // Test Case 6 : Shift Left with serial input 1
    mode = 2'b10;
    serial_right = 1;
    #10;

    // Test Case 7 : Shift Left with serial input 0
    serial_right = 0;
    #10;

    // Test Case 8 : Parallel Load all 1's
    mode = 2'b11;
    parallel_in = 4'b1111;
    #10;

    // Test Case 9 : Shift Right continuously
    mode = 2'b01;
    serial_left = 0;
    #40;

    // Test Case 10 : Parallel Load all 0's
    mode = 2'b11;
    parallel_in = 4'b0000;
    #10;

    // Test Case 11 : Parallel Load alternating bits
    parallel_in = 4'b0101;
    #10;

    // Test Case 12 : Shift Left continuously
    mode = 2'b10;
    serial_right = 1;
    #40;

    // Test Case 13 : Mid-operation Reset
    rst = 1;
    #10;
    rst = 0;

    // Test Case 14 : Parallel Load new value
    mode = 2'b11;
    parallel_in = 4'b1100;
    #10;

    // Test Case 15 : Hold after load
    mode = 2'b00;
    #20;

    $stop;
end

endmodule