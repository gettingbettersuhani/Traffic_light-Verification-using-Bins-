Traffic Light Controller FSM with Functional CoverageA SystemVerilog implementation of a basic Finite State Machine (FSM) modeling a traffic light controller, verified using a class-based functional coverage testbench.📌 Project OverviewThis project demonstrates core digital design and functional verification concepts in SystemVerilog:Design Under Test (DUT): A synchronous 3-state traffic light controller (design_1) with asynchronous reset.Verification (TB): A class-based testbench (tb) demonstrating functional coverage collection using covergroup, state transition bins, and illegal_bins.🚦 FSM ArchitectureState EncodingStateBinary ValueDescriptionRED2'b00StopYELLOW2'b01Caution / Prepare to stopGREEN2'b10GoOFF2'b11Unused / Illegal stateState Transition Diagram    +---------+
    |  RESET  |
    +----+----+
         |
         v
     +-------+        +---------+
     |  RED  | -----> |  GREEN  |
     +-------+        +----+----+
         ^                 |
         |                 |
         |    +--------+   |
         +--- | YELLOW | <-+
              +--------+
🎯 Verification & Functional Coverage StrategyThe testbench encapsulates coverage logic inside a dedicated class (cov_class) using embedded SystemVerilog covergroups:1. State Coverage (cp_state)Valid states: Monitored via explicit bins for red_bin (2'b00), yellow_bin (2'b01), and green_bin (2'b10).Illegal state detection: Configured off_bin (2'b11) as illegal_bins to immediately flag any invalid state transitions as a runtime error.2. Transition Coverage (cp_trans)Verifies that all expected operational paths and sequences occur:RED $\rightarrow$ GREEN (2'b00 => 2'b10)GREEN $\rightarrow$ YELLOW (2'b10 => 2'b01)YELLOW $\rightarrow$ RED (2'b01 => 2'b00)Full Cycle: Consecutive sequence verification (2'b00 => 2'b10 => 2'b01 => 2'b00)📂 File Structure.
├── design_1.sv      # Traffic Light Controller FSM
├── tb.sv            # Testbench with class-based coverage model
└── README.md        # Documentation
🚀 How to Run the SimulationYou can run this project on any standard SystemVerilog simulator (QuestaSim, VCS, Xcelium, or EDA Playground).Using Siemens QuestaSim / ModelSim# Compile design and testbench
vlog -sv design_1.sv tb.sv

# Run simulation with coverage enabled
vsim -c -coverage tb -do "run -all; coverage report -detail; quit -f"
Using Synopsys VCS# Compile with coverage switches
vcs -sverilog design_1.sv tb.sv -cm line+cond+fsm+tgl+branch+assert

# Execute binary
./simv -cm line+cond+fsm+tgl+branch+assert
Using Cadence Xceliumxrun -sv -coverage all design_1.sv tb.sv
📊 Sample OutputTime = 15  State = 00
Time = 25  State = 10
Time = 35  State = 01
Time = 45  State = 00
Time = 55  State = 10
Time = 65  State = 01
Time = 75  State = 00
Time = 85  State = 10
Time = 95  State = 01
Time = 105  State = 00
Time = 115  State = 10
Time = 125  State = 01
Coverage = 100.00 %
$finish at simulation time 145
