<script setup>
import { onMounted, ref } from 'vue'
import { API_BASE } from '@/config'

const noticias = ref([])
const loading = ref(true)
const error = ref('')

function formatearFecha(fecha) {
  if (!fecha) return ''
  return new Date(`${fecha}T00:00:00`).toLocaleDateString('es-AR', { day: 'numeric', month: 'long', year: 'numeric' })
}

// Instagram no publica una miniatura estática accesible sin login (su endpoint
// no oficial /media/ devuelve 404 incluso para reels públicos reales), así que
// sólo YouTube puede resolver una miniatura real acá; para Instagram se cae al
// "else" (imagen cargada a mano, o sólo la badge de categoría).
function obtenerThumbnailVideo(url) {
  if (!url) return null
  const youtube = url.match(/(?:youtube\.com\/(?:watch\?v=|embed\/|shorts\/)|youtu\.be\/)([a-zA-Z0-9_-]{11})/)
  if (youtube) return `https://img.youtube.com/vi/${youtube[1]}/hqdefault.jpg`
  return null
}

onMounted(async () => {
  try {
    const res = await fetch(`${API_BASE}/noticias?limit=50`)
    if (!res.ok) throw new Error('No se pudieron cargar las noticias')
    const data = await res.json()
    noticias.value = data.items
  } catch (err) {
    error.value = 'No se pudieron cargar las noticias en este momento.'
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <main class="w-full max-w-6xl mx-auto px-6 md:px-12 py-24 min-h-[600px]">
    <header class="mb-12 max-w-3xl">
      <span class="text-brit-teal text-xs font-bold uppercase tracking-wider">Noticias</span>
      <h1 class="font-title text-3xl/[1] md:text-[34px]/[1] font-semibold tracking-normal text-brit-teal mt-4 mb-6">Artículos de expertos</h1>
      <p class="text-gray-600 text-lg leading-relaxed">Información y novedades de nuestros especialistas para cuidar tu salud.</p>
    </header>

    <p v-if="loading" class="text-gray-600">Cargando noticias...</p>
    <p v-else-if="error" class="text-red-600">{{ error }}</p>
    <p v-else-if="!noticias.length" class="text-gray-600">Todavía no hay noticias publicadas.</p>

    <section v-else aria-label="Artículos de expertos" class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <article v-for="noticia in noticias" :key="noticia.id" class="flex flex-col">
        <a :href="`/noticias/${noticia.id}`" class="w-full aspect-[4/3] bg-gray-100 relative mb-4 overflow-hidden block">
          <img v-if="obtenerThumbnailVideo(noticia.video_url)" :src="obtenerThumbnailVideo(noticia.video_url)" :alt="noticia.titulo" class="w-full h-full object-cover" @error="$event.target.style.display = 'none'">
          <img v-else-if="noticia.tiene_imagen" :src="`${API_BASE}/noticias/${noticia.id}/imagen`" :alt="noticia.titulo" class="w-full h-full object-cover">
          <span v-if="noticia.video_url" class="absolute inset-0 flex items-center justify-center">
            <span class="w-12 h-12 rounded-full bg-black/50 flex items-center justify-center">
              <svg class="w-5 h-5 text-white ml-0.5" viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z" /></svg>
            </span>
          </span>
          <span class="absolute bottom-3 left-3 bg-white text-brit-teal text-[10px] font-bold px-3 py-1 rounded-full shadow-sm">{{ noticia.categoria }}</span>
        </a>
        <time class="text-gray-600 text-xs mb-2 font-medium" :datetime="noticia.fecha">{{ formatearFecha(noticia.fecha) }}</time>
        <h2 class="text-lg font-bold text-gray-800 mb-2 leading-snug">{{ noticia.titulo }}</h2>
        <p class="text-gray-600 text-sm mb-3 leading-relaxed">{{ noticia.descripcion }}</p>
        <a :href="`/noticias/${noticia.id}`" class="text-brit-teal text-sm font-semibold hover:underline mt-auto">Leer más <span aria-hidden="true">→</span></a>
      </article>
    </section>
  </main>
</template>
