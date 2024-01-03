//Uvm tests for simple_uvm_testcase
package simple_uvm_testcase_test_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import autb_generic_agent_pkg::*;
    import autb_csr_agent_pkg::*;
    //import observer_real_pkg::*;
    import simple_uvm_testcase_env_pkg::*;
    import simple_uvm_testcase_power_seq_lib_pkg::*;
    import simple_uvm_testcase_bias_seq_lib_pkg::*;
    import simple_uvm_testcase_digital_seq_lib_pkg::*;
    import simple_uvm_testcase_register_seq_lib_pkg::*;
    import simple_uvm_testcase_analog_seq_lib_pkg::*;
    import simple_uvm_testcase_test_seq_lib_pkg::*;
    

    `include "simple_uvm_testcase_test_base.svh"
    `include "sanity_test.svh"

endpackage: simple_uvm_testcase_test_pkg