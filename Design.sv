module design_1 (
    input  logic clk, rst,
    output logic [1:0] state
);

    typedef enum logic [1:0] {
        RED    = 2'b00,
        YELLOW = 2'b01,
        GREEN  = 2'b10,
        OFF    = 2'b11
    } light_t;

    light_t current_state, next_state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= RED;
        else
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
            RED:     next_state = GREEN;
            GREEN:   next_state = YELLOW;
            YELLOW:  next_state = RED;
            default: next_state = RED;
        endcase
    end

    assign state = current_state;

endmodule
