#!/data/data/com.termux/files/usr/bin/bash

mkdir -p "$HOME/.luciferhex"
cp ./bin/vpsmenu "$HOME/.luciferhex/vpsmenu"
cp ./lib/colors.sh "$HOME/.luciferhex/colors.sh"
cp ./assets/banner.txt "$HOME/.luciferhex/banner.txt"
chmod +x "$HOME/.luciferhex/"*


if [ -L "$PREFIX/bin/vpsmenu" ]; then
    echo "[!] Symlink 'vpsmenu' points to another location. Remove and fix.."
    rm "$PREFIX/bin/vpsmenu"
fi


if [ ! -f "$PREFIX/bin/vpsmenu" ]; then
    ln -s "$HOME/.luciferhex/vpsmenu" "$PREFIX/bin/vpsmenu"
    echo "[+] Symlink 'vpsmenu' successfully added to global PATH."
fi


SHELL_RC="$HOME/.bashrc"
[ -n "$ZSH_VERSION" ] && SHELL_RC="$HOME/.zshrc"


if ! grep -q 'vpsmenu' "$SHELL_RC"; then
    echo "alias vpsmenu='bash ~/.luciferhex/vpsmenu'" >> "$SHELL_RC"
    echo "[+] Alias 'vpsmenu' added to $SHELL_RC"
fi


echo "[*] Mengecek dependensi..."
PKGS=("openssh" "bash" "proot" "sshpass" "ncurses-utils" "figlet")
for pkg in "${PKGS[@]}"; do
    if ! command -v "$pkg" &>/dev/null; then
        echo -ne "[*] Installing $pkg..."
        pkg install -y "$pkg" > /dev/null 2>&1 &
        pid=$!
        spin='-\|/'; i=0
        while kill -0 $pid 2>/dev/null; do
            i=$(( (i+1) %4 ))
            printf "\r   [%c] $pkg..." "${spin:$i:1}"
            sleep 0.1
        done
        wait $pid
        if [ $? -eq 0 ]; then
            echo -e "\r $pkg successfully installed.     "
        else
            echo -e "\r Failed to install $pkg.     "
        fi
    else
        echo "[✓] $pkg already installed."
    fi
done


echo "[*] Running source $SHELL_RC to activate alias .."
source "$SHELL_RC"
echo "[✓] Setup is complete. Please type: vpsmenu"
