
//=========================== SystemVerilog Configuration ==========================
config myConfig;
	design simple_uvm_testcase_tb;

	default liblist  worklib RFDV_scratch DGC;

	cell simple_uvm_testcase use cds_amsconfiglib.simple_uvm_testcase:amsconfig;
endconfig