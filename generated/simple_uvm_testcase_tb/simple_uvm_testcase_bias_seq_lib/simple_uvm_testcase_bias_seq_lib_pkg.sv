package simple_uvm_testcase_bias_seq_lib_pkg;
    import uvm_pkg::*;
    import autb_generic_agent_pkg::*;
    //default sequence to set all supplies on to nominal voltages
    class bias_on_seq extends uvm_sequence#(autb_generic_seq_item);
        `uvm_object_utils(bias_on_seq)
        function new(string name = "bias_on_seq");
            super.new(name);
        endfunction
        task body;
            autb_generic_seq_item bias_on_item;
            
            real gset;
            
            string s_gset;
            begin
                bias_on_item = autb_generic_seq_item::type_id::create("bias_on_item");
                // nothing to randomize here.. no use in late randomization.(after start_item)
                
                gset = 1e-8;
                
                s_gset.realtoa(gset);
                bias_on_item.settings["action"] = "biason";
                
                


                start_item(bias_on_item);
                //assert(bias_on_item.randomize());
                finish_item(bias_on_item);
            end

        endtask: body
    endclass: bias_on_seq
endpackage: simple_uvm_testcase_bias_seq_lib_pkg
