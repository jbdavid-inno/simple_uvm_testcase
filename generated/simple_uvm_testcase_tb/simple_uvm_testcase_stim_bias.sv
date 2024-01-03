//SystemVerilog HDL for "RFDV_scratch_sim", "simple_uvm_testcase_stim_bias" "svlog"
// auto generated bias top
module simple_uvm_testcase_stim_bias ( 
);
// declarations for bused signals

// instantiate bias if
import uvm_pkg::uvm_config_db;
autb_generic_if bias_if(); // interface contains an associative array of string with string index settings
// if uvm , register if with config 
initial begin 
	uvm_config_db#(virtual autb_generic_if)::set(null, "uvm_test_top", "bias_vif", bias_if);
end
// ams block 
simple_uvm_testcase_stim_bias_adrive bias_adrive(
);
// set voltages/currents from if.. 
    
	// set enable from if.. 
    
	// set ron from if.. 
    
	// set roff from if.. 
    
	// set conductance from if..
	
//set if from input signals
    
endmodule