package simple_uvm_testcase_digital_seq_lib_pkg;
    import uvm_pkg::*;
    import autb_generic_agent_pkg::*;
    //default sequence to set all supplies on to nominal voltages
    class start_clocks_seq extends uvm_sequence#(autb_generic_seq_item);
        `uvm_object_utils(start_clocks_seq)
        function new(string name = "start_clocks_seq");
            super.new(name);
        endfunction
        task body;
            autb_generic_seq_item start_clocks_item;
            string mclk_in$s_freq;
            real mclk_in$freq ;
            
            string s_enable;
            begin
                // example 
                start_clocks_item = autb_generic_seq_item::type_id::create("start_clocks_item");
                // nothing to randomize here.. no use in late randomization.(after start_item)
                mclk_in$freq = 60e6;
                mclk_in$s_freq.realtoa(mclk_in$freq);
                s_enable.itoa(1);
                start_clocks_item.settings["action"] = "start_clocks";
                start_clocks_item.settings["mclk_in$freq"] = mclk_in$s_freq;
                start_clocks_item.settings["mclk_in$enable"] = s_enable;
                
                start_item(start_clocks_item);
                //assert(start_clocks_item.randomize());
                finish_item(start_clocks_item);
            end

        endtask: body
    endclass: start_clocks_seq
endpackage: simple_uvm_testcase_digital_seq_lib_pkg
