import { fileURLToPath, URL } from "node:url";
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { VitePWA } from "vite-plugin-pwa";

export default defineConfig({
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
  },
  plugins: [
    react(),
    VitePWA({
      // "prompt" em vez de "autoUpdate": uma nova versão nunca substitui o app
      // silenciosamente no meio de uma sessão de estudo — o usuário decide
      // quando atualizar (ver components/layout/UpdatePrompt.tsx).
      registerType: "prompt",
      includeAssets: ["favicon.svg", "icon-192.png", "icon-512.png", "icon-512-maskable.png"],
      manifest: {
        name: "ReviseTI",
        short_name: "ReviseTI",
        description: "Aplicativo de revisão e acompanhamento dos estudos de TI.",
        theme_color: "#4f46e5",
        background_color: "#ffffff",
        display: "standalone",
        orientation: "portrait",
        start_url: "/",
        icons: [
          { src: "/icon-192.png", sizes: "192x192", type: "image/png" },
          { src: "/icon-512.png", sizes: "512x512", type: "image/png" },
          { src: "/icon-512-maskable.png", sizes: "512x512", type: "image/png", purpose: "maskable" },
        ],
      },
      workbox: {
        // Precache do app shell (JS/CSS/HTML/fontes/ícones) para abrir offline.
        globPatterns: ["**/*.{js,css,html,svg,png,ico,woff2}"],
        navigateFallback: "/index.html",
        runtimeCaching: [
          // Apenas o conteúdo OFICIAL (study_contents/content_topics) é cacheado
          // via HTTP cache do Service Worker — é dado público, compartilhado por
          // todos os usuários. Dados pessoais (reviews, questions, sessions...)
          // nunca passam por aqui: eles são tratados pelo IndexedDB (Dexie) em
          // src/lib/localDb.ts, para não guardar respostas privadas no cache HTTP.
          {
            urlPattern: ({ url }) =>
              url.pathname.includes("/rest/v1/study_contents") || url.pathname.includes("/rest/v1/content_topics"),
            handler: "NetworkFirst",
            options: { cacheName: "study-contents-cache", expiration: { maxEntries: 50 } },
          },
        ],
      },
    }),
  ],
  server: { port: 5173 },
});
