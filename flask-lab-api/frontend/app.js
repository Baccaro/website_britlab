const { createApp, ref, computed, onMounted } = Vue;

// Opción especial del selector de colega que muestra el catálogo completo de Estudios
const ALL_ESTUDIOS = '__ALL_ESTUDIOS__';

// Entidades con botón propio en la barra de navegación superior.
const TOP_NAV_ENTITY_KEYS = ['colegas', 'metodos', 'preanaliticos'];

// Catálogos de Muestras: quedan agrupados en el dropdown "Muestras" de la
// barra de navegación superior (mismas opciones que tenía antes en el sidebar).
const MUESTRAS_CATALOGO_KEYS = ['tipos_muestra', 'aditivos', 'unidades_medida', 'recipientes',
  'modalidades_recoleccion', 'tecnicas_recoleccion', 'conservaciones', 'condiciones_especiales', 'prioridades_envio'];

// Clase de color del chip de colega en "Todos los Estudios", según el estado
// del registro estudio_colega en ese colega.
const ESTADO_CHIP_CLASS = {
  listo: 'bg-success-teal',
  verificado: 'bg-success-teal',
  pendiente: 'bg-tertiary',
  revisar: 'bg-warning text-dark'
};

// Campos de una muestra estructurada (o de una alternativa suya: misma forma),
// en el orden en que se muestran en el formulario. 'volumen' no es un catálogo
// (no tiene 'ref'), el resto son selects contra una tabla de referencia.
const MUESTRA_CAMPOS = [
  { field: 'id_tipo_muestra', ref: 'tipos_muestra', label: 'Tipo de Muestra', required: true, type: 'select' },
  { field: 'id_aditivo', ref: 'aditivos', label: 'Aditivo', type: 'select' },
  { field: 'volumen', label: 'Volumen', type: 'number' },
  { field: 'id_unidad_medida', ref: 'unidades_medida', label: 'Unidad de Medida', type: 'select' },
  { field: 'id_recipiente', ref: 'recipientes', label: 'Recipiente', type: 'select' },
  { field: 'id_modalidad_recoleccion', ref: 'modalidades_recoleccion', label: 'Modalidad de Recolección', type: 'select' },
  { field: 'id_tecnica_recoleccion', ref: 'tecnicas_recoleccion', label: 'Técnica de Recolección', type: 'select' },
  { field: 'id_conservacion', ref: 'conservaciones', label: 'Conservación / Temperatura', type: 'select' },
  { field: 'id_condicion_especial', ref: 'condiciones_especiales', label: 'Condición Especial', type: 'select' },
  { field: 'id_prioridad_envio', ref: 'prioridades_envio', label: 'Prioridad / Envío', type: 'select' }
];

// Secciones desplegables del formulario de "Estudio x Colega". 'muestras' no
// lleva 'fields': esa sección se arma aparte (ver muestrasForm más abajo).
const ESTUDIO_COLEGA_SECCIONES = [
  {
    key: 'general', title: 'Datos Generales',
    desc: 'Identificación del estudio y su clasificación general.',
    fields: ['id_estudio', 'nemonico_datatech', 'colega_id', 'id_metodo', 'id_sector_laboratorio', 'paridad_datatech_hexalis', 'estado']
  },
  { key: 'muestras', title: 'Muestras', desc: 'Una o varias muestras admitidas, cada una con su recolección y conservación.' },
  {
    key: 'preanalitico', title: 'Pre-analítico e Indicaciones',
    desc: 'Preparación previa, valores de referencia e indicaciones.',
    fields: ['id_preanalitico', 'valor_referencia', 'indicaciones_pacientes', 'indicaciones_colega']
  },
  {
    key: 'procesamiento', title: 'Procesamiento y Tiempos',
    desc: 'Demora, código propio del laboratorio y control de versión.',
    fields: ['dias_demora', 'codigo_laboratorio', 'version', 'revisor']
  }
];

let _muestraKeySeq = 0;
const nextMuestraKey = () => `m${_muestraKeySeq++}`;

