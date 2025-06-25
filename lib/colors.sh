#!/data/data/com.termux/files/usr/bin/bash

# ===============================
# LuciferHEx Termux Color Setup
# ===============================

if tput setaf 1 &>/dev/null; then
    COLOR_SUPPORT=true
else
    COLOR_SUPPORT=false
fi

if [ "$COLOR_SUPPORT" = true ]; then
    RED='\e[1;31m'
    GREEN='\e[1;32m'
    YELLOW='\e[1;33m'
    BLUE='\e[1;34m'
    CYAN='\e[1;36m'
    WHITE='\e[1;37m'
    RESET='\e[0m'
else
    RED='' GREEN='' YELLOW='' BLUE='' CYAN='' WHITE='' RESET=''
fi


SUCCESS="${GREEN}✔${RESET}"
FAILED="${RED}✖${RESET}"
ARROW="${CYAN}➤${RESET}"
INFO="${BLUE}[i]${RESET}"
WARN="${YELLOW}[!]${RESET}"
ADDED="${GREEN}[+]${RESET}"
FAILS="${RED}[-]${RESET}"


export RED GREEN YELLOW BLUE CYAN WHITE RESET
export SUCCESS FAILED ARROW INFO WARN ADDED FAILS
