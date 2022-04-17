#!/bin/env python

# Convert Sony A1 codes to ESPHome timing lists

import sys

PW_INIT = "2400";
PW_ONE = "1200";
PW_ZERO = "600";
PW_GAP = "-600";

outstr = "[ " + PW_INIT + ", " + PW_GAP + ", "

code = sys.argv[1]
codebytes = bytearray(code.decode("hex"))

for i, b in enumerate(codebytes):
	for j in range(8):
		if (b & (128 >> j)):
			outstr = outstr + PW_ONE 
		else:
			outstr = outstr + PW_ZERO 
		if ((j == 7) and (i == len(codebytes) - 1)):
			outstr = outstr + " ]"
		else:
			outstr = outstr + ", " + PW_GAP + ", "

print outstr
