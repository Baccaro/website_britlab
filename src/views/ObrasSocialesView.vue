<script setup>
import { computed, onMounted, ref } from 'vue'
import { API_BASE } from '@/config'

const obrasSociales = ref([])
const loading = ref(true)
const error = ref('')
const abiertaId = ref(null)
const query = ref('')

function toggle(id) {
  abiertaId.value = abiertaId.value === id ? null : id
}

function normalizar(texto) {
  return (texto || '')
    .toString()
    .toLowerCase()
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
}

const obrasSocialesFiltradas = computed(() => {
  const texto = normalizar(query.value.trim())
  if (!texto) return obrasSociales.value
  return obrasSociales.value.filter((os) => {
    if (normalizar(os.nombre).includes(texto)) return true
    return (os.planes || []).some((plan) => normalizar(plan).includes(texto))
  })
})

onMounted(async () => {
  try {
    const res = await fetch(`${API_BASE}/obras-sociales-publico`)
    if (!res.ok) throw new Error('No se pudieron cargar las Obras Sociales')
    obrasSociales.value = await res.json()
  } catch (err) {
    error.value = 'No pudimos cargar la lista de Obras Sociales en este momento.'
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <section class="w-full bg-gray-50 py-24 px-6 md:px-12 min-h-[600px]">
    <div class="max-w-6xl mx-auto">
      <span class="text-brit-teal text-xs font-bold uppercase tracking-wider">Pacientes</span>
      <h1 class="font-title text-3xl/[1] md:text-[62px]/[1] font-semibold tracking-normal text-brit-teal mt-4 mb-4">Obras Sociales</h1>
      <p class="text-gray-600 text-base md:text-lg leading-relaxed mb-8">Trabajamos con las principales Obras Sociales y prepagas de la región. Buscá por nombre de Obra Social o de plan para ver su cobertura.</p>

      <div class="relative mb-10">
        <div class="absolute inset-y-0 left-4 flex items-center pointer-events-none">
          <svg class="w-5 h-5 text-brit-teal" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
          </svg>
        </div>
        <input v-model="query" type="text" placeholder="Ej: Swiss Medical, OSDE 210, PAMI..."
          class="input-search w-full py-4 pl-12 pr-4 border-2 border-brit-teal rounded-full text-gray-800 focus:outline-none focus:ring-2 focus:ring-brit-teal-dark bg-white font-medium shadow-sm" />
      </div>

      <p v-if="loading" class="text-gray-500">Cargando...</p>
      <p v-else-if="error" class="text-red-600">{{ error }}</p>
      <p v-else-if="!obrasSociales.length" class="text-gray-500">Todavía no hay Obras Sociales publicadas.</p>
      <p v-else-if="!obrasSocialesFiltradas.length" class="text-gray-500">No encontramos Obras Sociales ni planes que coincidan con "{{ query }}".</p>

      <div v-else class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        <div v-for="os in obrasSocialesFiltradas" :key="os.id" class="bg-white border border-gray-200 rounded-xl shadow-sm overflow-hidden">
          <button @click="toggle(os.id)" class="w-full text-left">
            <div class="aspect-square w-full bg-gray-50 flex items-center justify-center p-8">
              <img v-if="os.tiene_imagen" :src="`${API_BASE}/obras-sociales/${os.id}/imagen`" :alt="os.nombre"
                class="max-w-full max-h-full object-contain" />
            </div>
            <div class="px-4 py-4 text-center border-t border-gray-100">
              <p class="font-bold text-gray-800">{{ os.nombre }}</p>
              <p class="text-gray-400 text-xs mt-1">{{ os.planes.length }} plan{{ os.planes.length === 1 ? '' : 'es' }}</p>
              <span aria-hidden="true" class="text-brit-teal text-xs inline-block mt-1 transition-transform" :class="{ 'rotate-180': abiertaId === os.id }">▾</span>
            </div>
          </button>

          <div v-if="abiertaId === os.id" class="px-4 pb-5 border-t border-gray-100 pt-4">
            <a v-if="os.pagina_web" :href="os.pagina_web" target="_blank" rel="noopener noreferrer"
              class="inline-flex items-center gap-1 text-brit-teal text-sm font-semibold hover:underline mb-4">
              Visitar sitio <span aria-hidden="true">↗</span>
            </a>
            <p v-if="!os.planes.length" class="text-gray-400 text-sm">Sin planes disponibles.</p>
            <template v-else>
              <h3 class="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">Planes de {{ os.nombre }}</h3>
              <ul class="space-y-1.5 text-sm text-gray-700">
                <li v-for="(p, idx) in os.planes" :key="idx">{{ p }}</li>
              </ul>
            </template>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
