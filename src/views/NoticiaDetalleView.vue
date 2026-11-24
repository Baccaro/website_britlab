<script setup>
import { computed, onMounted, ref } from 'vue'
import { API_BASE } from '@/config'

const props = defineProps({ id: { type: [String, Number], required: true } })

const noticia = ref(null)
const loading = ref(true)
const error = ref('')

function formatearFecha(fecha) {
  if (!fecha) return ''
  return new Date(`${fecha}T00:00:00`).toLocaleDateString('es-AR', { day: 'numeric', month: 'long', year: 'numeric' })
}

function obtenerEmbedInfo(url) {
  if (!url) return null
  const youtube = url.match(/(?:youtube\.com\/(?:watch\?v=|embed\/|shorts\/)|youtu\.be\/)([a-zA-Z0-9_-]{11})/)
  if (youtube) return { tipo: 'youtube', src: `https://www.youtube.com/embed/${youtube[1]}` }
  const instagram = url.match(/instagram\.com\/(reel|p|tv)\/([a-zA-Z0-9_-]+)/)
  // El embed de Instagram (perfil + video + acciones + comentarios) tiene una
  // altura fija de ~830px independiente del ancho, por eso va en una caja
  // angosta y alta en lugar del marco 16:9 que usan las fotos/YouTube: así se
  // ve completo, sin necesidad de scroll adentro del iframe.
  if (instagram) return { tipo: 'instagram', src: `https://www.instagram.com/${instagram[1]}/${instagram[2]}/embed` }
  return null
}

const embedInfo = computed(() => obtenerEmbedInfo(noticia.value?.video_url))

onMounted(async () => {
  try {
    const res = await fetch(`${API_BASE}/noticias/${props.id}`)
    if (!res.ok) throw new Error('No se encontró la noticia')
    noticia.value = await res.json()
  } catch (err) {
    error.value = 'No se pudo encontrar esta noticia.'
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <main class="w-full max-w-3xl mx-auto px-6 md:px-12 py-24 min-h-[600px]">
    <p v-if="loading" class="text-gray-600">Cargando noticia...</p>
    <div v-else-if="error">
      <p class="text-red-600 mb-6">{{ error }}</p>
      <a href="/noticias" class="text-brit-teal text-sm font-semibold hover:underline">← Volver a noticias</a>
    </div>
    <article v-else>
      <a href="/noticias" class="text-brit-teal text-sm font-semibold hover:underline mb-8 inline-block">← Volver a noticias</a>
      <span class="text-brit-teal text-xs font-bold uppercase tracking-wider block">Noticias / {{ noticia.categoria }}</span>
      <h1 class="font-title text-3xl/[1] md:text-[34px]/[1] font-semibold tracking-normal text-brit-teal mt-4 mb-4">{{ noticia.titulo }}</h1>
      <time class="text-gray-600 text-sm font-medium block mb-8" :datetime="noticia.fecha">{{ formatearFecha(noticia.fecha) }}</time>
      <div v-if="noticia.video_url" class="w-full mb-10">
        <div v-if="embedInfo?.tipo === 'instagram'" class="max-w-[500px] mx-auto overflow-hidden">
          <iframe :src="embedInfo.src" class="w-full border-0" style="height: 860px;" scrolling="no"
            allow="autoplay; encrypted-media; fullscreen; picture-in-picture" allowfullscreen loading="lazy"></iframe>
        </div>
        <div v-else-if="embedInfo?.tipo === 'youtube'" class="w-full aspect-[16/9] bg-gray-100 overflow-hidden">
          <iframe :src="embedInfo.src" class="w-full h-full" frameborder="0"
            allow="autoplay; encrypted-media; fullscreen; picture-in-picture" allowfullscreen loading="lazy"></iframe>
        </div>
        <a v-else :href="noticia.video_url" target="_blank" rel="noopener noreferrer"
          class="w-full aspect-[16/9] bg-gray-100 flex items-center justify-center text-brit-teal text-sm font-semibold underline">Ver video</a>
      </div>
      <div v-else-if="noticia.tiene_imagen" class="w-full aspect-[16/9] bg-gray-100 overflow-hidden mb-10">
        <img :src="`${API_BASE}/noticias/${noticia.id}/imagen`" :alt="noticia.titulo" class="w-full h-full object-cover">
      </div>
      <p class="text-gray-600 text-lg leading-relaxed mb-8">{{ noticia.descripcion }}</p>
      <div class="rich-content text-gray-800 leading-relaxed" v-html="noticia.cuerpo"></div>
    </article>
  </main>
</template>

<style scoped>
.rich-content :deep(p) {
  margin-bottom: 1rem;
}
.rich-content :deep(ul),
.rich-content :deep(ol) {
  margin-bottom: 1rem;
  padding-left: 1.5rem;
}
.rich-content :deep(a) {
  color: #0d9488;
  text-decoration: underline;
}
</style>
