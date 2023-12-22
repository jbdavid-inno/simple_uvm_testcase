
# This is the NC-SIM(R) probe command file
# used in the AMS-ADE integration.


#
# Database settings
#
if { [info exists ::env(AMS_RESULTS_DIR) ] } { set AMS_RESULTS_DIR $env(AMS_RESULTS_DIR)} else {set AMS_RESULTS_DIR "../psf"}
database -open ams_database -event -into ${AMS_RESULTS_DIR} -shm -default

#
# Probe settings
#
probe -create -tasks -functions -emptyok -database ams_database -shm -all -memories -variables -depth all {simple_uvm_testcase_tb}
probe -create -tasks -functions -emptyok -database ams_database -shm -all -memories -variables cds_globals
probe -create -tasks -functions -emptyok -database ams_database -shm -aicms -all {simple_uvm_testcase_tb}
#probe -create -tasks -functions -emptyok -database ams_database -shm -all -memories -variables -depth all {ilpll_top_tb.DUT.ilpll_core.vco.I82}
#probe -create -emptyok -database ams_database -shm -ports -flow {ilpll_top_tb.DUT.ilpll_core.ilpll_cm}
