//
// Class Description:
//
//
class simple_uvm_testcase_env extends uvm_env;

  // UVM Factory Registration Macro
  //
  `uvm_component_utils(simple_uvm_testcase_env)
  //------------------------------------------
  // Data Members
  //------------------------------------------
  autb_generic_agent m_analog_agent;
  autb_generic_agent m_bias_agent;
  autb_generic_agent m_digital_agent;
  autb_generic_agent m_power_agent;
  autb_csr_agent m_register_agent;
  simple_uvm_testcase_vsequencer v_sqr;
  simple_uvm_testcase_env_config m_cfg;
  simple_uvm_testcase_scoreboard m_scoreboard;

  // Register layer adapter
  //reg2apb_adapter m_reg2apb;
  // Register predictor
  //uvm_reg_predictor#(apb_seq_item) m_apb2reg_predictor;

  //------------------------------------------
  // Constraints
  //------------------------------------------

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "simple_uvm_testcase_env", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass:simple_uvm_testcase_env

function simple_uvm_testcase_env::new(string name = "simple_uvm_testcase_env", uvm_component parent = null);
  super.new(name, parent);
endfunction

function void simple_uvm_testcase_env::build_phase(uvm_phase phase);
  if (!uvm_config_db #(simple_uvm_testcase_env_config)::get(this, "", "simple_uvm_testcase_env_config", m_cfg))
    `uvm_fatal("CONFIG_LOAD", "Cannot get() configuration simple_uvm_testcase_env_config from uvm_config_db. Have you set() it?")

  uvm_config_db #(autb_generic_agent_config)::set(this, "m_analog_agent*",
                                         "autb_generic_agent_config",
                                         m_cfg.m_analog_agent_cfg);
  m_analog_agent = autb_generic_agent::type_id::create("m_analog_agent", this);

  uvm_config_db #(autb_generic_agent_config)::set(this, "m_bias_agent*",
                                         "autb_generic_agent_config",
                                         m_cfg.m_bias_agent_cfg);
  m_bias_agent = autb_generic_agent::type_id::create("m_bias_agent", this);

  uvm_config_db #(autb_generic_agent_config)::set(this, "m_digital_agent*",
                                         "autb_generic_agent_config",
                                         m_cfg.m_digital_agent_cfg);
  m_digital_agent = autb_generic_agent::type_id::create("m_digital_agent", this);

  uvm_config_db #(autb_generic_agent_config)::set(this, "m_power_agent*",
                                         "autb_generic_agent_config",
                                         m_cfg.m_power_agent_cfg);
  m_power_agent = autb_generic_agent::type_id::create("m_power_agent", this);

  uvm_config_db #(autb_csr_agent_config)::set(this, "m_register_agent*",
                                         "autb_csr_agent_config",
                                         m_cfg.m_register_agent_cfg);
  m_register_agent = autb_csr_agent::type_id::create("m_register_agent", this);

  v_sqr = simple_uvm_testcase_vsequencer::type_id::create("v_sqr",this);

//   if(m_cfg.has_simple_uvm_testcase_scoreboard) begin
//     m_scoreboard = simple_uvm_testcase_scoreboard::type_id::create("m_scoreboard", this);
//   end
endfunction:build_phase

function void simple_uvm_testcase_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    uvm_config_db#(autb_generic_sequencer)::set(this,"*","analog_sqr",m_analog_agent.m_sequencer); 
    uvm_config_db#(autb_generic_sequencer)::set(this,"*","bias_sqr",m_bias_agent.m_sequencer); 
    uvm_config_db#(autb_generic_sequencer)::set(this,"*","digital_sqr",m_digital_agent.m_sequencer); 
    uvm_config_db#(autb_generic_sequencer)::set(this,"*","power_sqr",m_power_agent.m_sequencer); 
    uvm_config_db#(autb_csr_sequencer)::set(this,"*","register_sqr",m_register_agent.m_sequencer); 
    
   // v_sqr.analog_sqr = this.m_analog_agent.m_sequencer;
   // v_sqr.bias_sqr = this.m_bias_agent.m_sequencer;
   // v_sqr.digital_sqr = this.m_digital_agent.m_sequencer;
   // v_sqr.power_sqr = this.m_power_agent.m_sequencer;
   // v_sqr.register_sqr = this.m_register_agent.m_sequencer;
    `uvm_info("ENV","sequencers should be set",UVM_LOW)
  

endfunction: connect_phase