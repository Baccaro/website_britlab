<script setup>
import { computed, onBeforeUnmount, onMounted, ref } from 'vue'
import HomeView from './views/HomeView.vue'
import InstitucionalView from './views/InstitucionalView.vue'
import NoticiasView from './views/NoticiasView.vue'
import NoticiaDetalleView from './views/NoticiaDetalleView.vue'
import PacientesView from './views/PacientesView.vue'
import ServiciosView from './views/ServiciosView.vue'

const currentPath = ref(window.location.pathname)

const routes = {
  '/': HomeView,
  '/institucional': InstitucionalView,
  '/servicios': ServiciosView,
  '/noticias': NoticiasView,
  '/pacientes': PacientesView,
}

// "/noticias/:id" no tiene una entrada fija en "routes" (no hay vue-router en
// este proyecto): se matchea a mano y el id se pasa como prop a la vista de
// detalle.
const noticiaDetalleMatch = computed(() => currentPath.value.match(/^\/noticias\/(\d+)$/))

const currentView = computed(() => {
  if (noticiaDetalleMatch.value) return NoticiaDetalleView
  return routes[currentPath.value] || ServiciosView
})

const currentViewProps = computed(() => {
  if (noticiaDetalleMatch.value) return { id: noticiaDetalleMatch.value[1] }
  return {}
})

function updatePath() {
  currentPath.value = window.location.pathname
}

onMounted(() => window.addEventListener('popstate', updatePath))
onBeforeUnmount(() => window.removeEventListener('popstate', updatePath))
</script>

<template>
  <component :is="currentView" v-bind="currentViewProps" />
</template>
