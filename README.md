# minui-report.pak

A MinUI app that generates a report on the device for development purposes

## Requirements

This pak is designed and tested on the following MinUI Platforms and devices:

- `tg5040`: Trimui Brick (formerly `tg3040`), Trimui Smart Pro
- `trimuismart`: Trimui Smart
- `rg35xxplus`: RG-35XX Plus, RG-34XX, RG-35XX H, RG-35XX SP

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
