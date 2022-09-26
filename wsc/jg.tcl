clear -all
analyze -sv09 okv.sv
elaborate -top okv
clock clk
reset rst
set_prove_per_property_max_time_limit 1s
prove -bg -all
