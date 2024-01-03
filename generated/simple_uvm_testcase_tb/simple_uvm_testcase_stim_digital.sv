//SystemVerilog HDL for "RFDV_scratch_sim", "simple_uvm_testcase_stim_digital" "svlog"
// auto generated digital top
`timescale 1ns/1ps
module simple_uvm_testcase_stim_digital ( 
	input logic  	 	clk_out_0 , 
	input logic  	 	clk_out_1 , 
	input logic  	 	clk_out_2 , 
	input logic  	 	clk_out_3 , 
	output logic  	 	mclk_in 
);


// instantiate digital if
import uvm_pkg::uvm_config_db;
autb_generic_if digital_if(); // interface contains  associative array of string with string index : string settings[string].
// if uvm , register if with config 
initial begin 
	uvm_config_db#(virtual autb_generic_if)::set(null, "uvm_test_top", "digital_vif", digital_if);
end
// insert digital behavior here:
real clk_out_0$freq ;
//  measure clock frequency for clk_out_0
	real clk_out_0$tlast;
	string clk_out_0$s_freq;
   	always  @(posedge clk_out_0) begin
        if (clk_out_0$tlast>0)  begin
			clk_out_0$freq = 1e9/($realtime()-clk_out_0$tlast);
			clk_out_0$s_freq.realtoa(clk_out_0$freq);
    	end
    	clk_out_0$tlast = $realtime();
   end
   task reset_clk_out_0$meas();
    	begin
      		clk_out_0$freq = 0;
      		clk_out_0$tlast = 0;
    	end
  	endtask
  	always @(digital_if.settings["reset_clk_out_0$meas"]) if (digital_if.settings["reset_clk_out_0$meas"].atoi()) reset_clk_out_0$meas();
  	always @(clk_out_0$s_freq) digital_if.observations["clk_out_0$freq"] = clk_out_0$s_freq;
real clk_out_1$freq ;
//  measure clock frequency for clk_out_1
	real clk_out_1$tlast;
	string clk_out_1$s_freq;
   	always  @(posedge clk_out_1) begin
        if (clk_out_1$tlast>0)  begin
			clk_out_1$freq = 1e9/($realtime()-clk_out_1$tlast);
			clk_out_1$s_freq.realtoa(clk_out_1$freq);
    	end
    	clk_out_1$tlast = $realtime();
   end
   task reset_clk_out_1$meas();
    	begin
      		clk_out_1$freq = 0;
      		clk_out_1$tlast = 0;
    	end
  	endtask
  	always @(digital_if.settings["reset_clk_out_1$meas"]) if (digital_if.settings["reset_clk_out_1$meas"].atoi()) reset_clk_out_1$meas();
  	always @(clk_out_1$s_freq) digital_if.observations["clk_out_1$freq"] = clk_out_1$s_freq;
real clk_out_2$freq ;
//  measure clock frequency for clk_out_2
	real clk_out_2$tlast;
	string clk_out_2$s_freq;
   	always  @(posedge clk_out_2) begin
        if (clk_out_2$tlast>0)  begin
			clk_out_2$freq = 1e9/($realtime()-clk_out_2$tlast);
			clk_out_2$s_freq.realtoa(clk_out_2$freq);
    	end
    	clk_out_2$tlast = $realtime();
   end
   task reset_clk_out_2$meas();
    	begin
      		clk_out_2$freq = 0;
      		clk_out_2$tlast = 0;
    	end
  	endtask
  	always @(digital_if.settings["reset_clk_out_2$meas"]) if (digital_if.settings["reset_clk_out_2$meas"].atoi()) reset_clk_out_2$meas();
  	always @(clk_out_2$s_freq) digital_if.observations["clk_out_2$freq"] = clk_out_2$s_freq;
real clk_out_3$freq ;
//  measure clock frequency for clk_out_3
	real clk_out_3$tlast;
	string clk_out_3$s_freq;
   	always  @(posedge clk_out_3) begin
        if (clk_out_3$tlast>0)  begin
			clk_out_3$freq = 1e9/($realtime()-clk_out_3$tlast);
			clk_out_3$s_freq.realtoa(clk_out_3$freq);
    	end
    	clk_out_3$tlast = $realtime();
   end
   task reset_clk_out_3$meas();
    	begin
      		clk_out_3$freq = 0;
      		clk_out_3$tlast = 0;
    	end
  	endtask
  	always @(digital_if.settings["reset_clk_out_3$meas"]) if (digital_if.settings["reset_clk_out_3$meas"].atoi()) reset_clk_out_3$meas();
  	always @(clk_out_3$s_freq) digital_if.observations["clk_out_3$freq"] = clk_out_3$s_freq;
real mclk_in$freq ;
// drive clock mclk_in at frequency
	bit mclk_in$enable;
	bit mclk_in$clk;
	real mclk_in$Thalf_ns;
	always_comb 
		if(mclk_in$freq>0) mclk_in$Thalf_ns = 0.5e9/mclk_in$freq;
		else mclk_in$Thalf_ns = 0;
	always wait(mclk_in$enable &&(mclk_in$Thalf_ns>0.01)) #(mclk_in$Thalf_ns*1ns) mclk_in$clk = mclk_in$clk !== 1;
	assign mclk_in = mclk_in$clk;
	always @(digital_if.settings["mclk_in$freq"]) mclk_in$freq = digital_if.settings["mclk_in$freq"].atoreal();
	always @(digital_if.settings["mclk_in$enable"]) mclk_in$enable = digital_if.settings["mclk_in$enable"].atoi();
	

endmodule