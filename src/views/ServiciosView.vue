<script setup>
import { ref } from 'vue'
import { API_BASE } from '@/config'

const cvSent = ref(false)
const cvSending = ref(false)
const cvError = ref('')
const cvForm = ref({ nombre_completo: '', email: '' })
const cvArchivo = ref(null)

function onCvArchivoChange(event) {
  cvArchivo.value = event.target.files[0] || null
}

const diagnosticAreas = [
  {
    name: 'Bioquímica Clínica',
    specialties: [
      'Química sanguínea',
      'Medio interno',
      'Hematología',
      'Endocrinología',
      'Inmunología',
      'Marcadores tumorales',
      'Monitoreo terapéutico de drogas',
      'Metabolismo',
    ],
  },
  {
    name: 'Microbiología',
    specialties: [
      'Bacteriología',
      'Virología',
      'Micología',
      'Parasitología',
      'Vigilancia epidemiológica institucional',
    ],
  },
  {
    name: 'Biología Molecular',
    specialties: [
      'Diagnóstico molecular de enfermedades infecciosas',
      'Estudios de enfermedades genéticas',
    ],
  },
]

async function submitCv() {
  cvError.value = ''
  if (!cvArchivo.value) {
    cvError.value = 'Adjuntá tu CV en PDF'
    return
  }
  cvSending.value = true
  try {
    const formData = new FormData()
    formData.append('nombre_completo', cvForm.value.nombre_completo)
    formData.append('email', cvForm.value.email)
    formData.append('archivo', cvArchivo.value)

    const res = await fetch(`${API_BASE}/cv`, { method: 'POST', body: formData })
    const data = await res.json().catch(() => ({}))
    if (!res.ok) {
      cvError.value = data.error || 'No se pudo enviar tu postulación. Probá de nuevo en unos minutos.'
      return
    }
    cvSent.value = true
    cvForm.value = { nombre_completo: '', email: '' }
    cvArchivo.value = null
  } catch (err) {
    cvError.value = 'No se pudo enviar tu postulación. Probá de nuevo en unos minutos.'
  } finally {
    cvSending.value = false
  }
}
</script>

