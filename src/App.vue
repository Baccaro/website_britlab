<script setup>
import { computed, onBeforeUnmount, onMounted, ref } from 'vue'
import HomeView from './views/HomeView.vue'
import InstitucionalView from './views/InstitucionalView.vue'
import NoticiasView from './views/NoticiasView.vue'
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

const currentView = computed(() => routes[currentPath.value] || ServiciosView)

function updatePath() {
  currentPath.value = window.location.pathname
}

onMounted(() => window.addEventListener('popstate', updatePath))
onBeforeUnmount(() => window.removeEventListener('popstate', updatePath))
</script>

<template>
  <component :is="currentView" />
</template>
