// FILE HEADER  {{{1
// File Information  {{{2
/*
 * bussed_port_bias_gen
 * generates 2 10uA bias from bandgap
 *
 * File type: SystemVerilog discrete electrical model
 * ID: RFDV_scratch.bused_port_bias_gen:MiM_DE
 * Verification engineer: Jonathan David
 * URL: https://mim.designers-guide.com/spec_sheets/edit/12647
 * Spec updated: November, 3 November 2023 at 9:50 AM UTC-0700
 * File generated: November, 3 November 2023 at 9:50 AM UTC-0700 by MiM version 2.0b22
 * MiM user: jonathan.david
 * Content signature: edcfcd807ba4341ad980bbd6c0d545fd (do not change this line)
 *
 * Copyright 2023 Designers Guide Consulting, Inc.  All rights reserved.
 * This code is the property of Designers Guide Consulting, Inc.
 * A license is granted to
 *     Innophase Inc (the Licensee)
 * to use this code until 11 Jan 2025 pursuant to the Standard License
 * Agreement between Licensee and Designers Guide Consulting, Inc.
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
    // Converts time in seconds to Verilog Time Units. [sVTU]
`define toSeconds(t)    ((t)*`UNIT_TIME)
    // Converts time in Verilog Time Units to seconds. [VTUs]
`define MIN_DELAY       `fromSeconds(`TIME_PREC)
    // Minimum resolvable time delay in Verilog Time Units. [VTU]


// MODULE HEADER  {{{1
module bused_port_bias_gen (
    input AVDD1P8,                      // supply
    input AVSS,                         // ground
    output[3:0] Ipt_10u,
    input bg_enable
);

// Discrete-Electrical (DE) Transceivers  {{{2
real AVDD1P8$Vobs, AVDD1P8$Iobs, AVDD1P8$Idrv, AVDD1P8$Gdrv;
DE_norton Xtcvr_AVDD1P8 (AVDD1P8, AVDD1P8$Vobs, AVDD1P8$Iobs, AVDD1P8$Idrv, AVDD1P8$Gdrv);

real AVSS$Vobs, AVSS$Iobs, AVSS$Idrv, AVSS$Gdrv;
DE_norton Xtcvr_AVSS (AVSS, AVSS$Vobs, AVSS$Iobs, AVSS$Idrv, AVSS$Gdrv);

real Ipt_10u$Vobs[3:0], Ipt_10u$Iobs[3:0], Ipt_10u$Idrv[3:0], Ipt_10u$Gdrv[3:0];
DE_norton Xtcvr_Ipt_10u[3:0] (Ipt_10u, Ipt_10u$Vobs, Ipt_10u$Iobs, Ipt_10u$Idrv, Ipt_10u$Gdrv);
//if we use these no problem
//DE_norton Xtcvr_Ipt_10u0 (Ipt_10u[0], Ipt_10u$Vobs[0], Ipt_10u$Iobs[0], Ipt_10u$Idrv[0], Ipt_10u$Gdrv[0]);
//DE_norton Xtcvr_Ipt_10u1 (Ipt_10u[1], Ipt_10u$Vobs[1], Ipt_10u$Iobs[1], Ipt_10u$Idrv[1], Ipt_10u$Gdrv[1]);
//DE_norton Xtcvr_Ipt_10u2 (Ipt_10u[2], Ipt_10u$Vobs[2], Ipt_10u$Iobs[2], Ipt_10u$Idrv[2], Ipt_10u$Gdrv[2]);
//DE_norton Xtcvr_Ipt_10u3 (Ipt_10u[3], Ipt_10u$Vobs[3], Ipt_10u$Iobs[3], Ipt_10u$Idrv[3], Ipt_10u$Gdrv[3]);


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
wire bg_enable$safe;
real Active$safe;
real Active;

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
    wor V_AVDD1P8 = 1'b0;
    wor V_AVSS = 1'b0;
end

// Uninteresting Variables  {{{2
// Placed in their own scope to hide them.
initial begin : _locals
    reg[320*8:1] module_name;
    reg enableAsserts;
    enableAsserts = 1'b0;
    #(3*`MIN_DELAY) enableAsserts = 1'b1;
end
initial $sformat(_locals.module_name, "%m (bused_port_bias_gen)");


// DISCRETE BEHAVIOR  {{{1
// Port Variables  {{{2
assign bg_enable$safe = ^bg_enable !== 1'bX ? bg_enable : 0;
assign Active$safe = bg_enable$safe&!Fault;


// CONTINUOUS BEHAVIOR  {{{1
// Port Variables  {{{2
assign Active = Active$safe;

// Port Drivers  {{{2
// Ipt_10u[3:0]  {{{3
// I(Ipt_10u[$i]) = Active10a
assign Ipt_10u$Idrv[0] = Active*-10e-6;
assign Ipt_10u$Idrv[1] = Active*-10e-6;
assign Ipt_10u$Idrv[2] = Active*-10e-6;
assign Ipt_10u$Idrv[3] = Active*-10e-6;


// ASSERTIONS  {{{1
// Check for V(AVDD1P8) out of range (1.7 to 1.9)  {{{2
assign #(`fromSeconds(10e-9), 0) _faults.V_AVDD1P8 = !(((1.7 < AVDD1P8$Vobs) && (AVDD1P8$Vobs < 1.9)) || !_locals.enableAsserts);
always @(_faults.V_AVDD1P8)
    _reportFault(_faults.V_AVDD1P8, "V(AVDD1P8) out of range");
assign _FaultOnInput = _faults.V_AVDD1P8;

// Check for V(AVSS) out of range (10m to 10m)  {{{2
assign #(`fromSeconds(10e-9), 0) _faults.V_AVSS = !(((-10e-3 < AVSS$Vobs) && (AVSS$Vobs < 10e-3)) || !_locals.enableAsserts);
always @(_faults.V_AVSS)
    _reportFault(_faults.V_AVSS, "V(AVSS) out of range");
assign _FaultOnInput = _faults.V_AVSS;

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