// Columnas disponibles en la tabla "Estudios por Colega" (para el selector de
// columnas visibles). El usuario puede ocultar cualquiera menos las fijas.
const INDICACIONES_COLUMNAS = [
  { field: 'nemonico_datatech', label: 'Nemónico' },
  { field: 'paridad_datatech_hexalis', label: 'Paridad' },
  { field: 'codigo_hexalis', label: 'Cód. Hex.' },
  { field: 'estudio_descripcion', label: 'Estudio' },
  { field: 'metodo', label: 'Método' },
  { field: 'preanalitico', label: 'Pre-analítico' },
  { field: 'muestra', label: 'Muestra' },
  { field: 'valor_referencia', label: 'Val. Ref.' },
  { field: 'dias_demora', label: 'Dem.' },
  { field: 'estado', label: 'Estado' },
  { field: 'codigo_laboratorio', label: 'Cód. Lab.' },
  { field: 'revisor', label: 'Revisor' },
  { field: 'indicaciones_pacientes', label: 'Ind. Pacientes' },
  { field: 'indicaciones_colega', label: 'Ind. Colega' },
  { field: 'observacion', label: 'Observaciones' }
];
const INDICACIONES_COLUMNAS_DEFAULT = INDICACIONES_COLUMNAS.map(c => c.field);

