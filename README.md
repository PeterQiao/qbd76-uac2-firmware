# QBD76 UAC2 Firmware Loader

This repository contains files for loading QBD76 UAC2 firmware on macOS (Apple Silicon):

- `start_qbd76.sh` — verifies the SHA-256 checksums and starts the loading process
- `verified_uac2_release_cb3dbc61.bix` — QBD76 UAC2 firmware image
- `ram_loader` — macOS arm64 RAM loader

## Usage

Install the Homebrew `libusb` dependency:

```sh
brew install libusb
```

Connect the device to your Mac, then run the following from this directory:

```sh
chmod +x start_qbd76.sh
./start_qbd76.sh
```

Before loading, the script verifies the SHA-256 checksum of both the loader and the firmware image. It refuses to run if either file has been modified or corrupted.

## No Affiliation with Chord

This is an independent community project. It is not affiliated with, authorized, sponsored, endorsed, or otherwise officially connected to Chord Electronics Ltd., Chord, or any of their affiliates.

“Chord,” “QBD76,” and other related names and marks belong to their respective owners. They are used in this repository only where necessary to identify device compatibility and intended use. Nothing in this repository should be interpreted as a trademark license or official support.

## License

The original scripts, README, and other documentation created for this project are released under the [MIT License](LICENSE).

The copyright, patent, trademark, and other rights to `verified_uac2_release_cb3dbc61.bix` and `ram_loader` may belong to their original rights holders. Unless expressly authorized in writing, this repository does not grant any license to those files beyond what is permitted by applicable law. They are provided “as is,” and users are responsible for confirming that their use is lawful and properly authorized.

## Copyright or Infringement Notices

If you believe that any content in this repository infringes your copyright, trademark, or other legal rights, please contact us through the repository’s GitHub Issues. Include the relevant file, the basis for your claim, and your contact information. We will review the matter promptly and, where appropriate, remove or otherwise address the content.
