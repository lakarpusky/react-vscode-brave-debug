# React VSCode Brave Debug 🚀

This setup hooks up **Visual Studio Code (VSCode)** with **Brave Browser** and **Yarn** for a seamless, automated debugging experience.

<br/>

### What You Get
- **Brave Browser Automation**: Launches with remote debugging (`port 9222`) with last session
- **Smart Server Handling**: Starts `yarn script` only if the server’s not up on `port 8000`.
- **Debugger Bliss**: Attaches VSCode to Brave.
- **Terminal Zen**: Auto-closes after launching Brave

### Prerequisites
- **VSCode** installed
- **Brave Browser** installed
- **Yarn** installed

<br/>

## Setup Steps

**Create the Browser Launcher**
1. In VSCode, go to `File > New File` and name it `run-browser.sh` in your project root.
2. See `run-browser.sh` in this repo for the code.

**Set Up VSCode Tasks**
1. Open the Command Palette (`Cmd + Shift + P`).
2. Type "Configure Tasks" and select `Tasks: Configure Tasks`.
3. Choose `Create tasks.json file from template > Others`.
4. Replace the default with a config to run the browser script and manage `yarn script` —check `.vscode/tasks.json` in this repo.
5. Save the file

**Configure the Debugger**
1. Open the Debug view (`Cmd + Shift + D`).
2. Click the gear icon and select `Chrome`.
3. Replace the default with a config to attach to Brave on `port 9222` —see `.vscode/launch.json` in this repo.
4. Save the file

**Kick It Off**
1. Open your project in VSCode.
2. Hit `F5` —watch the magic:
  - Brave fires up (or tabs in) on `port 9222`.
  - Server spins up (or chills) on `port 8000`.

<br/>

## Stopping the Show
- `Shift+F5`: Kills the debug session.
- `Ctrl+C`: Stops `yarn script` if it’s running.
- Close Brave when you’re done —your call.

## Got Issues? We’ve Got Fixes
- Brave Ghosting You? Test `bash /path/to/run-browser.sh`. Tweak the path or bump the sleep time.
- Terminal Lingering? Check `close: true` in `tasks.json`.
- Debugger doesn't attach? Check `/path/to/run-browser.sh` is executable
```
chmod +x /path/to/your-app/run-browser.sh
```

Crafted with care! Thanks 🤘
