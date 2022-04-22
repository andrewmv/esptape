An ESPHome based Home Assistant integration for controlling a Sony TC-WE675 Tape deck over its A1 Control serial port.

Would probably work on other Sony A1 tape decks, and could likely be expanded to support other Sony A1 audio equipment.

![sony-tcwe675](sony-tcwe675.jpg)

![card_shot](card_shot.png)

## Repository Structure

* /esphome - esphome YAML code
* /homeassistant - sample HACS/media_player_template entity and lovelace cards
* /util - code timing conversion utilities
* /pcb - EagleCAD files for hardware build
* /enclosure - OpenSCAD and STL files for 3D printing enclosure

## Protocol 

Protocol based in part on the A1/S-Link reverse engineering work of:

http://cegt201.bradley.edu/projects/proj2001/sonyntwk/SLink.PDF

and:

http://web.archive.org/web/20040722145551/http://www.undeadscientist.com/slink/encoding.html


I created a PulseView / Sigrok logic analyizer plugin to aid in the discovery of device specific codes:

https://github.com/andrewmv/sony-a1-sigrok-pd


## Status Codes

Reported from the device and interpreted by ESPHome

| Address | Code | Meaning            | Notes                                                        |
| ------- | ---- | ------------------ | ------------------------------------------------------------ |
| 0xAC    | 0x00 | Tape B Play        | No indication of direction is provided                       |
| 0xAC    | 0x01 | Tape B Stop        |                                                              |
| 0xAC    | 0x02 | Tape B Pause       |                                                              |
| 0xAC    | 0x04 | Tape B Record      | Recording started                                            |
| 0xAC    | 0x05 | Tape B Eject       |                                                              |
| 0xAC    | 0x06 | Tape B Autoreverse | Valid only from Play. Playback has reached end of side, but will continue on other side or deck. Always followed by a Stop, then a Play from the appropriate deck |
| 0xAC    | 0x07 | Tape B Cue         |                                                              |
| 0xAC    | 0x08 | Tape B Insert      |                                                              |
| 0xAC    | 0x0a | End of Tape B      | End of side reached, no followup playback will happen. Valid from Play, RR, FF, or AMS. |
| 0xAC    | 0x40 | Tape A Play        | No indication of direction is provided                       |
| 0xAC    | 0x41 | Tape A Stop        |                                                              |
| 0xAC    | 0x42 | Tape A Pause       |                                                              |
| 0xAC    | 0x44 | Tape A Record      | Recording started                                            |
| 0xAC    | 0x45 | Tape A Eject       |                                                              |
| 0xAC    | 0x46 | Tape A Autoreverse | Valid only from Play. Playback has reached end of side, but will continue on other side or deck. Always followed by a Stop, then a Play from the appropriate deck |
| 0xAC    | 0x47 | Tape A Cue         | Recording cued, play not yet pressed                         |
| 0xAC    | 0x48 | Tape A Insert      |                                                              |
| 0xAC    | 0x4a | End of Tape A      | End of side reached, no followup playback will happen. Valid from Play, RR, FF, or AMS. |

## Command codes

Sent to and interpreted by the device

| Address | Command | Result                                                       |
| ------- | ------- | ------------------------------------------------------------ |
| 0xA4    | 0x00    | Deck B Play (Current Direction)                              |
| 0xA4    | 0x01    | Deck B Stop                                                  |
| 0xA4    | 0x02    | Deck B Pause (Fixed)                                         |
| 0xA4    | 0x03    | Deck B Pause (Toggle)                                        |
| 0xA4    | 0x04    | Deck B Rec (Current Direction)                               |
| 0xA4    | 0x07    | Deck B Rec Cue (Direction Selectable with subsequent Play)   |
| 0xA4    | 0x0A    | Deck B FF (While Stopped – Forward) / AMS (While Playing – Current Direction) |
| 0xA4    | 0x0B    | Deck B RR (While Stopped – Reverse) / AMS (While Playing – Current Direction) |
| 0xA4    | 0x0C    | Deck B Play Forward                                          |
| 0xA4    | 0x0D    | Deck B Play Backward                                         |
| 0xA4    | 0x40    | Deck A Play (Current Direction)                              |
| 0xA4    | 0x41    | Deck A Stop                                                  |
| 0xA4    | 0x42    | Deck A Pause (Fixed)                                         |
| 0xA4    | 0x43    | Deck A Pause (Toggle)                                        |
| 0xA4    | 0x44    | Deck A Rec (Current Direction)                               |
| 0xA4    | 0x47    | Deck A Rec Cue                                               |
| 0xA4    | 0x4A    | Deck A FF (While Stopped – Forward) / AMS (While Playing – Current Direction) |
| 0xA4    | 0x4B    | Deck A RR (While Stopped – Rewind) / AMS (While Playing – Current Direction) |
| 0xA4    | 0x4C    | Deck A Play Forward                                          |
| 0xA4    | 0x4D    | Deck A Play Backward                                         |