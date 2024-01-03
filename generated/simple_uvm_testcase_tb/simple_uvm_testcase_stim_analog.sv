//SystemVerilog HDL for "RFDV_scratch_sim", "simple_uvm_testcase_stim_analog" "svlog"
// auto generated analog top
module simple_uvm_testcase_stim_analog ( 
	input interconnect  	 	vcntrl0 , 
	input interconnect  	 	vcntrl1 , 
	input interconnect  	 	vcntrl2 , 
	input interconnect  	 	vcntrl3 
);
// instantiate analog if
import uvm_pkg::uvm_config_db;
autb_generic_if analog_if(); // interface contains an associative array of string with string index settings, and a trigger event
// if uvm , register if with config 
initial begin 
	uvm_config_db#(virtual autb_generic_if)::set(null, "uvm_test_top", "analog_vif", analog_if);
end
// ams block 
simple_uvm_testcase_stim_analog_adrive analog_adrive(
	.vcntrl0(vcntrl0), 
	.vcntrl1(vcntrl1), 
	.vcntrl2(vcntrl2), 
	.vcntrl3(vcntrl3)
);
// set voltages/currents from if.. 
// hand coded
	always @(analog_if.sample_trigger) begin 
        analog_adrive.sample_trigger = 1;
        #1ns ;
        analog_adrive.sample_trigger = 0;
    end    
//set if from input signals
    always @(analog_adrive.vcntrl0_volts) analog_if.observations["vcntrl0_volts"].realtoa(analog_adrive.vcntrl0_volts) ;
	
	always @(analog_adrive.vcntrl1_volts) analog_if.observations["vcntrl1_volts"].realtoa(analog_adrive.vcntrl1_volts) ;
	
	always @(analog_adrive.vcntrl2_volts) analog_if.observations["vcntrl2_volts"].realtoa(analog_adrive.vcntrl2_volts) ;
	
	always @(analog_adrive.vcntrl3_volts) analog_if.observations["vcntrl3_volts"].realtoa(analog_adrive.vcntrl3_volts) ;
	
	
	

endmodule