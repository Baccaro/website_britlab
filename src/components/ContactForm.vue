<script setup>
import { ref } from 'vue'
import { API_BASE } from '@/config'

const props = defineProps({
  // Si se pasa, el formulario arranca con ese tipo de consulta y no muestra
  // el selector (para Contacto de facturación / Turnos, donde ya se sabe de
  // qué tipo es la consulta). En Contacto general no se pasa, y el visitante
  // elige entre los 4 tipos.
  tipoConsultaFijo: { type: String, default: null },
})

const TIPOS = [
  { value: 'general', label: 'Consulta general' },
  { value: 'turnos', label: 'Turnos' },
  { value: 'facturacion', label: 'Facturación' },
  { value: 'atencion_tecnica', label: 'Atención técnica' },
]

const form = ref({
  nombre: '',
  email: '',
  telefono: '',
  tipo_consulta: props.tipoConsultaFijo || 'general',
  mensaje: '',
})
const enviando = ref(false)
const enviado = ref(false)
const error = ref('')

async function enviar() {
  error.value = ''
  enviando.value = true
  try {
    const res = await fetch(`${API_BASE}/contacto`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(form.value),
    })
    if (!res.ok) throw new Error('No se pudo enviar')
    enviado.value = true
  } catch (err) {
    error.value = 'No pudimos enviar tu consulta en este momento. Probá de nuevo en un rato, o escribinos directamente por mail.'
  } finally {
    enviando.value = false
  }
}
</script>

<template>
  <div v-if="enviado" class="bg-brit-teal/10 border border-brit-teal/30 rounded-xl p-6 text-center">
    <p class="font-bold text-gray-800 mb-1">¡Gracias por tu mensaje!</p>
    <p class="text-gray-600 text-sm">Lo vamos a leer y responder a la brevedad.</p>
  </div>
  <form v-else @submit.prevent="enviar" class="space-y-4">
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
      <div>
        <label class="block text-xs font-semibold text-gray-600 mb-1">Nombre *</label>
        <input v-model="form.nombre" type="text" required
          class="w-full px-4 py-3 rounded-lg border border-gray-200 focus:outline-none focus:ring-2 focus:ring-brit-teal text-gray-800" />
      </div>
      <div>
        <label class="block text-xs font-semibold text-gray-600 mb-1">Email *</label>
        <input v-model="form.email" type="email" required
          class="w-full px-4 py-3 rounded-lg border border-gray-200 focus:outline-none focus:ring-2 focus:ring-brit-teal text-gray-800" />
      </div>
    </div>
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
      <div>
        <label class="block text-xs font-semibold text-gray-600 mb-1">Teléfono</label>
        <input v-model="form.telefono" type="tel"
          class="w-full px-4 py-3 rounded-lg border border-gray-200 focus:outline-none focus:ring-2 focus:ring-brit-teal text-gray-800" />
      </div>
      <div v-if="!tipoConsultaFijo">
        <label class="block text-xs font-semibold text-gray-600 mb-1">Tipo de consulta *</label>
        <select v-model="form.tipo_consulta" required
          class="w-full px-4 py-3 rounded-lg border border-gray-200 focus:outline-none focus:ring-2 focus:ring-brit-teal text-gray-800 bg-white">
          <option v-for="t in TIPOS" :key="t.value" :value="t.value">{{ t.label }}</option>
        </select>
      </div>
    </div>
    <div>
      <label class="block text-xs font-semibold text-gray-600 mb-1">Mensaje *</label>
      <textarea v-model="form.mensaje" rows="4" required
        class="w-full px-4 py-3 rounded-lg border border-gray-200 focus:outline-none focus:ring-2 focus:ring-brit-teal text-gray-800"></textarea>
    </div>
    <p v-if="error" class="text-red-600 text-sm">{{ error }}</p>
    <button :disabled="enviando" type="submit"
      class="bg-brit-teal hover:bg-brit-teal-dark text-white font-bold py-3 px-8 rounded-full transition-colors disabled:opacity-60">
      {{ enviando ? 'Enviando...' : 'Enviar mensaje' }}
    </button>
  </form>
</template>
