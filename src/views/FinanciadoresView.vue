<script setup>
import { onMounted, ref } from 'vue'
import { API_BASE } from '@/config'

const obrasSociales = ref([])
const loading = ref(true)
const error = ref('')
const abiertaId = ref(null)

function toggle(id) {
  abiertaId.value = abiertaId.value === id ? null : id
}

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
      <h1 class="font-title text-3xl/[1] md:text-[53px]/[1] font-semibold tracking-normal text-gray-800 mt-4 mb-4">Financiadores</h1>
      <p class="text-gray-600 text-base md:text-lg leading-relaxed mb-12">Obras Sociales y prepagas con las que trabajamos. Elegí la tuya para ver sus planes.</p>

      <p v-if="loading" class="text-gray-500">Cargando...</p>
      <p v-else-if="error" class="text-red-600">{{ error }}</p>
      <p v-else-if="!obrasSociales.length" class="text-gray-500">Todavía no hay Obras Sociales publicadas.</p>

      <div v-else class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        <div v-for="os in obrasSociales" :key="os.id" class="bg-white border border-gray-200 rounded-xl shadow-sm overflow-hidden">
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
