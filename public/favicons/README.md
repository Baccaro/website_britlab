Colocá acá los archivos del favicon (favicon.ico, favicon-32x32.png,
favicon-16x16.png, apple-touch-icon.png, etc.). El Dockerfile del frontend
copia esta carpeta entera a `/usr/share/nginx/html/favicon/`, y `index.html`
ya la referencia — sólo hace falta reconstruir el contenedor `frontend`
después de agregar los archivos.

Si tus nombres de archivo son distintos a los de arriba (por ejemplo, si los
generaste con una herramienta que usa otra convención), actualizá los
`<link rel="icon" ...>` en el `<head>` de `index.html` para que coincidan.
