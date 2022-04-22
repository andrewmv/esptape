# Utilities

Quick and dirty development tools with no input checking. You have been warned.

## code_cv.py

Convert Sony A1 code in Hex format to esphome remote_transmitter.transmit_raw timing blocks.
Do not provide a leading '0x'

Example: 

	code_cv.py ac40
	[ 2400, -600, 1200, -600, 600, -600, 1200, -600, 600, -600, 1200, -600, 1200, -600, 600, -600, 600, -600, 600, -600, 1200, -600, 600, -600, 600, -600, 600, -600, 600, -600, 600, -600, 600 ]

## rev_code_cv.py

Convert an esphome remote_receiver.receive_raw log message block into a Sony A1 code.

Example:

	./rev_code_cv.py "[22:06:27][D][remote.raw:041]: Received Raw: 2418, -594, 1202, -594, 603, -595, 1201, -596, 602, -597, 1200, -594, 1202, -595, 603, -594, 603, -597, 600, -598, 1199, -595, 602, -599, 599, -595, 1202, -594, 604, -594, 602, -596, 602"
	0xac
	0x48

## a1_rs232_bridge.ino

An Arduino sketch for code scanning and discovery. Should support any 5V tolerant target board.