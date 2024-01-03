//SystemVerilog RNM HDL for "simple_uvm_testcase_stim_power_adrive" "svrnm"
module simple_uvm_testcase_stim_power_adrive ( 	output interconnect  AVDD1P8, 
    output interconnect 	AVSS );
    real AVDD1P8$Vobs, AVDD1P8$Iobs, AVDD1P8$Vdrv, AVDD1P8$Rdrv; 
    real AVSS$Vobs, AVSS$Iobs, AVSS$Vdrv, AVSS$Rdrv;
    DE_thevenin Xtcvr_AVDD1P8( AVDD1P8,AVDD1P8$Vobs, AVDD1P8$Iobs, AVDD1P8$Vdrv, AVDD1P8$Rdrv);
    DE_thevenin Xtcvr_AVSS( AVSS,AVSS$Vobs, AVSS$Iobs, AVSS$Vdrv, AVSS$Rdrv);
    reg sample_trigger = 0; // only used in the vams implementation
    real AVDD1P8_vset;              bit AVDD1P8_enable;
    real AVDD1P8_roff = 10e3;       real AVDD1P8_tt = 1e-6;
    real AVDD1P8_ron = 0.1;
    always_comb 
        if (AVDD1P8_enable) begin
            AVDD1P8$Vdrv = AVDD1P8_vset;    AVDD1P8$Rdrv = AVDD1P8_ron;
        end	else begin 
            AVDD1P8$Vdrv = 0.0;         	AVDD1P8$Rdrv = AVDD1P8_roff;
        end
    initial begin
        AVSS$Vdrv = 0.0;
end
endmodule