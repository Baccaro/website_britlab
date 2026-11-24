import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
  ], server: {
    host: '0.0.0.0', // Permite que Docker exponga el servidor fuera del contenedor
    port: 5173,
    allowedHosts: [
      'public.britlab.com.ar',
    ],
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
})
