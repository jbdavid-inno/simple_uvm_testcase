// FILE HEADER  {{{1
// File Information  {{{2
/*
 * clk_dist_block
 * x2 x1 div2 div4  clock_gen
 *
 * File type: SystemVerilog discrete electrical model
 * ID: RFDV_scratch.clk_dist_block:MiM_DE
 * Verification engineer: Jonathan David
 * URL: https://mim.designers-guide.com/spec_sheets/edit/12657
 * Spec updated: November, 4 November 2023 at 12:25 PM UTC-0700
 * File generated: November, 4 November 2023 at 12:25 PM UTC-0700 by MiM version 2.0b22
 * MiM user: jonathan.david
 * Content signature: e8d8dc365896ec56136a965f32a917d0 (do not change this line)
 *
 * Copyright 2023 Designer’s Guide Consulting, Inc.  All rights reserved.
 * This code is the property of Designer’s Guide Consulting, Inc.
 * A license is granted to
 *     Innophase Inc (the Licensee)
 * to use this code until 11 Jan 2025 pursuant to the Standard License
 * Agreement between Licensee and Designer’s Guide Consulting, Inc.
 */

// Defines  {{{2
// Time definitions  {{{3
// VTU is short for Verilog time unit. Equals first value of `timescale.
`timescale 1ns/1ps
`define UNIT_TIME       1e-9
    // Duration of a unit time delay (first value of `timescale). [s]
`define TIME_PREC       1e-12
    // Minimum resolvable time delay (second value of `timescale). [s]
`define fromSeconds(t)  ((t)/`UNIT_TIME)
    // Converts time in seconds to Verilog Time Units. [s→VTU]
`define toSeconds(t)    ((t)*`UNIT_TIME)
    // Converts time in Verilog Time Units to seconds. [VTU→s]
