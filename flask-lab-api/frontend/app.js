const { createApp, ref, computed, onMounted } = Vue;

// Opción especial del selector de derivante que muestra el catálogo completo de Estudios
const ALL_ESTUDIOS = '__ALL_ESTUDIOS__';

// Entidades del sidebar (todas menos 'estudios', que solo se accede desde
// el selector de "Indicaciones por Derivante" eligiendo "Todos los Estudios")
const SIDEBAR_ENTITY_KEYS = ['derivantes', 'metodos', 'muestras', 'preanaliticos', 'sectores', 'valores_estudio_sector', 'estudio_derivante'];

createApp({
  setup() {
    const API_BASE = '/api';

    // Estado Navegación / Vistas
    const currentView = ref('indicaciones'); // 'crud' | 'indicaciones'
    const currentEntityKey = ref('estudios');
    const sidebarCollapsed = ref(localStorage.getItem('britlab_sidebar_collapsed') === '1');

    // Estado CRUD Generico
    const items = ref([]);
    const loading = ref(false);
    const formData = ref({});
    const modalMode = ref('create');
    // Qué definición de entidad usa el modal actualmente abierto y adónde hay
    // que refrescar al guardar (puede diferir de currentEntityKey/currentView
    // cuando se edita un Estudio x Derivante desde la vista de Indicaciones).
    const modalEntityKey = ref('estudios');
    const modalContext = ref('crud'); // 'crud' | 'indicaciones'
    let modalInstance = null;

    const alert = ref({ message: '', type: 'success' });
    const pagination = ref({ page: 1, limit: 50, total: 0, total_pages: 1 });

    // Estado Específico Vista "Estudios por Derivante"
    const selectedDerivanteId = ref(null);
    const derivanteEstudios = ref([]);
    const loadingIndicaciones = ref(false);
    const searchQuery = ref('');

    const ESTADOS_REGISTRO = ['listo', 'pendiente', 'revisar', 'verificado'];
    const ESTADOS_PARIDAD = ['listo', 'pendiente', 'revisar', 'inactivo', 'discontinuado'];

    // Listas maestras cacheadas para armar los selectores de claves foráneas
    // (id_estudio, derivante_id, id_metodo, id_muestra, id_preanalitico, id_sector_laboratorio)
    const refData = ref({
      estudios: [], derivantes: [], metodos: [], muestras: [], preanaliticos: [], sectores: [], valores_estudio_sector: []
    });
    // Texto mostrado en los inputs con autocompletado (datalist) del modal, por campo
    const fkText = ref({});
    // Código Hexalis tipeado cuando se está creando un Estudio nuevo "al vuelo"
    // (el usuario escribió un Estudio que no existe en el picker)
    const newEstudioCodigo = ref('');

    const REF_LABEL = {
      estudios: e => `${e.codigo_hexalis} — ${e.descripcion}`,
      derivantes: d => d.descripcion,
      metodos: m => m.nombre,
      muestras: m => m.nombre,
      preanaliticos: p => p.nombre,
      sectores: s => s.nombre,
      valores_estudio_sector: v => {
        const est = refData.value.estudios.find(e => e.id === v.id_estudio);
        const nombre = est ? est.descripcion : `#${v.id_estudio}`;
        return `${nombre} - Posición Informe: ${v.posicion_informe}`;
      }
    };

    const fetchRefData = async () => {
      try {
        const [est, der, met, mue, pre, sec, ves] = await Promise.all([
          axios.get(`${API_BASE}/estudios`, { params: { limit: 3000 } }),
          axios.get(`${API_BASE}/derivantes`, { params: { limit: 500 } }),
          axios.get(`${API_BASE}/metodos`, { params: { limit: 1000 } }),
          axios.get(`${API_BASE}/muestras`, { params: { limit: 1000 } }),
          axios.get(`${API_BASE}/preanaliticos`, { params: { limit: 500 } }),
          axios.get(`${API_BASE}/sectores`, { params: { limit: 500 } }),
          axios.get(`${API_BASE}/valores-estudio-sector`, { params: { limit: 3000 } })
        ]);
        refData.value = {
          estudios: est.data.items,
          derivantes: der.data.items,
          metodos: met.data.items,
          muestras: mue.data.items,
          preanaliticos: pre.data.items,
          sectores: sec.data.items,
          valores_estudio_sector: ves.data.items
        };
      } catch (err) {
        showAlert('No se pudieron cargar los datos de referencia (FKs)', 'danger');
      }
    };

    // Etiqueta legible para un id de una tabla de referencia (usada en tablas y modal)
    const fkLabel = (refKey, id) => {
      if (!id) return null;
      const list = refData.value[refKey] || [];
      const item = list.find(x => x.id === id);
      return item ? REF_LABEL[refKey](item) : `#${id}`;
    };

    const onFkInput = (field, refKey, value) => {
      fkText.value[field] = value;
      const list = refData.value[refKey] || [];
      const match = list.find(o => REF_LABEL[refKey](o) === value);
      formData.value[field] = match ? match.id : null;
    };

    // Definición de Esquemas para ABMs (tablas del esquema nuevo)
    const entities = {
      estudios: {
        label: 'Estudios',
        singular: 'Estudio',
        endpoint: 'estudios',
        icon: 'bi-journal-medical',
        columns: [
          { field: 'id', label: 'ID' },
          { field: 'codigo_hexalis', label: 'Cód. Hexalis' },
          { field: 'descripcion', label: 'Descripción' }
        ],
        fields: [
          { field: 'codigo_hexalis', label: 'Código Hexalis', type: 'text', required: true },
          { field: 'descripcion', label: 'Descripción del Estudio', type: 'textarea', required: true }
        ]
      },
      derivantes: {
        label: 'Derivantes',
        singular: 'Derivante',
        endpoint: 'derivantes',
        icon: 'bi-building',
        columns: [
          { field: 'descripcion', label: 'Descripción' }
        ],
        fields: [
          { field: 'descripcion', label: 'Descripción / Laboratorio', type: 'text', required: true }
        ]
      },
      metodos: {
        label: 'Métodos',
        singular: 'Método',
        endpoint: 'metodos',
        icon: 'bi-box-seam',
        columns: [
          { field: 'nombre', label: 'Nombre' },
          { field: 'descripcion', label: 'Descripción' }
        ],
        fields: [
          { field: 'nombre', label: 'Nombre del Método', type: 'text', required: true },
          { field: 'descripcion', label: 'Descripción', type: 'textarea' }
        ]
      },
      muestras: {
        label: 'Muestras',
        singular: 'Muestra',
        endpoint: 'muestras',
        icon: 'bi-droplet',
        columns: [
          { field: 'nombre', label: 'Nombre' },
          { field: 'observacion', label: 'Observación' }
        ],
        fields: [
          { field: 'nombre', label: 'Nombre / Tipo de Muestra', type: 'text', required: true },
          { field: 'observacion', label: 'Observación', type: 'textarea' }
        ]
      },
      preanaliticos: {
        label: 'Pre-analíticos',
        singular: 'Pre-analítico',
        endpoint: 'preanaliticos',
        icon: 'bi-clipboard-pulse',
        columns: [
          { field: 'nombre', label: 'Nombre' },
          { field: 'descripcion', label: 'Descripción' }
        ],
        fields: [
          { field: 'nombre', label: 'Nombre', type: 'text', required: true },
          { field: 'descripcion', label: 'Descripción', type: 'textarea' }
        ]
      },
      sectores: {
        label: 'Sectores',
        singular: 'Sector',
        endpoint: 'sectores',
        icon: 'bi-grid-3x3-gap',
        columns: [
          { field: 'nombre', label: 'Nombre' }
        ],
        fields: [
          { field: 'nombre', label: 'Nombre del Sector', type: 'text', required: true }
        ]
      },
      valores_estudio_sector: {
        label: 'Valores por Estudio-Sector',
        singular: 'Valor Estudio-Sector',
        endpoint: 'valores-estudio-sector',
        icon: 'bi-table',
        columns: [
          { field: 'id', label: 'ID' },
          { field: 'id_estudio', label: 'Estudio', type: 'fk', ref: 'estudios' },
          { field: 'id_sector', label: 'Sector', type: 'fk', ref: 'sectores' },
          { field: 'posicion_informe', label: 'Posición' },
          { field: 'rango', label: 'Rango' }
        ],
        fields: [
          { field: 'id_estudio', label: 'Estudio', type: 'fk', ref: 'estudios', required: true },
          { field: 'id_sector', label: 'Sector', type: 'fk', ref: 'sectores', required: true },
          { field: 'posicion_informe', label: 'Posición en Informe', type: 'number', required: true },
          { field: 'rango', label: 'Rango', type: 'text' }
        ]
      },
      estudio_derivante: {
        label: 'Estudio x Derivante',
        singular: 'Registro Estudio x Derivante',
        endpoint: 'estudio-derivante',
        icon: 'bi-diagram-3',
        columns: [
          { field: 'id', label: 'ID' },
          { field: 'nemonico_datatech', label: 'Nemónico' },
          { field: 'id_estudio', label: 'Estudio', type: 'fk', ref: 'estudios' },
          { field: 'derivante_id', label: 'Derivante', type: 'fk', ref: 'derivantes' },
          { field: 'estado', label: 'Estado' },
          { field: 'paridad_datatech_hexalis', label: 'Paridad' },
          { field: 'revisor', label: 'Revisor' }
        ],
        fields: [
          { field: 'nemonico_datatech', label: 'Nemónico Datatech', type: 'text', required: true },
          { field: 'id_estudio', label: 'Estudio', type: 'fk', ref: 'estudios', required: true, allowCreateNew: true },
          { field: 'derivante_id', label: 'Derivante', type: 'fk', ref: 'derivantes', required: true },
          { field: 'id_metodo', label: 'Método', type: 'fk', ref: 'metodos' },
          { field: 'id_preanalitico', label: 'Pre-analítico', type: 'fk', ref: 'preanaliticos' },
          { field: 'id_muestra', label: 'Muestra', type: 'fk', ref: 'muestras' },
          { field: 'id_sector_laboratorio', label: 'Valor Estudio-Sector', type: 'fk', ref: 'valores_estudio_sector' },
          { field: 'paridad_datatech_hexalis', label: 'Paridad Datatech-Hexalis', type: 'select', options: ESTADOS_PARIDAD, default: 'pendiente' },
          { field: 'estado', label: 'Estado', type: 'select', options: ESTADOS_REGISTRO, default: 'pendiente' },
          { field: 'valor_referencia', label: 'Valor de Referencia', type: 'textarea' },
          { field: 'indicaciones', label: 'Indicaciones', type: 'textarea' },
          { field: 'dias_demora', label: 'Días de Demora', type: 'number', default: 0 },
          { field: 'codigo_laboratorio', label: 'Código del Laboratorio', type: 'text' },
          { field: 'version', label: 'Versión', type: 'number', default: 1 },
          { field: 'revisor', label: 'Revisor', type: 'text', required: true },
          { field: 'observacion', label: 'Observación', type: 'textarea' }
        ]
      }
    };

    const sidebarEntities = SIDEBAR_ENTITY_KEYS.map(key => [key, entities[key]]);

    const currentEntity = computed(() => entities[currentEntityKey.value]);
    const modalEntity = computed(() => entities[modalEntityKey.value]);
    const isAllEstudiosMode = computed(() => currentView.value === 'indicaciones' && selectedDerivanteId.value === ALL_ESTUDIOS);

    // Filtro reactivo para la búsqueda de estudios por derivante
    const filteredEstudios = computed(() => {
      if (!searchQuery.value) return derivanteEstudios.value;
      const q = searchQuery.value.toLowerCase().trim();
      return derivanteEstudios.value.filter(e => {
        const nombre = (e.estudio_descripcion || '').toLowerCase();
        const codigo = (e.codigo_hexalis || '').toLowerCase();
        const nemonico = (e.nemonico_datatech || '').toLowerCase();
        return nombre.includes(q) || codigo.includes(q) || nemonico.includes(q);
      });
    });

    // Métodos CRUD Genericos
    const fetchItems = async (page = 1) => {
      loading.value = true;
      try {
        const response = await axios.get(`${API_BASE}/${currentEntity.value.endpoint}`, {
          params: { page, limit: 50 }
        });
        items.value = response.data.items;
        pagination.value = {
          page: response.data.page,
          limit: response.data.limit,
          total: response.data.total,
          total_pages: response.data.total_pages
        };
      } catch (err) {
        showAlert('Error al cargar datos desde la API', 'danger');
      } finally {
        loading.value = false;
      }
    };

    const switchCrudEntity = (key) => {
      currentView.value = 'crud';
      currentEntityKey.value = key;
      fetchItems(1);
    };

    const switchToIndicaciones = () => {
      currentView.value = 'indicaciones';
    };

    const toggleSidebar = () => {
      sidebarCollapsed.value = !sidebarCollapsed.value;
      localStorage.setItem('britlab_sidebar_collapsed', sidebarCollapsed.value ? '1' : '0');
    };

    // Métodos Vista "Estudios por Derivante"
    const fetchEstudiosPorDerivante = async () => {
      if (!selectedDerivanteId.value) {
        derivanteEstudios.value = [];
        return;
      }
      loadingIndicaciones.value = true;
      try {
        const res = await axios.get(`${API_BASE}/estudio-derivante/derivante/${selectedDerivanteId.value}`);
        derivanteEstudios.value = res.data;
      } catch (err) {
        showAlert('Error al consultar los estudios asignados al derivante', 'danger');
        derivanteEstudios.value = [];
      } finally {
        loadingIndicaciones.value = false;
      }
    };

    // Al cambiar el selector: "Todos los Estudios" reutiliza el ABM de Estudios,
    // cualquier otra opción consulta los estudios asignados a ese derivante.
    const onDerivanteSelectorChange = () => {
      searchQuery.value = '';
      if (selectedDerivanteId.value === ALL_ESTUDIOS) {
        currentEntityKey.value = 'estudios';
        fetchItems(1);
        return;
      }
      fetchEstudiosPorDerivante();
    };

    const changePage = (page) => {
      if (page >= 1 && page <= pagination.value.total_pages) {
        fetchItems(page);
      }
    };

    const openModal = (mode, item = null, opts = {}) => {
      modalMode.value = mode;
      modalEntityKey.value = opts.entityKey || currentEntityKey.value;
      modalContext.value = opts.context || 'crud';
      if (mode === 'edit' && item) {
        formData.value = { ...item };
      } else {
        formData.value = {};
        (modalEntity.value.fields || []).forEach(f => {
          if (f.default !== undefined) formData.value[f.field] = f.default;
        });
      }
      // Preparar el texto visible de los selectores con autocompletado (FK)
      fkText.value = {};
      (modalEntity.value.fields || []).forEach(f => {
        if (f.type === 'fk') {
          fkText.value[f.field] = fkLabel(f.ref, formData.value[f.field]) || '';
        }
      });
      newEstudioCodigo.value = '';
      modalInstance.show();
    };

    // Abre el mismo modal de "Estudio x Derivante" pero desde la tabla de
    // Indicaciones por Derivante: trae el registro completo (con los ids de
    // FK reales) porque esa tabla solo tiene los nombres ya resueltos.
    const editEstudioDerivante = async (item) => {
      try {
        const res = await axios.get(`${API_BASE}/estudio-derivante/${item.id}`);
        openModal('edit', res.data, { entityKey: 'estudio_derivante', context: 'indicaciones' });
      } catch (err) {
        showAlert('No se pudo cargar el registro para editar', 'danger');
      }
    };

    // "Nuevo Estudio" dentro de un derivante puntual: crea un registro de
    // Estudio x Derivante con el derivante ya elegido (el usuario solo busca
    // el Estudio existente a asignar).
    const openNewEstudioForDerivante = () => {
      openModal('create', null, { entityKey: 'estudio_derivante', context: 'indicaciones' });
      formData.value.derivante_id = selectedDerivanteId.value;
      fkText.value.derivante_id = fkLabel('derivantes', selectedDerivanteId.value) || '';
    };

    // El picker de Estudio tiene texto tipeado que no matchea ninguna opción
    // existente: hay que crear el Estudio antes de guardar el Estudio x Derivante.
    const needsNewEstudio = computed(() =>
      modalEntity.value && modalEntity.value.fields.some(f => f.field === 'id_estudio' && f.allowCreateNew) &&
      !!fkText.value.id_estudio && !formData.value.id_estudio
    );

    const saveItem = async () => {
      const entity = modalEntity.value;
      try {
        if (needsNewEstudio.value) {
          if (!newEstudioCodigo.value.trim()) {
            showAlert('Ingresá el Código Hexalis del estudio nuevo', 'danger');
            return;
          }
          const nuevoEstudio = await axios.post(`${API_BASE}/estudios`, {
            codigo_hexalis: newEstudioCodigo.value.trim(),
            descripcion: fkText.value.id_estudio.trim()
          });
          formData.value.id_estudio = nuevoEstudio.data.id;
        }
        if (modalMode.value === 'create') {
          await axios.post(`${API_BASE}/${entity.endpoint}`, formData.value);
          showAlert(`${entity.singular} creado correctamente`);
        } else {
          await axios.put(`${API_BASE}/${entity.endpoint}/${formData.value.id}`, formData.value);
          showAlert(`${entity.singular} actualizado correctamente`);
        }
        modalInstance.hide();
        if (modalContext.value === 'indicaciones') {
          fetchEstudiosPorDerivante();
        } else {
          fetchItems(pagination.value.page);
        }
        // Las listas de referencia pueden haber cambiado (p.ej. se creó un Estudio nuevo)
        fetchRefData();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'Error al guardar los cambios'), 'danger');
      }
    };

    const deleteItem = async (id) => {
      if (confirm(`¿Eliminar registro #${id}?`)) {
        try {
          await axios.delete(`${API_BASE}/${currentEntity.value.endpoint}/${id}`);
          showAlert('Registro eliminado correctamente');
          fetchItems(pagination.value.page);
        } catch (err) {
          showAlert(apiErrorMessage(err, 'No se pudo eliminar el registro (puede estar en uso por otros registros)'), 'danger');
        }
      }
    };

    const showAlert = (message, type = 'success') => {
      alert.value = { message, type };
      setTimeout(() => alert.value.message = '', 4000);
    };

    // Traduce la respuesta de error de la API (validación de Pydantic o
    // conflicto de integridad de la BD) a un mensaje legible.
    const apiErrorMessage = (err, fallback) => {
      const data = err.response?.data;
      if (Array.isArray(data)) return data.map(d => d.msg).join(' | ');
      if (data?.error) return data.detail ? `${data.error} (${data.detail})` : data.error;
      return fallback;
    };

    onMounted(async () => {
      const modalEl = document.getElementById('crudModal');
      if (modalEl) {
        modalInstance = new bootstrap.Modal(modalEl);
      }
      await fetchRefData();
    });

    return {
      currentView,
      entities,
      sidebarEntities,
      currentEntityKey,
      currentEntity,
      modalEntity,
      sidebarCollapsed,
      toggleSidebar,
      items,
      loading,
      formData,
      modalMode,
      pagination,
      alert,
      refData,
      fkText,
      fkLabel,
      onFkInput,
      newEstudioCodigo,
      needsNewEstudio,
      derivantesList: computed(() => refData.value.derivantes),
      ALL_ESTUDIOS,
      isAllEstudiosMode,
      selectedDerivanteId,
      derivanteEstudios,
      loadingIndicaciones,
      searchQuery,
      filteredEstudios,
      ESTADOS_REGISTRO,
      ESTADOS_PARIDAD,
      switchCrudEntity,
      switchToIndicaciones,
      onDerivanteSelectorChange,
      editEstudioDerivante,
      openNewEstudioForDerivante,
      changePage,
      openModal,
      saveItem,
      deleteItem
    };
  }
}).mount('#app');
