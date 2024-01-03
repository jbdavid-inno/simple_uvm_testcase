//default sequence to set all supplies on to nominal voltages
class top_on_seq extends uvm_sequence#(autb_csr_seq_item);
    `uvm_object_utils(top_on_seq)
    function new(string name = "top_on_seq");
        super.new(name);
    endfunction
    task body;
        autb_csr_seq_item top_on_item;
            int  bg_enable = 'b1 ;
            int  clk_en = 'b1111 ;
            int  mode_sel_0 = 'b00;
            int  mode_sel_1 = 'b01;
            int  mode_sel_2 = 'b11;
            int  mode_sel_3 = 'b10;
            
               begin
            top_on_item = autb_csr_seq_item::type_id::create("top_on_item");
            // nothing to randomize here.. no use in late randomization.(after start_item)
            top_on_item.writable["bg_enable"] = bg_enable;
            top_on_item.writable["clk_en"] = clk_en;
            top_on_item.writable["mode_sel_0"] = mode_sel_0;
            top_on_item.writable["mode_sel_1"] = mode_sel_1;
            top_on_item.writable["mode_sel_2"] = mode_sel_2;
            top_on_item.writable["mode_sel_3"] = mode_sel_3;
            
            top_on_item.delay_us = 3;


            start_item(top_on_item);
            //assert(top_on_item.randomize());
            finish_item(top_on_item);
        end

    endtask: body
endclass: top_on_seq