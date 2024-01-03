package simple_uvm_testcase_analog_seq_lib_pkg;
    import uvm_pkg::*;
    import autb_generic_agent_pkg::*;
    class analog_on_seq extends uvm_sequence#(autb_generic_seq_item);
        `uvm_object_utils(analog_on_seq)
        function new(string name = "analog_on_seq");
            super.new(name);
        endfunction
        task body;
            autb_generic_seq_item analog_on_item;
              
          
            begin
              analog_on_item = autb_generic_seq_item::type_id::create("analog_on_item");
              
              start_item(analog_on_item);
              analog_on_item.settings["action"] = "analog_on";
              //assert(analog_on_item.randomize());
              

              finish_item(analog_on_item);
            end
          
          endtask: body
        endclass: analog_on_seq
    endpackage: simple_uvm_testcase_analog_seq_lib_pkg
