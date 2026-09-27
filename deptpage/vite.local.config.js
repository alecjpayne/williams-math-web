// Local preview settings for this Mac. The original vite.config.js is unchanged.
// Poll for changes because native fs.watch is unavailable in the preview environment.
import { watchFile, unwatchFile } from 'node:fs'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import baseConfig from './vite.config.js'

const dataDir = fileURLToPath(new URL('./data/', import.meta.url))

export default {
  ...baseConfig,
  plugins: [
    ...baseConfig.plugins.filter((plugin) => plugin.name !== 'data-reload-plugin'),
    {
      name: 'local-preview-refresh',
      async configureServer(server) {
        const { readdir } = await import('node:fs/promises')
        const watched = []
        for (const name of await readdir(dataDir)) {
          if (!name.endsWith('.json')) continue
          const file = path.join(dataDir, name)
          const changed = () => {
            // Refreshing a page should use saved JSON. Do not interrupt the editor.
            server.moduleGraph.invalidateAll()
          }
          watchFile(file, { interval: 250 }, changed)
          watched.push([file, changed])
        }
        server.httpServer?.on('close', () => {
          for (const [file, changed] of watched) unwatchFile(file, changed)
        })
      },
    },
  ],
  server: {
    ...baseConfig.server,
    host: '127.0.0.1',
    port: 5173,
    strictPort: true,
    watch: { ...baseConfig.server.watch, usePolling: true, interval: 500 },
  },
}
