//------------------------------------------------------------
//   Copyright 2010-2018 Mentor Graphics Corporation
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//------------------------------------------------------------

package simple_uvm_testcase_test_seq_lib_pkg;

  import uvm_pkg::*;
    `include "uvm_macros.svh"

  import autb_generic_agent_pkg::*;
  import autb_csr_agent_pkg::*;
  import simple_uvm_testcase_env_pkg::*;
  import simple_uvm_testcase_register_seq_lib_pkg::*;

  //import spi_bus_sequence_lib_pkg::*;

  // Base class to get sub-sequencer handles
  //
  // Note that this virtual sequence uses resources to get
  // the handles to the target sequencers
  //
  // This means that we do not need a virtual sequencer
  //
  class simple_uvm_testcase_vseq_base extends uvm_sequence #(uvm_sequence_item);

    `uvm_object_utils(simple_uvm_testcase_vseq_base)

    function new(string name = "simple_uvm_testcase_vseq_base");
      super.new(name);
    endfunction

    // Virtual sequencer handles
    autb_generic_sequencer analog_sqr;
    autb_generic_sequencer bias_sqr;
    autb_generic_sequencer digital_sqr;
    autb_generic_sequencer power_sqr;
    autb_csr_sequencer register_sqr;

    // Handle for env config to get to interrupt line
    simple_uvm_testcase_env_config m_cfg;

    // This set up is required for child sequences to run
    task body;
      if(analog_sqr==null) begin
        `uvm_fatal("SEQ_ERROR", "analog Sequencer handle is null")
      end
      if(bias_sqr==null) begin
        `uvm_fatal("SEQ_ERROR", "bias Sequencer handle is null")
      end
      if(digital_sqr==null) begin
        `uvm_fatal("SEQ_ERROR", "digital Sequencer handle is null")
      end
      if(power_sqr==null) begin
        `uvm_fatal("SEQ_ERROR", "power Sequencer handle is null")
      end
      if(register_sqr==null) begin
        `uvm_fatal("SEQ_ERROR", "register Sequencer handle is null")
      end

      if(m_cfg==null) begin
        `uvm_fatal("CFG_ERROR", "Configuration handle is null")
      end

    endtask: body

  //   function void simple_uvm_testcase_seq_set_cfg(simple_uvm_testcase_bus_base_seq seq_);
  //     seq_.m_cfg = m_cfg;
  //   endfunction

  endclass: simple_uvm_testcase_vseq_base

  //
  // This virtual sequence does SPI transfers with randomized config
  // and tests the interrupt handling
  //
  // class config_interrupt_test extends simple_uvm_testcase_vseq_base;

  //   `uvm_object_utils(config_interrupt_test)

  //   logic[31:0] control;

  //   function new(string name = "config_interrupt_test");
  //     super.new(name);
  //   endfunction

  //   task body;
  //     // Sequences to be used
  //     ctrl_go_seq go = ctrl_go_seq::type_id::create("go");
  //     SPI_config_rand_order_seq spi_config = SPI_config_rand_order_seq::type_id::create("spi_config");
  //     tfer_over_by_poll_seq wait_unload = tfer_over_by_poll_seq::type_id::create("wait_unload");
  //     spi_rand_seq spi_transfer = spi_rand_seq::type_id::create("spi_transfer");

  //     spi_seq_set_cfg(go);
  //     spi_seq_set_cfg(spi_config);
  //     spi_seq_set_cfg(wait_unload);

  //     super.body;

  //     control = 0;

  //     repeat(10) begin
  //       spi_config.interrupt_enable = 1;
  //       spi_config.start(m_sequencer);
  //       control = spi_config.data;
  //       go.start(m_sequencer);
  //       fork
  //         begin
  //           m_cfg.wait_for_interrupt;
  //           wait_unload.start(m_sequencer);
  //           if(!m_cfg.is_interrupt_cleared()) begin
  //             `uvm_error("INT_ERROR", "Interrupt not cleared by register read/write");
  //           end
  //         end
  //         begin
  //           spi_transfer.BITS = control[6:0];
  //           spi_transfer.rx_edge = control[9];
  //           spi_transfer.start(spi);
  //         end
  //       join
  //     end
  //   endtask

  // endclass: config_interrupt_test

  // this example virtual sequence sets the vco coarse code based on a target vco frequency
  // it works like a SAR ADC .. set the coarse code to mid value (MSB = 1 reset 0)
  // if the vco frequency is above the target, we still need to add more capacitance
  // keep the MSB code of 1 and try the next bit 1.
  // else we need less capacitance,
  //  so set the MSB to 0 and try the next bit at 1.
