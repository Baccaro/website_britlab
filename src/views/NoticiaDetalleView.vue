<script setup>
import { onMounted, ref } from 'vue'
import { API_BASE } from '@/config'

const props = defineProps({ id: { type: [String, Number], required: true } })

const noticia = ref(null)
const loading = ref(true)
const error = ref('')

function formatearFecha(fecha) {
  if (!fecha) return ''
  return new Date(`${fecha}T00:00:00`).toLocaleDateString('es-AR', { day: 'numeric', month: 'long', year: 'numeric' })
}

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
    <p v-if="loading" class="text-gray-500">Cargando noticia...</p>
    <div v-else-if="error">
      <p class="text-red-600 mb-6">{{ error }}</p>
      <a href="/noticias" class="text-brit-teal text-sm font-semibold hover:underline">← Volver a noticias</a>
    </div>
    <article v-else>
      <a href="/noticias" class="text-brit-teal text-sm font-semibold hover:underline mb-8 inline-block">← Volver a noticias</a>
      <span class="text-brit-teal text-xs font-bold uppercase tracking-wider block">{{ noticia.categoria }}</span>
      <h1 class="text-3xl md:text-5xl font-bold text-gray-800 mt-4 mb-4 leading-tight">{{ noticia.titulo }}</h1>
      <time class="text-gray-400 text-sm font-medium block mb-8" :datetime="noticia.fecha">{{ formatearFecha(noticia.fecha) }}</time>
      <div v-if="noticia.tiene_imagen" class="w-full aspect-[16/9] bg-gray-100 rounded-2xl overflow-hidden mb-10">
        <img :src="`${API_BASE}/noticias/${noticia.id}/imagen`" :alt="noticia.titulo" class="w-full h-full object-cover">
      </div>
      <p class="text-gray-600 text-lg leading-relaxed mb-8">{{ noticia.descripcion }}</p>
      <div class="rich-content text-gray-700 leading-relaxed" v-html="noticia.cuerpo"></div>
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
