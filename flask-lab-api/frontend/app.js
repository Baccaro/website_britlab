const { createApp, ref, computed, watch, onMounted } = Vue;

// Opción especial del selector de colega que muestra el catálogo completo de Estudios
const ALL_ESTUDIOS = '__ALL_ESTUDIOS__';

// Entidades con botón propio en la barra de navegación superior.
const TOP_NAV_ENTITY_KEYS = ['colegas', 'metodos'];

// Catálogos de Muestras: quedan agrupados en el dropdown "Muestras" de la
// barra de navegación superior (mismas opciones que tenía antes en el sidebar).
const MUESTRAS_CATALOGO_KEYS = ['tipos_muestra', 'aditivos', 'unidades_medida', 'recipientes',
  'modalidades_recoleccion', 'tecnicas_recoleccion', 'conservaciones', 'condiciones_especiales', 'prioridades_envio'];

// Esquema de roles y permisos por módulo: cada "pantalla" del front pertenece
// a uno de los módulos del sistema (Estudios, Obras Sociales, Web, FAQ — la
// administración de usuarios NO es un módulo asignable, es exclusiva de
// SuperAdmin). Todo lo agrupado bajo el dropdown "Estudios" de la barra de
// navegación (Estudios, Laboratorios Procesantes, Métodos, Muestras) cae bajo
// el módulo "estudios".
const MODULOS_DISPONIBLES = [
  { key: 'estudios', label: 'Estudios' },
  { key: 'obras_sociales', label: 'Obras Sociales' },
  { key: 'web', label: 'Web' },
  { key: 'faq', label: 'FAQ' },
];
const ROLES_MODULO_DISPONIBLES = [
  { key: 'consultor', label: 'Consultor (sólo lectura)' },
  { key: 'administrador', label: 'Administrador (lectura y escritura)' },
];
const MODULO_POR_PANTALLA = {
  estudios: 'estudios', colegas: 'estudios', metodos: 'estudios',
  tipos_muestra: 'estudios', aditivos: 'estudios', unidades_medida: 'estudios', recipientes: 'estudios',
  modalidades_recoleccion: 'estudios', tecnicas_recoleccion: 'estudios', conservaciones: 'estudios',
  condiciones_especiales: 'estudios', prioridades_envio: 'estudios',
  obras_sociales: 'obras_sociales', web_britlab: 'web', faq: 'faq',
};

// Clase de color del badge de estado, tanto en los filtros como en la
// columna "Estado" de la tabla.
const ESTADO_CHIP_CLASS = {
  listo: 'bg-success-teal',
  verificado: 'bg-blue-600',
  pendiente: 'bg-tertiary',
  revisar: 'bg-warning text-dark',
  borrador: 'bg-white text-on-surface-variant border border-outline-variant'
};


// Campos de una muestra estructurada (o de una alternativa suya: misma forma),
// en el orden en que se muestran en el formulario. 'volumen' no es un catálogo
// (no tiene 'ref'); el resto son "combo": input autocompletable contra una
// tabla de referencia, con opción de crear un valor nuevo si no existe.
const MUESTRA_CAMPOS = [
  { field: 'id_tipo_muestra', ref: 'tipos_muestra', label: 'Tipo de Muestra', required: true, type: 'combo' },
  { field: 'id_aditivo', ref: 'aditivos', label: 'Aditivo', type: 'combo' },
  { field: 'volumen', label: 'Volumen', type: 'number' },
  { field: 'id_unidad_medida', ref: 'unidades_medida', label: 'Unidad de Medida', type: 'combo' },
  { field: 'id_recipiente', ref: 'recipientes', label: 'Recipiente', type: 'combo' },
  { field: 'id_modalidad_recoleccion', ref: 'modalidades_recoleccion', label: 'Modalidad de Recolección', type: 'combo' },
  { field: 'id_tecnica_recoleccion', ref: 'tecnicas_recoleccion', label: 'Técnica de Recolección', type: 'combo' },
  { field: 'id_conservacion', ref: 'conservaciones', label: 'Conservación / Temperatura', type: 'combo' },
  { field: 'id_condicion_especial', ref: 'condiciones_especiales', label: 'Condición Especial', type: 'combo' },
  { field: 'id_prioridad_envio', ref: 'prioridades_envio', label: 'Prioridad / Envío', type: 'combo' }
];

// Secciones desplegables del formulario de "Estudio x Colega". 'muestras' no
// lleva 'fields': esa sección se arma aparte (ver muestrasForm más abajo).
const ESTUDIO_COLEGA_SECCIONES = [
  {
    key: 'general', title: 'Identificación',
    desc: 'Estudio, laboratorio procesante, área y método.',
    fields: ['id_estudio', 'colega_id', 'id_sector_laboratorio', 'id_metodo']
  },
  { key: 'muestras', title: 'Muestras', desc: 'Una o varias muestras admitidas, cada una con su recolección y conservación.' },
  {
    key: 'preanalitico', title: 'Preanalítico',
    desc: 'Descripción y documentación adjunta.',
    fields: ['preanalitico_descripcion']
  },
  {
    key: 'indicaciones_pacientes', title: 'Indicaciones Pacientes',
    desc: 'Descripción de las indicaciones y documentación adjunta para el paciente.',
    fields: ['indicaciones_pacientes']
  },
  {
    key: 'indicaciones_colega', title: 'Indicaciones al Profesional / Derivante',
    desc: 'Descripción de las indicaciones para el laboratorio procesante.',
    fields: ['indicaciones_colega']
  },
  {
    key: 'modelo_derivante', title: 'Modelo Derivante',
    desc: 'Observaciones y modelos de informe (PDF) del laboratorio derivante, cada uno con su propia descripción.',
    fields: ['modelo_derivante_observaciones']
  },
  {
    key: 'procesamiento', title: 'Procesamiento y Tiempos',
    desc: 'Demora y observaciones operativas.',
    fields: ['dias_demora', 'observaciones_operativas']
  },
  {
    key: 'paridad_publicacion', title: 'Paridad y Publicación',
    desc: 'Identificadores del registro, estado y visibilidad.',
    // 'codigo_hexalis' no es un campo propio (pertenece al Estudio elegido):
    // se muestra aparte, de sólo lectura, antes de estos campos.
    fields: ['nemonico_datatech', 'tharsis', 'codigo_laboratorio', 'estado', 'habilitar_ia', 'habilitar_web']
  }
];

// Qué secciones del formulario llevan además un cargador de PDFs (1..N), y a
// qué categoría de estudio_colega_modelo corresponde cada una. Sólo
// 'modelo_derivante' permite ponerle una descripción propia a cada archivo.
const CATEGORIA_PDF_POR_SECCION = { preanalitico: 'preanalitico', indicaciones_pacientes: 'paciente', modelo_derivante: 'colega' };
const SECCIONES_CON_PDF = Object.keys(CATEGORIA_PDF_POR_SECCION);
const LABEL_PDF_POR_SECCION = {
  preanalitico: 'Documentación de Preanalítico (PDF)',
  indicaciones_pacientes: 'Documentación para el Paciente (PDF)',
  modelo_derivante: 'Modelos de Informe del Derivante (PDF)',
};

let _muestraKeySeq = 0;
const nextMuestraKey = () => `m${_muestraKeySeq++}`;

// Columnas disponibles en la tabla "Estudios por Colega" (para el selector de
// columnas visibles). Las primeras 10 son las que se muestran por defecto,
// en el orden pedido; el resto queda disponible para activar desde "Columnas".
const INDICACIONES_COLUMNAS = [
  { field: 'estudio_descripcion', label: 'Estudio' },
  { field: 'codigo_hexalis', label: 'Cód. Hex.' },
  { field: 'nemonico_datatech', label: 'Nemónico' },
  { field: 'colega_descripcion', label: 'Procesador' },
  { field: 'metodo', label: 'Método' },
  { field: 'muestra', label: 'Muestra' },
  { field: 'dias_demora', label: 'Dem.' },
  { field: 'indicaciones_pacientes', label: 'Ind. Paciente' },
  { field: 'indicaciones_colega', label: 'Modelo Laboratorio Procesante' },
  { field: 'estado', label: 'Estado' },
  { field: 'paridad_datatech_hexalis', label: 'Paridad' },
  { field: 'codigo_laboratorio', label: 'Cód. Lab.' },
  { field: 'revisor', label: 'Revisor' },
  { field: 'observacion', label: 'Observaciones' }
];
const INDICACIONES_COLUMNAS_DEFAULT = [
  'estudio_descripcion', 'codigo_hexalis', 'nemonico_datatech', 'colega_descripcion', 'metodo',
  'muestra', 'dias_demora', 'indicaciones_pacientes', 'indicaciones_colega', 'estado'
];

