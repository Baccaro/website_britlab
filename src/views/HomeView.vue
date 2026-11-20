<script setup>
const services = [
  {
    image: '/images/turnos-obras-sociales.png',
    label: 'Servicios / Pacientes',
    title: 'Turnos Online y Obras Sociales',
    text: 'Para su mejor atención puede solicitar el turno de forma online desde aquí. Consulte con todas las obras sociales que trabajamos.',
    reverse: false,
  },
  {
    image: '/images/extraccion-domicilio.png',
    label: 'Servicios / Comodidad',
    title: 'Extracción a domicilio y Resultados',
    text: 'Realizamos una gran cantidad de estudios a domicilio. Para su mejor atención puede solicitar el turno de forma online desde aquí y recibir sus resultados por email.',
    reverse: true,
  },
  {
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDq_3XZ55pskuWAsPJK4lJjIPycDhwYSksfzsC6s4A1EJyKJ4twYOK7rBZ1nOjsZpip_GbEeX2srImRotWH3jm1GjwMLeqyc2oXCZHbC5nDpLW0j5HhooAm0Bb_KO6UPknI3ri0EuBqoOTFv6HE8FBLYGdekjqFZoS0jGr2xsvkYN-YcdVFboJfws1d8wdv71Ckmq5RRnvUNE57okAjUaeCT-Y2xnIfNzfklwl6INSyzAJ4Y8TsHicJSBmNgyaqS-AIfO4',
    label: 'Servicios / Información',
    title: 'Preparaciones y Mis Estudios',
    text: 'Identifique su estudio y acceda a la información de preparación. Acceda al instante a todos sus estudios realizados en nuestro laboratorio.',
    reverse: false,
  },
]

</script>

<template>
  <div class="w-full">
    <section class="w-full max-w-6xl mx-auto px-6 md:px-12 pt-32 pb-16 mt-12">
      <div class="flex flex-col md:flex-row items-center gap-12">
        <div class="w-full md:w-1/2 pr-0 md:pr-12">
          <span class="text-brit-teal text-xs font-bold uppercase tracking-wider">Inicio</span>
          <h2 class="font-title text-3xl/[1] md:text-[34px]/[1] font-semibold tracking-normal text-brit-teal mb-6 mt-4">Soluciones de<br>alta complejidad.</h2>
          <h3 class="text-lg font-bold text-gray-600 mb-4">Las respuestas correctas, desde el principio.</h3>
          <p class="text-gray-600 text-sm md:text-base leading-relaxed">La eficacia del tratamiento depende del diagnóstico correcto. Nuestros expertos diagnostican y tratan los problemas médicos más complicados.</p>
        </div>
        <div class="w-full md:w-1/2 h-[300px] md:h-[400px] overflow-hidden shadow-lg">
          <img alt="Soluciones de alta complejidad" class="w-full h-full object-cover" src="/soluciones.png">
        </div>
      </div>
    </section>

    <section class="w-full max-w-6xl mx-auto px-6 md:px-12 py-16 space-y-24">
      <div v-for="service in services" :key="service.title" :class="['relative flex flex-col items-center', service.reverse ? 'md:flex-row-reverse' : 'md:flex-row']">
        <div class="w-full md:w-2/3 h-64 md:h-[400px] overflow-hidden shadow-lg bg-gray-100">
          <img :alt="service.title" class="w-full h-full object-cover" :src="service.image">
        </div>
        <div :class="['w-full md:w-1/2 bg-white p-8 md:p-12 shadow-xl md:absolute md:top-1/2 md:-translate-y-1/2 z-10 mt-[-40px] md:mt-0', service.reverse ? 'md:left-0' : 'md:right-0']">
          <span class="text-brit-teal text-xs font-bold uppercase tracking-wider mb-2 block">{{ service.label }}</span>
          <h3 class="text-2xl md:text-3xl font-bold text-gray-800 mb-4">{{ service.title }}</h3>
          <p class="text-gray-600 mb-6 leading-relaxed">{{ service.text }}</p>
        </div>
      </div>
    </section>

    <section class="w-full py-16"><div class="w-full h-[300px] md:h-[400px] lg:h-[500px] overflow-hidden"><img alt="Laboratorio Sanatorio Británico" class="w-full h-full object-cover" src="/lab_horizontal.png"></div></section>
  </div>
</template>
