# Introduction to Software Development: Codespaces POC

This repository is a proof of concept for giving every student the same Linux and Bash development environment from a browser on a Windows laboratory computer.

[Open this repository in GitHub Codespaces](https://codespaces.new/nalinabrol/intro-software-development-codespaces-poc?quickstart=1)

## What is already installed

- Bash on Ubuntu Linux
- Git
- G++ and Make
- Vim and common command-line utilities
- Python, FastAPI, and Uvicorn
- Browser-based VS Code

Students do not need administrator access on the Windows computer. The required software is installed in the remote development environment.

## Launch the POC

1. Sign in to GitHub in Microsoft Edge or Google Chrome.
2. Select the **Open this repository in GitHub Codespaces** link above.
3. Keep the default machine type and select **Create codespace**.
4. Wait for browser-based VS Code to open.
5. Open **Terminal → New Terminal**. The shell should be Bash.
6. Run:

```bash
bash scripts/verify_environment.sh
```

The final line should say:

```text
POC verification passed.
```

## Try the Lecture 1 command story

```bash
pwd
ls
ls -la
ls -lah
cd practice
pwd
cd ..
mkdir created-in-terminal
touch created-in-terminal/empty-note.txt
cat visible-note.txt
```

Compile and run the same C++ program with keyboard input:

```bash
g++ add.cpp -o add
./add
```

Type two numbers when the program waits, for example:

```text
12 30
```

Run the same program with input from a file:

```bash
./add < input.txt
```

## Run the small web server

```bash
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

Codespaces will display an **Open in Browser** notification for port `8000`. This opens a forwarded GitHub URL because the program is running on the remote Linux environment, not on the Windows computer.

Stop the server with `Ctrl+C`.

## Reset before another demonstration

```bash
bash scripts/reset_workspace.sh
```

This repository is the environment POC. The final one-page student practice sheet will be prepared separately after the workflow is approved.
