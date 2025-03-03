# React VSCode Brave Debug 🚀

This setup hooks up **Visual Studio Code (VSCode)** with **Brave Browser** and **Yarn** for a seamless, automated debugging experience.

<br/>

### What You Get
- **Brave Browser Automation**: Launches with remote debugging (`port 9222`) or tabs in if running.
- **Smart Server Handling**: Starts `yarn start` only if the server’s not up on `port 8000`.
- **Debugger Bliss**: Attaches VSCode to Brave.
- **Terminal Zen**: Auto-closes after launching Brave—no keypress nonsense.

### Prerequisites
- **Node.js & Yarn**
- **React App**
- **VSCode**
- **Brave Browser**

<br/>

## Setup: From Zero to Debug

**Create the Browser Launcher**
1. In VSCode, go to `File > New File` and name it `run-browser.sh` in your project root.
2. Add a script to launch Brave with debugging or open a new tab—see `run-browser.sh` in this repo for the code.
3. Save and make it executable in your terminal:
```
chmod +x /path/to/your-app/run-browser.sh
```

<br/>

**Set Up VSCode Tasks**
1. Open the Command Palette (`Cmd + Shift + P`).
2. Type "Configure Tasks" and select `Tasks: Configure Tasks`.
3. Choose `Create tasks.json file from template > Others`.
4. Replace the default with a config to run the browser script and manage `yarn start` —check `.vscode/tasks.json` in this repo.
5. Save it under `.vscode/tasks.json`.

<br/>

**Configure the Debugger**
- Open the Debug view (`Cmd + Shift + D`).
- Click the gear icon and select `Chrome`.
- Replace the default with a config to attach to Brave on `port 9222` —see `.vscode/launch.json` in this repo.
- Save it as `.vscode/launch.json`.

<br/>

**Kick It Off**
1. Open your project in VSCode.
2. Hit `F5` —watch the magic:
  - Brave fires up (or tabs in) on `port 9222`.
  - Server spins up (or chills) on `port 8000`.

<br/>

## Stopping the Show
- `Shift+F5`: Kills the debug session.
- `Ctrl+C`: Stops `yarn start` if it’s running.
- Close Brave when you’re done —your call.

<br/>

## Got Issues? We’ve Got Fixes
- Brave Ghosting You?
  - Test `bash /path/to/run-browser.sh`. Tweak the path or bump the sleep time.
- Cannot connect" Blues?
  - Quit Brave, hit `F5` —it’ll relaunch. Peek at `lsof -i :9222`.
- Terminal Lingering?
  - Check `close: true` in `tasks.json`.

<br/>
Crafted with care —check the commits for the full story. Clone, tweak, and dominate your React debugging! 🤘
