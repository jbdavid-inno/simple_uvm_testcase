// auto generated regsister top
module simple_uvm_testcase_stim_register ( 
	output			bg_enable , 
	output	[3:0]	clk_en , 
	input	[3:0]	dll_lock_status , 
	output	[1:0]	mode_sel_0 , 
	output	[1:0]	mode_sel_1 , 
	output	[1:0]	mode_sel_2 , 
	output	[1:0]	mode_sel_3 
);
// instantiate register if
autb_csr_if reg_if(); // interface contains 2 associative arrays of int with string argument : writable for regs set by firmware and readonly for regs that monitor the RFA section.
// if uvm , register if with config 
import uvm_pkg::uvm_config_db;
initial begin 
	uvm_config_db#(virtual autb_csr_if)::set(null, "uvm_test_top", "register_vif", reg_if);
end
// register output declarations
     reg  	 	bg_enable_reg ; 
     reg [3:0] 	clk_en_reg ; 
    
     reg [1:0] 	mode_sel_0_reg ; 
     reg [1:0] 	mode_sel_1_reg ; 
     reg [1:0] 	mode_sel_2_reg ; 
     reg [1:0] 	mode_sel_3_reg ; 
    
// set registers from if.. 
    always wait(reg_if.writable.exists("bg_enable")) begin
		bg_enable_reg =  reg_if.writable["bg_enable"];
		@(reg_if.writable["bg_enable"]); 
	end
    always wait(reg_if.writable.exists("clk_en")) begin
		clk_en_reg =  reg_if.writable["clk_en"];
		@(reg_if.writable["clk_en"]); 
	end
    
    always wait(reg_if.writable.exists("mode_sel_0")) begin
		mode_sel_0_reg =  reg_if.writable["mode_sel_0"];
		@(reg_if.writable["mode_sel_0"]); 
	end
    always wait(reg_if.writable.exists("mode_sel_1")) begin
		mode_sel_1_reg =  reg_if.writable["mode_sel_1"];
		@(reg_if.writable["mode_sel_1"]); 
	end
    always wait(reg_if.writable.exists("mode_sel_2")) begin
		mode_sel_2_reg =  reg_if.writable["mode_sel_2"];
		@(reg_if.writable["mode_sel_2"]); 
	end
    always wait(reg_if.writable.exists("mode_sel_3")) begin
		mode_sel_3_reg =  reg_if.writable["mode_sel_3"];
		@(reg_if.writable["mode_sel_3"]); 
	end
    
//set if from input signals
    always @(dll_lock_status) begin
	reg_if.readonly["dll_lock_status"]=	dll_lock_status;
	end
	
// assign registers to output
	assign bg_enable =  bg_enable_reg;
	assign clk_en =  clk_en_reg;
	assign mode_sel_0 =  mode_sel_0_reg;
	assign mode_sel_1 =  mode_sel_1_reg;
	assign mode_sel_2 =  mode_sel_2_reg;
	assign mode_sel_3 =  mode_sel_3_reg;
	
endmodule