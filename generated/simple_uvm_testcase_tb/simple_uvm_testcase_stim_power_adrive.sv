//SystemVerilog RNM HDL for "RFDV_scratch_sim", "simple_uvm_testcase_stim_power_adrive" "svrnm"

// auto generated power top
module simple_uvm_testcase_stim_power_adrive ( 
	output interconnect  	 	AVDD1P8 , 
	output interconnect  	 	AVSS 
);
// var declarations for DE signal ports
//real rxadc_ldo_avdd$Vobs, rxadc_ldo_avdd$Iobs, rxadc_ldo_avdd$Vdrv, rxadc_ldo_avdd$Rdrv;
 real AVDD1P8$Vobs, AVDD1P8$Iobs, AVDD1P8$Vdrv, AVDD1P8$Rdrv;
 real AVSS$Vobs, AVSS$Iobs, AVSS$Vdrv, AVSS$Rdrv;


// UDN instantiation for DE signal ports
//DE_thevenin Xtcvr_rxadc_ldo_avdd(rxadc_ldo_avdd, rxadc_ldo_avdd$Vobs, rxadc_ldo_avdd$Iobs, rxadc_ldo_avdd$Vdrv, rxadc_ldo_avdd$Rdrv);
DE_thevenin Xtcvr_AVDD1P8( AVDD1P8,AVDD1P8$Vobs, AVDD1P8$Iobs, AVDD1P8$Vdrv, AVDD1P8$Rdrv);
DE_thevenin Xtcvr_AVSS( AVSS,AVSS$Vobs, AVSS$Iobs, AVSS$Vdrv, AVSS$Rdrv);

// variables for the digital context
const real pi = $acos(-1);

reg sample_trigger = 0; // only used in the vams implementation
// declarations for supply voltage variables. (assuming all are voltages) //this is the variable set when the supply voltage changes
real AVDD1P8_vset;

// declarations for supply enable variables. (assuming all are voltages)// when set to 1 the resistance is changed from roff to ron (logarithmically)
bit AVDD1P8_enable;

// declarations for supply rout variables. (assuming all are voltages) - dont use array variable for easier plotting 
real AVDD1P8_roff = 10e3;

// declarations for transition time..(not used but upper level wants to be able to set it)
real AVDD1P8_tt = 1e-6;


real AVDD1P8_ron = 0.1;

always_comb 
	if (AVDD1P8_enable) begin
		AVDD1P8$Vdrv = AVDD1P8_vset;
		AVDD1P8$Rdrv = AVDD1P8_ron;
	end	else begin 
		AVDD1P8$Vdrv = 0.0;
		AVDD1P8$Rdrv = AVDD1P8_roff;
	end



initial begin
AVSS$Vdrv = 0.0;

end



endmodule