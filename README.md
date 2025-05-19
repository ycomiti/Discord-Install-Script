# Discord Install Script

A simple Bash script to download, install, and create desktop shortcuts for Discord on Linux.

This script fetches the latest official Discord Linux release, installs it under `~/opt/discord`, and sets up desktop entries for easy launching.

Once you install Discord using this script, manual updates will no longer be necessary, as Discord will be installed in the user's home directory and will be able to update itself automatically, similar to how it functions on Windows.

---

## Features

- Automatically downloads the latest Discord tarball.
- Cleans up previous installations.
- Extracts and installs Discord to `~/opt/discord`.
- Creates desktop entries in your user applications and desktop folders.
- Checks for executable permissions on the Discord binary.

---

## Requirements

- `bash`
- `curl`
- `tar`
- Basic Linux utilities (`rm`, `chmod`, `mkdir`, etc.)

---

## Installation

You can install Discord quickly by running the script directly via curl:

```bash
curl -fsSL https://raw.githubusercontent.com/ycomiti/Discord-Install-Script/main/install.sh | bash
````

This will:

* Download the latest Discord.
* Extract and install it.
* Create desktop shortcuts.

---

## Usage

Just run the script again if you want to update or reinstall Discord:

```bash
bash install.sh
```

---

## License

This project is licensed under the **GNU General Public License v3.0** (GPLv3).

See the [LICENSE](LICENSE) file for details.

---
## Repository

[https://github.com/ycomiti/Discord-Install-Script](https://github.com/ycomiti/Discord-Install-Script)
