<script setup>
import ContactForm from '@/components/ContactForm.vue'
</script>

<template>
  <section class="w-full bg-white py-24 px-6 md:px-12 min-h-[600px]">
    <div class="max-w-4xl mx-auto">
      <span class="text-brit-teal text-xs font-bold uppercase tracking-wider">Pacientes</span>
      <h1 class="font-title text-3xl/[1] md:text-[53px]/[1] font-semibold tracking-normal text-gray-800 mt-4 mb-6">Contacto de facturación</h1>
      <p class="text-gray-600 text-base md:text-lg leading-relaxed mb-10">Para consultas sobre facturación, comprobantes, notas de crédito o pagos a Obras Sociales, escribinos o llamanos directamente al área de facturación.</p>

      <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 mb-12">
        <div class="bg-gray-50 rounded-xl p-6">
          <h2 class="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">Email</h2>
          <a href="mailto:facturacion@britlab.com.ar" class="text-brit-teal font-semibold hover:underline">facturacion@britlab.com.ar</a>
        </div>
        <div class="bg-gray-50 rounded-xl p-6">
          <h2 class="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">Teléfono</h2>
          <a href="tel:+543414205500" class="text-gray-800 font-semibold hover:text-brit-teal">341 420 5500 (interno Facturación)</a>
        </div>
      </div>

      <h2 class="text-xl font-bold text-gray-800 mb-4">Escribinos</h2>
      <ContactForm tipo-consulta-fijo="facturacion" />
    </div>
  </section>
</template>
