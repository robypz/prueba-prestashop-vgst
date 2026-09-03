# PrestaShop Classic 8.2.8 (Dockerizado)

Proyecto limpio de **PrestaShop Edition Classic v8.2.8** preparado para desarrollo local mediante Docker y Docker Compose utilizando la imagen oficial [prestashop/prestashop:8.2.8-apache](https://hub.docker.com/r/prestashop/prestashop) y MySQL 8.0.

---

## Requisitos Previos

- [Docker](https://docs.docker.com/get-docker/) (versión 20.10 o superior)
- [Docker Compose](https://docs.docker.com/compose/) (v2 o superior)
- Make (opcional, para usar los atajos del `Makefile`)

---

## Puesta en Marcha Rápida (Primer Inicio / Clonado)

1. **Clonar el repositorio**:
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   cd prestashop_edition_classic_version_8.2.8
   ```

2. **Crear archivo de entorno e iniciar contenedores**:
   Con Make:
   ```bash
   make init
   ```
   O manualmente:
   ```bash
   cp .env.example .env
   docker compose up -d --build
   ```

3. **Completar la instalación desde el Asistente Web**:
   Abre en tu navegador:
   ```
   http://localhost/
   ```
   Serás redirigido al Asistente de Instalación de PrestaShop. Avanza por los pasos y en la pantalla de **Base de Datos**, introduce los siguientes datos:
   - **Servidor de base de datos**: `db`
   - **Nombre de la base de datos**: `prestashop`
   - **Usuario de la base de datos**: `prestashop`
   - **Contraseña de la base de datos**: `prestashop`
   - **Prefijo de las tablas**: `ps_`

4. Haz clic en **"¡Comprobar la conexión de tu base de datos ahora!"** y finaliza la instalación.

---

## Comandos del Makefile

| Comando | Descripción |
| :--- | :--- |
| `make init` | Crea `.env` desde `.env.example` y levanta los contenedores construyendo la imagen |
| `make up` | Levanta los contenedores en segundo plano |
| `make down` | Detiene los contenedores |
| `make restart` | Reinicia los contenedores |
| `make logs` | Sigue los registros (`logs -f`) del servicio PrestaShop |
| `make sh-app` | Abre una terminal interactiva `bash` en el contenedor de PrestaShop |
| `make sh-db` | Abre una terminal interactiva `bash` en el contenedor de MySQL |
| `make clean` | **Resetea la tienda**: elimina volúmenes de base de datos, credenciales locales y cachés para volver al asistente de instalación limpio |

---

## Modo de Instalación Automática (Opcional)

Si en lugar del asistente web prefieres que Docker ejecute la instalación desatendida por CLI:
1. En tu archivo `.env`, establece:
   ```dotenv
   PS_INSTALL_AUTO=1
   ```
2. Reinicia los contenedores limpiando volúmenes:
   ```bash
   make clean
   make up
   ```
   PrestaShop creará las tablas y el usuario administrador definido en `.env` de forma automática.

---

## Estructura del Proyecto

- `Dockerfile`: Extiende la imagen oficial con límites de memoria y parámetros recomendados de PHP (`memory_limit = 512M`, `max_input_vars = 5000`).
- `docker-compose.yml`: Define los servicios `prestashop` y `db` (MySQL 8.0) en una red aislada `prestashop_net`.
- `app/`, `modules/`, `themes/`, `classes/`, `src/`: Código fuente de PrestaShop montado en vivo (`bind mount`) para reflejar cambios inmediatamente sin reconstruir la imagen.
- `.gitignore`: Configurado para no subir credenciales locales (`.env`), parámetros de instalación (`parameters.php`), cachés ni volcados de base de datos.
