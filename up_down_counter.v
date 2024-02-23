module up_down_counter(
    input wire clk,
    input wire rst,
    input wire enable,
    input wire up_down,
    input wire load,
    input wire [3:0] data_in,
    output reg [3:0] count
);

always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 4'b0000;
    else if (enable) begin
        if (up_down)
            count <= count + 1;
        else
            count <= count - 1;
    end
end

always @(posedge clk) begin
    if (load)
        count <= data_in;
end

endmodule

