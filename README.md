# My MikroTik Scripts Collection

A set of automation and optimization scripts for MikroTik RouterOS devices.

## 📌 Description 

This repository contains scripts designed for:

* Automatic configuration backups
* Firmware and RouterOS updates
* PPPoE and routing monitoring
* LED status control
* Telegram alert notifications
* VPN connection management

## ⚙️ Requirements

* RouterOS version 6.45 or higher (some scripts may require newer versions)
* Enabled packages: system, scheduler, fetch, tool
* Internet access and a valid Telegram bot token (for Telegram-based scripts)

## 🚀 Installation & Usage

* Download the required script from this repository
* Upload it to your MikroTik device via Winbox, WebFig, or SSH
* Import the script using the following command:

```bash
/import file-name=script_name.rsc
```

* Customize the script parameters if needed

## 📄 Script List

* AutoBackup.rsc — automated configuration backups
* AutoUpdateFirmware.rsc — automated firmware updates
* AutoUpdateRouterOS.rsc — RouterOS upgrade automation
* CheckPPPoEAndRoutes.rsc — PPPoE and route state verification
* LedsDayMode.rsc / LedsNightMode.rsc / LedsToggleMode.rsc — LED mode control
* RebootStatus.rsc — reboot logging and monitoring
* TelegramMessage.rsc — send notifications via Telegram
* vpnscript.rsc — automated VPN connection management

## 🧩 Example Usage

Example of scheduling automatic configuration backups:

```bash
/system scheduler add interval=1d name=AutoBackup on-event="/system script run AutoBackup" start-date=2020-11-14 start-time=03:30:00
```

## 🛡️ License

GPL-3.0.

## 🤝 Contributions

Suggestions and improvements are welcome! Feel free to open an issue or submit a pull request.

## 📬 Contact

Author: [laspavel](https://github.com/laspavel)

Feel free to reach out with questions or ideas.

---