createApp({
  setup() {
    const API_BASE = '/api';

    // Estado Navegación / Vistas
    const currentView = ref('indicaciones'); // 'crud' | 'indicaciones'
    const currentEntityKey = ref('estudios');

    // Estado CRUD Generico
    const items = ref([]);
    const loading = ref(false);
    const formData = ref({});
    const modalMode = ref('create');
    // Qué definición de entidad usa el modal actualmente abierto y adónde hay
    // que refrescar al guardar (puede diferir de currentEntityKey/currentView
    // cuando se edita un Estudio x Colega desde la vista de Estudios por Colega).
    const modalEntityKey = ref('estudios');
    const modalContext = ref('crud'); // 'crud' | 'indicaciones'
    let modalInstance = null;
    // Secciones desplegables abiertas/cerradas del formulario de Estudio x Colega
    const sectionsOpen = ref(Object.fromEntries(ESTUDIO_COLEGA_SECCIONES.map(s => [s.key, true])));
    const toggleSection = (key) => { sectionsOpen.value[key] = !sectionsOpen.value[key]; };
    const fieldsForSection = (sectionKey) => {
      const section = ESTUDIO_COLEGA_SECCIONES.find(s => s.key === sectionKey);
      if (!section || !section.fields) return [];
      return section.fields
        .map(fieldName => entities.estudio_colega.fields.find(f => f.field === fieldName))
        .filter(Boolean);
    };

    const alert = ref({ message: '', type: 'success' });
    const pagination = ref({ page: 1, limit: 50, total: 0, total_pages: 1 });

    // Estado Específico Vista "Estudios por Colega". Por defecto siempre
    // arranca en "Todos los Estudios" (catálogo maestro deduplicado).
    const selectedColegaId = ref(ALL_ESTUDIOS);
    const colegaEstudios = ref([]);
    const loadingIndicaciones = ref(false);
    const searchQuery = ref('');
    const todosEstudios = ref([]);
    const loadingTodosEstudios = ref(false);
    // Filtro por estado (compartido entre "Todos los Estudios" y la tabla de
    // un colega puntual) y toggle para ver solo los estudios en conflicto.
    const estadoFiltro = ref(null);
    const soloConflictos = ref(false);
    const toggleEstadoFiltro = (estado) => {
      estadoFiltro.value = estadoFiltro.value === estado ? null : estado;
    };
    const toggleSoloConflictos = () => { soloConflictos.value = !soloConflictos.value; };
    const expandedRows = ref(new Set());
    const rowMuestrasCache = ref({});
    const rowMuestrasLoading = ref(new Set());
    const showColumnPicker = ref(false);
    const visibleColumns = ref(new Set(
      JSON.parse(localStorage.getItem('britlab_columnas_indicaciones') || 'null') || INDICACIONES_COLUMNAS_DEFAULT
    ));

    const toggleColumn = (field) => {
      const next = new Set(visibleColumns.value);
      if (next.has(field)) next.delete(field); else next.add(field);
      visibleColumns.value = next;
      localStorage.setItem('britlab_columnas_indicaciones', JSON.stringify([...next]));
    };

    const visibleColumnasList = computed(() => INDICACIONES_COLUMNAS.filter(c => visibleColumns.value.has(c.field)));

    const ESTADOS_REGISTRO = ['listo', 'pendiente', 'revisar', 'verificado'];
    const ESTADOS_PARIDAD = ['listo', 'pendiente', 'revisar', 'inactivo', 'discontinuado'];

    // Listas maestras cacheadas para armar los selectores de claves foráneas
    const refData = ref({
      estudios: [], colegas: [], metodos: [], muestras: [], preanaliticos: [], sectores: [], valores_estudio_sector: [],
      tipos_muestra: [], aditivos: [], unidades_medida: [], recipientes: [], modalidades_recoleccion: [],
      tecnicas_recoleccion: [], conservaciones: [], condiciones_especiales: [], prioridades_envio: []
    });
    // Texto mostrado en los inputs con autocompletado (datalist) del modal, por campo
    const fkText = ref({});
    // Código Hexalis tipeado cuando se está creando un Estudio nuevo "al vuelo"
    // (el usuario escribió un Estudio que no existe en el picker)
    const newEstudioCodigo = ref('');

    const REF_LABEL = {
      estudios: e => `${e.codigo_hexalis} — ${e.descripcion}`,
      colegas: d => d.descripcion,
      metodos: m => m.nombre,
      muestras: m => m.nombre,
      preanaliticos: p => p.nombre,
      sectores: s => s.nombre,
      valores_estudio_sector: v => {
        const est = refData.value.estudios.find(e => e.id === v.id_estudio);
        const nombre = est ? est.descripcion : `#${v.id_estudio}`;
        return `${nombre} - Posición Informe: ${v.posicion_informe}`;
      },
      tipos_muestra: x => x.nombre,
      aditivos: x => x.nombre,
      unidades_medida: x => x.nombre,
      recipientes: x => x.nombre,
      modalidades_recoleccion: x => x.nombre,
      tecnicas_recoleccion: x => x.nombre,
      conservaciones: x => x.nombre,
      condiciones_especiales: x => x.nombre,
      prioridades_envio: x => x.nombre
    };

    // endpoint de la API para cada clave de refData
    const REF_ENDPOINT = {
      estudios: 'estudios', colegas: 'colegas', metodos: 'metodos', muestras: 'muestras',
      preanaliticos: 'preanaliticos', sectores: 'sectores', valores_estudio_sector: 'valores-estudio-sector',
      tipos_muestra: 'tipos-muestra', aditivos: 'aditivos', unidades_medida: 'unidades-medida',
      recipientes: 'recipientes', modalidades_recoleccion: 'modalidades-recoleccion',
      tecnicas_recoleccion: 'tecnicas-recoleccion', conservaciones: 'conservaciones',
      condiciones_especiales: 'condiciones-especiales', prioridades_envio: 'prioridades-envio'
    };

    const fetchRefData = async () => {
      const keys = Object.keys(REF_ENDPOINT);
      try {
        const responses = await Promise.all(
          keys.map(k => axios.get(`${API_BASE}/${REF_ENDPOINT[k]}`, { params: { limit: 3000 } }))
        );
        const nuevo = {};
        keys.forEach((k, i) => { nuevo[k] = responses[i].data.items; });
        refData.value = nuevo;
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
      colegas: {
        label: 'Colegas',
        singular: 'Colega',
        endpoint: 'colegas',
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
      tipos_muestra: {
        label: 'Tipos de Muestra',
        singular: 'Tipo de Muestra',
        endpoint: 'tipos-muestra',
        icon: 'bi-droplet-half',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      aditivos: {
        label: 'Aditivos',
        singular: 'Aditivo',
        endpoint: 'aditivos',
        icon: 'bi-eyedropper',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      unidades_medida: {
        label: 'Unidades de Medida',
        singular: 'Unidad de Medida',
        endpoint: 'unidades-medida',
        icon: 'bi-rulers',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      recipientes: {
        label: 'Recipientes',
        singular: 'Recipiente',
        endpoint: 'recipientes',
        icon: 'bi-cup-straw',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      modalidades_recoleccion: {
        label: 'Modalidades de Recolección',
        singular: 'Modalidad de Recolección',
        endpoint: 'modalidades-recoleccion',
        icon: 'bi-calendar-check',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      tecnicas_recoleccion: {
        label: 'Técnicas de Recolección',
        singular: 'Técnica de Recolección',
        endpoint: 'tecnicas-recoleccion',
        icon: 'bi-tools',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      conservaciones: {
        label: 'Conservación / Temperatura',
        singular: 'Conservación',
        endpoint: 'conservaciones',
        icon: 'bi-thermometer-snow',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      condiciones_especiales: {
        label: 'Condiciones Especiales',
        singular: 'Condición Especial',
        endpoint: 'condiciones-especiales',
        icon: 'bi-exclamation-diamond',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      prioridades_envio: {
        label: 'Prioridad / Envío',
        singular: 'Prioridad de Envío',
        endpoint: 'prioridades-envio',
        icon: 'bi-truck',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      estudio_colega: {
        label: 'Estudio x Colega',
        singular: 'Registro Estudio x Colega',
        endpoint: 'estudio-colega',
        icon: 'bi-diagram-3',
        columns: [
          { field: 'id', label: 'ID' },
          { field: 'nemonico_datatech', label: 'Nemónico' },
          { field: 'id_estudio', label: 'Estudio', type: 'fk', ref: 'estudios' },
          { field: 'colega_id', label: 'Colega', type: 'fk', ref: 'colegas' },
          { field: 'estado', label: 'Estado' },
          { field: 'paridad_datatech_hexalis', label: 'Paridad' },
          { field: 'revisor', label: 'Revisor' }
        ],
        fields: [
          { field: 'nemonico_datatech', label: 'Nemónico Datatech', type: 'text', required: true },
          { field: 'id_estudio', label: 'Estudio', type: 'fk', ref: 'estudios', required: true, allowCreateNew: true },
          { field: 'colega_id', label: 'Colega', type: 'fk', ref: 'colegas', required: true },
          { field: 'id_metodo', label: 'Método', type: 'fk', ref: 'metodos' },
          { field: 'id_preanalitico', label: 'Pre-analítico', type: 'fk', ref: 'preanaliticos' },
          { field: 'id_sector_laboratorio', label: 'Valor Estudio-Sector', type: 'fk', ref: 'valores_estudio_sector' },
          { field: 'paridad_datatech_hexalis', label: 'Paridad Datatech-Hexalis', type: 'select', options: ESTADOS_PARIDAD, default: 'pendiente' },
          { field: 'estado', label: 'Estado', type: 'select', options: ESTADOS_REGISTRO, default: 'pendiente' },
          { field: 'valor_referencia', label: 'Valor de Referencia', type: 'textarea' },
          { field: 'indicaciones_pacientes', label: 'Indicaciones Pacientes', type: 'textarea' },
          { field: 'indicaciones_colega', label: 'Indicaciones Colega', type: 'textarea' },
          { field: 'dias_demora', label: 'Días de Demora', type: 'number', default: 0 },
          { field: 'codigo_laboratorio', label: 'Código del Laboratorio', type: 'text' },
          { field: 'version', label: 'Versión', type: 'number', default: 1 },
          { field: 'revisor', label: 'Revisor', type: 'text', required: true },
          { field: 'observacion', label: 'Observación', type: 'textarea' }
        ]
      }
    };

    const topNavEntities = TOP_NAV_ENTITY_KEYS.map(key => [key, entities[key]]);
    const muestrasCatalogoEntities = MUESTRAS_CATALOGO_KEYS.map(key => [key, entities[key]]);

    const currentEntity = computed(() => entities[currentEntityKey.value]);
    const modalEntity = computed(() => entities[modalEntityKey.value]);
    const isAllEstudiosMode = computed(() => currentView.value === 'indicaciones' && selectedColegaId.value === ALL_ESTUDIOS);
    const muestrasDropdownActive = computed(() => currentView.value === 'crud' && MUESTRAS_CATALOGO_KEYS.includes(currentEntityKey.value));

    // Filtro reactivo para la búsqueda + filtro de estado de estudios por colega
    const filteredEstudios = computed(() => {
      let lista = colegaEstudios.value;
      if (estadoFiltro.value) lista = lista.filter(e => e.estado === estadoFiltro.value);
      if (searchQuery.value) {
        const q = searchQuery.value.toLowerCase().trim();
        lista = lista.filter(e => {
          const nombre = (e.estudio_descripcion || '').toLowerCase();
          const codigo = (e.codigo_hexalis || '').toLowerCase();
          const nemonico = (e.nemonico_datatech || '').toLowerCase();
          return nombre.includes(q) || codigo.includes(q) || nemonico.includes(q);
        });
      }
      return lista;
    });

    // Un estudio está "en conflicto" cuando figura como 'listo' (activo) en
    // más de un colega a la vez: normalmente debería estar activo en uno solo.
    const esEstudioConflictivo = (e) => e.colegas.filter(c => c.estado === 'listo').length >= 2;
    const estudiosConConflicto = computed(() => todosEstudios.value.filter(esEstudioConflictivo));
    const estadoChipClass = (estado) => ESTADO_CHIP_CLASS[estado] || 'bg-tertiary';

    // Filtro reactivo para "Todos los Estudios": conflictos, estado y búsqueda.
    // Cuando hay un estado elegido, sólo quedan los estudios con al menos un
    // colega en ese estado (los chips que no matchean se ocultan en el template).
    const filteredTodosEstudios = computed(() => {
      let lista = soloConflictos.value ? estudiosConConflicto.value : todosEstudios.value;
      if (estadoFiltro.value) lista = lista.filter(e => e.colegas.some(c => c.estado === estadoFiltro.value));
      if (searchQuery.value) {
        const q = searchQuery.value.toLowerCase().trim();
        lista = lista.filter(e => {
          const nombre = (e.estudio_descripcion || '').toLowerCase();
          const codigo = (e.codigo_hexalis || '').toLowerCase();
          return nombre.includes(q) || codigo.includes(q);
        });
      }
      return lista;
    });

    // Chips a mostrar en la fila de un estudio: si hay filtro de estado activo,
    // sólo los colegas que matchean (para no mezclar estados en la vista filtrada).
    const chipsDeEstudio = (e) => estadoFiltro.value ? e.colegas.filter(c => c.estado === estadoFiltro.value) : e.colegas;

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

    // El botón "Estudios" de la barra superior siempre vuelve al catálogo
    // maestro "Todos los Estudios", sin recordar el último colega elegido.
    const switchToIndicaciones = () => {
      currentView.value = 'indicaciones';
      searchQuery.value = '';
      estadoFiltro.value = null;
      soloConflictos.value = false;
      selectedColegaId.value = ALL_ESTUDIOS;
      fetchTodosEstudios();
    };

    // Métodos Vista "Estudios por Colega"
    const fetchEstudiosPorColega = async () => {
      if (!selectedColegaId.value) {
        colegaEstudios.value = [];
        return;
      }
      loadingIndicaciones.value = true;
      expandedRows.value = new Set();
      try {
        const res = await axios.get(`${API_BASE}/estudio-colega/colega/${selectedColegaId.value}`);
        colegaEstudios.value = res.data;
      } catch (err) {
        showAlert('Error al consultar los estudios asignados al colega', 'danger');
        colegaEstudios.value = [];
      } finally {
        loadingIndicaciones.value = false;
      }
    };

    // Al cambiar el selector: "Todos los Estudios" trae el catálogo maestro
    // deduplicado por código hexalis, cualquier otra opción consulta los
    // estudios asignados a ese colega puntual.
    const onColegaSelectorChange = () => {
      searchQuery.value = '';
      estadoFiltro.value = null;
      soloConflictos.value = false;
      if (selectedColegaId.value === ALL_ESTUDIOS) {
        fetchTodosEstudios();
        return;
      }
      fetchEstudiosPorColega();
    };

    const fetchTodosEstudios = async () => {
      loadingTodosEstudios.value = true;
      try {
        const res = await axios.get(`${API_BASE}/estudio-colega/todos`);
        todosEstudios.value = res.data;
      } catch (err) {
        showAlert('Error al consultar el catálogo de estudios', 'danger');
        todosEstudios.value = [];
      } finally {
        loadingTodosEstudios.value = false;
      }
    };

    // --- Filas desplegables de la tabla de Estudios por Colega ---
    const toggleRowExpand = (item) => {
      const next = new Set(expandedRows.value);
      if (next.has(item.id)) {
        next.delete(item.id);
      } else {
        next.add(item.id);
        if (!rowMuestrasCache.value[item.id]) {
          fetchRowMuestras(item.id);
        }
      }
      expandedRows.value = next;
    };

    const fetchRowMuestras = async (idEstudioColega) => {
      const loadingSet = new Set(rowMuestrasLoading.value);
      loadingSet.add(idEstudioColega);
      rowMuestrasLoading.value = loadingSet;
      try {
        const res = await axios.get(`${API_BASE}/estudio-colega-muestra/estudio-colega/${idEstudioColega}`);
        rowMuestrasCache.value = { ...rowMuestrasCache.value, [idEstudioColega]: res.data };
      } catch (err) {
        rowMuestrasCache.value = { ...rowMuestrasCache.value, [idEstudioColega]: [] };
      } finally {
        const doneSet = new Set(rowMuestrasLoading.value);
        doneSet.delete(idEstudioColega);
        rowMuestrasLoading.value = doneSet;
      }
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
      Object.keys(sectionsOpen.value).forEach(k => { sectionsOpen.value[k] = true; });

      // Sub-sección de Muestras estructuradas: se editan en un buffer local y
      // se guardan (create/update/delete) recién cuando se guarda el formulario.
      muestrasEliminadas.value = [];
      alternativasEliminadas.value = [];
      if (modalEntityKey.value === 'estudio_colega' && mode === 'edit') {
        fetchMuestrasDeEstudioColega(formData.value.id);
      } else {
        muestrasForm.value = [];
      }

      modalInstance.show();
    };

    // --- Muestras estructuradas (1..N por Estudio x Colega). Cada muestra, a
    // su vez, puede tener 1..N alternativas propias (nivel anidado, no una
    // lista plana). Todo se edita en memoria y se persiste recién al Guardar. ---
    const muestrasForm = ref([]);
    const muestrasLoading = ref(false);
    const muestrasEliminadas = ref([]); // ids de estudio_colega_muestra ya existentes a borrar
    const alternativasEliminadas = ref([]); // ids de alternativas ya existentes a borrar

    const blankCampos = () => {
      const row = { volumen: null };
      MUESTRA_CAMPOS.forEach(c => { if (c.field !== 'volumen') row[c.field] = null; });
      return row;
    };

    const blankMuestraRow = (orden) => ({
      _key: nextMuestraKey(), _isNew: true, id: null, orden, observacion: null,
      alternativas: [], ...blankCampos()
    });

    const blankAlternativaRow = (orden) => ({
      _key: nextMuestraKey(), _isNew: true, id: null, orden, observacion: null,
      ...blankCampos()
    });

    const copiarCampos = (origen, destino) => {
      MUESTRA_CAMPOS.forEach(c => { destino[c.field] = origen[c.field]; });
      destino.observacion = origen.observacion;
    };

    const fetchMuestrasDeEstudioColega = async (idEstudioColega) => {
      muestrasLoading.value = true;
      try {
        const res = await axios.get(`${API_BASE}/estudio-colega-muestra/estudio-colega/${idEstudioColega}`);
        muestrasForm.value = res.data.map(m => ({
          ...m,
          _key: nextMuestraKey(),
          _isNew: false,
          alternativas: (m.alternativas || []).map(a => ({ ...a, _key: nextMuestraKey(), _isNew: false }))
        }));
      } catch (err) {
        showAlert('No se pudieron cargar las muestras de este estudio', 'danger');
        muestrasForm.value = [];
      } finally {
        muestrasLoading.value = false;
      }
    };

    const addMuestraRow = () => {
      muestrasForm.value.push(blankMuestraRow(muestrasForm.value.length + 1));
    };

    const duplicateMuestraRow = (idx) => {
      const copia = blankMuestraRow(muestrasForm.value.length + 1);
      copiarCampos(muestrasForm.value[idx], copia);
      muestrasForm.value.splice(idx + 1, 0, copia);
      renumerar(muestrasForm.value);
    };

    const removeMuestraRow = (idx) => {
      const row = muestrasForm.value[idx];
      if (!row._isNew && row.id) muestrasEliminadas.value.push(row.id);
      muestrasForm.value.splice(idx, 1);
      renumerar(muestrasForm.value);
    };

    const moveMuestraRow = (idx, dir) => {
      const target = idx + dir;
      if (target < 0 || target >= muestrasForm.value.length) return;
      const arr = muestrasForm.value;
      [arr[idx], arr[target]] = [arr[target], arr[idx]];
      renumerar(arr);
    };

    // --- Alternativas de una muestra puntual (anidadas dentro de ella) ---
    const addAlternativaRow = (muestraIdx) => {
      const alts = muestrasForm.value[muestraIdx].alternativas;
      alts.push(blankAlternativaRow(alts.length + 1));
    };

    const duplicateAlternativaRow = (muestraIdx, altIdx) => {
      const alts = muestrasForm.value[muestraIdx].alternativas;
      const copia = blankAlternativaRow(alts.length + 1);
      copiarCampos(alts[altIdx], copia);
      alts.splice(altIdx + 1, 0, copia);
      renumerar(alts);
    };

    const removeAlternativaRow = (muestraIdx, altIdx) => {
      const alts = muestrasForm.value[muestraIdx].alternativas;
      const row = alts[altIdx];
      if (!row._isNew && row.id) alternativasEliminadas.value.push(row.id);
      alts.splice(altIdx, 1);
      renumerar(alts);
    };

    const moveAlternativaRow = (muestraIdx, altIdx, dir) => {
      const alts = muestrasForm.value[muestraIdx].alternativas;
      const target = altIdx + dir;
      if (target < 0 || target >= alts.length) return;
      [alts[altIdx], alts[target]] = [alts[target], alts[altIdx]];
      renumerar(alts);
    };

    const renumerar = (arr) => { arr.forEach((row, i) => { row.orden = i + 1; }); };

    const persistMuestras = async (idEstudioColega) => {
      // 1. Borrados primero (alternativas sueltas, y muestras completas que
      // arrastran en cascada del lado del server sus propias alternativas).
      await Promise.all(alternativasEliminadas.value.map(id =>
        axios.delete(`${API_BASE}/estudio-colega-muestra-alternativa/${id}`)));
      await Promise.all(muestrasEliminadas.value.map(id =>
        axios.delete(`${API_BASE}/estudio-colega-muestra/${id}`)));

      // 2. Alta/edición: secuencial porque las alternativas nuevas necesitan
      // el id real de su muestra (que para una muestra nueva recién se sabe
      // después de crearla).
      for (const m of muestrasForm.value) {
        const payload = { id_estudio_colega: idEstudioColega, orden: m.orden, observacion: m.observacion };
        MUESTRA_CAMPOS.forEach(c => { payload[c.field] = m[c.field]; });

        let muestraId = m.id;
        if (m._isNew) {
          const res = await axios.post(`${API_BASE}/estudio-colega-muestra`, payload);
          muestraId = res.data.id;
        } else {
          await axios.put(`${API_BASE}/estudio-colega-muestra/${m.id}`, payload);
        }

        for (const a of m.alternativas) {
          const altPayload = { id_estudio_colega_muestra: muestraId, orden: a.orden, observacion: a.observacion };
          MUESTRA_CAMPOS.forEach(c => { altPayload[c.field] = a[c.field]; });
          if (a._isNew) {
            await axios.post(`${API_BASE}/estudio-colega-muestra-alternativa`, altPayload);
          } else {
            await axios.put(`${API_BASE}/estudio-colega-muestra-alternativa/${a.id}`, altPayload);
          }
        }
      }
      delete rowMuestrasCache.value[idEstudioColega];
    };

    // Abre el mismo modal de "Estudio x Colega" pero desde la tabla de
    // Estudios por Colega: trae el registro completo (con los ids de FK
    // reales) porque esa tabla solo tiene los nombres ya resueltos.
    const editEstudioColega = async (item, context = 'indicaciones') => {
      try {
        const res = await axios.get(`${API_BASE}/estudio-colega/${item.id}`);
        openModal('edit', res.data, { entityKey: 'estudio_colega', context });
      } catch (err) {
        showAlert('No se pudo cargar el registro para editar', 'danger');
      }
    };

    // "Nuevo Estudio" dentro de un colega puntual: crea un registro de
    // Estudio x Colega con el colega ya elegido (el usuario solo busca el
    // Estudio existente a asignar).
    const openNewEstudioForColega = () => {
      openModal('create', null, { entityKey: 'estudio_colega', context: 'indicaciones' });
      formData.value.colega_id = selectedColegaId.value;
      fkText.value.colega_id = fkLabel('colegas', selectedColegaId.value) || '';
    };

    // El picker de Estudio tiene texto tipeado que no matchea ninguna opción
    // existente: hay que crear el Estudio antes de guardar el Estudio x Colega.
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
        if (modalEntityKey.value === 'estudio_colega' && muestrasForm.value.some(
          m => !m.id_tipo_muestra || m.alternativas.some(a => !a.id_tipo_muestra)
        )) {
          showAlert('Todas las muestras y sus alternativas necesitan un Tipo de Muestra', 'danger');
          return;
        }
        let savedId = formData.value.id;
        if (modalMode.value === 'create') {
          const res = await axios.post(`${API_BASE}/${entity.endpoint}`, formData.value);
          savedId = res.data.id;
          showAlert(`${entity.singular} creado correctamente`);
        } else {
          await axios.put(`${API_BASE}/${entity.endpoint}/${formData.value.id}`, formData.value);
          showAlert(`${entity.singular} actualizado correctamente`);
        }
        if (modalEntityKey.value === 'estudio_colega') {
          await persistMuestras(savedId);
        }
        modalInstance.hide();
        if (modalContext.value === 'indicaciones') {
          fetchEstudiosPorColega();
        } else if (modalContext.value === 'todos_estudios') {
          fetchTodosEstudios();
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
      fetchTodosEstudios();
    });

    return {
      currentView,
      entities,
      topNavEntities,
      muestrasCatalogoEntities,
      muestrasDropdownActive,
      currentEntityKey,
      currentEntity,
      modalEntity,
      modalEntityKey,
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
      colegasList: computed(() => refData.value.colegas),
      ALL_ESTUDIOS,
      isAllEstudiosMode,
      selectedColegaId,
      colegaEstudios,
      loadingIndicaciones,
      searchQuery,
      filteredEstudios,
      todosEstudios,
      loadingTodosEstudios,
      filteredTodosEstudios,
      estudiosConConflicto,
      esEstudioConflictivo,
      estadoChipClass,
      estadoFiltro,
      toggleEstadoFiltro,
      soloConflictos,
      toggleSoloConflictos,
      chipsDeEstudio,
      ESTADOS_REGISTRO,
      ESTADOS_PARIDAD,
      switchCrudEntity,
      switchToIndicaciones,
      onColegaSelectorChange,
      editEstudioColega,
      openNewEstudioForColega,
      changePage,
      openModal,
      saveItem,
      deleteItem,
      MUESTRA_CAMPOS,
      ESTUDIO_COLEGA_SECCIONES,
      sectionsOpen,
      toggleSection,
      fieldsForSection,
      muestrasForm,
      muestrasLoading,
      addMuestraRow,
      duplicateMuestraRow,
      removeMuestraRow,
      moveMuestraRow,
      addAlternativaRow,
      duplicateAlternativaRow,
      removeAlternativaRow,
      moveAlternativaRow,
      INDICACIONES_COLUMNAS,
      visibleColumns,
      visibleColumnasList,
      toggleColumn,
      showColumnPicker,
      expandedRows,
      toggleRowExpand,
      rowMuestrasCache,
      rowMuestrasLoading
    };
  }
}).mount('#app');
