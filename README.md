# minui-report.pak

A MinUI app that generates a report on the device for development purposes

## Requirements

This pak is designed and tested on the following MinUI Platforms and devices:

- `h700`: Anbernic RG28XX, RG34XX, RG34XX SP, RG35XX Plus, RG35XX 2024, RG35XX H, RG35XX Pro, RG35XX SP, RG40XX H, RG40XX V, RG CubeXX and RG SP, running NextUI on BaseOS
- `miyoomini`: Miyoo Mini Plus and the Miyoo Mini
- `my282`: Miyoo A30
- `my355`: Miyoo Flip
- `rg35xxplus`: RG-35XX Plus, RG-34XX, RG-35XX H, RG-35XX SP
- `tg5040`: Trimui Brick (formerly `tg3040`), Trimui Smart Pro
- `tg5050`: Trimui Smart Pro S
- `trimuismart`: Trimui Smart

Use the correct platform for your device.

## Installation

1. Mount your MinUI SD card.
2. Download the latest release from Github. It will be named `Report.pak.zip`.
3. Copy the zip file to `/Tools/$PLATFORM/Report.pak.zip`.
4. Extract the zip in place, then delete the zip file.
5. Confirm that there is a `/Tools/$PLATFORM/Report.pak/launch.sh` file on your SD card.
6. Unmount your SD Card and insert it into your MinUI device.

## Usage

Just start it. It will display a message and then exit. The report will be available at the root of the SD Card in `report.txt`.
