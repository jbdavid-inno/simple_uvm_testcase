package simple_uvm_testcase_power_seq_lib_pkg;
    import uvm_pkg::*;
    import autb_generic_agent_pkg::*;
    //default sequence to set all supplies on to nominal voltages
    // this could be in an include file
    class power_on_seq extends uvm_sequence#(autb_generic_seq_item);
        `uvm_object_utils(power_on_seq)
        function new(string name = "power_on_seq");
            super.new(name);
        endfunction
        task body;
            autb_generic_seq_item power_on_reg;
            real AVDD1P8_vset;
            
            string s_AVDD1P8;
            
        
            string s_enable;
            begin
                power_on_reg = autb_generic_seq_item::type_id::create("power_on_reg");
                // nothing to randomize here.. no use in late randomization.(after start_item)
                s_enable.itoa(1);
                AVDD1P8_vset = 1.8;
                
                s_AVDD1P8.realtoa(AVDD1P8_vset);
                
                power_on_reg.settings["action"] = "poweron";
                power_on_reg.settings["AVDD1P8_vset"] = s_AVDD1P8;
                
                power_on_reg.settings["AVDD1P8_enable"] = s_enable;
                


                start_item(power_on_reg);
                //assert(power_on_reg.randomize());
                finish_item(power_on_reg);
            end

        endtask: body
    endclass: power_on_seq
endpackage: simple_uvm_testcase_power_seq_lib_pkg
