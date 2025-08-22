# amazon-q-developer-cli-for-windows

> **Disclaimer**: This is an unofficial repository and is not affiliated with or endorsed by Amazon Web Services (AWS). This project simply provides Windows builds of the official [Amazon Q Developer CLI](https://github.com/aws/amazon-q-developer-cli).

> **Note**: There is no official Windows build of the Amazon Q Developer CLI. This unofficial build may be unstable or have bugs.

> **Security Note**: The built binary is not code-signed, so Windows SmartScreen may display a warning when you first run it. This is normal for unsigned executables.

Build Amazon Q Developer CLI for Windows.

## Download

Download the latest zip file from the [Releases](https://github.com/DiscreteTom/amazon-q-developer-cli-for-windows/releases) page. Extract the `q.exe` binary and `update_q.bat` script from the downloaded zip file.

## Updating

To update to the latest version, run the included `update_q.bat` script. This will automatically:
- Download the latest release from GitHub
- Extract and replace your current `q.exe` binary
- Clean up temporary files

The script downloads files to your `~/Downloads` folder during the update process.

## Overview

This repository provides a GitHub workflow to automatically build the [Amazon Q Developer CLI](https://github.com/aws/amazon-q-developer-cli) for Windows and create releases with the compiled binary.

The workflow:
- Clones the specified version from the [aws/amazon-q-developer-cli](https://github.com/aws/amazon-q-developer-cli) repository
- Builds the binary using `cargo build --bin chat_cli --release`
- Renames the output from `chat_cli.exe` to `q.exe`
- Creates a zip archive with the version in the filename
- Creates a new release with the specified tag name
- Uploads the zip file to the release
