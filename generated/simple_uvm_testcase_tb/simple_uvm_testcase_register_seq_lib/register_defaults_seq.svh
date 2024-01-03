//default sequence to set all registers to hardware default values
class register_defaults_seq extends uvm_sequence#(autb_csr_seq_item);
    `uvm_object_utils(register_defaults_seq)
    function new(string name = "register_defaults_seq");
        super.new(name);
    endfunction
    task body;
        autb_csr_seq_item hw_defaults_item;
            int  bg_enable = 'b0;
            int  clk_en = 'b0000;
            int  mode_sel_0 = 'b00;
            int  mode_sel_1 = 'b00;
            int  mode_sel_2 = 'b00;
            int  mode_sel_3 = 'b00;
            
               begin
            hw_defaults_item = autb_csr_seq_item::type_id::create("hw_defaults_item");
            // nothing to randomize here.. no use in late randomization.(after start_item)
            hw_defaults_item.writable["bg_enable"] = bg_enable;
            hw_defaults_item.writable["clk_en"] = clk_en;
            hw_defaults_item.writable["mode_sel_0"] = mode_sel_0;
            hw_defaults_item.writable["mode_sel_1"] = mode_sel_1;
            hw_defaults_item.writable["mode_sel_2"] = mode_sel_2;
            hw_defaults_item.writable["mode_sel_3"] = mode_sel_3;
            
            hw_defaults_item.delay_us = 1;


            start_item(hw_defaults_item);
            //assert(hw_defaults_item.randomize());
            finish_item(hw_defaults_item);
        end

    endtask: body
endclass: register_defaults_seq