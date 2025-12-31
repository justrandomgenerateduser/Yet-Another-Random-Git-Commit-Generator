# Random Git Commit Generator

Random Git Commit Generator is a lightweight Bash script that generates fake Git 
commits over a configurable date range. It is intended for GitHub profile graph 
customization, testing, and experimentation — not for real or production repositories.

This tool can be used to fill a GitHub contribution graph, simulate historical Git 
activity, generate demo repositories, or experiment with Git history rewriting.

**WARNING**
This script rewrites Git history by creating artificial commits. 
Do NOT use it in important, shared, or production repositories.

---

## Features

- Generate random Git commits automatically
- Configurable start and end dates
- Custom Git author name and email

---

## Requirements

- Git repository already initialized
- Bash shell
- GNU date (Linux, WSL, or macOS with coreutils)

---

## Usage (Run via curl)

1. Create your new repo
2. Clone it onto your disk
3. Change directory into your new git repo
4. Run the script directly without downloading it locally:

```bash
curl -fsSL https://raw.githubusercontent.com/justrandomgenerateduser/Yet-Another-Random-Git-Commit-Generator/main/yargcg.sh | \
AUTHOR_NAME="Jurek Ogurek" \
AUTHOR_EMAIL="jurek.ogurek@users.noreply.github.com" \
START_DATE="2022-01-12" \
END_DATE="2025-12-22" \
bash
```

