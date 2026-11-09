<script setup>
import { ref, watch } from 'vue'
import { API_BASE } from '@/config'

const query = ref('')
const resultados = ref([])
const buscando = ref(false)
const errorBusqueda = ref('')

const seleccionado = ref(null)
const cargandoDetalle = ref(false)
const errorDetalle = ref('')

let debounceId = null
watch(query, (valor) => {
  seleccionado.value = null
  errorDetalle.value = ''
  if (debounceId) clearTimeout(debounceId)
  const texto = valor.trim()
  if (texto.length < 2) {
    resultados.value = []
    errorBusqueda.value = ''
    buscando.value = false
    return
  }
  buscando.value = true
  debounceId = setTimeout(async () => {
    try {
      const res = await fetch(`${API_BASE}/indicaciones-publico/buscar?q=${encodeURIComponent(texto)}`)
      if (!res.ok) throw new Error('No se pudo buscar')
      resultados.value = await res.json()
      errorBusqueda.value = ''
    } catch (err) {
      resultados.value = []
      errorBusqueda.value = 'No pudimos buscar en este momento. Probá de nuevo en un rato.'
    } finally {
      buscando.value = false
    }
  }, 350)
})

async function elegirEstudio(id) {
  cargandoDetalle.value = true
  errorDetalle.value = ''
  try {
    const res = await fetch(`${API_BASE}/indicaciones-publico/${id}`)
    if (!res.ok) throw new Error('No se pudo cargar el estudio')
    seleccionado.value = await res.json()
  } catch (err) {
    seleccionado.value = null
    errorDetalle.value = 'No pudimos cargar el detalle de este estudio. Probá de nuevo en un rato.'
  } finally {
    cargandoDetalle.value = false
  }
}

function volverABuscar() {
  seleccionado.value = null
  errorDetalle.value = ''
}

function textoDemora(dias) {
  if (dias === null || dias === undefined) return null
  if (dias === 0) return 'El mismo día'
  return dias === 1 ? '1 día hábil' : `${dias} días hábiles`
}
</script>

