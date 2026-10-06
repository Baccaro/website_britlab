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
      <h1 class="text-4xl md:text-6xl font-bold text-gray-800 mt-4 mb-6">Artículos de expertos</h1>
      <p class="text-gray-500 text-lg leading-relaxed">Información y novedades de nuestros especialistas para cuidar tu salud.</p>
    </header>

    <p v-if="loading" class="text-gray-500">Cargando noticias...</p>
    <p v-else-if="error" class="text-red-600">{{ error }}</p>
    <p v-else-if="!noticias.length" class="text-gray-500">Todavía no hay noticias publicadas.</p>

    <section v-else aria-label="Artículos de expertos" class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <article v-for="noticia in noticias" :key="noticia.id" class="flex flex-col">
        <a :href="`/noticias/${noticia.id}`" class="w-full aspect-[4/3] bg-gray-100 relative mb-4 rounded-lg overflow-hidden block">
          <img v-if="noticia.tiene_imagen" :src="`${API_BASE}/noticias/${noticia.id}/imagen`" :alt="noticia.titulo" class="w-full h-full object-cover">
          <span class="absolute bottom-3 left-3 bg-white text-brit-teal text-[10px] font-bold px-3 py-1 rounded-full shadow-sm">{{ noticia.categoria }}</span>
        </a>
        <time class="text-gray-400 text-xs mb-2 font-medium" :datetime="noticia.fecha">{{ formatearFecha(noticia.fecha) }}</time>
        <h2 class="text-lg font-bold text-gray-700 mb-2 leading-snug">{{ noticia.titulo }}</h2>
        <p class="text-gray-500 text-sm mb-3 leading-relaxed">{{ noticia.descripcion }}</p>
        <a :href="`/noticias/${noticia.id}`" class="text-brit-teal text-sm font-semibold hover:underline mt-auto">Leer más <span aria-hidden="true">→</span></a>
      </article>
    </section>
  </main>
</template>
