//SystemVerilog HDL for "simple_uvm_testcase_stim_power" "svlog"
module simple_uvm_testcase_stim_power ( 
	output interconnect  AVDD1P8, 	output interconnect  	 AVSS );
import uvm_pkg::uvm_config_db;
autb_generic_if pwr_if(); // contains an associative array of string with string index settings
initial begin 
	uvm_config_db#(virtual autb_generic_if)::set(null, "uvm_test_top", "power_vif", pwr_if);
end
simple_uvm_testcase_stim_power_adrive power_adrive(
	.AVDD1P8(AVDD1P8), 	.AVSS(AVSS) );
bit sample_trigger;
always @(pwr_if.settings["trigger"] or pwr_if.sample_trigger) begin
	sample_trigger = pwr_if.settings["trigger"].atoi();
	if (sample_trigger ) begin
  		power_adrive.sample_trigger = 1;
  		#1ps power_adrive.sample_trigger = 0;
	end
end
    always @(pwr_if.settings["AVDD1P8_vset"]) 
		power_adrive.AVDD1P8_vset =  pwr_if.settings["AVDD1P8_vset"].atoreal();
    always @(pwr_if.settings["AVDD1P8_enable"]) 
        power_adrive.AVDD1P8_enable =  pwr_if.settings["AVDD1P8_enable"].atoi();
    always @(pwr_if.settings["AVDD1P8_ron"])   
        power_adrive.AVDD1P8_ron =  pwr_if.settings["AVDD1P8_ron"].atoreal();
    always @(pwr_if.settings["AVDD1P8_roff"]) 
        power_adrive.AVDD1P8_roff =  pwr_if.settings["AVDD1P8_roff"].atoreal();
    always @(pwr_if.settings["AVDD1P8_tt"]) 
        power_adrive.AVDD1P8_tt =  pwr_if.settings["AVDD1P8_tt"].atoreal();
endmodule