//   class cal_ilpll_vco_coarse_code extends simple_uvm_testcase_vseq_base;
//     `uvm_object_utils(cal_ilpll_vco_coarse_code)
//     real ilpll_vco_target_freq = 16.000e9;
//     bit [9:0] ilpll_vco_coarse_code;
//     int tempcode;
//     function new(string name = "set_ilpll_vco_coarse_code");
//       super.new(name);
//     endfunction

//     task body;
//       ilpll_vco_coarse_code_set_seq set_coarse = ilpll_vco_coarse_code_set_seq::type_id::create("set_coarse");
//       ilpll_vco_cal_en_seq vco_cal_en = ilpll_vco_cal_en_seq::type_id::create("vco_cal_en");
//       ilpll_vco_lpf_en_seq vco_lpf_en = ilpll_vco_lpf_en_seq::type_id::create("vco_lpf_en");
//       begin
//         vco_cal_en.start(register_sqr);
//         ilpll_vco_coarse_code = 0; //start with ALL bits 0

//         for (int i = 9; i>= 0 ; i--) begin
//           ilpll_vco_coarse_code[i]=1;
//           set_coarse.ilpll_vco_coarse_code = int'(ilpll_vco_coarse_code);
//           set_coarse.start(register_sqr);
//           ilpll_vco_coarse_code[i] = m_cfg.is_vco_freq_above_target(ilpll_vco_target_freq);
//         end
//         vco_lpf_en.start(register_sqr);
//       end

//     endtask
//   endclass : cal_ilpll_vco_coarse_code
// //
// // This virtual sequence does SPI transfers with randomized config
// // and polls the go_bsy bit in the control register to determine
// // when the transfer has completed
// //
// class config_polling_test extends simple_uvm_testcase_vseq_base;

//   `uvm_object_utils(config_polling_test)

//   logic[31:0] control;

//   function new(string name = "config_polling_test");
//     super.new(name);
//   endfunction

//   task body;
//     // Sequences to be used
//     ctrl_go_seq go = ctrl_go_seq::type_id::create("go");
//     SPI_config_rand_order_seq spi_config = SPI_config_rand_order_seq::type_id::create("spi_config");
//     tfer_over_by_poll_seq wait_unload = tfer_over_by_poll_seq::type_id::create("wait_unload");
//     spi_rand_seq spi_transfer = spi_rand_seq::type_id::create("spi_transfer");

//     spi_seq_set_cfg(go);
//     spi_seq_set_cfg(spi_config);
//     spi_seq_set_cfg(wait_unload);

//     super.body;

//     control = 0;

//     repeat(10) begin
//       spi_config.interrupt_enable = 1;
//       spi_config.start(m_sequencer);
//       control = spi_config.data;
//       spi_transfer.BITS = control[6:0];
//       spi_transfer.rx_edge = control[9];
//       fork
//         spi_transfer.start(spi);
//       join_none
//       go.start(m_sequencer);
//       wait_unload.start(m_sequencer);
//     end
//   endtask

// endclass: config_polling_test

// //
// // Register test:
// //
// // Checks the reset values
// // Does a randomized read/write bit test using the front door
// // Repeats the read/write bit test using the back door (not necessary, but as an illustration)
// //
// class register_test_vseq extends simple_uvm_testcase_vseq_base;

//   `uvm_object_utils(register_test_vseq)

//   function new(string name = "register_test_vseq");
//     super.new(name);
//   endfunction

//   task body;
//     uvm_reg_hw_reset_seq reg_seq = uvm_reg_hw_reset_seq::type_id::create("reg_seq");
//     reg_seq.model = m_cfg.spi_rb;

//     super.body;
//     reg_seq.start(m_sequencer);
//   endtask: body

// endclass: register_test_vseq

endpackage:simple_uvm_testcase_test_seq_lib_pkg