//SystemVerilog HDL for "RFDV_scratch_sim", "simple_uvm_testcase_stim_power" "svlog"
// auto generated power top
module simple_uvm_testcase_stim_power ( 
	output interconnect  	 	AVDD1P8 , 
	output interconnect  	 	AVSS 
);
// instantiate power if
import uvm_pkg::uvm_config_db;
autb_generic_if pwr_if(); // interface contains an associative array of string with string index settings
// if uvm , register if with config 
initial begin 
	uvm_config_db#(virtual autb_generic_if)::set(null, "uvm_test_top", "power_vif", pwr_if);
end

// ams block 
simple_uvm_testcase_stim_power_adrive power_adrive(
	.AVDD1P8(AVDD1P8), 
	.AVSS(AVSS)
);

bit sample_trigger;
always @(pwr_if.settings["trigger"] or pwr_if.sample_trigger) begin
	sample_trigger = pwr_if.settings["trigger"].atoi();
	if (sample_trigger ) begin
  		power_adrive.sample_trigger = 1;
  		#1ps power_adrive.sample_trigger = 0;
	end
end

// set voltages from if.. 
    always @(pwr_if.settings["AVDD1P8_vset"]) 
		power_adrive.AVDD1P8_vset =  pwr_if.settings["AVDD1P8_vset"].atoreal();
	
	// set enable from if.. 
    always @(pwr_if.settings["AVDD1P8_enable"]) power_adrive.AVDD1P8_enable =  pwr_if.settings["AVDD1P8_enable"].atoi();
	
	// set ron from if.. 
    always @(pwr_if.settings["AVDD1P8_ron"]) power_adrive.AVDD1P8_ron =  pwr_if.settings["AVDD1P8_ron"].atoreal();
	
	// set roff from if.. 
    always @(pwr_if.settings["AVDD1P8_roff"]) power_adrive.AVDD1P8_roff =  pwr_if.settings["AVDD1P8_roff"].atoreal();
	
	// set transition_time from if.. 
    always @(pwr_if.settings["AVDD1P8_tt"]) power_adrive.AVDD1P8_tt =  pwr_if.settings["AVDD1P8_tt"].atoreal();
	
//set if from input signals
    
endmodule