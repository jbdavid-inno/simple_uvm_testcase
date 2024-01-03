
# This is the NC-SIM(R) probe command file
# used in the AMS-ADE integration.


#
# Database settings
#
database -open ams_database -dynamic -into ../simulation_results -default

#
# Probe settings
#
probe -create -tasks -functions -event -emptyok -database ams_database -all -memories -variables -depth all -noaicms {simple_uvm_testcase}
probe -create -tasks -functions -event -emptyok -database ams_database -all -memories -variables cds_globals

