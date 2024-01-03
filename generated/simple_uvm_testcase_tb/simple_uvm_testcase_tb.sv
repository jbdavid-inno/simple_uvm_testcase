// auto generate testbench top 
module simple_uvm_testcase_tb ();
    // declarations for bused signals
     interconnect		AVDD1P8;
     interconnect		AVSS;
     interconnect		bg_enable;
     interconnect [3:0]	clk_en;
     interconnect		clk_out_0;
     interconnect		clk_out_1;
     interconnect		clk_out_2;
     interconnect		clk_out_3;
     interconnect [3:0]	dll_lock_status;
     interconnect		mclk_in;
     interconnect [1:0]	mode_sel_0;
     interconnect [1:0]	mode_sel_1;
     interconnect [1:0]	mode_sel_2;
     interconnect [1:0]	mode_sel_3;
     interconnect		vcntrl0;
     interconnect		vcntrl1;
     interconnect		vcntrl2;
     interconnect		vcntrl3;
    
    
    import uvm_pkg::*;
    import simple_uvm_testcase_test_pkg::*;

    initial begin
        run_test("sanity_test");
    end 
    // block declarations
    
    simple_uvm_testcase DUT(
        .AVDD1P8(AVDD1P8), 
        .AVSS(AVSS), 
        .bg_enable(bg_enable), 
        .clk_en(clk_en), 
        .clk_out_0(clk_out_0), 
        .clk_out_1(clk_out_1), 
        .clk_out_2(clk_out_2), 
        .clk_out_3(clk_out_3), 
        .dll_lock_status(dll_lock_status), 
        .mclk_in(mclk_in), 
        .mode_sel_0(mode_sel_0), 
        .mode_sel_1(mode_sel_1), 
        .mode_sel_2(mode_sel_2), 
        .mode_sel_3(mode_sel_3), 
        .vcntrl0(vcntrl0), 
        .vcntrl1(vcntrl1), 
        .vcntrl2(vcntrl2), 
        .vcntrl3(vcntrl3)
        );
    simple_uvm_testcase_stim_register REGISTER(
        .bg_enable(bg_enable), 
        .clk_en(clk_en), 
        .dll_lock_status(dll_lock_status), 
        .mode_sel_0(mode_sel_0), 
        .mode_sel_1(mode_sel_1), 
        .mode_sel_2(mode_sel_2), 
        .mode_sel_3(mode_sel_3)
        );
    simple_uvm_testcase_stim_power POWER(
        .AVDD1P8(AVDD1P8), 
        .AVSS(AVSS)
        );
    simple_uvm_testcase_stim_bias BIAS(
        );
    simple_uvm_testcase_stim_digital DIGITAL(
        .clk_out_0(clk_out_0), 
        .clk_out_1(clk_out_1), 
        .clk_out_2(clk_out_2), 
        .clk_out_3(clk_out_3), 
        .mclk_in(mclk_in)
        );
    simple_uvm_testcase_stim_analog ANALOG(
        .vcntrl0(vcntrl0), 
        .vcntrl1(vcntrl1), 
        .vcntrl2(vcntrl2), 
        .vcntrl3(vcntrl3)
        );
    

endmodule