# 🔐 Linux Security Check Tool

A simple yet powerful Bash script for **post-attack investigation** on Linux systems.  
Useful for sysadmins, security teams, and DevOps engineers to detect potential signs of compromise.

---

## 🚀 Features

- 🔍 Check active SSH sessions and login history
- 🕵️ Detect suspicious listening ports and processes
- 📂 List sensitive files modified in the last 24 hours
- ⚠️ Find executable files in `/tmp` and `/dev/shm`
- 👥 Show recently created users (UID ≥ 1000)
- 🎯 Color-coded output: red for suspicious, yellow for known, blue for neutral

---

## ⚙️ Requirements

- Linux system (AlmaLinux, Ubuntu, Debian, CentOS, etc.)
- `lsof`, `find`, `awk`, `who`, `w`, `last`

### Install `lsof` (if missing):

```bash
# Debian / Ubuntu
sudo apt install lsof

# RHEL / AlmaLinux / CentOS
sudo yum install lsof

# Alpine
apk add lsof
```

## 📄 Usage
chmod +x security-check.sh
./security-check.sh | less

✅ Run as a normal user (root not required for basic checks).
To detect deeper issues, use sudo for broader output.


## 🧪 Sample Output

🔍 Active SSH and user sessions
farzan13 pts/0        2025-07-06 19:31 (192.168.1.1)


<pre> ``` 🔍 Running processes with open network ports 🚨 Suspicious: nc 48837 farzan13 ... TCP *:4444 (LISTEN) ⚠️ Known service: sshd 923 root ... TCP *:22 (LISTEN) ``` </pre>


🔍 Files modified in the last 24 hours
/etc/passwd
/etc/shadow
...

🔍 Executable files in /tmp or /dev/shm
/tmp/.xploit

🔍 Recently created users
afringan     1009
farzan13     1014


## 📌 Notes
👉This tool is for manual review — it does not block or clean anything.

👉Use alongside log auditing (journalctl, /var/log/auth.log, etc.) for deeper investigation.

👉For real-time alerting, consider pairing with monitoring tools like PRTG, OSSEC, or Wazuh.


## 📄 License
Licensed under the MIT License.

## 🙋‍♂️ Author

**Farzan Afringan**  
🌐 [farzan.us](https://farzan.us)  
📄 [biography.afringan.com](https://biography.afringan.com)  
🐙 [GitHub Profile](https://github.com/farzan-dev13)

## 🤝 Contributions

Pull requests are welcome!
Please fork the repository and submit improvements or feature ideas.



