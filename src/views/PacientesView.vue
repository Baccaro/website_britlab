<script setup>
const secciones = [
  { href: '/pacientes/indicaciones', titulo: 'Indicaciones', descripcion: 'Preparación, muestras y días de demora de tu estudio.' },
  { href: '/pacientes/obras-sociales', titulo: 'Obras Sociales', descripcion: 'Cobertura y requisitos de autorización.' },
  { href: '/pacientes/financiadores', titulo: 'Financiadores', descripcion: 'Obras Sociales y prepagas con las que trabajamos.' },
  { href: '/pacientes/contacto-facturacion', titulo: 'Contacto de facturación', descripcion: 'Consultas sobre comprobantes y pagos.' },
  { href: '/pacientes/turnos', titulo: 'Turnos', descripcion: 'Cómo solicitar tu turno.' },
  { href: '/pacientes/contacto', titulo: 'Contacto', descripcion: 'Dirección, teléfono y email del laboratorio.' },
]
</script>

<template>
  <section class="w-full max-w-6xl mx-auto px-6 md:px-12 py-24">
    <span class="text-brit-teal text-xs font-bold uppercase tracking-wider">Pacientes</span>
    <h1 class="font-title text-3xl/[1] md:text-[53px]/[1] font-semibold tracking-normal text-gray-800 mt-4 mb-6 max-w-3xl">Todo lo que necesitás antes y después de tu estudio.</h1>
    <p class="text-gray-500 text-lg max-w-2xl leading-relaxed mb-12">Consultá preparaciones, resultados, turnos y respuestas a las preguntas más frecuentes.</p>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
      <a v-for="s in secciones" :key="s.href" :href="s.href"
        class="bg-white border border-gray-200 hover:border-brit-teal rounded-xl p-6 transition-colors shadow-sm">
        <p class="font-bold text-gray-800 mb-2">{{ s.titulo }}</p>
        <p class="text-gray-500 text-sm leading-relaxed">{{ s.descripcion }}</p>
      </a>
    </div>
  </section>
</template>
