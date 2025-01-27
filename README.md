# trimui-brick-report.pak

A MinUI app that generates a report on the device for development purposes

## Requirements

- Docker (for building)

## Building

```shell
make release
```

## Installation

1. Mount your TrimUI Brick SD card.
2. Download the latest release from Github. It will be named `Report.pak.zip`.
3. Copy the zip file to `/Tools/tg5040/Report.pak.zip`.
4. Extract the zip in place, then delete the zip file.
5. Confirm that there is a `/Tools/tg5040/Report.pak/launch.sh` file on your SD card.
6. Unmount your SD Card and insert it into your TrimUI Brick.

> [!NOTE]
> The device directory changed from `/Tools/tg3040` to `/Tools/tg5040` in `MinUI-20250126-0` - released 2025-01-26. If you are using an older version of MinUI, use `/Tools/tg3040` instead.

## Usage

Just start it. It will display a message and then exit. The report will be available at the root of the SD Card in `report.txt`.
