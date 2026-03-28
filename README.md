# oss-audit-24bce10117
### Open Source Software Course — Capstone Project | VIT Bhopal

| Field | Details |
|-------|---------|
| **Student Name** | Prakhar Shukla |
| **Registration Number** | 24BCE10117 |
| **Course** | Open Source Software (NGMC) |
| **Chosen Software** | Git |
| **License** | GNU General Public License v2 (GPL v2) |
| **Environment** | WSL (Ubuntu on Windows) / Ubuntu Linux |

---

## About This Project

This repository contains the shell script component of the **Open Source Audit** capstone project for the Open Source Software course at VIT Bhopal.

The audit subject is **Git** — the distributed version control system created by Linus Torvalds in 2005 after BitKeeper revoked its free-of-charge license for the Linux kernel project. Git is one of the most consequential pieces of open-source software ever written. It is used by virtually every software developer in the world, it is licensed under GPL v2, and its origin story is a direct result of proprietary licensing failure — making it an ideal subject for a FOSS audit.

The five shell scripts below demonstrate practical Linux command-line skills aligned with Units 1–5 of the course.

---

## Scripts Overview

### Script 1 — System Identity Report
**File:** `script1_system_identity.sh`

Displays a formatted welcome screen with: Linux distribution name, kernel version, current user and home directory, system uptime, date/time, installed Git version, WSL environment detection, and the GPL v2 license context for both the kernel and Git.

**Shell concepts used:** Variables, `echo`, command substitution `$()`, conditional WSL detection with `grep -qi`, output formatting.

---

### Script 2 — FOSS Package Inspector
**File:** `script2_package_inspector.sh`

Accepts a package name as an argument (default: `git`). Auto-detects the package manager (`dpkg` on Ubuntu, `rpm` on Fedora/RHEL), checks if the package is installed, retrieves version and metadata, and uses a `case` statement to print a philosophy note based on the package name.

**Shell concepts used:** `if-then-else`, `case` statement, `dpkg`/`rpm`, pipe with `grep`, `awk`, `command -v`, command-line arguments `$1` with default values.

---

### Script 3 — Disk and Permission Auditor
**File:** `script3_disk_auditor.sh`

Iterates over standard system directories and reports permissions, owner/group, and disk usage. A second loop audits Git-specific paths (`/usr/bin/git`, `/usr/lib/git-core`, `~/.gitconfig`, etc.).

**Shell concepts used:** Arrays, `for` loop, `ls -ld`, `awk`, `du -sh`, `cut`, `[ -d ]` and `[ -f ]` file tests, `printf` for aligned output.

---

### Script 4 — Log File Analyzer
**File:** `script4_log_analyzer.sh`

Reads a log file line by line, counts occurrences of a keyword, and displays the last 5 matching lines with a summary. Includes retry logic with WSL-aware fallback log paths for when the specified file is missing or empty.

**Shell concepts used:** `while IFS= read -r` loop, `if-then` inside loop, counter variables with `$(( ))`, retry loop with `while` counter, fallback arrays, `grep`, `tail`, `wc -l`, `$1` and `$2` arguments.

---

### Script 5 — Open Source Manifesto Generator
**File:** `script5_manifesto_generator.sh`

Asks three interactive questions and composes a personalised open-source philosophy statement saved to `manifesto_<username>.txt`. Demonstrates the `alias` concept inside a script.

**Shell concepts used:** `read -p` for user input, string concatenation, file redirection (`>` overwrite, `>>` append), `date` with format strings, `alias` with `shopt -s expand_aliases`, `cat` to display file, `-z` string test for input validation.

---

## Running the Scripts on WSL (Ubuntu)

### One-time setup

Open your WSL Ubuntu terminal and run:

```bash
# Install Git if not already present
sudo apt update && sudo apt install git -y

# Clone the repository
git clone https://github.com/<your-username>/oss-audit-24bce10117.git
cd oss-audit-24bce10117

# Make all scripts executable
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

### Running each script

**Script 1 — System Identity Report**
```bash
./script1_system_identity.sh
```

**Script 2 — FOSS Package Inspector**
```bash
# Check git (default)
./script2_package_inspector.sh

# Check another package
./script2_package_inspector.sh curl
./script2_package_inspector.sh python3
./script2_package_inspector.sh firefox
```

**Script 3 — Disk and Permission Auditor**
```bash
./script3_disk_auditor.sh
# For complete size data on protected directories:
sudo ./script3_disk_auditor.sh
```

**Script 4 — Log File Analyzer**
```bash
# Analyze dpkg log for git-related entries (WSL-friendly, no sudo needed)
./script4_log_analyzer.sh /var/log/dpkg.log git

# Analyze syslog for errors
./script4_log_analyzer.sh /var/log/syslog error

# Auth log (requires sudo on WSL)
sudo ./script4_log_analyzer.sh /var/log/auth.log failed

# Run with no arguments — auto-selects best available log
./script4_log_analyzer.sh
```

**Script 5 — Manifesto Generator (interactive)**
```bash
./script5_manifesto_generator.sh
# Follow the prompts. Output saved to manifesto_<yourusername>.txt
```

---

## WSL-Specific Notes

- **Kernel string:** WSL kernels contain `microsoft` in `uname -r` — Script 1 detects and displays this.
- **Log files:** WSL Ubuntu may not have `/var/log/syslog` or `/var/log/messages` populated at first. Use `/var/log/dpkg.log` or `/var/log/apt/history.log` for Script 4 — these are always present after using `apt`.
- **Permissions:** Some directories (`/var/log`, `/etc`) may show limited size data without `sudo`. This is expected behaviour.
- **Services:** WSL does not run `systemd` by default in older versions. Scripts do not depend on systemd.

---

## Dependencies

| Dependency | Purpose | Install |
|-----------|---------|---------|
| `bash` 4+ | Run all scripts | Pre-installed |
| `git` | Audit subject; Script 2 default | `sudo apt install git` |
| `lsb-release` | Distro detection in Script 1 | `sudo apt install lsb-release` |
| `dpkg` | Package inspection in Script 2 | Pre-installed on Ubuntu |
| `coreutils` (`du`, `df`, `ls`, `wc`) | Disk audit in Script 3 | Pre-installed |
| `grep`, `awk`, `cut` | Text processing across all scripts | Pre-installed |

---

## Project Report

The full project report (PDF) is submitted separately on the VITyarthi portal and covers:

- **Part A:** Git's origin story, GPL v2 license analysis, ethical reflection on open source
- **Part B:** Git's Linux footprint — directory structure, binary locations, config files
- **Part C:** FOSS ecosystem — dependencies, what Git enabled (GitHub, GitLab, Gitea, etc.), community governance
- **Part D:** Comparison with proprietary alternatives (Perforce, Azure DevOps)

---

## Academic Integrity

All written content in the report and all shell scripts were written by Prakhar Shukla (24BCE10117). AI tools were used only for concept clarification and script debugging. All analysis, arguments, and conclusions are the student's own.

---

*VIT Bhopal University | B.Tech CSE | 2024–2028 Batch*