// Tamaños de página disponibles para los listados paginados (Estudios,
// Métodos, Tipos de Muestra, etc.): por defecto 25, con 50 y 100 como alternativas.
const PAGE_SIZE_OPTIONS = [25, 50, 100];
const AUTH_TOKEN_KEY = 'britlab_token';

const app = createApp({
  setup() {
    const API_BASE = '/api';

    // --- Autenticación: JWT guardado en localStorage, mandado en cada
    // request via interceptor de axios. Sin usuario logueado no se pide
    // ningún dato a la API (ver onMounted). ---
    const authToken = ref(localStorage.getItem(AUTH_TOKEN_KEY) || '');
    const currentUser = ref(null);
    const authView = ref('login'); // 'login' | 'register' | 'forgot' | 'reset'
    const authLoading = ref(false);
    const authError = ref('');
    const authForm = ref({ username: '', password: '', password2: '', nombre_completo: '', email: '' });
    const forgotUsername = ref('');
    const forgotResult = ref(null);
    const resetForm = ref({ token: '', password: '', password2: '' });
    const resetResult = ref('');

    const isLoggedIn = computed(() => !!currentUser.value);
    // SuperAdmin: administración íntegra del sistema (usuarios, roles,
    // permisos, todos los módulos). Es lo único que da acceso al panel de
    // Administración — un Administrador de módulo NO alcanza para eso.
    const isSuperAdmin = computed(() => !!currentUser.value && currentUser.value.rol === 'superadmin');

    // Rol efectivo del usuario logueado en un módulo (null = sin acceso,
    // 'consultor' o 'administrador'). SuperAdmin resuelve siempre a
    // 'administrador' en cualquier módulo. A diferencia del esquema anterior
    // (pantallas, opt-out), acá un módulo ausente de permisos.modulos es
    // sin acceso — hay que asignárselo explícitamente desde Administración.
    const rolEnModulo = (modulo) => {
      if (isSuperAdmin.value) return 'administrador';
      const modulos = (currentUser.value && currentUser.value.permisos && currentUser.value.permisos.modulos) || {};
      const rol = modulos[modulo];
      return (rol === 'consultor' || rol === 'administrador') ? rol : null;
    };
    // Puede crear/editar/deshabilitar en el módulo Estudios (Estudios,
    // Laboratorios Procesantes, Métodos, Muestras): usado en todos los
    // botones de escritura de esas pantallas.
    const isAdmin = computed(() => rolEnModulo('estudios') === 'administrador');

    const misPermisos = computed(() => (currentUser.value && currentUser.value.permisos) || {});
    const pantallaPermitida = (key) => {
      if (isSuperAdmin.value) return true;
      const modulo = MODULO_POR_PANTALLA[key] || key;
      return !!rolEnModulo(modulo);
    };
    const columnaOcultaPorPermiso = (field) => {
      const ocultas = misPermisos.value.columnas_ocultas_estudios;
      return !!(ocultas && ocultas.includes(field));
    };

    axios.interceptors.request.use((config) => {
      if (authToken.value) config.headers.Authorization = `Bearer ${authToken.value}`;
      return config;
    });
    axios.interceptors.response.use(
      (res) => res,
      (err) => {
        if (err.response && err.response.status === 401 && currentUser.value) {
          logout(true);
        }
        return Promise.reject(err);
      }
    );

    const goToAuthView = (view) => {
      authView.value = view;
      authError.value = '';
      forgotResult.value = null;
      resetResult.value = '';
    };

    const afterLogin = async () => {
      // Si a este usuario le restringieron la pantalla de Estudios, arranca
      // en la primera pantalla que sí tenga permitida.
      if (!pantallaPermitida('estudios')) {
        const primeraPermitida = [...TOP_NAV_ENTITY_KEYS, ...MUESTRAS_CATALOGO_KEYS].find(pantallaPermitida);
        if (primeraPermitida) {
          currentView.value = 'crud';
          currentEntityKey.value = primeraPermitida;
        } else {
          const primeraVistaSuelta = ['obras_sociales', 'web_britlab', 'faq'].find(pantallaPermitida);
          if (primeraVistaSuelta) currentView.value = primeraVistaSuelta;
        }
      }
      await fetchRefData();
      if (currentView.value === 'indicaciones') fetchEstudiosPorColega();
      else if (currentView.value === 'crud') fetchItems(1);
    };

    const login = async () => {
      authError.value = '';
      authLoading.value = true;
      try {
        const res = await axios.post(`${API_BASE}/auth/login`, {
          username: authForm.value.username.trim(),
          password: authForm.value.password,
        });
        authToken.value = res.data.token;
        localStorage.setItem(AUTH_TOKEN_KEY, res.data.token);
        currentUser.value = res.data.usuario;
        authForm.value = { username: '', password: '', password2: '', nombre_completo: '', email: '' };
        await afterLogin();
      } catch (err) {
        authError.value = apiErrorMessage(err, 'No se pudo iniciar sesión');
      } finally {
        authLoading.value = false;
      }
    };

    const register = async () => {
      authError.value = '';
      if (authForm.value.password !== authForm.value.password2) {
        authError.value = 'Las contraseñas no coinciden';
        return;
      }
      authLoading.value = true;
      try {
        const res = await axios.post(`${API_BASE}/auth/register`, {
          username: authForm.value.username.trim(),
          password: authForm.value.password,
          nombre_completo: authForm.value.nombre_completo.trim() || null,
          email: authForm.value.email.trim() || null,
        });
        authToken.value = res.data.token;
        localStorage.setItem(AUTH_TOKEN_KEY, res.data.token);
        currentUser.value = res.data.usuario;
        authForm.value = { username: '', password: '', password2: '', nombre_completo: '', email: '' };
        await afterLogin();
        showAlert('Cuenta creada correctamente.');
      } catch (err) {
        authError.value = apiErrorMessage(err, 'No se pudo completar el registro');
      } finally {
        authLoading.value = false;
      }
    };

    const requestForgotPassword = async () => {
      authError.value = '';
      forgotResult.value = null;
      if (!forgotUsername.value.trim()) {
        authError.value = 'Ingresá tu usuario';
        return;
      }
      authLoading.value = true;
      try {
        const res = await axios.post(`${API_BASE}/auth/forgot-password`, { username: forgotUsername.value.trim() });
        forgotResult.value = res.data;
      } catch (err) {
        authError.value = apiErrorMessage(err, 'No se pudo procesar la solicitud');
      } finally {
        authLoading.value = false;
      }
    };

    const submitResetPassword = async () => {
      authError.value = '';
      resetResult.value = '';
      if (resetForm.value.password !== resetForm.value.password2) {
        authError.value = 'Las contraseñas no coinciden';
        return;
      }
      authLoading.value = true;
      try {
        await axios.post(`${API_BASE}/auth/reset-password`, {
          token: resetForm.value.token.trim(),
          password: resetForm.value.password,
        });
        resetResult.value = 'Contraseña actualizada correctamente. Ya podés iniciar sesión.';
        resetForm.value = { token: '', password: '', password2: '' };
        setTimeout(() => goToAuthView('login'), 2500);
      } catch (err) {
        authError.value = apiErrorMessage(err, 'No se pudo actualizar la contraseña');
      } finally {
        authLoading.value = false;
      }
    };

    const logout = (expired = false) => {
      authToken.value = '';
      localStorage.removeItem(AUTH_TOKEN_KEY);
      currentUser.value = null;
      currentView.value = 'indicaciones';
      goToAuthView('login');
      if (expired) showAlert('Tu sesión expiró, iniciá sesión de nuevo', 'warning');
    };

    // Estado Navegación / Vistas
    const currentView = ref('indicaciones'); // 'crud' | 'indicaciones' | 'admin_usuarios'
    const currentEntityKey = ref('estudios');

    // Estado CRUD Generico
    const items = ref([]);
    const loading = ref(false);
    const formData = ref({});
    const modalMode = ref('create');
    // Qué definición de entidad usa el modal genérico actualmente abierto
    // (Estudio x Colega no usa este modal: tiene su propia pantalla completa).
    const modalEntityKey = ref('estudios');
    let modalInstance = null;
    // El modal (#crudModal) recién existe en el DOM una vez logueado (todo el
    // resto de la app vive detrás de v-if="isLoggedIn"), así que no se puede
    // instanciar en onMounted como antes: se crea recién la primera vez que
    // hace falta, con el elemento ya presente.
    const ensureModalInstance = () => {
      if (!modalInstance) {
        const modalEl = document.getElementById('crudModal');
        if (modalEl) modalInstance = new bootstrap.Modal(modalEl);
      }
      return modalInstance;
    };

    // --- "Ver ampliado": abre cualquier campo de texto enriquecido del
    // formulario de Estudio x Colega en un modal grande, para escribir más
    // cómodo. Edita el mismo formData[campo] en vivo (no hay "aceptar/cancelar"
    // por separado: es sólo una vista más grande del mismo campo). ---
    let richModalInstance = null;
    const richModalField = ref(null);
    const richModalLabel = ref('');
    const ensureRichModalInstance = () => {
      if (!richModalInstance) {
        const modalEl = document.getElementById('richEditorModal');
        if (modalEl) richModalInstance = new bootstrap.Modal(modalEl);
      }
      return richModalInstance;
    };
    const abrirEditorAmpliado = (field, label) => {
      richModalField.value = field;
      richModalLabel.value = label;
      ensureRichModalInstance().show();
    };
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
    // arranca en "Todos los Estudios": la misma lista sirve para ese modo
    // (todos los registros, de todos los colegas, sin deduplicar) y para un
    // colega puntual (filtrados por colega_id) — la diferencia está sólo en
    // qué pide fetchEstudiosPorColega().
    const selectedColegaId = ref(ALL_ESTUDIOS);
    const colegaEstudios = ref([]);
    const loadingIndicaciones = ref(false);
    const searchQuery = ref('');
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

    // Además del propio filtro de columnas del usuario, un admin puede haberle
    // ocultado columnas puntuales desde el panel de usuarios (permisos.columnas_ocultas_estudios).
    const visibleColumnasList = computed(() =>
      INDICACIONES_COLUMNAS.filter(c => visibleColumns.value.has(c.field) && !columnaOcultaPorPermiso(c.field))
    );

    const ESTADOS_REGISTRO = ['listo', 'pendiente', 'revisar', 'verificado', 'borrador'];
    const ESTADOS_PARIDAD = ['listo', 'pendiente', 'revisar', 'inactivo', 'discontinuado'];

    // Listas maestras cacheadas para armar los selectores de claves foráneas
    const refData = ref({
      estudios: [], colegas: [], metodos: [], muestras: [], sectores: [], valores_estudio_sector: [],
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
      sectores: 'sectores', valores_estudio_sector: 'valores-estudio-sector',
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
        label: 'Laboratorios Procesantes',
        singular: 'Laboratorio Procesante',
        endpoint: 'colegas',
        icon: 'bi-building',
        searchable: true,
        searchPlaceholder: 'Buscar por nombre de laboratorio procesante...',
        hasEnableToggle: true,
        columns: [
          { field: 'descripcion', label: 'Descripción' },
          { field: 'es_propio', label: 'Propio del Sanatorio', type: 'boolean' },
          { field: 'habilitado', label: 'Estado', type: 'estado-habilitado' },
          { field: 'portal_url', label: 'Portal', type: 'portal' }
        ],
        fields: [
          { field: 'descripcion', label: 'Descripción / Laboratorio', type: 'text', required: true },
          { field: 'es_propio', label: '¿Es un laboratorio propio del Sanatorio Británico?', type: 'switch', default: false },
          { field: 'habilitado', label: '¿Habilitado?', type: 'switch', default: true },
          { field: 'portal_url', label: 'Enlace al Portal', type: 'text' },
          // Sensibles: sólo un admin (o un 'user' con el permiso puntual) las ve
          // al leer; acá se editan sin restricción porque este modal es admin-only.
          { field: 'portal_usuario', label: 'Usuario del Portal', type: 'text' },
          { field: 'portal_password', label: 'Contraseña del Portal', type: 'password' },
          { field: 'observaciones', label: 'Observaciones', type: 'textarea' }
        ]
      },
      metodos: {
        label: 'Métodos',
        singular: 'Método',
        endpoint: 'metodos',
        icon: 'bi-box-seam',
        searchable: true,
        searchPlaceholder: 'Buscar por nombre de método...',
        noDelete: true,
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
        noDelete: true,
        searchable: true,
        searchPlaceholder: 'Buscar por nombre...',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      aditivos: {
        label: 'Aditivos',
        singular: 'Aditivo',
        endpoint: 'aditivos',
        icon: 'bi-eyedropper',
        noDelete: true,
        searchable: true,
        searchPlaceholder: 'Buscar por nombre...',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      unidades_medida: {
        label: 'Unidades de Medida',
        singular: 'Unidad de Medida',
        endpoint: 'unidades-medida',
        icon: 'bi-rulers',
        noDelete: true,
        searchable: true,
        searchPlaceholder: 'Buscar por nombre...',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      recipientes: {
        label: 'Recipientes',
        singular: 'Recipiente',
        endpoint: 'recipientes',
        icon: 'bi-cup-straw',
        noDelete: true,
        searchable: true,
        searchPlaceholder: 'Buscar por nombre...',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      modalidades_recoleccion: {
        label: 'Modalidades de Recolección',
        singular: 'Modalidad de Recolección',
        endpoint: 'modalidades-recoleccion',
        icon: 'bi-calendar-check',
        noDelete: true,
        searchable: true,
        searchPlaceholder: 'Buscar por nombre...',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      tecnicas_recoleccion: {
        label: 'Técnicas de Recolección',
        singular: 'Técnica de Recolección',
        endpoint: 'tecnicas-recoleccion',
        icon: 'bi-tools',
        noDelete: true,
        searchable: true,
        searchPlaceholder: 'Buscar por nombre...',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      conservaciones: {
        label: 'Conservación / Temperatura',
        singular: 'Conservación',
        endpoint: 'conservaciones',
        icon: 'bi-thermometer-snow',
        noDelete: true,
        searchable: true,
        searchPlaceholder: 'Buscar por nombre...',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      condiciones_especiales: {
        label: 'Condiciones Especiales',
        singular: 'Condición Especial',
        endpoint: 'condiciones-especiales',
        icon: 'bi-exclamation-diamond',
        noDelete: true,
        searchable: true,
        searchPlaceholder: 'Buscar por nombre...',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      prioridades_envio: {
        label: 'Prioridad / Envío',
        singular: 'Prioridad de Envío',
        endpoint: 'prioridades-envio',
        icon: 'bi-truck',
        noDelete: true,
        searchable: true,
        searchPlaceholder: 'Buscar por nombre...',
        columns: [{ field: 'nombre', label: 'Nombre' }],
        fields: [{ field: 'nombre', label: 'Nombre', type: 'text', required: true }]
      },
      estudio_colega: {
        label: 'Estudio x Laboratorio Procesante',
        singular: 'Registro Estudio x Laboratorio Procesante',
        endpoint: 'estudio-colega',
        icon: 'bi-diagram-3',
        columns: [
          { field: 'id', label: 'ID' },
          { field: 'nemonico_datatech', label: 'Nemónico' },
          { field: 'id_estudio', label: 'Estudio', type: 'fk', ref: 'estudios' },
          { field: 'colega_id', label: 'Laboratorio Procesante', type: 'fk', ref: 'colegas' },
          { field: 'estado', label: 'Estado' },
          { field: 'paridad_datatech_hexalis', label: 'Paridad' },
          { field: 'revisor', label: 'Revisor' }
        ],
        fields: [
          { field: 'nemonico_datatech', label: 'Nemónico Datatech', type: 'text', required: true },
          { field: 'id_estudio', label: 'Estudio', type: 'fk', ref: 'estudios', required: true, allowCreateNew: true },
          { field: 'colega_id', label: 'Laboratorio Procesante', type: 'fk', ref: 'colegas', required: true },
          { field: 'id_metodo', label: 'Método', type: 'fk', ref: 'metodos' },
          { field: 'id_sector_laboratorio', label: 'Área', type: 'fk', ref: 'valores_estudio_sector' },
          { field: 'paridad_datatech_hexalis', label: 'Paridad Datatech-Hexalis', type: 'select', options: ESTADOS_PARIDAD, default: 'pendiente' },
          { field: 'estado', label: 'Estado', type: 'select', options: ESTADOS_REGISTRO, default: 'pendiente' },
          { field: 'preanalitico_descripcion', label: 'Descripción', type: 'richtext' },
          { field: 'indicaciones_pacientes', label: 'Descripción', type: 'richtext' },
          { field: 'indicaciones_colega', label: 'Descripción', type: 'richtext' },
          { field: 'modelo_derivante_observaciones', label: 'Observaciones', type: 'richtext' },
          { field: 'dias_demora', label: 'Días de Demora', type: 'number', default: 0 },
          // Placeholder visual, sin backend todavía: no se persiste (el schema
          // del servidor ignora cualquier campo que no reconoce).
          { field: 'observaciones_operativas', label: 'Observaciones Operativas', type: 'richtext' },
          { field: 'codigo_laboratorio', label: 'Código Laboratorio Procesante', type: 'text' },
          // 'tharsis', 'habilitar_ia' y 'habilitar_web' son placeholders
          // visuales de una futura integración: tampoco se persisten aún.
          { field: 'tharsis', label: 'Tharsis', type: 'text' },
          { field: 'habilitar_ia', label: '¿Habilitar para Asistente IA?', type: 'switch', default: false },
          { field: 'habilitar_web', label: '¿Habilitar para Página Web?', type: 'switch', default: false },
          { field: 'version', label: 'Versión', type: 'number', default: 1 },
          { field: 'revisor', label: 'Revisor', type: 'text', required: true, default: 'Laboratorio SBLab' },
          { field: 'observacion', label: 'Observación', type: 'textarea' }
        ]
      }
    };

    const topNavEntities = TOP_NAV_ENTITY_KEYS.map(key => [key, entities[key]]);
    const muestrasCatalogoEntities = MUESTRAS_CATALOGO_KEYS.map(key => [key, entities[key]]);
    // Filtradas por el rol del usuario logueado en el módulo "estudios" (ver
    // más abajo, pantallaPermitida): separado de las listas de arriba porque
    // Vue 3 no permite combinar v-for y v-if en el mismo elemento.
    const topNavEntitiesVisibles = computed(() => topNavEntities.filter(([key]) => pantallaPermitida(key)));
    const muestrasCatalogoEntitiesVisibles = computed(() => muestrasCatalogoEntities.filter(([key]) => pantallaPermitida(key)));

    // --- Panel de administración de usuarios ---
    const adminUsuarios = ref([]);
    const adminUsuariosLoading = ref(false);
    const adminUsuarioForm = ref({ username: '', password: '', nombre_completo: '', email: '', rol: 'user' });
    const adminCreandoUsuario = ref(false);
    const expandedUsuarioId = ref(null);
    const permisosEditForm = ref({ modulos: {}, columnas_ocultas_estudios: [], ver_credenciales_colegas: false });

    const fetchAdminUsuarios = async () => {
      adminUsuariosLoading.value = true;
      try {
        const res = await axios.get(`${API_BASE}/usuarios`);
        adminUsuarios.value = res.data;
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudieron cargar los usuarios'), 'danger');
      } finally {
        adminUsuariosLoading.value = false;
      }
    };

    const switchToAdminUsuarios = () => {
      currentView.value = 'admin_usuarios';
      expandedUsuarioId.value = null;
      fetchAdminUsuarios();
    };

    const crearUsuarioAdmin = async () => {
      if (!adminUsuarioForm.value.username.trim() || !adminUsuarioForm.value.password) {
        showAlert('Usuario y contraseña son obligatorios', 'danger');
        return;
      }
      adminCreandoUsuario.value = true;
      try {
        await axios.post(`${API_BASE}/usuarios`, {
          username: adminUsuarioForm.value.username.trim(),
          password: adminUsuarioForm.value.password,
          nombre_completo: adminUsuarioForm.value.nombre_completo.trim() || null,
          email: adminUsuarioForm.value.email.trim() || null,
          rol: adminUsuarioForm.value.rol,
        });
        showAlert('Usuario creado correctamente');
        adminUsuarioForm.value = { username: '', password: '', nombre_completo: '', email: '', rol: 'user' };
        fetchAdminUsuarios();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo crear el usuario'), 'danger');
      } finally {
        adminCreandoUsuario.value = false;
      }
    };

    const toggleUsuarioActivo = async (usuario) => {
      try {
        await axios.put(`${API_BASE}/usuarios/${usuario.id}`, { activo: !usuario.activo });
        showAlert(usuario.activo ? 'Usuario deshabilitado correctamente' : 'Usuario habilitado correctamente');
        fetchAdminUsuarios();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo cambiar el estado del usuario'), 'danger');
      }
    };

    const cambiarRolUsuario = async (usuario, nuevoRol) => {
      try {
        await axios.put(`${API_BASE}/usuarios/${usuario.id}`, { rol: nuevoRol });
        showAlert('Rol actualizado correctamente');
        fetchAdminUsuarios();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo cambiar el rol'), 'danger');
      }
    };

    const resetearPasswordUsuario = async (usuario) => {
      if (!confirm(`¿Resetear la contraseña de "${usuario.username}"? Se va a generar una contraseña provisoria.`)) return;
      try {
        const res = await axios.post(`${API_BASE}/usuarios/${usuario.id}/resetear-password`, {});
        if (res.data.password_generada) {
          // window.alert, no alert() a secas: 'alert' acá es el ref del banner de arriba.
          window.alert(`Nueva contraseña provisoria para ${usuario.username}:\n\n${res.data.password_generada}\n\nCompartísela al usuario; puede cambiarla luego desde "Olvidé mi contraseña".`);
        }
        showAlert('Contraseña reseteada correctamente');
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo resetear la contraseña'), 'danger');
      }
    };

    const toggleEditarPermisos = (usuario) => {
      if (expandedUsuarioId.value === usuario.id) {
        expandedUsuarioId.value = null;
        return;
      }
      expandedUsuarioId.value = usuario.id;
      const p = usuario.permisos || {};
      permisosEditForm.value = {
        modulos: { ...(p.modulos || {}) },
        columnas_ocultas_estudios: [...(p.columnas_ocultas_estudios || [])],
        ver_credenciales_colegas: !!p.ver_credenciales_colegas,
      };
    };

    // Rol de un módulo en el formulario de edición ('' = sin acceso).
    const rolModuloEnEdicion = (modulo) => permisosEditForm.value.modulos[modulo] || '';

    const establecerRolModulo = (modulo, rol) => {
      if (!rol) {
        delete permisosEditForm.value.modulos[modulo];
      } else {
        permisosEditForm.value.modulos[modulo] = rol;
      }
    };

    const togglePermisoColumnaOculta = (field) => {
      const arr = permisosEditForm.value.columnas_ocultas_estudios;
      const i = arr.indexOf(field);
      if (i >= 0) arr.splice(i, 1); else arr.push(field);
    };

    const guardarPermisosUsuario = async (usuario) => {
      try {
        const modulos = Object.keys(permisosEditForm.value.modulos).length ? { ...permisosEditForm.value.modulos } : null;
        const columnasOcultas = permisosEditForm.value.columnas_ocultas_estudios.length
          ? permisosEditForm.value.columnas_ocultas_estudios : null;
        // A diferencia de "modulos" (opt-in: sin asignación no ve nada),
        // columnasOcultas y ver_credenciales_colegas son restricciones extra
        // DENTRO del módulo Estudios; se guardan sólo si están marcadas.
        const permisos = (modulos || columnasOcultas || permisosEditForm.value.ver_credenciales_colegas)
          ? { modulos, columnas_ocultas_estudios: columnasOcultas, ver_credenciales_colegas: permisosEditForm.value.ver_credenciales_colegas }
          : null;
        await axios.put(`${API_BASE}/usuarios/${usuario.id}`, { permisos });
        showAlert('Permisos actualizados correctamente');
        expandedUsuarioId.value = null;
        fetchAdminUsuarios();
        if (currentUser.value && currentUser.value.id === usuario.id) {
          currentUser.value = { ...currentUser.value, permisos };
        }
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudieron guardar los permisos'), 'danger');
      }
    };

    const currentEntity = computed(() => entities[currentEntityKey.value]);
    const modalEntity = computed(() => entities[modalEntityKey.value]);
    const isAllEstudiosMode = computed(() => currentView.value === 'indicaciones' && selectedColegaId.value === ALL_ESTUDIOS);
    const muestrasDropdownActive = computed(() => currentView.value === 'crud' && MUESTRAS_CATALOGO_KEYS.includes(currentEntityKey.value));
    // El nav "Estudios" agrupa Estudios + Laboratorios Procesantes + Métodos +
    // Muestras (con su propio sub-menú): queda "activo" si la vista actual es
    // cualquiera de esas.
    const estudiosDropdownActive = computed(() =>
      currentView.value === 'indicaciones' ||
      (currentView.value === 'crud' && (TOP_NAV_ENTITY_KEYS.includes(currentEntityKey.value) || MUESTRAS_CATALOGO_KEYS.includes(currentEntityKey.value)))
    );
    // "Obras Sociales" / "Web BritLab" / "FAQ": pantallas propias, todavía sin
    // contenido funcional (placeholders explícitos, no simulan datos).
    const switchToPlaceholder = (view) => {
      if (!pantallaPermitida(view)) return;
      currentView.value = view;
    };

    // Un estudio está "en conflicto" cuando figura como 'listo' (activo) en
    // más de un colega a la vez: normalmente debería estar activo en uno solo.
    // Se agrupa por código hexalis sobre la lista SIN filtrar (siempre refleja
    // el estado real de los datos, more allá de qué esté filtrado en pantalla).
    const gruposConflicto = computed(() => {
      if (!isAllEstudiosMode.value) return [];
      const porCodigo = {};
      colegaEstudios.value.forEach(e => {
        if (e.estado !== 'listo') return;
        const grupo = (porCodigo[e.codigo_hexalis] = porCodigo[e.codigo_hexalis] || {
          codigo_hexalis: e.codigo_hexalis, estudio_descripcion: e.estudio_descripcion, filas: []
        });
        grupo.filas.push(e);
      });
      return Object.values(porCodigo).filter(g => g.filas.length >= 2);
    });
    const filasConflicto = computed(() => gruposConflicto.value.flatMap(g => g.filas));
    const codigosConConflicto = computed(() => new Set(gruposConflicto.value.map(g => g.codigo_hexalis)));
    const filaEnConflicto = (e) => isAllEstudiosMode.value && codigosConConflicto.value.has(e.codigo_hexalis);
    const estadoChipClass = (estado) => ESTADO_CHIP_CLASS[estado] || 'bg-tertiary';

    // Filtro reactivo: conflictos (sólo en "Todos los Estudios"), estado y búsqueda.
    const filteredEstudios = computed(() => {
      let lista = soloConflictos.value ? filasConflicto.value : colegaEstudios.value;
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

    // Paginado (client-side, ya que el filtrado por búsqueda/estado/conflictos
    // también es client-side) del listado de "Estudios" (744 registros sin
    // paginar era demasiado para una sola tabla). Tamaño de página elegible
    // (25 por defecto, 50 o 100), recordado en localStorage.
    const estudiosPorPagina = ref(Number(localStorage.getItem('britlab_estudios_por_pagina')) || 25);
    const paginaEstudios = ref(1);
    const totalPaginasEstudios = computed(() =>
      Math.max(1, Math.ceil(filteredEstudios.value.length / estudiosPorPagina.value))
    );
    const estudiosPaginados = computed(() => {
      const inicio = (paginaEstudios.value - 1) * estudiosPorPagina.value;
      return filteredEstudios.value.slice(inicio, inicio + estudiosPorPagina.value);
    });
    const cambiarPaginaEstudios = (page) => {
      if (page >= 1 && page <= totalPaginasEstudios.value) paginaEstudios.value = page;
    };
    const cambiarTamanioPaginaEstudios = (size) => {
      estudiosPorPagina.value = Number(size);
      localStorage.setItem('britlab_estudios_por_pagina', String(estudiosPorPagina.value));
      paginaEstudios.value = 1;
    };
    // Cualquier cambio de filtro vuelve a la página 1 (si no, se podría quedar
    // en una página que ya no existe con el nuevo resultado filtrado).
    watch([searchQuery, estadoFiltro, soloConflictos, selectedColegaId], () => {
      paginaEstudios.value = 1;
    });

    // Métodos CRUD Genericos
    const crudSearchQuery = ref('');
    // Tamaño de página de los listados server-side (Métodos, Tipos de Muestra,
    // etc.): mismo criterio que el de Estudios (25 por defecto, 50 o 100).
    const crudPageSize = ref(Number(localStorage.getItem('britlab_crud_pagina_size')) || 25);
    const cambiarTamanioPaginaCrud = (size) => {
      crudPageSize.value = Number(size);
      localStorage.setItem('britlab_crud_pagina_size', String(crudPageSize.value));
      fetchItems(1);
    };

    const fetchItems = async (page = 1) => {
      loading.value = true;
      try {
        const params = { page, limit: crudPageSize.value };
        if (currentEntity.value.searchable && crudSearchQuery.value.trim()) {
          params.q = crudSearchQuery.value.trim();
        }
        const response = await axios.get(`${API_BASE}/${currentEntity.value.endpoint}`, { params });
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

    const onCrudSearchInput = () => { fetchItems(1); };

    const switchCrudEntity = (key) => {
      if (!pantallaPermitida(key)) return;
      currentView.value = 'crud';
      currentEntityKey.value = key;
      crudSearchQuery.value = '';
      fetchItems(1);
    };

    // Habilitar/deshabilitar un colega en vez de borrarlo (borrarlo dejaría
    // huérfanos sus estudios). Al deshabilitar, se ofrece pasar todos sus
    // estudios a 'pendiente' para que dejen de figurar como vigentes.
    const toggleColegaHabilitado = async (item) => {
      try {
        if (item.habilitado) {
          if (!confirm(`¿Deshabilitar "${item.descripcion}"?`)) return;
          const marcarPendiente = confirm(
            `¿Pasar todos los estudios de "${item.descripcion}" a estado "pendiente"?\n\nAceptar: sí, marcarlos pendientes.\nCancelar: no, dejarlos como están.`
          );
          const res = await axios.post(`${API_BASE}/colegas/${item.id}/deshabilitar`, { marcar_pendiente: marcarPendiente });
          showAlert(
            marcarPendiente
              ? `Laboratorio procesante deshabilitado. ${res.data.estudios_marcados_pendiente} estudio(s) pasaron a "pendiente".`
              : 'Laboratorio procesante deshabilitado correctamente.'
          );
        } else {
          await axios.post(`${API_BASE}/colegas/${item.id}/habilitar`);
          showAlert('Laboratorio procesante habilitado correctamente.');
        }
        fetchItems(pagination.value.page);
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo cambiar el estado del laboratorio procesante'), 'danger');
      }
    };

    // Muestra usuario/contraseña del portal de un colega. Si vinieron en null
    // pese a haber datos cargados (portal_usuario_cargado/portal_password_cargado)
    // es que el backend los redactó por falta de permiso (ver_credenciales_colegas):
    // se avisa en vez de mostrar "vacío" como si no hubiera nada cargado.
    const verCredencialesColega = (item) => {
      if (item.portal_usuario == null && item.portal_password == null && (item.portal_usuario_cargado || item.portal_password_cargado)) {
        showAlert('Este laboratorio procesante tiene credenciales de portal cargadas, pero no tenés permiso para verlas.', 'danger');
        return;
      }
      window.alert(`Credenciales del portal de "${item.descripcion}":\n\nUsuario: ${item.portal_usuario || '(sin usuario)'}\nContraseña: ${item.portal_password || '(sin contraseña)'}`);
    };

    // El botón "Estudios" de la barra superior siempre vuelve al catálogo
    // maestro "Todos los Estudios", sin recordar el último colega elegido.
    const switchToIndicaciones = () => {
      if (!pantallaPermitida('estudios')) return;
      currentView.value = 'indicaciones';
      searchQuery.value = '';
      estadoFiltro.value = null;
      soloConflictos.value = false;
      selectedColegaId.value = ALL_ESTUDIOS;
      fetchEstudiosPorColega();
    };

    // Métodos Vista "Estudios por Colega": "Todos los Estudios" trae TODOS
    // los registros de TODOS los colegas sin deduplicar (un estudio en 2
    // colegas aparece 2 veces), cualquier otra opción filtra a ese colega puntual.
    const fetchEstudiosPorColega = async () => {
      if (!selectedColegaId.value) {
        colegaEstudios.value = [];
        return;
      }
      loadingIndicaciones.value = true;
      expandedRows.value = new Set();
      try {
        const url = selectedColegaId.value === ALL_ESTUDIOS
          ? `${API_BASE}/estudio-colega/todos`
          : `${API_BASE}/estudio-colega/colega/${selectedColegaId.value}`;
        const res = await axios.get(url);
        colegaEstudios.value = res.data;
      } catch (err) {
        showAlert('Error al consultar los estudios', 'danger');
        colegaEstudios.value = [];
      } finally {
        loadingIndicaciones.value = false;
      }
    };

    const onColegaSelectorChange = () => {
      searchQuery.value = '';
      estadoFiltro.value = null;
      soloConflictos.value = false;
      fetchEstudiosPorColega();
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
        // Arranca mostrando la primera muestra (si tiene alguna cargada).
        if (muestraSeleccionadaPorFila.value[item.id] === undefined) {
          muestraSeleccionadaPorFila.value[item.id] = 0;
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

    // Selector "paginado" de muestras de la tarjeta "Muestras" (un botón por
    // muestra + "Ver todas"): sólo se muestra en la tarjeta la muestra elegida.
    const muestraSeleccionadaPorFila = ref({});
    const seleccionarMuestraFila = (idEstudioColega, idx) => {
      muestraSeleccionadaPorFila.value[idEstudioColega] = idx;
    };

    // --- Panel lateral (desde la derecha) para ver, sin salir de la tabla,
    // el contenido de cada dropdown de documentación de una fila: Preanalítico,
    // Indicaciones Paciente, o Modelo Derivante (éste último con las
    // Indicaciones al Profesional/Derivante también, ya que están relacionadas). ---
    const sidePanel = ref({ open: false, kind: null, item: null, modelos: [], muestras: [], loadingModelos: false });

    const _abrirPanelConPdfs = async (item, kind, categoria) => {
      sidePanel.value = { open: true, kind, item, modelos: [], muestras: [], loadingModelos: true };
      try {
        const res = await axios.get(`${API_BASE}/estudio-colega-modelo/estudio-colega/${item.id}`, { params: { categoria } });
        sidePanel.value.modelos = res.data;
      } catch (err) {
        sidePanel.value.modelos = [];
      } finally {
        sidePanel.value.loadingModelos = false;
      }
    };

    const openPreanaliticoPanel = (item) => _abrirPanelConPdfs(item, 'preanalitico', 'preanalitico');
    const openIndicacionesPanel = (item) => _abrirPanelConPdfs(item, 'paciente', 'paciente');
    const openModeloColegaPanel = (item) => _abrirPanelConPdfs(item, 'colega', 'colega');

    // "Ver todas" en la tarjeta de Muestras: todas las muestras del registro,
    // ya ordenadas por 'orden' (mismo endpoint que arma la tarjeta compacta).
    const openMuestrasPanel = async (item) => {
      sidePanel.value = { open: true, kind: 'muestras', item, modelos: [], muestras: [], loadingModelos: true };
      try {
        const res = await axios.get(`${API_BASE}/estudio-colega-muestra/estudio-colega/${item.id}`);
        sidePanel.value.muestras = res.data;
      } catch (err) {
        sidePanel.value.muestras = [];
      } finally {
        sidePanel.value.loadingModelos = false;
      }
    };

    // Observaciones generales del registro: no tiene PDFs propios, así que no
    // hace falta pedir nada, sólo mostrar lo que ya está en memoria.
    const openObservacionPanel = (item) => {
      sidePanel.value = { open: true, kind: 'observacion', item, modelos: [], muestras: [], loadingModelos: false };
    };

    const closeSidePanel = () => { sidePanel.value.open = false; };

    const changePage = (page) => {
      if (page >= 1 && page <= pagination.value.total_pages) {
        fetchItems(page);
      }
    };

    // Modal genérico: usado por todas las entidades excepto Estudio x Colega,
    // que tiene su propia pantalla completa (ver openEstudioColegaForm más abajo).
    const openModal = (mode, item = null) => {
      modalMode.value = mode;
      modalEntityKey.value = currentEntityKey.value;
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
      ensureModalInstance().show();
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
      MUESTRA_CAMPOS.forEach(c => {
        if (c.field === 'volumen') return;
        row[c.field] = null;
        row['_text_' + c.field] = '';
      });
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
      MUESTRA_CAMPOS.forEach(c => {
        destino[c.field] = origen[c.field];
        if (c.field !== 'volumen') destino['_text_' + c.field] = origen['_text_' + c.field];
      });
      destino.observacion = origen.observacion;
    };

    // El backend ya devuelve, junto a cada id, el nombre resuelto del catálogo
    // (p.ej. 'id_tipo_muestra' + 'tipo_muestra'): se usa directo como texto
    // inicial del combo, sin pedidos extra.
    const labelKeyDeCombo = (field) => field.replace(/^id_/, '');

    const conTextoDeCombos = (row) => {
      const conTexto = { ...row };
      MUESTRA_CAMPOS.forEach(c => {
        if (c.field !== 'volumen') conTexto['_text_' + c.field] = row[labelKeyDeCombo(c.field)] || '';
      });
      return conTexto;
    };

    const fetchMuestrasDeEstudioColega = async (idEstudioColega) => {
      muestrasLoading.value = true;
      try {
        const res = await axios.get(`${API_BASE}/estudio-colega-muestra/estudio-colega/${idEstudioColega}`);
        muestrasForm.value = res.data.map(m => ({
          ...conTextoDeCombos(m),
          _key: nextMuestraKey(),
          _isNew: false,
          alternativas: (m.alternativas || []).map(a => ({ ...conTextoDeCombos(a), _key: nextMuestraKey(), _isNew: false }))
        }));
      } catch (err) {
        showAlert('No se pudieron cargar las muestras de este estudio', 'danger');
        muestrasForm.value = [];
      } finally {
        muestrasLoading.value = false;
      }
    };

    // --- Combo autocompletable + "crear si no existe" para las dimensiones
    // de una muestra (tipo, aditivo, unidad, etc.): igual idea que el picker
    // de Estudio, pero generalizada a cualquier catálogo de 'nombre' simple. ---
    const onComboInput = (row, campo, value) => {
      row['_text_' + campo.field] = value;
      const match = (refData.value[campo.ref] || []).find(o => o.nombre.trim().toLowerCase() === value.trim().toLowerCase());
      row[campo.field] = match ? match.id : null;
    };

    const comboNeedsCreate = (row, campo) => {
      const text = (row['_text_' + campo.field] || '').trim();
      return !!text && !row[campo.field];
    };

    const crearValorCombo = async (row, campo) => {
      const text = (row['_text_' + campo.field] || '').trim();
      if (!text) return;
      try {
        const res = await axios.post(`${API_BASE}/${REF_ENDPOINT[campo.ref]}`, { nombre: text });
        refData.value[campo.ref] = [...refData.value[campo.ref], res.data];
        row[campo.field] = res.data.id;
        row['_text_' + campo.field] = res.data.nombre;
        showAlert(`"${res.data.nombre}" agregado a ${entities[campo.ref].label}`);
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo crear el valor'), 'danger');
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

    // --- Modelos de informe (PDF), 1..N por Estudio x Colega, agrupados por
    // categoría (una por cada dropdown que admite documentación: Preanalítico,
    // Indicaciones Paciente y Modelo Derivante). Editando un registro ya
    // guardado se suben al toque (requieren un id_estudio_colega real).
    // Creando uno nuevo, todavía no existe ese id: los PDF elegidos se
    // bufferan en memoria (como las muestras) y recién se suben al guardar,
    // con el id real que devuelve la creación. Sólo 'colega' (Modelo
    // Derivante) permite ponerle una descripción propia a cada archivo. ---
    const blankModelosPorCategoria = () => ({ preanalitico: [], paciente: [], colega: [] });
    const modelosPorCategoria = ref(blankModelosPorCategoria());
    const modelosLoading = ref(false);
    const modeloSubiendo = ref(false);
    const modelosPendientesPorCategoria = ref(blankModelosPorCategoria()); // {_key, file, descripcion}

    const fetchModelosDeEstudioColega = async (idEstudioColega) => {
      modelosLoading.value = true;
      try {
        const res = await axios.get(`${API_BASE}/estudio-colega-modelo/estudio-colega/${idEstudioColega}`);
        const agrupado = blankModelosPorCategoria();
        res.data.forEach(m => { (agrupado[m.categoria] || (agrupado[m.categoria] = [])).push(m); });
        modelosPorCategoria.value = agrupado;
      } catch (err) {
        modelosPorCategoria.value = blankModelosPorCategoria();
      } finally {
        modelosLoading.value = false;
      }
    };

    const subirModeloInmediato = async (file, categoria, descripcion = null) => {
      const fd = new FormData();
      fd.append('id_estudio_colega', formData.value.id);
      fd.append('archivo', file);
      fd.append('categoria', categoria);
      if (descripcion) fd.append('descripcion', descripcion);
      modeloSubiendo.value = true;
      try {
        await axios.post(`${API_BASE}/estudio-colega-modelo`, fd);
        await fetchModelosDeEstudioColega(formData.value.id);
        showAlert('PDF agregado correctamente');
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo subir el archivo'), 'danger');
      } finally {
        modeloSubiendo.value = false;
      }
    };

    // Si el registro ya existe (edit) sube directo; si se está creando uno
    // nuevo, lo guarda en el buffer para subirlo recién al guardar el formulario.
    const onSeleccionarPdf = (event, categoria) => {
      const file = event.target.files[0];
      event.target.value = '';
      if (!file) return;
      if (!file.name.toLowerCase().endsWith('.pdf')) {
        showAlert('Sólo se aceptan archivos PDF', 'danger');
        return;
      }
      if (modalMode.value === 'edit') {
        subirModeloInmediato(file, categoria);
      } else {
        modelosPendientesPorCategoria.value[categoria].push({ _key: nextMuestraKey(), file, descripcion: '' });
      }
    };

    const quitarModeloPendiente = (categoria, item) => {
      modelosPendientesPorCategoria.value[categoria] = modelosPendientesPorCategoria.value[categoria].filter(m => m._key !== item._key);
    };

    const persistModelosPendientes = async (idEstudioColega) => {
      for (const categoria of Object.keys(modelosPendientesPorCategoria.value)) {
        for (const m of modelosPendientesPorCategoria.value[categoria]) {
          const fd = new FormData();
          fd.append('id_estudio_colega', idEstudioColega);
          fd.append('archivo', m.file);
          fd.append('categoria', categoria);
          if (m.descripcion) fd.append('descripcion', m.descripcion);
          await axios.post(`${API_BASE}/estudio-colega-modelo`, fd);
        }
      }
      modelosPendientesPorCategoria.value = blankModelosPorCategoria();
    };

    const eliminarModelo = async (modelo, categoria) => {
      if (!confirm(`¿Eliminar "${modelo.nombre_archivo}"?`)) return;
      try {
        await axios.delete(`${API_BASE}/estudio-colega-modelo/${modelo.id}`);
        modelosPorCategoria.value[categoria] = modelosPorCategoria.value[categoria].filter(m => m.id !== modelo.id);
        showAlert('Archivo eliminado correctamente');
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo eliminar el archivo'), 'danger');
      }
    };

    // Editar la descripción de un PDF de "Modelo Derivante" ya subido (el
    // resto de categorías no muestran este input, aunque el backend lo acepta
    // para cualquiera).
    const actualizarDescripcionModelo = async (modelo) => {
      try {
        await axios.put(`${API_BASE}/estudio-colega-modelo/${modelo.id}`, { descripcion: modelo.descripcion || null });
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo guardar la descripción del archivo'), 'danger');
      }
    };

    // La descarga ahora requiere sesión (JWT en el header Authorization), así
    // que un <a href> con navegación normal del browser no sirve (no manda el
    // header): se pide como blob vía axios (que sí lo manda, por el
    // interceptor) y se abre en una pestaña nueva ya con el PDF en memoria.
    // La ventana se abre primero, en vacío, porque abrirla recién después del
    // await la bloquearían varios browsers (ya no sería un gesto directo del usuario).
    const abrirModelo = async (modelo) => {
      const nuevaVentana = window.open('', '_blank');
      try {
        const res = await axios.get(`${API_BASE}/estudio-colega-modelo/${modelo.id}/descargar`, { responseType: 'blob' });
        const blobUrl = URL.createObjectURL(new Blob([res.data], { type: 'application/pdf' }));
        if (nuevaVentana) nuevaVentana.location.href = blobUrl;
        else window.open(blobUrl, '_blank');
      } catch (err) {
        if (nuevaVentana) nuevaVentana.close();
        showAlert(apiErrorMessage(err, 'No se pudo abrir el archivo'), 'danger');
      }
    };

    // Estudio x Colega tiene su propia pantalla completa (no un modal): más
    // espacio y claridad para un formulario con varias secciones y muestras.
    const _prepareEstudioColegaForm = (mode, item) => {
      modalMode.value = mode;
      modalEntityKey.value = 'estudio_colega';
      if (mode === 'edit' && item) {
        formData.value = { ...item };
      } else {
        formData.value = {};
        (entities.estudio_colega.fields || []).forEach(f => {
          if (f.default !== undefined) formData.value[f.field] = f.default;
        });
      }
      fkText.value = {};
      (entities.estudio_colega.fields || []).forEach(f => {
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
      modelosPendientesPorCategoria.value = blankModelosPorCategoria();
      if (mode === 'edit') {
        fetchMuestrasDeEstudioColega(formData.value.id);
        fetchModelosDeEstudioColega(formData.value.id);
      } else {
        muestrasForm.value = [];
        modelosPorCategoria.value = blankModelosPorCategoria();
      }
    };

    const openEstudioColegaForm = (mode, item = null) => {
      _prepareEstudioColegaForm(mode, item);
      currentView.value = 'estudio_colega_form';
    };

    const cancelEstudioColegaForm = () => { currentView.value = 'indicaciones'; };

    // Abre la pantalla de "Estudio x Colega" desde la tabla de Estudios por
    // Colega: trae el registro completo (con los ids de FK reales) porque
    // esa tabla solo tiene los nombres ya resueltos.
    const editEstudioColega = async (item) => {
      try {
        const res = await axios.get(`${API_BASE}/estudio-colega/${item.id}`);
        openEstudioColegaForm('edit', res.data);
      } catch (err) {
        showAlert('No se pudo cargar el registro para editar', 'danger');
      }
    };

    // "Nuevo Estudio": disponible tanto con un colega puntual elegido (se
    // precarga) como en "Todos los Estudios" (el usuario elige el Colega a
    // mano en el propio formulario, ya que ahí no hay uno sólo preseleccionado).
    const openNewEstudioForColega = () => {
      openEstudioColegaForm('create');
      if (selectedColegaId.value !== ALL_ESTUDIOS) {
        formData.value.colega_id = selectedColegaId.value;
        fkText.value.colega_id = fkLabel('colegas', selectedColegaId.value) || '';
      }
    };

    // El picker de Estudio tiene texto tipeado que no matchea ninguna opción
    // existente: hay que crear el Estudio antes de guardar el Estudio x Colega.
    const needsNewEstudio = computed(() =>
      modalEntity.value && modalEntity.value.fields.some(f => f.field === 'id_estudio' && f.allowCreateNew) &&
      !!fkText.value.id_estudio && !formData.value.id_estudio
    );

    // Código Hexalis del Estudio elegido: de sólo lectura en "Paridad y
    // Publicación" (el dato pertenece al Estudio, no al registro Estudio x
    // Laboratorio Procesante, así que no se edita acá).
    const codigoHexalisSeleccionado = computed(() => {
      const est = (refData.value.estudios || []).find(e => e.id === formData.value.id_estudio);
      return est ? est.codigo_hexalis : '';
    });

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
          await persistModelosPendientes(savedId);
          currentView.value = 'indicaciones';
          fetchEstudiosPorColega();
        } else {
          ensureModalInstance().hide();
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
    // conflicto de integridad de la BD) a un mensaje legible. Nunca se
    // muestra el detalle crudo de la base de datos (data.detail) en la web:
    // sólo queda en la consola, por si hace falta para soporte.
    const apiErrorMessage = (err, fallback) => {
      const data = err.response?.data;
      if (data?.detail) console.error('Detalle del error (no mostrado en la UI):', data.detail);
      if (Array.isArray(data)) return data.map(d => d.msg).join(' | ');
      if (data?.error) return data.error;
      return fallback;
    };

    // Vista previa de una sola línea de un campo de texto enriquecido (le
    // saca las etiquetas HTML y lo trunca) para las tarjetas resumen de la
    // fila desplegable de "Todos los Estudios".
    const textoPlano = (html, maxLen = 90) => {
      if (!html) return '';
      const texto = html.replace(/<[^>]*>/g, ' ').replace(/\s+/g, ' ').trim();
      return texto.length > maxLen ? texto.slice(0, maxLen) + '…' : texto;
    };

    onMounted(async () => {
      // Sin token guardado, se queda en la pantalla de login sin pedir nada
      // a la API. Con token, se valida contra /api/auth/me antes de cargar
      // el resto de la app (puede haber expirado o el usuario fue deshabilitado).
      if (authToken.value) {
        try {
          const res = await axios.get(`${API_BASE}/auth/me`);
          currentUser.value = res.data;
          await afterLogin();
        } catch (err) {
          authToken.value = '';
          localStorage.removeItem(AUTH_TOKEN_KEY);
        }
      }
    });

    return {
      // Autenticación
      isLoggedIn,
      isAdmin,
      isSuperAdmin,
      rolEnModulo,
      MODULOS_DISPONIBLES,
      ROLES_MODULO_DISPONIBLES,
      authView,
      authLoading,
      authError,
      authForm,
      forgotUsername,
      forgotResult,
      resetForm,
      resetResult,
      currentUser,
      goToAuthView,
      login,
      register,
      requestForgotPassword,
      submitResetPassword,
      logout,
      pantallaPermitida,
      // Panel de administración de usuarios
      adminUsuarios,
      adminUsuariosLoading,
      adminUsuarioForm,
      adminCreandoUsuario,
      expandedUsuarioId,
      permisosEditForm,
      switchToAdminUsuarios,
      crearUsuarioAdmin,
      toggleUsuarioActivo,
      cambiarRolUsuario,
      resetearPasswordUsuario,
      toggleEditarPermisos,
      rolModuloEnEdicion,
      establecerRolModulo,
      togglePermisoColumnaOculta,
      guardarPermisosUsuario,
      // Paginado: tamaño de página elegible
      PAGE_SIZE_OPTIONS,
      estudiosPorPagina,
      cambiarTamanioPaginaEstudios,
      crudPageSize,
      cambiarTamanioPaginaCrud,
      currentView,
      entities,
      topNavEntities,
      muestrasCatalogoEntities,
      topNavEntitiesVisibles,
      muestrasCatalogoEntitiesVisibles,
      muestrasDropdownActive,
      estudiosDropdownActive,
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
      codigoHexalisSeleccionado,
      colegasList: computed(() => refData.value.colegas),
      ALL_ESTUDIOS,
      isAllEstudiosMode,
      selectedColegaId,
      colegaEstudios,
      loadingIndicaciones,
      searchQuery,
      filteredEstudios,
      estudiosPaginados,
      paginaEstudios,
      totalPaginasEstudios,
      cambiarPaginaEstudios,
      gruposConflicto,
      filaEnConflicto,
      estadoChipClass,
      estadoFiltro,
      toggleEstadoFiltro,
      soloConflictos,
      toggleSoloConflictos,
      ESTADOS_REGISTRO,
      ESTADOS_PARIDAD,
      switchCrudEntity,
      switchToIndicaciones,
      switchToPlaceholder,
      onColegaSelectorChange,
      editEstudioColega,
      openNewEstudioForColega,
      openEstudioColegaForm,
      cancelEstudioColegaForm,
      changePage,
      openModal,
      saveItem,
      deleteItem,
      crudSearchQuery,
      onCrudSearchInput,
      toggleColegaHabilitado,
      verCredencialesColega,
      MUESTRA_CAMPOS,
      onComboInput,
      comboNeedsCreate,
      crearValorCombo,
      ESTUDIO_COLEGA_SECCIONES,
      sectionsOpen,
      toggleSection,
      richModalField,
      richModalLabel,
      abrirEditorAmpliado,
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
      rowMuestrasLoading,
      muestraSeleccionadaPorFila,
      seleccionarMuestraFila,
      API_BASE,
      SECCIONES_CON_PDF,
      CATEGORIA_PDF_POR_SECCION,
      LABEL_PDF_POR_SECCION,
      modelosPorCategoria,
      modelosLoading,
      modeloSubiendo,
      modelosPendientesPorCategoria,
      onSeleccionarPdf,
      quitarModeloPendiente,
      eliminarModelo,
      actualizarDescripcionModelo,
      abrirModelo,
      sidePanel,
      openIndicacionesPanel,
      openPreanaliticoPanel,
      openModeloColegaPanel,
      openMuestrasPanel,
      openObservacionPanel,
      closeSidePanel,
      textoPlano
    };
  }
});

// Editor de texto enriquecido (negrita, cursiva, listas) para Indicaciones
// Paciente, Indicaciones Colega y Observaciones: un div contenteditable con
// una mini barra de comandos, guardando el HTML resultante como texto plano
// en el campo (las columnas ya son TEXT, sin cambios de esquema). Al pegar
// contenido se descarta el formato de origen y se inserta como texto plano,
// para no poder inyectar HTML/atributos ajenos vía el portapapeles.
app.component('rich-editor', {
  props: {
    modelValue: { type: String, default: '' },
    placeholder: { type: String, default: '' },
    // 'large': usado dentro del modal de edición ampliada, le da mucho más
    // alto al área de texto para trabajar cómodo en pantalla completa.
    large: { type: Boolean, default: false },
  },
  emits: ['update:modelValue'],
  template: `
    <div :class="['rich-editor', large ? 'rich-editor-lg' : '']">
      <div class="rich-toolbar">
        <button type="button" title="Negrita" @mousedown.prevent="exec('bold')"><i class="bi bi-type-bold"></i></button>
        <button type="button" title="Cursiva" @mousedown.prevent="exec('italic')"><i class="bi bi-type-italic"></i></button>
        <button type="button" title="Lista con viñetas" @mousedown.prevent="exec('insertUnorderedList')"><i class="bi bi-list-ul"></i></button>
        <button type="button" title="Lista numerada" @mousedown.prevent="exec('insertOrderedList')"><i class="bi bi-list-ol"></i></button>
      </div>
      <div ref="editor" class="rich-content form-control form-control-sm" contenteditable="true"
        :data-placeholder="placeholder" @input="onInput" @paste="onPaste"></div>
    </div>
  `,
  mounted() {
    this.$refs.editor.innerHTML = this.modelValue || '';
  },
  watch: {
    modelValue(val) {
      const el = this.$refs.editor;
      if (el && el.innerHTML !== (val || '')) el.innerHTML = val || '';
    }
  },
  methods: {
    exec(cmd) {
      this.$refs.editor.focus();
      document.execCommand(cmd);
      this.onInput();
    },
    onInput() {
      this.$emit('update:modelValue', this.$refs.editor.innerHTML);
    },
    onPaste(e) {
      e.preventDefault();
      const texto = (e.clipboardData || window.clipboardData).getData('text/plain');
      document.execCommand('insertText', false, texto);
    }
  }
});

app.mount('#app');
