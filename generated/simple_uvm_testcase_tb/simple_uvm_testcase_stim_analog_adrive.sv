//SystemVerilog RNM HDL for "RFDV_scratch_sim", "simple_uvm_testcase_stim_analog_adrive" "svrnm"

// auto generated bias top
module simple_uvm_testcase_stim_analog_adrive ( 
	input  	 	vcntrl0 , 
	input  	 	vcntrl1 , 
	input  	 	vcntrl2 , 
	input  	 	vcntrl3 
);
// declarations for ports signals
 interconnect	vcntrl0;
 interconnect	vcntrl1;
 interconnect	vcntrl2;
 interconnect	vcntrl3;

// var declarations for DE signal ports
real vcntrl0$Vobs, vcntrl0$Iobs, vcntrl0$Idrv, vcntrl0$Gdrv;
real vcntrl1$Vobs, vcntrl1$Iobs, vcntrl1$Idrv, vcntrl1$Gdrv;
real vcntrl2$Vobs, vcntrl2$Iobs, vcntrl2$Idrv, vcntrl2$Gdrv;
real vcntrl3$Vobs, vcntrl3$Iobs, vcntrl3$Idrv, vcntrl3$Gdrv;


// UDN instantiation for DE signal ports
DE_norton Xtcvr_vcntrl0( vcntrl0,vcntrl0$Vobs, vcntrl0$Iobs, vcntrl0$Idrv, vcntrl0$Gdrv );
DE_norton Xtcvr_vcntrl1( vcntrl1,vcntrl1$Vobs, vcntrl1$Iobs, vcntrl1$Idrv, vcntrl1$Gdrv );
DE_norton Xtcvr_vcntrl2( vcntrl2,vcntrl2$Vobs, vcntrl2$Iobs, vcntrl2$Idrv, vcntrl2$Gdrv );
DE_norton Xtcvr_vcntrl3( vcntrl3,vcntrl3$Vobs, vcntrl3$Iobs, vcntrl3$Idrv, vcntrl3$Gdrv );

//pi
const real pi = $acos(-1);
// variables for the digital context
reg sample_trigger = 0;
//the only thing we'll start with is monitoring input voltages
real vcntrl0_volts;
real vcntrl1_volts;
real vcntrl2_volts;
real vcntrl3_volts;

// rest  need to write by hand based on design needs
always_comb vcntrl0_volts = vcntrl0$Vobs ;
always_comb vcntrl1_volts = vcntrl1$Vobs ;
always_comb vcntrl2_volts = vcntrl2$Vobs ;
always_comb vcntrl3_volts = vcntrl3$Vobs ;

// dc sources

endmodule