<template>
  <div class="w-full bg-white">
    <section id="britlab" class="institutional-anchor max-w-6xl mx-auto px-6 md:px-12 py-24">
      <div class="grid gap-12 lg:grid-cols-[1.1fr_0.9fr] items-start">
        <div>
          <span class="text-brit-teal text-xs font-bold uppercase tracking-wider">Servicios / BritLAB</span>
          <h1 class="text-4xl md:text-6xl font-bold text-gray-800 mt-4 mb-8">Laboratorio del Sanatorio Británico</h1>
          <div class="space-y-5 text-gray-600 text-lg leading-relaxed">
            <p>BritLab brinda servicios de diagnóstico bioquímico para pacientes internados y ambulatorios, profesionales médicos y laboratorios derivantes.</p>
            <p>Integra diferentes áreas diagnósticas para brindar resultados confiables, seguros y oportunos, coordinados con los equipos asistenciales del Sanatorio Británico.</p>
          </div>
        </div>
        <div class="bg-gray-50 border-l-4 border-brit-teal p-8 rounded-r-2xl">
          <h2 class="text-2xl font-bold text-gray-800 mb-6">Áreas diagnósticas</h2>
          <div class="space-y-6">
            <section v-for="area in diagnosticAreas" :key="area.name" class="border-t border-gray-200 pt-5 first:border-0 first:pt-0">
              <h3 class="text-lg font-bold text-brit-teal mb-3">{{ area.name }}</h3>
              <ul class="grid grid-cols-1 sm:grid-cols-2 gap-x-6 gap-y-2 text-gray-600">
                <li v-for="specialty in area.specialties" :key="specialty" class="flex gap-2">
                  <span class="text-brit-teal" aria-hidden="true">•</span>{{ specialty }}
                </li>
              </ul>
            </section>
          </div>
        </div>
      </div>
    </section>

    <section id="tecnologia" class="institutional-anchor max-w-6xl mx-auto px-6 md:px-12 py-24">
      <div class="max-w-4xl">
        <span class="text-brit-teal text-xs font-bold uppercase tracking-wider">Servicios / Tecnología</span>
        <h2 class="text-4xl md:text-5xl font-bold text-gray-800 mt-4 mb-6">Tecnología e innovación</h2>
        <p class="text-gray-600 text-lg leading-relaxed">BritLab destaca dentro de su evolución reciente la incorporación de tecnología de vanguardia, nuevas capacidades diagnósticas y una infraestructura orientada al desarrollo tecnológico. La información recibida hasta el momento no detalla cuáles son concretamente los equipos y tecnologías que respaldan esta evolución.</p>
      </div>
    </section>

    <section id="docencia" class="institutional-anchor bg-gray-50 px-6 md:px-12 py-24">
      <div class="max-w-6xl mx-auto grid gap-12 md:grid-cols-2">
        <div>
          <span class="text-brit-teal text-xs font-bold uppercase tracking-wider">Servicios / Formación</span>
          <h2 class="text-4xl font-bold text-gray-800 mt-4 mb-6">Docencia e Investigación</h2>
          <p class="text-gray-600 text-lg leading-relaxed">BritLab mantiene una participación activa en actividades académicas, formación profesional e investigación.</p>
          <h3 class="text-xl font-bold text-brit-teal mt-8 mb-4">Docencia de grado y posgrado</h3>
          <p class="text-gray-600 leading-relaxed">BritLab participa como Institución Coformadora de la Práctica Profesional Obligatoria (PPO) de estudiantes de la Carrera de Bioquímica de la Facultad de Ciencias Bioquímicas y Farmacéuticas de la Universidad Nacional de Rosario.</p>
        </div>
        <div class="bg-white rounded-2xl p-8 shadow-sm space-y-8">
          <div><h3 class="text-xl font-bold text-gray-800 mb-3">Actividades</h3><ul class="list-disc pl-5 text-gray-600 space-y-2"><li>Pasantías para estudiantes avanzados de Bioquímica.</li><li>Rotaciones en Microbiología para profesionales en formación en Infectología.</li><li>Formación y capacitación profesional continua.</li></ul></div>
          <div><h3 class="text-xl font-bold text-gray-800 mb-3">Investigación y desarrollo</h3><p class="text-gray-600 mb-3">El Laboratorio informa participación en:</p><ul class="list-disc pl-5 text-gray-600 space-y-2"><li>Investigación clínica.</li><li>Validación de tecnologías y tests de diagnóstico in vitro (IVD).</li><li>Publicaciones científicas.</li><li>Presentaciones en congresos y reuniones científicas.</li></ul></div>
        </div>
      </div>
    </section>

    <section id="trabaja" class="institutional-anchor max-w-6xl mx-auto px-6 md:px-12 py-24">
      <div class="grid gap-12 lg:grid-cols-2 items-start">
        <div>
          <span class="text-brit-teal text-xs font-bold uppercase tracking-wider">Oportunidades</span>
          <h2 class="text-4xl md:text-5xl font-bold text-gray-800 mt-4 mb-6">Trabajá con Nosotros</h2>
          <p class="text-gray-600 text-lg leading-relaxed">Creemos en el desarrollo de equipos profesionales comprometidos con la ciencia, la innovación y la mejora continua.</p>
        </div>
        <form class="bg-gray-50 rounded-2xl p-8 space-y-5" @submit.prevent="submitCv" v-if="!cvSent">
          <h3 class="text-2xl font-bold text-gray-800">Enviá tu CV</h3>
          <input class="w-full rounded-lg border-gray-200 px-4 py-3" required type="text" placeholder="Nombre y apellido" v-model="cvForm.nombre_completo">
          <input class="w-full rounded-lg border-gray-200 px-4 py-3" required type="email" placeholder="Correo electrónico" v-model="cvForm.email">
          <input class="w-full rounded-lg border-gray-200 px-4 py-3" required type="file" accept=".pdf" @change="onCvArchivoChange">
          <p class="text-xs text-gray-500">Sólo se aceptan archivos PDF.</p>
          <p v-if="cvError" class="text-red-600 text-sm font-semibold" role="alert">{{ cvError }}</p>
          <button class="w-full bg-brit-teal hover:bg-brit-teal-dark text-white font-bold py-3 rounded-full transition-colors disabled:opacity-60" type="submit" :disabled="cvSending">{{ cvSending ? 'Enviando...' : 'Enviar CV' }}</button>
        </form>
        <div class="bg-gray-50 rounded-2xl p-8" v-else>
          <p class="text-brit-teal font-semibold text-lg" role="status">Gracias. Recibimos tu postulación.</p>
        </div>
      </div>
    </section>

    <section id="britgen" class="institutional-anchor bg-gray-50 px-6 md:px-12 py-24">
      <div class="max-w-6xl mx-auto grid gap-12 lg:grid-cols-[0.8fr_1.2fr] items-center">
        <div class="bg-white rounded-2xl shadow-sm p-8 md:p-12">
          <span class="text-brit-teal text-xs font-bold uppercase tracking-wider">Servicios / BritGEN</span>
          <h2 class="mt-4 mb-6">
            <img class="w-full max-w-[440px] h-auto" src="/images/britgen-logo.svg" alt="BritGen, Unidad de Medicina Genómica del Sanatorio Británico">
          </h2>
          <p class="text-gray-600 text-lg leading-relaxed mb-8">BritGen forma parte de la propuesta de servicios especializados de BritLab y constituye la Unidad de Medicina Genómica del Sanatorio Británico, orientada al estudio y aplicación de la genética y la genómica en diferentes áreas de la medicina.</p>
          <a class="inline-flex items-center bg-brit-teal hover:bg-brit-teal-dark text-white font-bold px-6 py-3 rounded-full transition-colors" href="https://britgen.com.ar/" target="_blank" rel="noopener noreferrer">Conocé BritGen <span class="ml-2" aria-hidden="true">→</span></a>
        </div>
        <div>
          <h3 class="text-2xl font-bold text-brit-teal mb-6">Principales áreas de trabajo</h3>
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div v-for="area in ['Oncogenética', 'Neurogenética', 'Cardiogenética', 'Farmacogenética', 'Genómica reproductiva', 'Genómica del bienestar']" :key="area" class="bg-white border border-gray-100 p-5 rounded-xl shadow-sm text-gray-700 font-semibold">{{ area }}</div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>