`define MIN_DELAY       `fromSeconds(`TIME_PREC)
    // Minimum resolvable time delay in Verilog Time Units. [VTU]


// MODULE HEADER  {{{1
module clk_dist_block (
    output dll_locked,                  // doubler dll is at 50% duty cycle
    input AVSS,                         // Ground
    input Ibg_10u,                      // ibias in
    input clk_en,                       // enable for block
    input mclk_in,                      // 80M input clk
    output vcntrl,                      // Output
    input AVDD_1P8,                     // Supply
    input[1:0] mode_sel,                // 00 is x1 01 is x2, 11 is div2 10 is div4
    output clk_out                      // output clock
);

// Discrete-Electrical (DE) Transceivers  {{{2
real AVSS$Vobs, AVSS$Iobs, AVSS$Idrv, AVSS$Gdrv;
DE_norton Xtcvr_AVSS (AVSS, AVSS$Vobs, AVSS$Iobs, AVSS$Idrv, AVSS$Gdrv);

real Ibg_10u$Vobs, Ibg_10u$Iobs, Ibg_10u$Vdrv, Ibg_10u$Rdrv;
DE_thevenin Xtcvr_Ibg_10u (Ibg_10u, Ibg_10u$Vobs, Ibg_10u$Iobs, Ibg_10u$Vdrv, Ibg_10u$Rdrv);

real vcntrl$Vobs, vcntrl$Iobs, vcntrl$Vdrv, vcntrl$Rdrv;
DE_thevenin Xtcvr_vcntrl (vcntrl, vcntrl$Vobs, vcntrl$Iobs, vcntrl$Vdrv, vcntrl$Rdrv);

real AVDD_1P8$Vobs, AVDD_1P8$Iobs, AVDD_1P8$Idrv, AVDD_1P8$Gdrv;
DE_norton Xtcvr_AVDD_1P8 (AVDD_1P8, AVDD_1P8$Vobs, AVDD_1P8$Iobs, AVDD_1P8$Idrv, AVDD_1P8$Gdrv);


// DECLARATIONS  {{{1
// Missing Functions  {{{2
// these function may be needed by MiM but are not provided by SV
function automatic real max(real a, b);
    max = (a > b) ? a : b;
endfunction

function automatic real min(real a, b);
    min = (a < b) ? a : b;
endfunction

// User Variables  {{{2
reg Active;
real On;                                // Active smoothed
reg Clk_Out = 0;
wire update_clk;                        // 1Ghz update
wire DLLenable;
wire Clk2x;                             // 50% duty cycle of 4x clk
reg DLL_locked;
wire Clk_del;
real Tclk_in_last = 0;
reg DLLready;
real VdelayControl;
reg Clk_div4 = 0;
real Clpf = 1e-9;
reg Clk_div2 = 0;
wire Clk_del1;                          // non 50% version 2x clk
wire Clk_del2;                          // non 50% version 2x clk
wire Clk_del3;                          // non 50% version 2x clk
real Icp;                               // Charge Pump current
real Ibias;
wire enable;
wire Clk_in;
real Vdd;
wire [1:0] Mode;

// Global fault variables  {{{2
reg [1:0] _faultReportingMask = 2'b11;
`ifdef TESTBENCH
    always @(`TESTBENCH._faultReportingMask)
    _faultReportingMask = `TESTBENCH._faultReportingMask;
`endif
wor _FaultOnInput = 'b0;                // Indicates assertion failure on an input port
wire Fault = (_FaultOnInput & _faultReportingMask[0]) === 1;
                                        // Gated version, used to suppress model activity
reg[80*8:1] _FaultMessage = "";         // Message describing active fault
always @(negedge _FaultOnInput)
    _FaultMessage = "";

// Fault Variables  {{{2
// Placed in their own scope to consolidate them.
begin : _faults
    wor V_AVSS = 1'b0;
    wor I_Ibg_10u = 1'b0;
    wor V_AVDD_1P8 = 1'b0;
    wor mode_sel = 1'b0;
end

// Uninteresting Variables  {{{2
// Placed in their own scope to hide them.
initial begin : _locals
    reg[320*8:1] module_name;
    reg enableAsserts;
    enableAsserts = 1'b0;
    #(3*`MIN_DELAY) enableAsserts = 1'b1;
end
initial $sformat(_locals.module_name, "%m (clk_dist_block)");

// User Code  {{{2
// This code was specified literally in the MiM specification.
// Changes to non-shared code are uploaded to MiM server using: av update - upload
// { de_mod_aft_var_decls 22171 (do not delete this line)
    always wait (enable) @(posedge Clk_in) Clk_div2 <= ~Clk_div2;
    always wait (enable) @(posedge Clk_div2) Clk_div4 <= ~Clk_div4;
    always wait (enable) begin
    	case(mode_sel)
    		'b00 : @(Clk_in or mode_sel or negedge enable) Clk_Out = Clk_in&enable;
    		'b01 : @(Clk2x or mode_sel or negedge enable) Clk_Out = Clk2x&enable;
    		'b11 : @(Clk_div2 or mode_sel or negedge enable) Clk_Out = Clk_div2&enable;
    		'b10 : @(Clk_div4 or mode_sel or negedge enable) Clk_Out = Clk_div4&enable;
          default: @(Clk_in or mode_sel or negedge enable) Clk_Out = Clk_in&enable;
        endcase
    end
    always @(VdelayControl) vcntrl$Vdrv = VdelayControl;
    // as we are only generating 2x clock delay of both inverters must be at Least 1 clock cycle
    //otherwise we need to keep increasing the delay
    real Vdelta;
    real Tnow;
    always wait(DLLenable & !DLLready) @(posedge Clk_in) begin
        if (Clk_del3) DLLready = 1;
        else if (Tclk_in_last > 0) begin
            Tnow = $realtime();
            Vdelta = Icp*(Tnow -Tclk_in_last)*`UNIT_TIME/Clpf;
            VdelayControl += Vdelta;
        end
        Tclk_in_last = $realtime();
    end
    real Tup_last, Tdn_last;
    bit Up, Dn;
    always wait(DLLready) @(posedge Clk_in) begin
        if (Dn) begin // Feedback clk was first
            Tnow = $realtime();
            if (Tnow -Tdn_last > 0.001) begin
                Vdelta = Icp*(Tnow -Tdn_last)*`UNIT_TIME/Clpf;
                VdelayControl += Vdelta;
            end else begin
                DLL_locked = 1;
                Vdelta = 0;
            end
            Dn = 0;
        end else begin
            #0 if (!Clk_del3) Up = 1;
            Tup_last = $realtime();
        end
    end
    always wait(DLLready) @(posedge Clk_del3) begin
        if (Up) begin // Ref clk was first
            Tnow = $realtime();
            if (Tnow -Tup_last > 1) begin
                Vdelta = -Icp*(Tnow -Tup_last)*`UNIT_TIME/Clpf;
                VdelayControl += Vdelta;
            end else begin
                DLL_locked = 1;
                Vdelta = 0;
            end
            Up = 0;
        end else begin
            #0 if(!Clk_in)  Dn = 1;
            Tdn_last = $realtime();
        end
    end
    always wait(DLLready & !DLL_locked) @(posedge Up) begin
          if (!DLL_locked) @(posedge Dn) DLL_locked = DLLready;
    end
    always wait(DLLready & !DLL_locked) @(posedge Dn) begin
          if (!DLL_locked) @(posedge Up) begin
              if (!DLL_locked) DLL_locked = DLLready;
          end
    end
    always @(negedge DLLenable) DLL_locked = 0;
    always @(negedge DLLenable) VdelayControl = 0;
// } de_mod_aft_var_decls 22171 (do not delete this line)


// DISCRETE BEHAVIOR  {{{1
// Port Variables  {{{2
assign enable = ^clk_en !== 1'bX ? clk_en : 0;
assign Clk_in = mclk_in;
assign Mode = mode_sel;

// Discrete Variables  {{{2
always @(enable or Fault)
    Active <= enable&!Fault;
always @(negedge enable)
    Clk_Out <= 0;
assign #(`fromSeconds(max(1e-9, `TIME_PREC))) update_clk = enable ? update_clk === 0 : 0;
assign DLLenable = enable && mode_sel == 2'b01;
assign Clk2x = DLLenable&(Clk_in^Clk_del);
assign #(`fromSeconds(max(1e-9*(10*VdelayControl + 1), `TIME_PREC))) Clk_del = DLLenable&Clk_in;
always @(negedge DLLenable)
    Tclk_in_last <= 0;
always @(negedge DLLenable)
    DLLready <= 0;
always @(negedge enable)
    Clk_div4 <= 0;
always @(negedge enable)
    Clk_div2 <= 0;
assign #(`fromSeconds(max(1e-9*(10*VdelayControl + 1), `TIME_PREC))) Clk_del1 = DLLenable&Clk_del;
assign #(`fromSeconds(max(1e-9*(10*VdelayControl + 1), `TIME_PREC))) Clk_del2 = DLLenable&Clk_del1;
assign #(`fromSeconds(max(1e-9*(10*VdelayControl + 1), `TIME_PREC))) Clk_del3 = DLLenable&Clk_del2;

// Port Drivers  {{{2
// dll_locked: doubler dll is at 50% duty cycle  {{{3
// dll_locked = DLL_locked
assign dll_locked = DLL_locked;

// clk_out: output clock  {{{3
// clk_out = Clk_Out
assign clk_out = Clk_Out;


// CONTINUOUS BEHAVIOR  {{{1
// Port Variables  {{{2
assign Ibias = Ibg_10u$Iobs;
assign Vdd = AVDD_1P8$Vobs;

// Smoothed Discrete Variables  {{{2
assign On = Active;

// Continuous Variables  {{{2
assign Icp = 10*Ibias;

// Port Drivers  {{{2
// Ibg_10u: ibias in  {{{3
// V(Ibg_10u) = 0
// R(Ibg_10u) = 400kΩ
assign Ibg_10u$Vdrv = 0;
assign Ibg_10u$Rdrv = 400e3;


// ASSERTIONS  {{{1
// Check for V(AVSS) out of range (−10mV to 10mV)  {{{2
assign #(`fromSeconds(10e-9), 0) _faults.V_AVSS = !(((-10e-3 < AVSS$Vobs) && (AVSS$Vobs < 10e-3)) || !_locals.enableAsserts);
always @(_faults.V_AVSS)
    _reportFault(_faults.V_AVSS, "V(AVSS) out of range");
assign _FaultOnInput = _faults.V_AVSS;

// Check for I(Ibg_10u) out of range (9µa to 11µa when enable for 1µs)  {{{2
assign #(`fromSeconds(1e-6), 0) _faults.I_Ibg_10u = !(((9e-6 < Ibg_10u$Iobs) && (Ibg_10u$Iobs < 11e-6)) || !(_locals.enableAsserts && enable));
always @(_faults.I_Ibg_10u)
    _reportFault(_faults.I_Ibg_10u, "I(Ibg_10u) out of range");
assign _FaultOnInput = _faults.I_Ibg_10u;

// Check for V(AVDD_1P8) out of range (1.6V to 2V)  {{{2
assign #(`fromSeconds(10e-9), 0) _faults.V_AVDD_1P8 = !(((1.6 < AVDD_1P8$Vobs) && (AVDD_1P8$Vobs < 2.0)) || !_locals.enableAsserts);
always @(_faults.V_AVDD_1P8)
    _reportFault(_faults.V_AVDD_1P8, "V(AVDD_1P8) out of range");
assign _FaultOnInput = _faults.V_AVDD_1P8;

// Check for mode_sel out of range (nox)  {{{2
assign #(`fromSeconds(10e-9), 0) _faults.mode_sel = !((^mode_sel !== 'bX) || !_locals.enableAsserts);
always @(_faults.mode_sel)
    _reportFault(_faults.mode_sel, "mode_sel out of range");
assign _FaultOnInput = _faults.mode_sel;

// Report changes in assertions to the user  {{{2
`ifdef TESTBENCH
    // Report via the testbench.
    task _reportFault (
        input fault,
        input [8*400:1] description
    );
        begin
            `TESTBENCH._reportFault(
                fault, _locals.module_name,
                description, _faultReportingMask[1]
            );
            if (fault)
                _FaultMessage = description;
            else
                _FaultMessage = "unknown fault";
        end
    endtask
    assign `TESTBENCH._FaultOnInput = _FaultOnInput;
    assign `TESTBENCH.Fault = Fault;
`else
    // Report from here because testbench is unknown.
    task _reportFault (
        input fault,
        input [8*400:1] description
    );
        reg [8*20:1] status;
        begin
            if (fault === 1'b1)
                status = "FAULT detected";
            else if (fault === 1'b0)
                status = "Fault ends";
            else
                status = "FAULT may exist";
            if (fault !== 0) begin
                if ($time > 2*`MIN_DELAY && _faultReportingMask[1])
                    $display("    %0s @ %0.8es in %0s: %0s.",
                        status, `toSeconds($realtime), _locals.module_name, description
                    );
                _FaultMessage = description;
            end else
                _FaultMessage = "unknown fault";
        end
    endtask
`endif

endmodule
`undef UNIT_TIME
`undef TIME_PREC
`undef fromSeconds
`undef toSeconds
`undef MIN_DELAY

// vim: set sw=4 sts=4 et foldmethod=marker :
