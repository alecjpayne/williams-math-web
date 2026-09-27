# Try the Williams mathematics website on your Mac

This folder is your working copy of the downloaded website. The original ZIP on your Desktop is still your starting-point backup.

The preview runs on your own Mac. Its address, http://127.0.0.1:5173/, means “this computer.” The preview must be running for that address to work.

## Start the website

1. In Finder, open this folder.
2. Double-click **Start Local Website.command**.
3. A Terminal window opens and the website opens in your browser. Leave that Terminal window open while you work.
4. If the browser does not open automatically, visit http://127.0.0.1:5173/.

If you see “port 5173 is already in use,” try that address: the preview may already be running. Codex started it while preparing this copy.

## Make your first edit

1. Keep the website open in one browser tab: http://127.0.0.1:5173/.
2. Open the built-in editor in another tab: http://127.0.0.1:5173/admin/.
3. Select **Front Page**. Scroll to **article body (markdown)** under the welcome heading.
4. Add a sentence, such as “This is my first local edit.” The panel beside the text shows a formatted preview.
5. Click **Save** at the top. Wait until the button says **Saved**.
6. Return to the website tab and refresh it with **Command+R**. Your sentence should appear.
7. To undo the experiment, remove the sentence in the editor, click **Save**, and refresh again.

To change a news article instead, choose **News** in the editor, open an existing article, change its article body, and click **Save**. View it at http://127.0.0.1:5173/news and refresh.

Use **Save** for this local workflow. **Publish to live site** belongs to an older single-server workflow and does not publish the GitHub review site. See [COLLABORATING.md](COLLABORATING.md) to share edits through the project's `source` branch.

## What you are editing

The editor saves ordinary files inside this folder:

- `articles/` contains the article text. The home page's welcome text is `articles/welcome.md`.
- `deptpage/data/` contains page headings, article listings, and other settings.
- `images/` contains pictures.
- `deptpage/src/` contains the website's layout and behavior.

You can edit articles through the browser editor without opening any source code. If you later want to edit a file directly, use a plain-text/code editor, save the file, and refresh the local website. Avoid simultaneously editing the same article in the browser editor and a text editor.

Markdown is plain text with a few optional formatting marks:

```text
This is an ordinary paragraph.

**This is bold.**

*This is italic.*

## This is a heading

[This is a link](https://www.williams.edu/)
```

## Stop and restart

For a preview you started with the launcher, click its Terminal window and press **Control+C** to stop it. Your saved edits stay on disk. Double-click **Start Local Website.command** when you want to work again. Closing just the browser tab does not stop the server.

The preview initially started by Codex can be stopped by asking Codex to stop this local website.

## How the setup works

This is a React website with Vite, a development server that prepares the source files for your browser. That is why double-clicking an HTML file is not the normal way to run it. See the [Vite guide](https://vite.dev/guide/).

Codex extracted the ZIP with its article/image folder links preserved, installed the exact supporting packages recorded in the download, and used the Node.js runtime already bundled with Codex. The [npm ci command](https://docs.npmjs.com/cli/v11/commands/npm-ci/) installs packages from the project's lockfile.

This working copy includes the launcher and `deptpage/vite.local.config.js`, plus a colleague guide, cleaned-up mathematics documentation, and a proposed GitHub preview workflow. The original Desktop ZIP remains unchanged. The extra local configuration uses polling because native file watching failed in the Codex environment. It keeps the article editor open while saving; refresh the website tab to see your edits.

The Mac launcher uses the current user's existing Codex runtime if available, or a normal `node` command. Installed packages are in `deptpage/node_modules`. A different computer needs its own Node.js and package installation; do not share or commit `node_modules` through GitHub.
