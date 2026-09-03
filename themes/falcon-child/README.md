# Falcon Child Theme

Tema hijo para PrestaShop 8 basado en el tema **[Falcon](https://github.com/Oksydan/falcon)**.

Permite modificar plantillas Smarty, estilos CSS y comportamiento JavaScript sin tocar el tema base original, garantizando que el tema padre pueda ser actualizado sin perder personalizaciones.

---

## 📁 Estructura del Tema

```
themes/falcon-child/
├── config/
│   ├── theme.yml          # Configuración del child theme (parent: falcon)
│   └── assets.yml         # Registro de assets por vista (requerido por is_themecore)
├── assets/
│   ├── css/
│   │   ├── custom.css     # ⭐ EDITA AQUÍ COLORES, TIPOGRAFÍA Y ESTILOS
│   │   └── [symlinks]     # Enlaces a los bundles base de falcon
│   ├── js/
│   │   ├── custom.js      # ⭐ EDITA AQUÍ SCRIPTS PERSONALIZADOS
│   │   └── [symlinks]     # Enlaces a los bundles base de falcon
│   ├── fonts/             # Enlace a fuentes base de falcon
│   ├── img/               # Enlace a imágenes base de falcon
│   └── preload.html       # Enlace a precarga de fuentes
├── templates/             # ⭐ COPIA Y SOBRESCRIBE AQUÍ TUS PLANTILLAS SMARTY
├── preview.png            # Miniatura del tema para el Back Office
└── README.md
```

---

## 🎨 1. Personalizar Colores y Tipografía

Todo se gestiona directamente en [`assets/css/custom.css`](assets/css/custom.css). 

Este archivo se carga en el Front Office con **prioridad 1000** (por encima de los estilos base de Falcon y Bootstrap).

### Cambiar la paleta de colores:
Abre `assets/css/custom.css` y modifica las variables del bloque `:root`:

```css
:root {
  --child-color-primary: #ff5722;       /* Cambia el color principal */
  --child-color-primary-hover: #e64a19; /* Color al pasar el ratón */
  --child-color-accent: #00bcd4;        /* Color de acento / badges */
  /* ... */
}
```

### Cambiar la tipografía:
Puedes importar cualquier fuente (por ejemplo Google Fonts) al inicio de `assets/css/custom.css` y asignarla:

```css
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap');

:root {
  --child-font-family-base: 'Montserrat', sans-serif;
  --child-font-family-headings: 'Montserrat', sans-serif;
}
```

---

## 📄 2. Sobrescribir Plantillas Smarty

PrestaShop busca automáticamente primero en la carpeta `templates/` del child-theme. Si no encuentra el archivo, recurre al tema padre `falcon`.

### Método 1: Extender la plantilla del padre (Recomendado)
Para modificar un bloque concreto sin reescribir toda la plantilla:

1. Crea el archivo con la misma ruta que en el padre dentro de `templates/` (por ejemplo `templates/catalog/product.tpl`).
2. Usa `{extends file='parent:catalog/product.tpl'}` y redefine sólo los bloques necesarios:

```tpl
{extends file='parent:catalog/product.tpl'}

{block name='product_prices'}
  <div class="mi-bloque-personalizado">
    {$smarty.block.parent}
  </div>
{/block}
```

### Método 2: Reemplazo completo
Si prefieres reescribir por completo una plantilla o partial, simplemente copia el archivo de `themes/falcon/templates/...` a `themes/falcon-child/templates/...` y modifícalo a tu gusto.

---

## ⚡ Limpieza de Caché

Tras realizar cambios en archivos `.tpl` o de configuración, limpia la caché con:

```bash
docker compose exec prestashop ./bin/console cache:clear --no-warmup
```
O desde el panel de administración: **Parámetros Avanzados > Rendimiento > Borrar la caché**.
