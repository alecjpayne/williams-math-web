#!/bin/zsh
cd -- "${0:A:h}/deptpage" || exit 1

preview_node="$HOME/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/bin/node"
if [[ ! -x "$preview_node" ]]; then
  preview_node="$(command -v node)"
fi
if [[ -z "$preview_node" || ! -x "$preview_node" ]]; then
  print 'Node.js is missing. Install Node.js 24 LTS, then try again.'
  read '?Press Return to close this window.'
  exit 1
fi

if [[ ! -f node_modules/vite/bin/vite.js ]]; then
  print 'The website packages are missing. Ask Codex to reinstall them, or run npm ci in the deptpage folder after installing Node.js.'
  read '?Press Return to close this window.'
  exit 1
fi

print 'Your local website: http://127.0.0.1:5173/'
print 'Article editor:     http://127.0.0.1:5173/admin/'
print 'Leave this window open while editing. Press Control+C here to stop.'
print 'Click Save in the editor, then refresh the website tab to see changes.'
print ''
"$preview_node" node_modules/vite/bin/vite.js --config vite.local.config.js --open /
preview_result=$?
if (( preview_result != 0 && preview_result != 130 )); then
  print ''
  print 'If port 5173 is already in use, the preview may already be running.'
  print 'Try opening http://127.0.0.1:5173/ in your browser.'
  read '?Press Return to close this window.'
fi
exit "$preview_result"
