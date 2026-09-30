const { createApp, ref, computed, watch, onMounted, nextTick } = Vue;

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
  tarifarios: 'obras_sociales', nomencladores: 'obras_sociales', autorizadores: 'obras_sociales',
};

// Clase de color del badge de estado, tanto en los filtros como en la
// columna "Estado" de la tabla.
const ESTADO_CHIP_CLASS = {
  listo: 'bg-success-teal',
  verificado: 'bg-blue-600',
  pendiente: 'bg-tertiary',
  revisar: 'bg-warning text-dark',
  borrador: 'bg-white text-on-surface-variant border border-outline-variant',
  // Estados propios de FAQ (RN-FAQ-04): 'borrador' ya está definido arriba.
  activo: 'bg-success-teal',
  inactivo: 'bg-tertiary'
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
    desc: 'Identificadores del registro y visibilidad.',
    // 'codigo_hexalis' no es un campo propio (pertenece al Estudio elegido):
    // se muestra aparte, de sólo lectura, antes de estos campos.
    fields: ['nemonico_datatech', 'codigo_ams', 'codigo_laboratorio', 'paridad_datatech_hexalis', 'habilitar_ia', 'habilitar_web']
  },
  {
    key: 'estado_observaciones', title: 'Estado y Observaciones',
    desc: 'Estado del registro y observaciones generales.',
    fields: ['estado', 'observacion']
  }
];

// Qué secciones del formulario llevan además un cargador de PDFs (1..N), y a
// qué categoría de estudio_colega_modelo corresponde cada una. Sólo
// 'modelo_derivante' permite ponerle una descripción propia a cada archivo.
const CATEGORIA_PDF_POR_SECCION = { preanalitico: 'preanalitico', modelo_derivante: 'colega' };
const SECCIONES_CON_PDF = Object.keys(CATEGORIA_PDF_POR_SECCION);
const LABEL_PDF_POR_SECCION = {
  preanalitico: 'Documentación de Preanalítico (PDF)',
  modelo_derivante: 'Modelos de Informe del Derivante (PDF)',
};

let _muestraKeySeq = 0;
const nextMuestraKey = () => `m${_muestraKeySeq++}`;

