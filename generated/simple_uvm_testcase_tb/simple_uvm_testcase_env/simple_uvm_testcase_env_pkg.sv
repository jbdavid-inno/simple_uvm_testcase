//
// Package Description:
//
package simple_uvm_testcase_env_pkg;

    // Standard UVM import & include:
    import uvm_pkg::*;
  `include "uvm_macros.svh"
  
    // Any further package imports:
    import autb_generic_agent_pkg::*;
    import autb_csr_agent_pkg::*;
   // import observer_real_pkg::*;
    
    // Includes:
  `include "simple_uvm_testcase_env_config.svh"
  `include "simple_uvm_testcase_scoreboard.svh"
  `include "simple_uvm_testcase_vsequencer.svh"
  `include "simple_uvm_testcase_env.svh"
  
  endpackage: simple_uvm_testcase_env_pkg
  