<template>
  <section class="w-full bg-gray-50 py-24 px-6 md:px-12 min-h-[600px]">
    <div class="max-w-4xl mx-auto">
      <span class="text-brit-teal text-xs font-bold uppercase tracking-wider">Pacientes</span>
      <h1 class="font-title text-3xl/[1] md:text-[53px]/[1] font-semibold tracking-normal text-gray-800 mt-4 mb-4">Indicaciones para tu estudio</h1>
      <p class="text-gray-600 text-base md:text-lg leading-relaxed mb-8">Buscá tu estudio por nombre para ver la preparación, las muestras necesarias y los días de demora.</p>

      <div class="relative mb-8">
        <div class="absolute inset-y-0 left-4 flex items-center pointer-events-none">
          <svg class="w-5 h-5 text-brit-teal" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
          </svg>
        </div>
        <input v-model="query" type="text" placeholder="Ej: Hemograma, Glucemia, TSH..."
          class="input-search w-full py-4 pl-12 pr-4 border-2 border-brit-teal rounded-full text-gray-800 focus:outline-none focus:ring-2 focus:ring-brit-teal-dark bg-white font-medium shadow-sm" />
      </div>

      <!-- Detalle del estudio elegido -->
      <div v-if="seleccionado" class="bg-white rounded-2xl shadow-lg p-8 md:p-10">
        <button @click="volverABuscar" class="text-brit-teal text-sm font-semibold hover:underline mb-6 inline-flex items-center gap-1">
          <span aria-hidden="true">←</span> Volver a la búsqueda
        </button>
        <h2 class="text-2xl md:text-3xl font-bold text-gray-800 mb-1">{{ seleccionado.nombre }}</h2>
        <p class="text-gray-400 text-sm mb-8" v-if="seleccionado.nemonico || seleccionado.laboratorio">
          <span v-if="seleccionado.nemonico">Nemónico: {{ seleccionado.nemonico }}</span>
          <span v-if="seleccionado.nemonico && seleccionado.laboratorio"> · </span>
          <span v-if="seleccionado.laboratorio">Procesado en {{ seleccionado.laboratorio }}</span>
        </p>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
          <div class="bg-gray-50 rounded-xl p-5" v-if="seleccionado.metodo">
            <h3 class="text-xs font-bold text-gray-400 uppercase tracking-wider mb-1">Método</h3>
            <p class="text-gray-700">{{ seleccionado.metodo }}</p>
          </div>
          <div class="bg-gray-50 rounded-xl p-5" v-if="textoDemora(seleccionado.dias_demora)">
            <h3 class="text-xs font-bold text-gray-400 uppercase tracking-wider mb-1">Días de demora</h3>
            <p class="text-gray-700">{{ textoDemora(seleccionado.dias_demora) }}</p>
          </div>
        </div>

        <div class="mb-8" v-if="seleccionado.preanalitico_descripcion">
          <h3 class="text-sm font-bold text-gray-800 uppercase tracking-wider mb-2">Preanalítico</h3>
          <div class="text-gray-600 leading-relaxed rich-display" v-html="seleccionado.preanalitico_descripcion"></div>
        </div>

        <div class="mb-8" v-if="seleccionado.indicaciones_pacientes">
          <h3 class="text-sm font-bold text-gray-800 uppercase tracking-wider mb-2">Indicaciones para el paciente</h3>
          <div class="text-gray-600 leading-relaxed rich-display" v-html="seleccionado.indicaciones_pacientes"></div>
        </div>

        <div v-if="seleccionado.muestras && seleccionado.muestras.length">
          <h3 class="text-sm font-bold text-gray-800 uppercase tracking-wider mb-3">Muestras</h3>
          <div class="space-y-4">
            <div v-for="(m, idx) in seleccionado.muestras" :key="m.id" class="border border-gray-200 rounded-xl p-5">
              <p class="font-bold text-gray-800 mb-2">Muestra {{ idx + 1 }}: {{ m.tipo_muestra || 'Sin especificar' }}</p>
              <dl class="grid grid-cols-1 sm:grid-cols-2 gap-x-6 gap-y-1 text-sm">
                <div class="flex justify-between gap-4 py-1" v-if="m.volumen">
                  <dt class="text-gray-400">Volumen</dt>
                  <dd class="text-gray-700 font-medium">{{ m.volumen }} {{ m.unidad_medida || '' }}</dd>
                </div>
                <div class="flex justify-between gap-4 py-1" v-if="m.aditivo">
                  <dt class="text-gray-400">Aditivo</dt>
                  <dd class="text-gray-700 font-medium">{{ m.aditivo }}</dd>
                </div>
                <div class="flex justify-between gap-4 py-1" v-if="m.recipiente">
                  <dt class="text-gray-400">Recipiente</dt>
                  <dd class="text-gray-700 font-medium">{{ m.recipiente }}</dd>
                </div>
                <div class="flex justify-between gap-4 py-1" v-if="m.conservacion">
                  <dt class="text-gray-400">Conservación</dt>
                  <dd class="text-gray-700 font-medium">{{ m.conservacion }}</dd>
                </div>
                <div class="flex justify-between gap-4 py-1" v-if="m.modalidad_recoleccion">
                  <dt class="text-gray-400">Modalidad</dt>
                  <dd class="text-gray-700 font-medium">{{ m.modalidad_recoleccion }}</dd>
                </div>
                <div class="flex justify-between gap-4 py-1" v-if="m.tecnica_recoleccion">
                  <dt class="text-gray-400">Técnica</dt>
                  <dd class="text-gray-700 font-medium">{{ m.tecnica_recoleccion }}</dd>
                </div>
                <div class="flex justify-between gap-4 py-1" v-if="m.condicion_especial">
                  <dt class="text-gray-400">Condición especial</dt>
                  <dd class="text-gray-700 font-medium">{{ m.condicion_especial }}</dd>
                </div>
                <div class="flex justify-between gap-4 py-1" v-if="m.prioridad_envio">
                  <dt class="text-gray-400">Prioridad de envío</dt>
                  <dd class="text-gray-700 font-medium">{{ m.prioridad_envio }}</dd>
                </div>
              </dl>
              <p class="text-gray-600 text-sm mt-2" v-if="m.observacion">{{ m.observacion }}</p>

              <div v-if="m.alternativas && m.alternativas.length" class="mt-4 pt-4 border-t border-gray-100 space-y-3">
                <div v-for="(a, aidx) in m.alternativas" :key="a.id">
                  <span class="inline-block bg-brit-teal/10 text-brit-teal text-xs font-bold px-3 py-1 rounded-full mb-2">Alternativa {{ aidx + 1 }}: {{ a.tipo_muestra || 'Sin especificar' }}</span>
                  <dl class="grid grid-cols-1 sm:grid-cols-2 gap-x-6 gap-y-1 text-sm">
                    <div class="flex justify-between gap-4 py-1" v-if="a.volumen">
                      <dt class="text-gray-400">Volumen</dt>
                      <dd class="text-gray-700 font-medium">{{ a.volumen }} {{ a.unidad_medida || '' }}</dd>
                    </div>
                    <div class="flex justify-between gap-4 py-1" v-if="a.aditivo">
                      <dt class="text-gray-400">Aditivo</dt>
                      <dd class="text-gray-700 font-medium">{{ a.aditivo }}</dd>
                    </div>
                    <div class="flex justify-between gap-4 py-1" v-if="a.recipiente">
                      <dt class="text-gray-400">Recipiente</dt>
                      <dd class="text-gray-700 font-medium">{{ a.recipiente }}</dd>
                    </div>
                    <div class="flex justify-between gap-4 py-1" v-if="a.conservacion">
                      <dt class="text-gray-400">Conservación</dt>
                      <dd class="text-gray-700 font-medium">{{ a.conservacion }}</dd>
                    </div>
                  </dl>
                </div>
              </div>
            </div>
          </div>
        </div>
        <p class="text-gray-500 text-sm" v-else>Para este estudio no hay muestras cargadas.</p>
      </div>

      <!-- Resultados de la búsqueda -->
      <template v-else>
        <p v-if="cargandoDetalle" class="text-gray-500">Cargando el detalle del estudio...</p>
        <p v-else-if="errorDetalle" class="text-red-600">{{ errorDetalle }}</p>
        <p v-else-if="buscando" class="text-gray-500">Buscando...</p>
        <p v-else-if="errorBusqueda" class="text-red-600">{{ errorBusqueda }}</p>
        <p v-else-if="query.trim().length >= 2 && !resultados.length" class="text-gray-500">No encontramos estudios que coincidan con "{{ query }}".</p>

        <div v-if="!cargandoDetalle && !errorDetalle && resultados.length" class="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <button v-for="r in resultados" :key="r.id" @click="elegirEstudio(r.id)"
            class="text-left bg-white border border-gray-200 hover:border-brit-teal rounded-xl p-5 transition-colors shadow-sm">
            <p class="font-bold text-gray-800 mb-1">{{ r.nombre }}</p>
            <p class="text-gray-400 text-xs" v-if="r.nemonico || r.laboratorio">
              <span v-if="r.nemonico">{{ r.nemonico }}</span>
              <span v-if="r.nemonico && r.laboratorio"> · </span>
              <span v-if="r.laboratorio">{{ r.laboratorio }}</span>
            </p>
          </button>
        </div>
      </template>
    </div>
  </section>
</template>
