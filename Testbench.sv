module tb;
    logic clk, rst;
    logic [1:0] state;

    design_1 uut (
        .clk(clk),
        .rst(rst),
        .state(state)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    class cov_class;
        logic [1:0] st;

        covergroup cg;
            cp_state : coverpoint st {
                bins red_bin         = {2'b00};
                bins yellow_bin      = {2'b01};
                bins green_bin       = {2'b10};
                illegal_bins off_bin = {2'b11};
            }

            cp_trans : coverpoint st {
                bins red_to_green    = (2'b00 => 2'b10);
                bins green_to_yellow = (2'b10 => 2'b01);
                bins yellow_to_red   = (2'b01 => 2'b00);
                bins full_cycle      = (2'b00 => 2'b10 => 2'b01 => 2'b00);
            }
        endgroup

        function new();
            cg = new();
        endfunction
    endclass

    cov_class c1;

    initial begin
        c1 = new();
        rst = 1;
        #12;
        rst = 0;

        repeat (12) begin
            @(posedge clk);
            #1;
            c1.st = state;
            c1.cg.sample();
            $display("Time = %0t  State = %b", $time, state);
        end

        #20;
        $display("Coverage = %0.2f %%", c1.cg.get_coverage());
        $finish;
    end
endmodule