// Columnas disponibles en la tabla "Estudios por Colega" (para el selector de
// columnas visibles), en el orden fijo pedido. Las marcadas con "fija: true"
// (Estudio, Laboratorio Procesante, Estado) no se pueden sacar desde
// "Columnas": quedan siempre visibles y ancladas (sticky) al hacer scroll
// horizontal (ver .col-pin en index.html y pinStyle/getColWidth más abajo).
const INDICACIONES_COLUMNAS = [
  { field: 'estudio_descripcion', label: 'Estudio', fija: true },
  { field: 'colega_descripcion', label: 'Laboratorio Procesante', fija: true },
  { field: 'estado', label: 'Estado', fija: true },
  { field: 'codigo_hexalis', label: 'Cód. Hexa' },
  { field: 'nemonico_datatech', label: 'Nemónico' },
  { field: 'codigo_laboratorio', label: 'Cód. Lab. Externo' },
  { field: 'codigo_ams', label: 'Cód AMS' },
  { field: 'metodo', label: 'Método' },
  { field: 'muestra', label: 'Muestra' },
  { field: 'dias_demora', label: 'Demora' },
  { field: 'indicaciones_pacientes', label: 'Indicaciones Paciente' },
  { field: 'preanalitico_descripcion', label: 'Pre-Analítico' },
  { field: 'indicaciones_colega', label: 'Indicaciones Profesional / Derivante' },
  { field: 'sector', label: 'Área' },
  { field: 'disponibilidad', label: 'Disponibilidad (Web/IA)' },
  { field: 'paridad_datatech_hexalis', label: 'Paridad' },
  { field: 'revisor', label: 'Revisor' },
  { field: 'observacion', label: 'Observaciones' }
];
// Orden de las columnas "fija" (para calcular el "left" acumulado de cada
// una al anclarlas) y ancho inicial de cada columna (el usuario lo puede
// cambiar arrastrando el borde; ver columnWidths/getColWidth más abajo).
const PINNED_FIELDS_ORDER = ['estudio_descripcion', 'colega_descripcion', 'estado'];
const CHEVRON_WIDTH = 32; // 2rem, la columna del ">" para expandir la fila
const DEFAULT_COL_WIDTH = 150;
const DEFAULT_COL_WIDTHS = {
  estudio_descripcion: 200,
  colega_descripcion: 170,
  estado: 90,
};
const INDICACIONES_COLUMNAS_DEFAULT = [
  'estudio_descripcion', 'colega_descripcion', 'estado', 'codigo_hexalis', 'nemonico_datatech', 'codigo_laboratorio',
  'codigo_ams', 'metodo', 'muestra', 'dias_demora', 'indicaciones_pacientes', 'preanalitico_descripcion',
  'indicaciones_colega', 'sector', 'disponibilidad', 'paridad_datatech_hexalis', 'revisor', 'observacion'
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
    // Puede crear/editar/eliminar preguntas frecuentes (módulo FAQ).
    const puedeEscribirFaq = computed(() => rolEnModulo('faq') === 'administrador');
    // Puede crear/editar/eliminar tarifarios, ítems y precios (módulo Obras
    // Sociales). La auditoría de cada período (quién/cuándo) es aparte: sólo
    // la ve SuperAdmin (isSuperAdmin), ni siquiera un Administrador de este
    // módulo, ver periodosConAuditoria más abajo.
    const puedeEscribirTarifarios = computed(() => rolEnModulo('obras_sociales') === 'administrador');

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

    const login = async (event) => {
      authError.value = '';
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { authError.value = errorValidacion; return; }
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

    const register = async (event) => {
      authError.value = '';
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { authError.value = errorValidacion; return; }
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

    const requestForgotPassword = async (event) => {
      authError.value = '';
      forgotResult.value = null;
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { authError.value = errorValidacion; return; }
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

    const submitResetPassword = async (event) => {
      authError.value = '';
      resetResult.value = '';
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { authError.value = errorValidacion; return; }
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

    // --- "Ver ampliado": abre cualquier campo de texto enriquecido (del
    // formulario de Estudio x Colega, o de cualquier otro, como FAQ) en un
    // modal grande, para escribir más cómodo. Edita el mismo campo en vivo
    // (no hay "aceptar/cancelar" por separado: es sólo una vista más grande
    // del mismo campo). 'targetKey' identifica qué objeto reactivo editar. ---
    let richModalInstance = null;
    const richModalField = ref(null);
    const richModalLabel = ref('');
    const richModalTargetKey = ref('formData');
    const richModalTargetObj = computed(() => (richModalTargetKey.value === 'faqForm' ? faqForm.value : formData.value));
    const ensureRichModalInstance = () => {
      if (!richModalInstance) {
        const modalEl = document.getElementById('richEditorModal');
        if (modalEl) richModalInstance = new bootstrap.Modal(modalEl);
      }
      return richModalInstance;
    };
    const abrirEditorAmpliado = (field, label, targetKey = 'formData') => {
      richModalField.value = field;
      richModalLabel.value = label;
      richModalTargetKey.value = targetKey;
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
    // Las columnas "fija" (Estudio, Laboratorio Procesante, Estado) se muestran
    // siempre, sin depender de si el usuario las tildó en "Columnas".
    const visibleColumnasList = computed(() =>
      INDICACIONES_COLUMNAS.filter(c => (c.fija || visibleColumns.value.has(c.field)) && !columnaOcultaPorPermiso(c.field))
    );
    // Columnas que sí se pueden tildar/destildar desde el selector "Columnas"
    // (las fijas ni siquiera se listan ahí).
    const columnasTogglables = computed(() => INDICACIONES_COLUMNAS.filter(c => !c.fija));

    // Ancho de cada columna de "Todos los Estudios": el usuario lo puede
    // cambiar arrastrando el borde derecho del encabezado (ver
    // startResize/col-resize-handle); se persiste por navegador, igual que
    // las columnas visibles.
    const columnWidths = ref(
      JSON.parse(localStorage.getItem('britlab_anchos_indicaciones') || 'null') || { ...DEFAULT_COL_WIDTHS }
    );
    const getColWidth = (field) => columnWidths.value[field] || DEFAULT_COL_WIDTH;
    const persistColumnWidths = () => {
      localStorage.setItem('britlab_anchos_indicaciones', JSON.stringify(columnWidths.value));
    };

    // Offset "left" acumulado de una columna fija (Estudio/Laboratorio
    // Procesante/Estado), sumando el ancho de la columna del ">" y de las
    // fijas anteriores: recalcula solo cuando alguna cambia de ancho.
    const pinLeftOffset = (field) => {
      const idx = PINNED_FIELDS_ORDER.indexOf(field);
      let left = CHEVRON_WIDTH;
      for (let i = 0; i < idx; i++) left += getColWidth(PINNED_FIELDS_ORDER[i]);
      return left;
    };
    const pinStyle = (field) => {
      const w = getColWidth(field) + 'px';
      // "position: sticky" va acá (inline, máxima prioridad) porque
      // ".th-resizable" pisa el "position: sticky" de ".col-pin" al tener la
      // misma especificidad y venir después en la hoja de estilos.
      return { position: 'sticky', left: pinLeftOffset(field) + 'px', width: w, minWidth: w, maxWidth: w };
    };

    let resizingField = null;
    let resizeStartX = 0;
    let resizeStartWidth = 0;
    const onResizeMove = (e) => {
      if (!resizingField) return;
      const next = Math.max(60, resizeStartWidth + (e.clientX - resizeStartX));
      columnWidths.value[resizingField] = next;
    };
    const onResizeEnd = () => {
      if (!resizingField) return;
      resizingField = null;
      document.removeEventListener('mousemove', onResizeMove);
      document.removeEventListener('mouseup', onResizeEnd);
      persistColumnWidths();
    };
    const startResize = (event, field) => {
      event.preventDefault();
      event.stopPropagation();
      resizingField = field;
      resizeStartX = event.clientX;
      resizeStartWidth = getColWidth(field);
      document.addEventListener('mousemove', onResizeMove);
      document.addEventListener('mouseup', onResizeEnd);
    };

    // Botones "<"/">" junto a "Columnas": alternativa al scrollbar nativo,
    // que con muchas columnas visibles y la tabla muy alta queda al fondo de
    // la página y cuesta encontrarlo/agarrarlo.
    const scrollTablaEstudios = (delta) => {
      const el = document.getElementById('tablaEstudiosScroll');
      if (el) el.scrollBy({ left: delta, behavior: 'smooth' });
    };

    // Cuánto se scrolleó horizontalmente la tabla: la fila de detalle
    // desplegable (colspan a todo el ancho) lo usa para no irse de la vista
    // con translateX (position:sticky no calza bien ahí con el
    // table-layout:fixed + colgroup del resize de columnas).
    const tablaScrollLeft = ref(0);
    const onTablaEstudiosScroll = (e) => { tablaScrollLeft.value = e.target.scrollLeft; };

    const ESTADOS_REGISTRO = ['listo', 'pendiente', 'revisar', 'verificado', 'borrador'];
    // "Paridad" (campo paridad_datatech_hexalis): sólo Sí/No.
    const ESTADOS_PARIDAD = ['Sí', 'No'];

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

    // allSettled (no all): estos catálogos son todos del módulo "estudios",
    // así que a un usuario con acceso sólo a otro módulo (p.ej. Obras
    // Sociales/Tarifarios) el backend le va a rechazar cada uno con 403 — no
    // tiene sentido tirar abajo la carga de TODO ni mostrarle una alerta de
    // error por algo a lo que de entrada no tiene (ni necesita) acceso.
    const fetchRefData = async () => {
      const keys = Object.keys(REF_ENDPOINT);
      const resultados = await Promise.allSettled(
        keys.map(k => axios.get(`${API_BASE}/${REF_ENDPOINT[k]}`, { params: { limit: 3000 } }))
      );
      const nuevo = { ...refData.value };
      resultados.forEach((r, i) => {
        if (r.status === 'fulfilled') nuevo[keys[i]] = r.value.data.items;
      });
      refData.value = nuevo;
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
          { field: 'paridad_datatech_hexalis', label: 'Paridad', type: 'select', options: ESTADOS_PARIDAD, default: 'No' },
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
          { field: 'codigo_ams', label: 'Código AMS', type: 'text' },
          { field: 'habilitar_ia', label: '¿Habilitar para Asistente IA?', type: 'switch', default: false },
          { field: 'habilitar_web', label: '¿Habilitar para Página Web?', type: 'switch', default: false },
          { field: 'version', label: 'Versión', type: 'number', default: 1 },
          { field: 'revisor', label: 'Revisor', type: 'text', required: true, default: 'Laboratorio SBLab' },
          { field: 'observacion', label: 'Observación', type: 'richtext' }
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

    const crearUsuarioAdmin = async (event) => {
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
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
    // El nav "Obras Sociales" agrupa Obras Sociales, Nomencladores,
    // Autorizadores y Tarifarios.
    const VISTAS_DROPDOWN_OBRAS_SOCIALES = [
      'obras_sociales', 'obra_social_form', 'tarifarios', 'tarifario_form', 'nomencladores', 'autorizadores',
    ];
    const obrasSocialesDropdownActive = computed(() => VISTAS_DROPDOWN_OBRAS_SOCIALES.includes(currentView.value));
    // "Web BritLab": pantalla propia, todavía sin contenido funcional
    // (placeholder explícito, no simula datos).
    const switchToPlaceholder = (view) => {
      if (!pantallaPermitida(view)) return;
      currentView.value = view;
    };

    // --- Módulo FAQ (Preguntas Frecuentes) ---
    const ESTADOS_FAQ = ['borrador', 'activo', 'inactivo'];
    const faqItems = ref([]);
    const faqLoading = ref(false);
    const faqPagination = ref({ page: 1, limit: 25, total: 0, total_pages: 1 });
    const faqPageSize = ref(Number(localStorage.getItem('britlab_faq_pagina_size')) || 25);
    const faqCategoriasDisponibles = ref([]);
    const faqBusqueda = ref('');
    const faqCategoriaFiltro = ref('');
    const faqDisponibilidadFiltro = ref({ web: false, ia: false, interno: false });
    const faqEstadoFiltro = ref('');
    const expandedFaqId = ref(null);
    const faqForm = ref({});
    const faqModalMode = ref('create');
    const faqGuardando = ref(false);

    const fetchFaqCategorias = async () => {
      try {
        const res = await axios.get(`${API_BASE}/faq/categorias`);
        faqCategoriasDisponibles.value = res.data;
      } catch (err) {
        faqCategoriasDisponibles.value = [];
      }
    };

    const fetchFaqItems = async (page = 1) => {
      faqLoading.value = true;
      try {
        const params = { page, limit: faqPageSize.value };
        if (faqBusqueda.value.trim()) params.q = faqBusqueda.value.trim();
        if (faqCategoriaFiltro.value) params.categoria = faqCategoriaFiltro.value;
        if (faqEstadoFiltro.value) params.estado = faqEstadoFiltro.value;
        if (faqDisponibilidadFiltro.value.web) params.web = 'true';
        if (faqDisponibilidadFiltro.value.ia) params.ia = 'true';
        if (faqDisponibilidadFiltro.value.interno) params.interno = 'true';
        const res = await axios.get(`${API_BASE}/faq`, { params });
        faqItems.value = res.data.items;
        faqPagination.value = {
          page: res.data.page, limit: res.data.limit,
          total: res.data.total, total_pages: res.data.total_pages,
        };
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudieron cargar las preguntas frecuentes'), 'danger');
      } finally {
        faqLoading.value = false;
      }
    };

    const switchToFaq = () => {
      if (!pantallaPermitida('faq')) return;
      currentView.value = 'faq';
      expandedFaqId.value = null;
      fetchFaqCategorias();
      fetchFaqItems(1);
    };

    const cambiarPaginaFaq = (page) => {
      if (page >= 1 && page <= faqPagination.value.total_pages) fetchFaqItems(page);
    };
    const cambiarTamanioPaginaFaq = (size) => {
      faqPageSize.value = Number(size);
      localStorage.setItem('britlab_faq_pagina_size', String(faqPageSize.value));
      fetchFaqItems(1);
    };
    const onFaqFiltroChange = () => { fetchFaqItems(1); };

    const toggleFaqRowExpand = (id) => {
      expandedFaqId.value = expandedFaqId.value === id ? null : id;
    };

    // Texto informativo de disponibilidad, según RN-FAQ-03/05/06/07: refleja
    // dónde va a aparecer (o no) la pregunta según canal + estado elegidos.
    const textoDisponibilidadFaq = (item) => {
      const canal = item.disponible_web && item.disponible_ia ? 'Web + Asistente IA'
        : item.disponible_web ? 'Web'
        : item.disponible_ia ? 'Asistente IA'
        : 'Exclusivamente interno';
      if (item.estado === 'borrador') return `En preparación (Borrador). Cuando pase a Activo, se publicará en: ${canal}.`;
      if (item.estado === 'inactivo') return `Inactiva: no visible al público, sólo consultable desde Administración. Canal configurado: ${canal}.`;
      return `Publicada en: ${canal}.`;
    };

    const abrirFaqForm = (mode, item = null) => {
      faqModalMode.value = mode;
      if (mode === 'edit' && item) {
        faqForm.value = { ...item };
      } else {
        faqForm.value = { pregunta: '', respuesta: '', categoria: '', disponible_web: false, disponible_ia: false, estado: 'borrador' };
      }
      currentView.value = 'faq_form';
    };
    const cancelarFaqForm = () => { currentView.value = 'faq'; };

    const guardarFaq = async (event) => {
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
      if (!faqForm.value.pregunta || !faqForm.value.pregunta.trim()) {
        showAlert('La pregunta es obligatoria', 'danger'); return;
      }
      if (!faqForm.value.respuesta || !faqForm.value.respuesta.trim()) {
        showAlert('La respuesta es obligatoria', 'danger'); return;
      }
      if (!faqForm.value.categoria || !faqForm.value.categoria.trim()) {
        showAlert('La categoría es obligatoria', 'danger'); return;
      }
      faqGuardando.value = true;
      try {
        if (faqModalMode.value === 'create') {
          await axios.post(`${API_BASE}/faq`, faqForm.value);
          showAlert('Pregunta frecuente creada correctamente');
        } else {
          await axios.put(`${API_BASE}/faq/${faqForm.value.id}`, faqForm.value);
          showAlert('Pregunta frecuente actualizada correctamente');
        }
        currentView.value = 'faq';
        fetchFaqCategorias();
        fetchFaqItems(faqPagination.value.page);
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo guardar la pregunta frecuente'), 'danger');
      } finally {
        faqGuardando.value = false;
      }
    };

    const eliminarFaq = async (item) => {
      if (!confirm(`¿Eliminar la pregunta "${item.pregunta}"?`)) return;
      try {
        await axios.delete(`${API_BASE}/faq/${item.id}`);
        showAlert('Pregunta frecuente eliminada correctamente');
        fetchFaqItems(faqPagination.value.page);
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo eliminar la pregunta frecuente'), 'danger');
      }
    };

    // --- Módulo Tarifarios (Obras Sociales): tarifarios/convenios (master),
    // cada uno con sus ítems (un Estudio con precio) y el historial de
    // precios por período de cada ítem (detail). Vista master-detail: lista
    // de tarifarios a la izquierda, detalle del elegido a la derecha. ---
    const TIPOS_TARIFARIO = ['TARIFARIO', 'CONVENIO', 'DERIVACION', 'LISTA', 'ANEXO'];
    const TIPOS_TARIFARIO_LABEL = {
      TARIFARIO: 'Tarifario', CONVENIO: 'Convenio particular', DERIVACION: 'Derivación externa',
      LISTA: 'Lista de precios', ANEXO: 'Anexo',
    };
    const TIPOS_RELACIONADO_TARIFARIO = ['Laboratorio / Procesador externo', 'Obra Social'];
    const ESTADOS_TARIFARIO = ['activo', 'inactivo'];
    const ESTADOS_TARIFARIO_ITEM = ['Activo', 'Inactivo'];

    const tarifarios = ref([]);
    const tarifariosLoading = ref(false);
    const tarifariosPagination = ref({ page: 1, limit: 25, total: 0, total_pages: 1 });
    const tarifariosBusqueda = ref('');
    const tarifariosTipoFiltro = ref('');
    const tarifariosEstadoFiltro = ref('');

    const tarifarioSeleccionado = ref(null);
    const tarifarioDetalleLoading = ref(false);
    const tarifarioItemBusqueda = ref('');

    const tarifarioForm = ref({});
    const tarifarioModalMode = ref('create');
    const tarifarioGuardando = ref(false);

    const fetchTarifarios = async (page = 1) => {
      tarifariosLoading.value = true;
      try {
        const params = { page, limit: tarifariosPagination.value.limit };
        if (tarifariosBusqueda.value.trim()) params.q = tarifariosBusqueda.value.trim();
        if (tarifariosTipoFiltro.value) params.tipo = tarifariosTipoFiltro.value;
        if (tarifariosEstadoFiltro.value) params.estado = tarifariosEstadoFiltro.value;
        const res = await axios.get(`${API_BASE}/tarifarios`, { params });
        tarifarios.value = res.data.items;
        tarifariosPagination.value = {
          page: res.data.page, limit: res.data.limit, total: res.data.total, total_pages: res.data.total_pages,
        };
        // Si el tarifario elegido ya no está en la lista (p.ej. se lo borró
        // desde otra pestaña) o todavía no hay ninguno elegido, se pasa al primero.
        if (tarifarios.value.length && !tarifarios.value.some(t => t.id === (tarifarioSeleccionado.value || {}).id)) {
          seleccionarTarifario(tarifarios.value[0].id);
        } else if (!tarifarios.value.length) {
          tarifarioSeleccionado.value = null;
        }
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudieron cargar los tarifarios'), 'danger');
      } finally {
        tarifariosLoading.value = false;
      }
    };

    // Catálogo de Estudios para el picker de ítems: propio (no refData.estudios,
    // que requiere el módulo 'estudios') porque a este módulo se accede sólo
    // con permiso de 'obras_sociales' (ver /tarifarios/estudios-disponibles).
    const tarifarioEstudiosDisponibles = ref([]);
    const tarifarioEstudioLabel = (e) => `${e.codigo_hexalis} — ${e.descripcion}`;
    const fetchTarifarioEstudiosDisponibles = async () => {
      try {
        const res = await axios.get(`${API_BASE}/tarifarios/estudios-disponibles`);
        tarifarioEstudiosDisponibles.value = res.data;
      } catch (err) {
        tarifarioEstudiosDisponibles.value = [];
      }
    };

    const switchToTarifarios = () => {
      if (!pantallaPermitida('tarifarios')) return;
      currentView.value = 'tarifarios';
      fetchTarifarios(1);
      fetchTarifarioEstudiosDisponibles();
    };

    const cambiarPaginaTarifarios = (page) => {
      if (page >= 1 && page <= tarifariosPagination.value.total_pages) fetchTarifarios(page);
    };
    const onTarifariosFiltroChange = () => fetchTarifarios(1);

    const seleccionarTarifario = async (id) => {
      tarifarioDetalleLoading.value = true;
      tarifarioItemBusqueda.value = '';
      try {
        const res = await axios.get(`${API_BASE}/tarifarios/${id}`);
        tarifarioSeleccionado.value = res.data;
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo cargar el detalle del tarifario'), 'danger');
      } finally {
        tarifarioDetalleLoading.value = false;
      }
    };

    const tarifarioItemsFiltrados = computed(() => {
      const t = tarifarioSeleccionado.value;
      if (!t) return [];
      const q = tarifarioItemBusqueda.value.trim().toLowerCase();
      if (!q) return t.items;
      return t.items.filter(i => [i.estudio_descripcion, i.estudio_codigo_hexalis, i.nemonico, i.codigo]
        .join(' ').toLowerCase().includes(q));
    });

    const abrirTarifarioForm = (mode, item = null) => {
      tarifarioModalMode.value = mode;
      if (mode === 'edit' && item) {
        tarifarioForm.value = { ...item };
      } else {
        tarifarioForm.value = {
          nombre: '', tipo: 'TARIFARIO', tipo_relacionado: 'Laboratorio / Procesador externo',
          entidad: '', moneda: 'ARS', estado: 'activo', observaciones: '',
        };
      }
      currentView.value = 'tarifario_form';
    };
    const cancelarTarifarioForm = () => { currentView.value = 'tarifarios'; };

    const guardarTarifario = async (event) => {
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
      if (!tarifarioForm.value.nombre || !tarifarioForm.value.nombre.trim()) {
        showAlert('El nombre es obligatorio', 'danger'); return;
      }
      tarifarioGuardando.value = true;
      try {
        let id = tarifarioForm.value.id;
        if (tarifarioModalMode.value === 'create') {
          const res = await axios.post(`${API_BASE}/tarifarios`, tarifarioForm.value);
          id = res.data.id;
          showAlert('Tarifario creado correctamente');
        } else {
          await axios.put(`${API_BASE}/tarifarios/${id}`, tarifarioForm.value);
          showAlert('Tarifario actualizado correctamente');
        }
        currentView.value = 'tarifarios';
        await fetchTarifarios(tarifariosPagination.value.page);
        seleccionarTarifario(id);
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo guardar el tarifario'), 'danger');
      } finally {
        tarifarioGuardando.value = false;
      }
    };

    const eliminarTarifario = async (item) => {
      if (!confirm(`¿Eliminar el tarifario "${item.nombre}" y todos sus ítems y precios?`)) return;
      try {
        await axios.delete(`${API_BASE}/tarifarios/${item.id}`);
        showAlert('Tarifario eliminado correctamente');
        fetchTarifarios(1);
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo eliminar el tarifario'), 'danger');
      }
    };

    // --- Ítems de un tarifario (modal chico: Estudio + metadatos; si es
    // nuevo, además pide el período/precio inicial) ---
    let tarifarioItemModalInstance = null;
    const ensureTarifarioItemModalInstance = () => {
      if (!tarifarioItemModalInstance) {
        const el = document.getElementById('tarifarioItemModal');
        if (el) tarifarioItemModalInstance = new bootstrap.Modal(el);
      }
      return tarifarioItemModalInstance;
    };
    const tarifarioItemForm = ref({});
    const tarifarioItemModalMode = ref('create');
    const tarifarioItemFkText = ref('');
    const tarifarioItemGuardando = ref(false);

    const onTarifarioItemEstudioInput = (value) => {
      tarifarioItemFkText.value = value;
      const match = tarifarioEstudiosDisponibles.value.find(e => tarifarioEstudioLabel(e) === value);
      tarifarioItemForm.value.id_estudio = match ? match.id : null;
    };

    const abrirTarifarioItemModal = (mode, item = null) => {
      tarifarioItemModalMode.value = mode;
      if (mode === 'edit' && item) {
        tarifarioItemForm.value = { ...item };
        const est = tarifarioEstudiosDisponibles.value.find(e => e.id === item.id_estudio);
        tarifarioItemFkText.value = est ? tarifarioEstudioLabel(est) : (item.estudio_codigo_hexalis ? `${item.estudio_codigo_hexalis} — ${item.estudio_descripcion}` : '');
      } else {
        tarifarioItemForm.value = { id_estudio: null, nemonico: '', codigo: '', estado: 'Activo', nota: '', periodo: '', precio: null };
        tarifarioItemFkText.value = '';
      }
      ensureTarifarioItemModalInstance().show();
    };

    const guardarTarifarioItem = async (event) => {
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
      const f = tarifarioItemForm.value;
      if (!f.id_estudio) { showAlert('Elegí un Estudio de la lista', 'danger'); return; }
      if (tarifarioItemModalMode.value === 'create' && (!f.periodo || !f.periodo.trim())) {
        showAlert('El período inicial es obligatorio', 'danger'); return;
      }
      if (tarifarioItemModalMode.value === 'create' && (f.precio === null || f.precio === '' || Number(f.precio) < 0)) {
        showAlert('Ingresá un precio inicial válido', 'danger'); return;
      }
      tarifarioItemGuardando.value = true;
      try {
        if (tarifarioItemModalMode.value === 'create') {
          await axios.post(`${API_BASE}/tarifarios/${tarifarioSeleccionado.value.id}/items`, f);
          showAlert('Ítem agregado correctamente');
        } else {
          await axios.put(`${API_BASE}/tarifarios/items/${f.id}`, f);
          showAlert('Ítem actualizado correctamente');
        }
        ensureTarifarioItemModalInstance().hide();
        seleccionarTarifario(tarifarioSeleccionado.value.id);
        fetchTarifarios(tarifariosPagination.value.page);
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo guardar el ítem'), 'danger');
      } finally {
        tarifarioItemGuardando.value = false;
      }
    };

    const eliminarTarifarioItem = async (item) => {
      if (!confirm(`¿Eliminar "${item.estudio_descripcion}" de este tarifario?`)) return;
      try {
        await axios.delete(`${API_BASE}/tarifarios/items/${item.id}`);
        showAlert('Ítem eliminado correctamente');
        seleccionarTarifario(tarifarioSeleccionado.value.id);
        fetchTarifarios(tarifariosPagination.value.page);
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo eliminar el ítem'), 'danger');
      }
    };

    // --- Actualizar precio de un ítem: SIEMPRE pide un período nuevo (nunca
    // pisa el precio vigente), ver app/routes/tarifarios.py create_periodo. ---
    let tarifarioPrecioModalInstance = null;
    const ensureTarifarioPrecioModalInstance = () => {
      if (!tarifarioPrecioModalInstance) {
        const el = document.getElementById('tarifarioPrecioModal');
        if (el) tarifarioPrecioModalInstance = new bootstrap.Modal(el);
      }
      return tarifarioPrecioModalInstance;
    };
    const tarifarioPrecioForm = ref({ periodo: '', precio: null });
    const tarifarioPrecioContexto = ref(null);
    const tarifarioPrecioGuardando = ref(false);

    const abrirPrecioModal = (item) => {
      tarifarioPrecioContexto.value = item;
      tarifarioPrecioForm.value = { periodo: '', precio: item.precio_vigente };
      ensureTarifarioPrecioModalInstance().show();
    };

    const guardarNuevoPrecio = async (event) => {
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
      const f = tarifarioPrecioForm.value;
      if (!f.periodo || !f.periodo.trim()) { showAlert('Ingresá el período de este precio', 'danger'); return; }
      if (f.precio === null || f.precio === '' || Number(f.precio) < 0) { showAlert('Ingresá un precio válido', 'danger'); return; }
      tarifarioPrecioGuardando.value = true;
      try {
        await axios.post(`${API_BASE}/tarifarios/items/${tarifarioPrecioContexto.value.id}/periodos`, f);
        showAlert('Precio actualizado correctamente');
        ensureTarifarioPrecioModalInstance().hide();
        seleccionarTarifario(tarifarioSeleccionado.value.id);
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo actualizar el precio'), 'danger');
      } finally {
        tarifarioPrecioGuardando.value = false;
      }
    };

    // --- Historial de precios (todos los períodos) de un ítem: la auditoría
    // (usuario/fecha) sólo se pide y se muestra si isSuperAdmin. ---
    let tarifarioHistorialModalInstance = null;
    const ensureTarifarioHistorialModalInstance = () => {
      if (!tarifarioHistorialModalInstance) {
        const el = document.getElementById('tarifarioHistorialModal');
        if (el) tarifarioHistorialModalInstance = new bootstrap.Modal(el);
      }
      return tarifarioHistorialModalInstance;
    };
    const tarifarioHistorialItem = ref(null);
    const tarifarioHistorialPeriodos = ref([]);
    const tarifarioHistorialLoading = ref(false);

    const abrirHistorialModal = async (item) => {
      tarifarioHistorialItem.value = item;
      tarifarioHistorialPeriodos.value = [];
      tarifarioHistorialLoading.value = true;
      ensureTarifarioHistorialModalInstance().show();
      try {
        const res = await axios.get(`${API_BASE}/tarifarios/items/${item.id}/periodos`);
        tarifarioHistorialPeriodos.value = res.data;
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo cargar el historial de precios'), 'danger');
      } finally {
        tarifarioHistorialLoading.value = false;
      }
    };

    // --- Catálogos reutilizables entre Obras Sociales: Nomencladores y
    // Autorizadores. Ninguno se borra (allow_delete=False en el backend):
    // se inactivan, para no dejar huérfanas las relaciones que ya los usan.
    // Ambos ofrecen las dos vistas pedidas (tabla con desplegable / split
    // view maestro-detalle) — como no tienen hijos propios, el "detalle" del
    // split view es simplemente el mismo registro que ya está en la lista,
    // sin pedir nada aparte. ---
    const ESTADOS_SIMPLES = ['activo', 'inactivo'];
    const TIPOS_NOMENCLADOR = ['NBU', 'especial', 'convenio_particular', 'listado_anexo'];
    const TIPOS_NOMENCLADOR_LABEL = {
      NBU: 'NBU', especial: 'Nomenclador especial', convenio_particular: 'Convenio particular', listado_anexo: 'Listado / Anexo',
    };
    const TIPOS_AUTORIZADOR = ['Portal externo', 'Sistema interno'];

    function crearEstadoCatalogo(nombreEntidad, endpoint, camposDefault) {
      const items = ref([]);
      const loading = ref(false);
      const pagination = ref({ page: 1, limit: 25, total: 0, total_pages: 1 });
      const busqueda = ref('');
      const estadoFiltro = ref('');
      const vistaModo = ref(localStorage.getItem(`britlab_vista_${nombreEntidad}`) || 'tabla');
      const expandedId = ref(null);
      const seleccionado = ref(null);
      const form = ref({});
      const modalMode = ref('create');
      const guardando = ref(false);
      let modalInstance = null;

      const fetchItems = async (page = 1) => {
        loading.value = true;
        try {
          const params = { page, limit: pagination.value.limit };
          if (busqueda.value.trim()) params.q = busqueda.value.trim();
          if (estadoFiltro.value) params.estado = estadoFiltro.value;
          const res = await axios.get(`${API_BASE}/${endpoint}`, { params });
          items.value = res.data.items;
          pagination.value = { page: res.data.page, limit: res.data.limit, total: res.data.total, total_pages: res.data.total_pages };
          if (seleccionado.value) {
            seleccionado.value = items.value.find(i => i.id === seleccionado.value.id) || null;
          }
          if (!seleccionado.value && items.value.length) seleccionado.value = items.value[0];
        } catch (err) {
          showAlert(apiErrorMessage(err, `No se pudieron cargar los registros de ${nombreEntidad}`), 'danger');
        } finally {
          loading.value = false;
        }
      };

      const setVista = (modo) => {
        vistaModo.value = modo;
        localStorage.setItem(`britlab_vista_${nombreEntidad}`, modo);
      };
      const onFiltroChange = () => fetchItems(1);
      const cambiarPagina = (page) => { if (page >= 1 && page <= pagination.value.total_pages) fetchItems(page); };
      const toggleExpand = (id) => { expandedId.value = expandedId.value === id ? null : id; };
      const seleccionar = (item) => { seleccionado.value = item; };

      const ensureModal = (modalId) => {
        if (!modalInstance) {
          const el = document.getElementById(modalId);
          if (el) modalInstance = new bootstrap.Modal(el);
        }
        return modalInstance;
      };
      const abrirForm = (modalId, mode, item = null) => {
        modalMode.value = mode;
        form.value = mode === 'edit' && item ? { ...item } : { ...camposDefault };
        ensureModal(modalId).show();
      };
      const guardar = async (modalId, event) => {
        const errorValidacion = validarFormulario(event?.target);
        if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
        if (!form.value.nombre || !form.value.nombre.trim()) { showAlert('El nombre es obligatorio', 'danger'); return; }
        guardando.value = true;
        try {
          if (modalMode.value === 'create') {
            await axios.post(`${API_BASE}/${endpoint}`, form.value);
            showAlert('Registro creado correctamente');
          } else {
            await axios.put(`${API_BASE}/${endpoint}/${form.value.id}`, form.value);
            showAlert('Registro actualizado correctamente');
          }
          ensureModal(modalId).hide();
          fetchItems(pagination.value.page);
        } catch (err) {
          showAlert(apiErrorMessage(err, 'No se pudo guardar el registro'), 'danger');
        } finally {
          guardando.value = false;
        }
      };
      const cambiarEstadoActivoInactivo = async (item) => {
        const nuevoEstado = item.estado === 'activo' ? 'inactivo' : 'activo';
        try {
          await axios.put(`${API_BASE}/${endpoint}/${item.id}`, { estado: nuevoEstado });
          showAlert(`Registro ${nuevoEstado === 'activo' ? 'activado' : 'inactivado'} correctamente`);
          fetchItems(pagination.value.page);
        } catch (err) {
          showAlert(apiErrorMessage(err, 'No se pudo cambiar el estado'), 'danger');
        }
      };

      return {
        items, loading, pagination, busqueda, estadoFiltro, vistaModo, expandedId, seleccionado,
        form, modalMode, guardando,
        fetchItems, setVista, onFiltroChange, cambiarPagina, toggleExpand, seleccionar,
        abrirForm, guardar, cambiarEstadoActivoInactivo,
      };
    }

    const nom = crearEstadoCatalogo('nomencladores', 'nomencladores', { nombre: '', tipo: 'NBU', version_o_fecha: '', vigencia: '', link: '', observacion: '', estado: 'activo' });
    const aut = crearEstadoCatalogo('autorizadores', 'autorizadores', { nombre: '', tipo: 'Portal externo', link: '', instructivo: '', observacion: '', estado: 'activo' });

    const switchToNomencladores = () => {
      if (!pantallaPermitida('nomencladores')) return;
      currentView.value = 'nomencladores';
      nom.fetchItems(1);
    };
    const switchToAutorizadores = () => {
      if (!pantallaPermitida('autorizadores')) return;
      currentView.value = 'autorizadores';
      aut.fetchItems(1);
    };

    // "nom"/"aut" agrupan cada bloque de estado por prolijidad (misma lógica
    // de crearEstadoCatalogo), pero se exponen acá con nombres planos porque
    // son refs "sueltos" adentro de un objeto no-reactivo: Vue sólo
    // auto-desenvuelve (y v-model sólo funciona bien con) los refs que
    // quedan como propiedad de primer nivel del objeto que devuelve setup().
    const abrirNomencladorForm = (mode, item) => nom.abrirForm('nomencladorFormModal', mode, item);
    const guardarNomenclador = (event) => nom.guardar('nomencladorFormModal', event);
    const abrirAutorizadorForm = (mode, item) => aut.abrirForm('autorizadorFormModal', mode, item);
    const guardarAutorizador = (event) => aut.guardar('autorizadorFormModal', event);

    // --- Módulo Obras Sociales: Obra Social + Planes, historial de estados,
    // contactos, y relaciones con Nomencladores/Autorizadores (credenciales
    // redactadas salvo SuperAdmin o permiso puntual, ver
    // app/routes/obras_sociales.py). Dos vistas (tabla con desplegable /
    // split view), igual que Nomencladores y Autorizadores. ---
    const ESTADOS_ATENCION = ['activo', 'limitada', 'suspendida', 'sin_atencion'];
    const ESTADOS_ATENCION_LABEL = { activo: 'Activo', limitada: 'Limitada', suspendida: 'Suspendida', sin_atencion: 'Sin atención' };
    const ESTADOS_ATENCION_CHIP = { activo: 'bg-success-teal', limitada: 'bg-warning text-dark', suspendida: 'bg-tertiary', sin_atencion: 'bg-white text-on-surface-variant border border-outline-variant' };
    // Singular/plural para el resumen de planes por estado en el listado
    // (ej. "1 activo, 2 suspendidos y 1 limitado"), ver resumenPlanesPorEstado.
    const ESTADOS_ATENCION_LABEL_CANTIDAD = {
      activo: { s: 'activo', p: 'activos' },
      limitada: { s: 'limitado', p: 'limitados' },
      suspendida: { s: 'suspendido', p: 'suspendidos' },
      sin_atencion: { s: 'sin atención', p: 'sin atención' },
    };
    // Cuántos planes de un ítem del listado hay en cada estado, en orden fijo
    // y sin mostrar los estados en 0 (ej: 4 planes → "1 activo" / "2
    // suspendidos" / "1 limitado", cada uno como chip aparte).
    const resumenPlanesPorEstado = (item) => {
      const conteos = {};
      (item.planes_resumen || []).forEach(p => { conteos[p.estado] = (conteos[p.estado] || 0) + 1; });
      return ESTADOS_ATENCION.filter(e => conteos[e] > 0).map(e => {
        const n = conteos[e];
        const label = ESTADOS_ATENCION_LABEL_CANTIDAD[e][n === 1 ? 's' : 'p'];
        return { estado: e, texto: `${n} ${label}` };
      });
    };
    // Estado "efectivo" que se muestra para la Obra Social: si al menos uno
    // de sus planes está Limitado, la Obra Social se ve como Limitada aunque
    // su propio estado guardado sea otro (no modifica el dato, sólo cómo se
    // pinta el badge en el listado/detalle).
    const estadoEfectivoObraSocial = (item) => {
      const hayLimitado = (item.planes_resumen || []).some(p => p.estado === 'limitada');
      return hayLimitado ? 'limitada' : item.estado;
    };
    const TIPOS_CONTACTO = ['General', 'Autorizaciones', 'Auditoría', 'Convenios', 'Facturación', 'Otro'];
    const PRIORIDADES_AUTORIZADOR = ['principal', 'alternativo'];

    const obrasSociales = ref([]);
    const obrasSocialesLoading = ref(false);
    const obrasSocialesPagination = ref({ page: 1, limit: 25, total: 0, total_pages: 1 });
    const obrasSocialesBusqueda = ref('');
    const obrasSocialesEstadoFiltro = ref('');
    const obrasSocialesEstadoInfoFiltro = ref('');
    const obrasSocialesVistaModo = ref(localStorage.getItem('britlab_vista_obras_sociales') || 'tabla');
    const expandedObraSocialId = ref(null);
    const obraSocialSeleccionada = ref(null);
    const obraSocialDetalleLoading = ref(false);

    const fetchObrasSociales = async (page = 1) => {
      obrasSocialesLoading.value = true;
      try {
        const params = { page, limit: obrasSocialesPagination.value.limit };
        if (obrasSocialesBusqueda.value.trim()) params.q = obrasSocialesBusqueda.value.trim();
        if (obrasSocialesEstadoFiltro.value) params.estado = obrasSocialesEstadoFiltro.value;
        if (obrasSocialesEstadoInfoFiltro.value) params.estado_informacion = obrasSocialesEstadoInfoFiltro.value;
        const res = await axios.get(`${API_BASE}/obras-sociales`, { params });
        obrasSociales.value = res.data.items;
        obrasSocialesPagination.value = { page: res.data.page, limit: res.data.limit, total: res.data.total, total_pages: res.data.total_pages };
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudieron cargar las Obras Sociales'), 'danger');
      } finally {
        obrasSocialesLoading.value = false;
      }
    };

    const setVistaObrasSociales = (modo) => {
      obrasSocialesVistaModo.value = modo;
      localStorage.setItem('britlab_vista_obras_sociales', modo);
    };
    const onObrasSocialesFiltroChange = () => fetchObrasSociales(1);
    const cambiarPaginaObrasSociales = (page) => { if (page >= 1 && page <= obrasSocialesPagination.value.total_pages) fetchObrasSociales(page); };

    const seleccionarObraSocial = async (id) => {
      obraSocialDetalleLoading.value = true;
      try {
        const res = await axios.get(`${API_BASE}/obras-sociales/${id}`);
        if (!obraSocialSeleccionada.value || obraSocialSeleccionada.value.id !== id) {
          expandedObraSocialNomencladorId.value = null;
        }
        obraSocialSeleccionada.value = res.data;
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo cargar el detalle de la Obra Social'), 'danger');
      } finally {
        obraSocialDetalleLoading.value = false;
      }
    };
    const toggleExpandObraSocial = async (id) => {
      if (expandedObraSocialId.value === id) { expandedObraSocialId.value = null; return; }
      expandedObraSocialId.value = id;
      await seleccionarObraSocial(id);
    };

    const refrescarObraSocialActual = async () => {
      const id = obraSocialSeleccionada.value && obraSocialSeleccionada.value.id;
      if (id) await seleccionarObraSocial(id);
      fetchObrasSociales(obrasSocialesPagination.value.page);
    };

    const switchToObrasSociales = () => {
      if (!pantallaPermitida('obras_sociales')) return;
      currentView.value = 'obras_sociales';
      fetchObrasSociales(1);
    };

    // --- Alta / edición de datos generales de la Obra Social: pantalla
    // completa, mismo criterio que Tarifario/FAQ. Planes, contactos,
    // nomencladores y autorizadores se manejan desde el detalle (una vez
    // que la Obra Social ya existe), no en este formulario. ---
    const obraSocialForm = ref({});
    // Alias / otros nombres: input tipo "chips" — cada coma que se tipea
    // cierra un chip nuevo (obraSocialAliasChips) y limpia lo que queda
    // escrito (obraSocialAliasInputTexto) para seguir cargando el próximo.
    const obraSocialAliasChips = ref([]);
    const obraSocialAliasInputTexto = ref('');
    const obraSocialModalMode = ref('create');
    const obraSocialGuardando = ref(false);
    // Estado con el que se abrió el formulario de edición: si al guardar
    // cambió, el cambio se manda aparte por /estado (deja historial con el
    // usuario logueado como "quién lo comunicó"), no por el PUT genérico.
    const obraSocialEstadoAlAbrir = ref(null);

    const onObraSocialAliasInput = (value) => {
      if (!value.includes(',')) { obraSocialAliasInputTexto.value = value; return; }
      const partes = value.split(',');
      const restante = partes.pop();
      partes.forEach(p => {
        const limpio = p.trim();
        if (limpio && !obraSocialAliasChips.value.includes(limpio)) obraSocialAliasChips.value.push(limpio);
      });
      obraSocialAliasInputTexto.value = restante;
    };
    const confirmarObraSocialAliasPendiente = () => {
      const limpio = obraSocialAliasInputTexto.value.trim();
      if (limpio && !obraSocialAliasChips.value.includes(limpio)) obraSocialAliasChips.value.push(limpio);
      obraSocialAliasInputTexto.value = '';
    };
    const onObraSocialAliasKeydown = (e) => {
      if (e.key === 'Enter') { e.preventDefault(); confirmarObraSocialAliasPendiente(); }
      else if (e.key === 'Backspace' && !obraSocialAliasInputTexto.value && obraSocialAliasChips.value.length) {
        obraSocialAliasChips.value.pop();
      }
    };
    const quitarObraSocialAliasChip = (idx) => { obraSocialAliasChips.value.splice(idx, 1); };

    const abrirObraSocialForm = (mode, item = null) => {
      obraSocialModalMode.value = mode;
      obraSocialAliasInputTexto.value = '';
      if (mode === 'edit' && item) {
        obraSocialForm.value = { ...item };
        obraSocialAliasChips.value = [...(item.alias || [])];
        obraSocialEstadoAlAbrir.value = item.estado;
      } else {
        obraSocialForm.value = {
          nombre: '', estado: 'activo', estado_informacion: 'borrador', mostrar_web: false, habilitar_ia: false,
          modalidad_autorizacion: '', observacion_general: '', informacion_publica: '',
        };
        obraSocialAliasChips.value = [];
        obraSocialEstadoAlAbrir.value = null;
      }
      currentView.value = 'obra_social_form';
    };
    const cancelarObraSocialForm = () => { currentView.value = 'obras_sociales'; };

    const guardarObraSocial = async (event) => {
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
      if (!obraSocialForm.value.nombre || !obraSocialForm.value.nombre.trim()) {
        showAlert('El nombre es obligatorio', 'danger'); return;
      }
      confirmarObraSocialAliasPendiente();
      obraSocialGuardando.value = true;
      try {
        // El estado se manda aparte (si cambió) para que quede en el
        // historial con el usuario logueado como "quién lo comunicó" — el
        // PUT genérico de abajo no deja historial.
        const estadoCambio = obraSocialModalMode.value === 'edit' && obraSocialForm.value.estado !== obraSocialEstadoAlAbrir.value;
        const payload = { ...obraSocialForm.value, alias: obraSocialAliasChips.value };
        if (estadoCambio) delete payload.estado;
        let id = obraSocialForm.value.id;
        if (obraSocialModalMode.value === 'create') {
          const res = await axios.post(`${API_BASE}/obras-sociales`, payload);
          id = res.data.id;
          showAlert('Obra Social creada correctamente');
        } else {
          await axios.put(`${API_BASE}/obras-sociales/${id}`, payload);
          if (estadoCambio) {
            await axios.post(`${API_BASE}/obras-sociales/${id}/estado`, {
              estado: obraSocialForm.value.estado,
              comunicado_por: currentUser.value?.username || '',
            });
          }
          showAlert('Obra Social actualizada correctamente');
        }
        currentView.value = 'obras_sociales';
        await fetchObrasSociales(obrasSocialesPagination.value.page);
        seleccionarObraSocial(id);
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo guardar la Obra Social'), 'danger');
      } finally {
        obraSocialGuardando.value = false;
      }
    };

    const eliminarObraSocial = async (item) => {
      if (!confirm(`¿Eliminar la Obra Social "${item.nombre}" y todos sus planes, contactos e historial?`)) return;
      try {
        await axios.delete(`${API_BASE}/obras-sociales/${item.id}`);
        showAlert('Obra Social eliminada correctamente');
        if (obraSocialSeleccionada.value && obraSocialSeleccionada.value.id === item.id) obraSocialSeleccionada.value = null;
        fetchObrasSociales(1);
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo eliminar la Obra Social'), 'danger');
      }
    };

    const validarObraSocial = async (item) => {
      try {
        await axios.post(`${API_BASE}/obras-sociales/${item.id}/validar`);
        showAlert('Obra Social validada correctamente');
        refrescarObraSocialActual();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo validar la Obra Social'), 'danger');
      }
    };
    const volverABorradorObraSocial = async (item) => {
      try {
        await axios.post(`${API_BASE}/obras-sociales/${item.id}/volver-a-borrador`);
        showAlert('Obra Social pasada a Borrador');
        refrescarObraSocialActual();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo cambiar el estado de información'), 'danger');
      }
    };

    // --- Cambiar estado de atención (Obra Social o un Plan puntual): un
    // único modal chico, pide período/comunicado_por/motivo y deja
    // historial (ver ObraSocialHistorialEstado). ---
    let obraSocialEstadoModalInstance = null;
    const ensureObraSocialEstadoModal = () => {
      if (!obraSocialEstadoModalInstance) {
        const el = document.getElementById('obraSocialEstadoModal');
        if (el) obraSocialEstadoModalInstance = new bootstrap.Modal(el);
      }
      return obraSocialEstadoModalInstance;
    };
    const obraSocialEstadoForm = ref({ estado: 'activo', comunicado_por: '', motivo: '' });
    const obraSocialEstadoContexto = ref(null); // { id, nombre } del Plan
    const obraSocialEstadoGuardando = ref(false);

    // El estado de la Obra Social misma ya sólo se cambia editándola (botón
    // Editar): este modal quedó exclusivo para el estado de un Plan puntual.
    // "Quién lo comunicó" tampoco se tipea a mano acá: queda registrado solo
    // con el usuario logueado que hizo el cambio (currentUser).
    const abrirCambioEstadoPlan = (plan) => {
      obraSocialEstadoContexto.value = { id: plan.id, nombre: plan.nombre };
      obraSocialEstadoForm.value = { estado: plan.estado, comunicado_por: currentUser.value?.username || '', motivo: '' };
      ensureObraSocialEstadoModal().show();
    };
    const guardarCambioEstado = async (event) => {
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
      const ctx = obraSocialEstadoContexto.value;
      if (!ctx) return;
      obraSocialEstadoGuardando.value = true;
      try {
        await axios.post(`${API_BASE}/obras-sociales/planes/${ctx.id}/estado`, obraSocialEstadoForm.value);
        showAlert('Estado actualizado correctamente');
        ensureObraSocialEstadoModal().hide();
        refrescarObraSocialActual();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo cambiar el estado'), 'danger');
      } finally {
        obraSocialEstadoGuardando.value = false;
      }
    };

    // --- Historial de cambios de estado de la Obra Social (y sus Planes) ---
    let obraSocialHistorialModalInstance = null;
    const ensureObraSocialHistorialModal = () => {
      if (!obraSocialHistorialModalInstance) {
        const el = document.getElementById('obraSocialHistorialModal');
        if (el) obraSocialHistorialModalInstance = new bootstrap.Modal(el);
      }
      return obraSocialHistorialModalInstance;
    };
    const obraSocialHistorial = ref([]);
    const obraSocialHistorialLoading = ref(false);

    const abrirHistorialObraSocial = async (obraSocial) => {
      obraSocialHistorial.value = [];
      obraSocialHistorialLoading.value = true;
      ensureObraSocialHistorialModal().show();
      try {
        const res = await axios.get(`${API_BASE}/obras-sociales/${obraSocial.id}/historial`);
        obraSocialHistorial.value = res.data;
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo cargar el historial'), 'danger');
      } finally {
        obraSocialHistorialLoading.value = false;
      }
    };

    // --- Planes ---
    let obraSocialPlanModalInstance = null;
    const ensureObraSocialPlanModal = () => {
      if (!obraSocialPlanModalInstance) {
        const el = document.getElementById('obraSocialPlanModal');
        if (el) obraSocialPlanModalInstance = new bootstrap.Modal(el);
      }
      return obraSocialPlanModalInstance;
    };
    const obraSocialPlanForm = ref({});
    const obraSocialPlanModalMode = ref('create');
    const obraSocialPlanGuardando = ref(false);

    const abrirObraSocialPlanForm = (mode, plan = null) => {
      obraSocialPlanModalMode.value = mode;
      obraSocialPlanForm.value = mode === 'edit' && plan
        ? { ...plan }
        // "S/C" (Sin Código) por default: la mayoría de los planes no tienen
        // un código propio y así queda explícito en vez de un campo vacío.
        : { nombre: '', codigo_datatech_gravado: 'S/C', codigo_datatech_exento: 'S/C', estado: 'activo', observacion: '' };
      ensureObraSocialPlanModal().show();
    };
    const guardarObraSocialPlan = async (event) => {
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
      const f = obraSocialPlanForm.value;
      if (!f.nombre || !f.nombre.trim()) { showAlert('El nombre del plan es obligatorio', 'danger'); return; }
      obraSocialPlanGuardando.value = true;
      try {
        if (obraSocialPlanModalMode.value === 'create') {
          await axios.post(`${API_BASE}/obras-sociales/${obraSocialSeleccionada.value.id}/planes`, f);
          showAlert('Plan agregado correctamente');
        } else {
          await axios.put(`${API_BASE}/obras-sociales/planes/${f.id}`, f);
          showAlert('Plan actualizado correctamente');
        }
        ensureObraSocialPlanModal().hide();
        refrescarObraSocialActual();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo guardar el plan'), 'danger');
      } finally {
        obraSocialPlanGuardando.value = false;
      }
    };
    const eliminarObraSocialPlan = async (plan) => {
      if (!confirm(`¿Eliminar el plan "${plan.nombre}"?`)) return;
      try {
        await axios.delete(`${API_BASE}/obras-sociales/planes/${plan.id}`);
        showAlert('Plan eliminado correctamente');
        refrescarObraSocialActual();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo eliminar el plan'), 'danger');
      }
    };

    // --- Contactos ---
    let obraSocialContactoModalInstance = null;
    const ensureObraSocialContactoModal = () => {
      if (!obraSocialContactoModalInstance) {
        const el = document.getElementById('obraSocialContactoModal');
        if (el) obraSocialContactoModalInstance = new bootstrap.Modal(el);
      }
      return obraSocialContactoModalInstance;
    };
    const obraSocialContactoForm = ref({});
    const obraSocialContactoModalMode = ref('create');
    const obraSocialContactoGuardando = ref(false);

    const abrirObraSocialContactoForm = (mode, contacto = null) => {
      obraSocialContactoModalMode.value = mode;
      obraSocialContactoForm.value = mode === 'edit' && contacto
        ? { ...contacto }
        : { tipo: 'General', nombre: '', telefono: '', whatsapp: '', email: '', observacion: '' };
      ensureObraSocialContactoModal().show();
    };
    const guardarObraSocialContacto = async (event) => {
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
      obraSocialContactoGuardando.value = true;
      try {
        const f = obraSocialContactoForm.value;
        if (obraSocialContactoModalMode.value === 'create') {
          await axios.post(`${API_BASE}/obras-sociales/${obraSocialSeleccionada.value.id}/contactos`, f);
          showAlert('Contacto agregado correctamente');
        } else {
          await axios.put(`${API_BASE}/obras-sociales/contactos/${f.id}`, f);
          showAlert('Contacto actualizado correctamente');
        }
        ensureObraSocialContactoModal().hide();
        refrescarObraSocialActual();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo guardar el contacto'), 'danger');
      } finally {
        obraSocialContactoGuardando.value = false;
      }
    };
    const eliminarObraSocialContacto = async (contacto) => {
      if (!confirm('¿Eliminar este contacto?')) return;
      try {
        await axios.delete(`${API_BASE}/obras-sociales/contactos/${contacto.id}`);
        showAlert('Contacto eliminado correctamente');
        refrescarObraSocialActual();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo eliminar el contacto'), 'danger');
      }
    };

    // --- Nomencladores asociados: catálogo propio (nomencladoresDisponibles)
    // buscado al abrir el modal, independiente de la pantalla "Nomencladores"
    // (puede no haberse visitado todavía en esta sesión). ---
    let obraSocialNomencladorModalInstance = null;
    const ensureObraSocialNomencladorModal = () => {
      if (!obraSocialNomencladorModalInstance) {
        const el = document.getElementById('obraSocialNomencladorModal');
        if (el) obraSocialNomencladorModalInstance = new bootstrap.Modal(el);
      }
      return obraSocialNomencladorModalInstance;
    };
    const nomencladoresDisponibles = ref([]);
    const obraSocialNomencladorSeleccionadoId = ref(null);
    const obraSocialNomencladorGuardando = ref(false);

    const abrirObraSocialNomencladorForm = async () => {
      obraSocialNomencladorSeleccionadoId.value = null;
      ensureObraSocialNomencladorModal().show();
      try {
        const res = await axios.get(`${API_BASE}/nomencladores`, { params: { limit: 500, estado: 'activo' } });
        nomencladoresDisponibles.value = res.data.items;
      } catch (err) {
        nomencladoresDisponibles.value = [];
      }
    };
    const guardarObraSocialNomenclador = async (event) => {
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
      if (!obraSocialNomencladorSeleccionadoId.value) { showAlert('Elegí un nomenclador', 'danger'); return; }
      obraSocialNomencladorGuardando.value = true;
      try {
        await axios.post(`${API_BASE}/obras-sociales/${obraSocialSeleccionada.value.id}/nomencladores`, { id_nomenclador: obraSocialNomencladorSeleccionadoId.value });
        showAlert('Nomenclador asociado correctamente');
        ensureObraSocialNomencladorModal().hide();
        refrescarObraSocialActual();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo asociar el nomenclador'), 'danger');
      } finally {
        obraSocialNomencladorGuardando.value = false;
      }
    };
    const quitarObraSocialNomenclador = async (rel) => {
      if (!confirm(`¿Quitar "${rel.nombre}" de esta Obra Social?`)) return;
      try {
        await axios.delete(`${API_BASE}/obras-sociales/nomencladores-rel/${rel.id}`);
        showAlert('Nomenclador desasociado correctamente');
        refrescarObraSocialActual();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo desasociar el nomenclador'), 'danger');
      }
    };
    const expandedObraSocialNomencladorId = ref(null);
    const toggleExpandObraSocialNomenclador = (relId) => {
      expandedObraSocialNomencladorId.value = expandedObraSocialNomencladorId.value === relId ? null : relId;
    };

    // --- Autorizadores asociados (con credenciales propias de la relación,
    // redactadas salvo SuperAdmin o permiso ver_credenciales_autorizadores) ---
    let obraSocialAutorizadorModalInstance = null;
    const ensureObraSocialAutorizadorModal = () => {
      if (!obraSocialAutorizadorModalInstance) {
        const el = document.getElementById('obraSocialAutorizadorModal');
        if (el) obraSocialAutorizadorModalInstance = new bootstrap.Modal(el);
      }
      return obraSocialAutorizadorModalInstance;
    };
    const autorizadoresDisponibles = ref([]);
    const obraSocialAutorizadorForm = ref({});
    const obraSocialAutorizadorModalMode = ref('create');
    const obraSocialAutorizadorGuardando = ref(false);

    const abrirObraSocialAutorizadorForm = async (mode, rel = null) => {
      obraSocialAutorizadorModalMode.value = mode;
      obraSocialAutorizadorForm.value = mode === 'edit' && rel
        ? { ...rel }
        : { id_autorizador: null, prioridad: 'principal', usuario: '', password: '', observacion: '' };
      ensureObraSocialAutorizadorModal().show();
      if (mode === 'create') {
        try {
          const res = await axios.get(`${API_BASE}/autorizadores`, { params: { limit: 500, estado: 'activo' } });
          autorizadoresDisponibles.value = res.data.items;
        } catch (err) {
          autorizadoresDisponibles.value = [];
        }
      }
    };
    const guardarObraSocialAutorizador = async (event) => {
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
      const f = obraSocialAutorizadorForm.value;
      obraSocialAutorizadorGuardando.value = true;
      try {
        if (obraSocialAutorizadorModalMode.value === 'create') {
          if (!f.id_autorizador) { showAlert('Elegí un autorizador', 'danger'); obraSocialAutorizadorGuardando.value = false; return; }
          await axios.post(`${API_BASE}/obras-sociales/${obraSocialSeleccionada.value.id}/autorizadores`, f);
          showAlert('Autorizador asociado correctamente');
        } else {
          await axios.put(`${API_BASE}/obras-sociales/autorizadores-rel/${f.id}`, f);
          showAlert('Autorizador actualizado correctamente');
        }
        ensureObraSocialAutorizadorModal().hide();
        refrescarObraSocialActual();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo guardar el autorizador'), 'danger');
      } finally {
        obraSocialAutorizadorGuardando.value = false;
      }
    };
    const quitarObraSocialAutorizador = async (rel) => {
      if (!confirm(`¿Quitar "${rel.nombre}" de esta Obra Social?`)) return;
      try {
        await axios.delete(`${API_BASE}/obras-sociales/autorizadores-rel/${rel.id}`);
        showAlert('Autorizador desasociado correctamente');
        refrescarObraSocialActual();
      } catch (err) {
        showAlert(apiErrorMessage(err, 'No se pudo desasociar el autorizador'), 'danger');
      }
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
    const blankModelosPorCategoria = () => ({ preanalitico: [], colega: [] });
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

    const saveItem = async (event) => {
      const entity = modalEntity.value;
      const errorValidacion = validarFormulario(event?.target);
      if (errorValidacion) { showAlert(errorValidacion, 'danger'); return; }
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

    // Link de WhatsApp de un contacto: la API de WhatsApp necesita el
    // número completo con código de país (549 para celulares de Argentina)
    // y sin ningún separador.
    const whatsappLink = (numero) => `https://api.whatsapp.com/send/?phone=549${(numero || '').replace(/\D/g, '')}`;

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

    // Alto de los paneles de listado/detalle de un split view (Obras
    // Sociales, etc.): en vez de un "calc(100vh - Npx)" fijo en el CSS —que
    // sólo queda bien en el ancho de ventana con el que se lo midió, porque
    // arriba (filtros, título) puede pasar de una a varias líneas según el
    // ancho disponible—, se mide en JS dónde arranca cada panel de verdad y
    // se le da exactamente el alto que queda hasta el borde de la ventana.
    // Se recalcula solo: al mostrar el panel y cada vez que la ventana
    // cambia de tamaño (no hace falta tocar esto de nuevo si el día de
    // mañana se agrega un split view en otra pantalla, sólo hay que ponerle
    // la clase "split-scroll-pane").
    const ajustarAlturaScrollPanes = () => {
      document.querySelectorAll('.split-scroll-pane').forEach((el) => {
        const top = el.getBoundingClientRect().top;
        el.style.maxHeight = `${Math.max(240, Math.round(window.innerHeight - top - 16))}px`;
      });
    };
    window.addEventListener('resize', ajustarAlturaScrollPanes);

    // Foco automático de formularios: al abrirse un modal o entrar a una
    // pantalla de carga, el foco va directo al primer campo para no obligar
    // a hacer click antes de poder escribir.
    const enfocarPrimerCampo = (contenedor) => {
      if (!contenedor) return;
      const campo = contenedor.querySelector(
        'input:not([type=hidden]):not([disabled]), select:not([disabled]), textarea:not([disabled])'
      );
      if (campo) campo.focus();
    };

    // Etiqueta legible de un campo inválido para listarlo en el cartel de
    // alerta: primero busca un <label for="..."> asociado, si no hay usa el
    // <label> que lo acompaña en el mismo contenedor (el patrón usado en casi
    // todos los formularios de la app), y como último recurso el placeholder.
    const obtenerEtiquetaCampo = (el) => {
      if (el.id) {
        const lbl = document.querySelector(`label[for="${el.id}"]`);
        if (lbl) return lbl.textContent.replace('*', '').trim();
      }
      const wrapper = el.closest('div');
      const lbl = wrapper ? wrapper.querySelector('label') : null;
      if (lbl) return lbl.textContent.replace('*', '').trim();
      return el.getAttribute('placeholder') || el.name || 'Campo requerido';
    };

    // Validación genérica de un <form> antes de guardar: se apoya en los
    // atributos "required" (y demás validaciones nativas de HTML5) que ya
    // tienen los campos. Si falta algo, resalta en rojo los campos
    // incompletos (clase "was-validated" de Bootstrap) y hace scroll + foco
    // al primero. Devuelve el mensaje a mostrar en el cartel de alerta (cada
    // pantalla decide dónde: showAlert() en la app, authError en el login),
    // o null si el formulario está OK para seguir guardando.
    const validarFormulario = (formEl) => {
      if (!formEl || typeof formEl.checkValidity !== 'function') return null;
      formEl.classList.add('was-validated');
      if (formEl.checkValidity()) return null;
      const invalidos = Array.from(formEl.querySelectorAll(':invalid'));
      if (!invalidos.length) return null;
      const etiquetas = [...new Set(invalidos.map(obtenerEtiquetaCampo))];
      const primero = invalidos[0];
      primero.scrollIntoView({ behavior: 'smooth', block: 'center' });
      primero.focus();
      return `Faltan completar campos obligatorios: ${etiquetas.join(', ')}`;
    };

    // Pantallas de carga a página completa (no modal): al entrar, foco en el
    // primer campo. Los modales de Bootstrap se manejan aparte (evento
    // "shown.bs.modal" más abajo), que cubre a todos por igual.
    const VISTAS_CON_FOCO_AUTOMATICO = ['estudio_colega_form', 'obra_social_form', 'tarifario_form', 'faq_form', 'admin_usuarios'];
    watch(currentView, async (v) => {
      if (!VISTAS_CON_FOCO_AUTOMATICO.includes(v)) return;
      await nextTick();
      const main = document.querySelector('main');
      if (!main) return;
      main.querySelectorAll('form.was-validated').forEach(f => f.classList.remove('was-validated'));
      enfocarPrimerCampo(main);
    });
    watch(authView, async () => {
      await nextTick();
      const card = document.querySelector('.auth-card');
      if (!card) return;
      card.querySelectorAll('form.was-validated').forEach(f => f.classList.remove('was-validated'));
      enfocarPrimerCampo(card);
    });
    // Los paneles ".split-scroll-pane" recién existen en el DOM cuando se
    // entra a la pantalla y se está en modo split: hay que recalcular su
    // alto en ese momento (el listener de "resize" ya cubre los cambios de
    // ancho de ventana estando ahí adentro).
    watch([currentView, obrasSocialesVistaModo], async () => {
      await nextTick();
      ajustarAlturaScrollPanes();
    });

    onMounted(async () => {
      // Foco automático al abrirse CUALQUIER modal de Bootstrap: un solo
      // listener delegado en document (los eventos de modal burbujean hasta
      // ahí) cubre a todos los modales de la app por igual, sin tener que
      // engancharlo a mano en cada uno. También limpia el resaltado en rojo
      // de una validación anterior, para que un modal reabierto (o abierto
      // para otro registro) arranque limpio.
      document.addEventListener('shown.bs.modal', (e) => {
        e.target.querySelectorAll('form.was-validated').forEach(f => f.classList.remove('was-validated'));
        enfocarPrimerCampo(e.target);
      });

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
      whatsappLink,
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
      obrasSocialesDropdownActive,
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
      puedeEscribirFaq,
      ESTADOS_FAQ,
      faqItems,
      faqLoading,
      faqPagination,
      faqPageSize,
      faqCategoriasDisponibles,
      faqBusqueda,
      faqCategoriaFiltro,
      faqDisponibilidadFiltro,
      faqEstadoFiltro,
      expandedFaqId,
      faqForm,
      faqModalMode,
      faqGuardando,
      switchToFaq,
      cambiarPaginaFaq,
      cambiarTamanioPaginaFaq,
      onFaqFiltroChange,
      toggleFaqRowExpand,
      textoDisponibilidadFaq,
      abrirFaqForm,
      cancelarFaqForm,
      guardarFaq,
      eliminarFaq,
      puedeEscribirTarifarios,
      TIPOS_TARIFARIO,
      TIPOS_TARIFARIO_LABEL,
      TIPOS_RELACIONADO_TARIFARIO,
      ESTADOS_TARIFARIO,
      ESTADOS_TARIFARIO_ITEM,
      tarifarios,
      tarifariosLoading,
      tarifariosPagination,
      tarifariosBusqueda,
      tarifariosTipoFiltro,
      tarifariosEstadoFiltro,
      tarifarioSeleccionado,
      tarifarioDetalleLoading,
      tarifarioItemBusqueda,
      tarifarioItemsFiltrados,
      tarifarioForm,
      tarifarioModalMode,
      tarifarioGuardando,
      switchToTarifarios,
      cambiarPaginaTarifarios,
      onTarifariosFiltroChange,
      seleccionarTarifario,
      abrirTarifarioForm,
      cancelarTarifarioForm,
      guardarTarifario,
      eliminarTarifario,
      tarifarioEstudiosDisponibles,
      tarifarioEstudioLabel,
      tarifarioItemForm,
      tarifarioItemModalMode,
      tarifarioItemFkText,
      tarifarioItemGuardando,
      onTarifarioItemEstudioInput,
      abrirTarifarioItemModal,
      guardarTarifarioItem,
      eliminarTarifarioItem,
      tarifarioPrecioForm,
      tarifarioPrecioContexto,
      tarifarioPrecioGuardando,
      abrirPrecioModal,
      guardarNuevoPrecio,
      tarifarioHistorialItem,
      tarifarioHistorialPeriodos,
      tarifarioHistorialLoading,
      abrirHistorialModal,
      ESTADOS_SIMPLES,
      TIPOS_NOMENCLADOR,
      TIPOS_NOMENCLADOR_LABEL,
      TIPOS_AUTORIZADOR,
      switchToNomencladores,
      switchToAutorizadores,
      nomencladores: nom.items,
      nomencladoresLoading: nom.loading,
      nomencladoresPagination: nom.pagination,
      nomencladoresBusqueda: nom.busqueda,
      nomencladoresEstadoFiltro: nom.estadoFiltro,
      nomencladoresVistaModo: nom.vistaModo,
      nomencladorExpandedId: nom.expandedId,
      nomencladorSeleccionado: nom.seleccionado,
      nomencladorForm: nom.form,
      nomencladorModalMode: nom.modalMode,
      nomencladorGuardando: nom.guardando,
      fetchNomencladores: nom.fetchItems,
      setVistaNomencladores: nom.setVista,
      onNomencladoresFiltroChange: nom.onFiltroChange,
      cambiarPaginaNomencladores: nom.cambiarPagina,
      toggleExpandNomenclador: nom.toggleExpand,
      seleccionarNomenclador: nom.seleccionar,
      abrirNomencladorForm,
      guardarNomenclador,
      cambiarEstadoNomenclador: nom.cambiarEstadoActivoInactivo,
      autorizadores: aut.items,
      autorizadoresLoading: aut.loading,
      autorizadoresPagination: aut.pagination,
      autorizadoresBusqueda: aut.busqueda,
      autorizadoresEstadoFiltro: aut.estadoFiltro,
      autorizadoresVistaModo: aut.vistaModo,
      autorizadorExpandedId: aut.expandedId,
      autorizadorSeleccionado: aut.seleccionado,
      autorizadorForm: aut.form,
      autorizadorModalMode: aut.modalMode,
      autorizadorGuardando: aut.guardando,
      fetchAutorizadores: aut.fetchItems,
      setVistaAutorizadores: aut.setVista,
      onAutorizadoresFiltroChange: aut.onFiltroChange,
      cambiarPaginaAutorizadores: aut.cambiarPagina,
      toggleExpandAutorizador: aut.toggleExpand,
      seleccionarAutorizador: aut.seleccionar,
      abrirAutorizadorForm,
      guardarAutorizador,
      cambiarEstadoAutorizador: aut.cambiarEstadoActivoInactivo,
      ESTADOS_ATENCION,
      ESTADOS_ATENCION_LABEL,
      ESTADOS_ATENCION_CHIP,
      resumenPlanesPorEstado,
      estadoEfectivoObraSocial,
      TIPOS_CONTACTO,
      PRIORIDADES_AUTORIZADOR,
      obrasSociales,
      obrasSocialesLoading,
      obrasSocialesPagination,
      obrasSocialesBusqueda,
      obrasSocialesEstadoFiltro,
      obrasSocialesEstadoInfoFiltro,
      obrasSocialesVistaModo,
      expandedObraSocialId,
      obraSocialSeleccionada,
      obraSocialDetalleLoading,
      fetchObrasSociales,
      setVistaObrasSociales,
      onObrasSocialesFiltroChange,
      cambiarPaginaObrasSociales,
      seleccionarObraSocial,
      toggleExpandObraSocial,
      switchToObrasSociales,
      obraSocialForm,
      obraSocialAliasChips,
      obraSocialAliasInputTexto,
      onObraSocialAliasInput,
      onObraSocialAliasKeydown,
      confirmarObraSocialAliasPendiente,
      quitarObraSocialAliasChip,
      obraSocialModalMode,
      obraSocialGuardando,
      abrirObraSocialForm,
      cancelarObraSocialForm,
      guardarObraSocial,
      eliminarObraSocial,
      validarObraSocial,
      volverABorradorObraSocial,
      obraSocialEstadoForm,
      obraSocialEstadoContexto,
      obraSocialEstadoGuardando,
      abrirCambioEstadoPlan,
      guardarCambioEstado,
      obraSocialHistorial,
      obraSocialHistorialLoading,
      abrirHistorialObraSocial,
      obraSocialPlanForm,
      obraSocialPlanModalMode,
      obraSocialPlanGuardando,
      abrirObraSocialPlanForm,
      guardarObraSocialPlan,
      eliminarObraSocialPlan,
      obraSocialContactoForm,
      obraSocialContactoModalMode,
      obraSocialContactoGuardando,
      abrirObraSocialContactoForm,
      guardarObraSocialContacto,
      eliminarObraSocialContacto,
      nomencladoresDisponibles,
      obraSocialNomencladorSeleccionadoId,
      obraSocialNomencladorGuardando,
      abrirObraSocialNomencladorForm,
      guardarObraSocialNomenclador,
      quitarObraSocialNomenclador,
      expandedObraSocialNomencladorId,
      toggleExpandObraSocialNomenclador,
      autorizadoresDisponibles,
      obraSocialAutorizadorForm,
      obraSocialAutorizadorModalMode,
      obraSocialAutorizadorGuardando,
      abrirObraSocialAutorizadorForm,
      guardarObraSocialAutorizador,
      quitarObraSocialAutorizador,
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
      richModalTargetKey,
      richModalTargetObj,
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
      columnasTogglables,
      getColWidth,
      pinStyle,
      startResize,
      scrollTablaEstudios,
      tablaScrollLeft,
      onTablaEstudiosScroll,
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
    // 'links': suma insertar/editar enlace y quitar enlace a la barra (lo
    // pide la respuesta de FAQ; el resto de los usos no lo necesitan).
    links: { type: Boolean, default: false },
  },
  emits: ['update:modelValue'],
  template: `
    <div :class="['rich-editor', large ? 'rich-editor-lg' : '']">
      <div class="rich-toolbar">
        <button type="button" title="Negrita" @mousedown.prevent="exec('bold')"><i class="bi bi-type-bold"></i></button>
        <button type="button" title="Cursiva" @mousedown.prevent="exec('italic')"><i class="bi bi-type-italic"></i></button>
        <button type="button" title="Lista con viñetas" @mousedown.prevent="exec('insertUnorderedList')"><i class="bi bi-list-ul"></i></button>
        <button type="button" title="Lista numerada" @mousedown.prevent="exec('insertOrderedList')"><i class="bi bi-list-ol"></i></button>
        <template v-if="links">
          <button type="button" title="Insertar/editar enlace" @mousedown.prevent="insertarEnlace"><i class="bi bi-link-45deg"></i></button>
          <button type="button" title="Quitar enlace" @mousedown.prevent="quitarEnlace"><i class="bi bi-link-45deg" style="text-decoration: line-through;"></i></button>
        </template>
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
    insertarEnlace() {
      // Si el cursor está sobre un enlace existente, precarga su URL (editar
      // en vez de crear uno nuevo encima).
      let urlActual = '';
      const seleccion = window.getSelection();
      let nodo = seleccion && seleccion.anchorNode;
      while (nodo && nodo !== this.$refs.editor) {
        if (nodo.nodeName === 'A') { urlActual = nodo.getAttribute('href') || ''; break; }
        nodo = nodo.parentNode;
      }
      const url = window.prompt('URL del enlace (página web, https://wa.me/549... para WhatsApp, o tel:+549... para teléfono):', urlActual);
      if (url === null) return;
      this.$refs.editor.focus();
      if (!url.trim()) {
        document.execCommand('unlink');
      } else {
        document.execCommand('createLink', false, url.trim());
      }
      this.onInput();
    },
    quitarEnlace() {
      this.$refs.editor.focus();
      document.execCommand('unlink');
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
