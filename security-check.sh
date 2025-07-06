#!/bin/bash

# Colors
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
GREEN="\e[32m"
RESET="\e[0m"

print_section() {
  echo -e "\n${CYAN}🔸==============================🔸"
  echo -e "🔍 $1"
  echo -e "🔸==============================🔸${RESET}"
}

echo -e "${GREEN}🔐 Linux Post-Incident Security Scanner${RESET}"

# ------------------------------
# 1. Active SSH and user sessions
# ------------------------------
print_section "Active SSH and user sessions"
who
uptime
w
last -n 10

# ------------------------------
# 2. Open network connections (via lsof)
# ------------------------------
print_section "Running processes with open network ports"

mapfile -t open_ports < <(lsof -i -nP | grep LISTEN)

for line in "${open_ports[@]}"; do
  if echo "$line" | grep -Eiq 'nc|ncat|bash|python|perl|ruby|nmap|netcat'; then
    echo -e "${RED}🚨 Suspicious: $line${RESET}"
  elif echo "$line" | grep -Eiq 'sshd|nginx|httpd|named|rpcbind|chronyd|systemd-resolved|dnsmasq|mysql|postgres'; then
    echo -e "${YELLOW}⚠️ Known service: $line${RESET}"
  else
    echo -e "${CYAN}ℹ️ Listening: $line${RESET}"
  fi
done

# ------------------------------
# 3. Files modified in the last 24 hours
# ------------------------------
print_section "Files modified in the last 24 hours"
find /etc -type f -mtime -1 2>/dev/null

# ------------------------------
# 4. Suspicious executables in /tmp /dev/shm
# ------------------------------
print_section "Suspicious executables in /tmp or /dev/shm"
find /tmp /dev/shm -type f -perm -111 -exec ls -lh {} \; 2>/dev/null || echo "No access to check."

# ------------------------------
# 5. Recently created users (UID >= 1000)
# ------------------------------
print_section "Recently created users (UID ≥ 1000)"
awk -F: '$3 >= 1000 {print $1, $3}' /etc/passwd

# ------------------------------
# Done
# ------------------------------
echo -e "\n${GREEN}✅ Scan complete.${RESET}"
