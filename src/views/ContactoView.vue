<script setup>
import ContactForm from '@/components/ContactForm.vue'

const telefonosPorArea = [
  { area: 'Conmutador / Recepción', telefono: '341 420 5500' },
  { area: 'Turnos', telefono: '341 420 5500 (interno Turnos)' },
  { area: 'Facturación', telefono: '341 420 5500 (interno Facturación)' },
  { area: 'Atención técnica (laboratorios y profesionales)', telefono: '341 420 5500 (interno Atención Técnica)' },
]

const emails = [
  { label: 'General', email: 'info@britlab.com.ar' },
  { label: 'Turnos', email: 'turnos@britlab.com.ar' },
  { label: 'Facturación', email: 'facturacion@britlab.com.ar' },
  { label: 'Atención técnica', email: 'atenciontecnica@britlab.com.ar' },
]

const horarios = [
  { dia: 'Lunes a Viernes', horario: '7:00 a 19:00 hs' },
  { dia: 'Sábados', horario: '7:30 a 12:00 hs' },
  { dia: 'Domingos y feriados', horario: 'Cerrado' },
]

const redes = [
  { nombre: 'Instagram', href: 'https://www.instagram.com/' },
  { nombre: 'Facebook', href: 'https://www.facebook.com/' },
  { nombre: 'LinkedIn', href: 'https://www.linkedin.com/' },
  { nombre: 'YouTube', href: 'https://www.youtube.com/' },
]
</script>

<template>
  <section class="w-full bg-white py-24 px-6 md:px-12 min-h-[600px]">
    <div class="max-w-6xl mx-auto">
      <span class="text-brit-teal text-xs font-bold uppercase tracking-wider">Pacientes</span>
      <h1 class="font-title text-3xl/[1] md:text-[53px]/[1] font-semibold tracking-normal text-gray-800 mt-4 mb-6">Contacto</h1>
      <p class="text-gray-600 text-base md:text-lg leading-relaxed mb-12 max-w-2xl">Estamos para ayudarte. Elegí el medio que prefieras o escribinos usando el formulario.</p>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 mb-16">
        <!-- Dirección y mapa -->
        <div>
          <h2 class="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">Dirección</h2>
          <p class="text-gray-800 font-semibold mb-4">Paraguay 40, S2000 Rosario, Santa Fe.</p>
          <div class="rounded-xl overflow-hidden border border-gray-200 h-64">
            <iframe
              title="Mapa: Paraguay 40, Rosario"
              class="w-full h-full"
              style="border:0"
              loading="lazy"
              referrerpolicy="no-referrer-when-downgrade"
              src="https://www.google.com/maps?q=Paraguay+40,+S2000+Rosario,+Santa+Fe&output=embed">
            </iframe>
          </div>
        </div>

        <!-- Teléfonos, emails y horario -->
        <div class="space-y-8">
          <div>
            <h2 class="text-xs font-bold text-gray-400 uppercase tracking-wider mb-3">Teléfonos por área</h2>
            <ul class="space-y-2">
              <li v-for="t in telefonosPorArea" :key="t.area" class="flex justify-between gap-4 text-sm">
                <span class="text-gray-500">{{ t.area }}</span>
                <a :href="`tel:+54${t.telefono.replace(/\\D/g, '').slice(0, 10)}`" class="text-gray-800 font-semibold hover:text-brit-teal text-right">{{ t.telefono }}</a>
              </li>
            </ul>
          </div>

          <div>
            <h2 class="text-xs font-bold text-gray-400 uppercase tracking-wider mb-3">Emails</h2>
            <ul class="space-y-2">
              <li v-for="e in emails" :key="e.email" class="flex justify-between gap-4 text-sm">
                <span class="text-gray-500">{{ e.label }}</span>
                <a :href="`mailto:${e.email}`" class="text-brit-teal font-semibold hover:underline text-right">{{ e.email }}</a>
              </li>
            </ul>
          </div>

          <div>
            <h2 class="text-xs font-bold text-gray-400 uppercase tracking-wider mb-3">Horario de atención</h2>
            <ul class="space-y-2">
              <li v-for="h in horarios" :key="h.dia" class="flex justify-between gap-4 text-sm">
                <span class="text-gray-500">{{ h.dia }}</span>
                <span class="text-gray-800 font-semibold text-right">{{ h.horario }}</span>
              </li>
            </ul>
          </div>

          <div>
            <h2 class="text-xs font-bold text-gray-400 uppercase tracking-wider mb-3">Seguinos</h2>
            <div class="flex gap-4">
              <a v-for="r in redes" :key="r.nombre" :href="r.href" target="_blank" rel="noopener noreferrer"
                class="text-gray-500 hover:text-brit-teal text-sm font-semibold">{{ r.nombre }}</a>
            </div>
          </div>
        </div>
      </div>

      <h2 class="text-xl font-bold text-gray-800 mb-4">Formulario de contacto</h2>
      <ContactForm />
    </div>
  </section>
</template>
