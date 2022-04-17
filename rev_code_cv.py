#!/bin/env python

# Convert to ESPHome timing lists to Sony A1 codes

import sys

PW_INIT = 2400;
PW_ONE = 1200;
PW_ZERO = 600;
PW_GAP = -600;

start_token = "Received Raw: "
tolerance = 0.25

timelist = sys.argv[1]
t_start = timelist.find(start_token) + len(start_token)
t = timelist[t_start:-1]

times = t.split(', ')

outbyte = 0x00
bitcount = 0

for j in range(len(times)):
	i = int(times[j])
	if i < 0:
		continue
	elif ( (i > (PW_INIT - (PW_INIT * tolerance))) and (i < (PW_INIT + (PW_INIT * tolerance))) ):
		# print("INIT")
		continue
	elif ( (i > (PW_ONE - (PW_ONE * tolerance))) and (i < (PW_ONE + (PW_ONE * tolerance))) ):
		# print("ONE")
		outbyte = outbyte | (128 >> bitcount)
		bitcount += 1
	elif ( (i > (PW_ZERO - (PW_ZERO * tolerance))) and (i < (PW_ZERO + (PW_ZERO * tolerance))) ):
		# print("ZERO")
		bitcount += 1
	else:
		print("Value " + str(i) + " is out of range")
	if bitcount >= 8:
		print(hex(outbyte))
		outbyte = 0x00
		bitcount = 0

if bitcount != 0:
	print("Warning: data not an integer number of bytes")