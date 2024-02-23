`include "up_down_counter.v"

module testbench;

reg clk, rst, enable, up_down, load;
reg [3:0] data_in;
wire [3:0] count;

up_down_counter uut(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .up_down(up_down),
    .load(load),
    .data_in(data_in),
    .count(count)
);

initial begin
    $dumpfile("counter.vcd");
    $dumpvars(0, testbench);

    clk = 0;
    rst = 1;
    enable = 0;
    up_down = 1;
    load = 0;
    data_in = 4'b0000;

    #10 rst = 0;
    #10 enable = 1;

    // Up counting test
    up_down = 1;
    load = 0;
    #20;
    load = 1;
    data_in = 4'b0110;
    #20;
    load = 0;
    #50;
    $display("Up count: %b", count);

    // Down counting test
    up_down = 0;
    load = 0;
    #20;
    load = 1;
    data_in = 4'b1001;
    #20;
    load = 0;
    #50;
    $display("Down count: %b", count);

    // Up counting with enable disabled
    enable = 0;
    #20;
    enable = 1;
    #20;
    $display("Up count with enable disabled: %b", count);

    // Reset test
    rst = 1;
    enable = 0;
    up_down = 1;
    load = 0;
    data_in = 4'b0101;
    #10 rst = 0;
    #20;
    rst = 1;
    #20;
    rst = 0;
    #20;
    $display("After reset: %b", count);

    $finish;
end

always #5 clk = ~clk;

endmodule

