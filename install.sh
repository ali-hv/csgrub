#!/bin/bash
# ===============================================================
# csgrub Theme Installer
# Repository: https://github.com/ali-hv/csgrub
# ===============================================================

set -e

THEME_NAME="csgrub"
THEME_DIR="/boot/grub/themes"
GRUB_CFG="/etc/default/grub"
GRUB_FILE="/boot/grub/grub.cfg"

echo ""
echo "==========================="
echo "csgrub GRUB Theme Installer"
echo "==========================="
echo ""

# Root check
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)."
    exit 1
fi

# Ensure theme directory exists
mkdir -p "$THEME_DIR"

# Copy theme
echo "Installing theme files..."
rm -rf "$THEME_DIR/$THEME_NAME"
cp -r "$THEME_NAME" "$THEME_DIR/"

# Ensure required GRUB options
echo "Configuring GRUB defaults..."

grep -q '^GRUB_TIMEOUT_STYLE=' "$GRUB_CFG" \
    && sed -i 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=menu/' "$GRUB_CFG" \
    || echo 'GRUB_TIMEOUT_STYLE=menu' >> "$GRUB_CFG"

grep -q '^GRUB_DISABLE_SUBMENU=' "$GRUB_CFG" \
    && sed -i 's/^GRUB_DISABLE_SUBMENU=.*/GRUB_DISABLE_SUBMENU=y/' "$GRUB_CFG" \
    || echo 'GRUB_DISABLE_SUBMENU=y' >> "$GRUB_CFG"

grep -q '^GRUB_DISABLE_OS_PROBER=' "$GRUB_CFG" \
    && sed -i 's/^GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' "$GRUB_CFG" \
    || echo 'GRUB_DISABLE_OS_PROBER=false' >> "$GRUB_CFG"

# Set theme
grep -q '^GRUB_THEME=' "$GRUB_CFG" \
    && sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"|" "$GRUB_CFG" \
    || echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> "$GRUB_CFG"

# Regenerate GRUB
echo "Rebuilding GRUB..."
if command -v update-grub >/dev/null 2>&1; then
    update-grub
elif command -v grub-mkconfig >/dev/null 2>&1; then
    grub-mkconfig -o "$GRUB_FILE"
else
    echo "No GRUB update command found."
    exit 1
fi

echo ""
echo "Installation complete!"
echo "Reboot to see csgrub."
echo ""
