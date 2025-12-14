# csgrub – Counter‑Strike Style GRUB Theme 🎮

A **Counter‑Strike inspired GRUB theme** that turns your boot menu into a **fullscreen side picker** (Linux vs Windows), inspired by the classic *CT vs T* selection screen.

> ⚠️ **Important:**
> This theme intentionally uses a GRUB layout trick where **each menu entry is rendered as a fullscreen image**.
> This is **safe**, but it requires specific GRUB settings to behave correctly. 

---

## 📸 What this theme does

* Fullscreen background per menu entry
* Linux / Windows visual selection
* Keyboard‑only navigation (↑ ↓ Enter)
* No animations, no scripts at boot time
* Pure GRUB theme (cosmetic only)

---

## ✅ Supported Distributions

Tested / intended for:

* **Ubuntu & Ubuntu‑based**

  * Ubuntu
  * Mint
  * Debian
* **Arch**
* **Fedora**

Other distros *may* work, but are not officially covered.

---

## ⚠️ Requirements & Limitations (READ THIS)

Because of how this theme works:

* Each visible GRUB menu entry **must have a fullscreen image**
* Extra entries (Recovery, Advanced options, UEFI Firmware) will break navigation
* This theme works best with **exactly two entries**:

  * Linux
  * Windows

👉 This is **not a bug** — it’s a known GRUB limitation.

---

## 🛠 Before Installation (MANDATORY)

### 1️⃣ Backup GRUB config (recommended)

```bash
sudo cp /etc/default/grub /etc/default/grub.backup
```

---

### 2️⃣ Required GRUB settings

Edit GRUB defaults:

```bash
sudo nano /etc/default/grub
```

Add or ensure the following:

```ini
GRUB_TIMEOUT_STYLE=menu
GRUB_DISABLE_SUBMENU=y
GRUB_DISABLE_OS_PROBER=false
```

#### If you ever saw Recovery Mode when pressing Enter:

Add this as well:

```ini
GRUB_DEFAULT="0>0"
```

This forces **normal Linux boot** instead of recovery.

---

### 3️⃣ (Optional but Recommended) Remove UEFI Firmware entry

To keep navigation clean:

```bash
sudo chmod -x /etc/grub.d/30_uefi-firmware
```

You can restore it later with:

```bash
sudo chmod +x /etc/grub.d/30_uefi-firmware
```

---

## 🚀 Installation

Clone the repository:

```bash
git clone https://github.com/ali-hv/csgrub.git
cd csgrub
```

Run the installer:

```bash
sudo ./install.sh
```

Reboot:

```bash
reboot
```

---

## 📂 Expected File Layout

After installation:

```
/boot/grub/themes/csgrub/
├── theme.txt
├── font.pf2
└── icons/
    ├── linux.png
    └── windows.png
```

---

## 🧯 Recovery (If Something Goes Wrong)

### Quick fix (from your installed system):

```bash
sudo nano /etc/default/grub
# Comment or remove GRUB_THEME
sudo update-grub
```

---

### Full recovery (Live USB)

if you couldn't enter your os:

1. Boot a live USB
2. Mount your system and chroot
3. Run:

```bash
update-grub
```

GRUB themes are **purely cosmetic** — no risk of data loss.

---

## ♻️ Uninstall

```bash
sudo nano /etc/default/grub
# Remove GRUB_THEME line
sudo update-grub
sudo rm -rf /boot/grub/themes/csgrub
```

---

## 🧠 Notes for Advanced Users

* This theme is **index‑based**, not OS‑based
* Menu order matters
* Designed for **1920×1080** (works on others, but not guaranteed)
* Not compatible with animated or complex GRUB layouts

---

## ❤️ Credits

Inspired by classic GRUB fullscreen picker themes and the Counter‑Strike universe.

Enjoy — and boot responsibly 😄
