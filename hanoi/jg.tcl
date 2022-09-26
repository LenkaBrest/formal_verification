clear -all
analyze -sv09 hanoi.sv
elaborate -top Hanoi
clock clk
reset rst
prove -bg -all

