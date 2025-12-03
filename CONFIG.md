# Configuración centralizada

Este documento describe cómo manejar la configuración y variables de entorno del proyecto.

## Variables de entorno

### Archivo `.env`

El proyecto usa un archivo `.env` para centralizar todas las variables de entorno. Este archivo **NO debe versionarse** por razones de seguridad.

#### Setup inicial

1. Copia el archivo de ejemplo:
```bash
cp .env.example .env
```

2. Edita `.env` con tus valores:
```bash
MYSQL_ROOT_PASSWORD=tu_contraseña
GOOGLE_CLIENT_ID=tu_client_id
GOOGLE_CLIENT_SECRET=tu_client_secret
```

3. Docker Compose carga automáticamente `.env`

#### Variables disponibles

| Variable | Descripción | Ejemplo | Requerido |
|----------|-------------|---------|-----------|
| `MYSQL_ROOT_PASSWORD` | Contraseña de MySQL root | `root` | Sí |
| `MYSQL_DATABASE` | Nombre de la base de datos | `agprueba` | Sí |
| `GOOGLE_CLIENT_ID` | Client ID de Google OAuth | `xxx.apps.googleusercontent.com` | No |
| `GOOGLE_CLIENT_SECRET` | Client Secret de Google OAuth | `GOCSP-xxx` | No |


## `.env.example` - Única fuente de verdad

El archivo `.env.example` documenta todas las variables disponibles. **Siempre que añadas una nueva variable:**

1. Añádela a `.env.example` con un valor de ejemplo
2. Actualiza este documento (`CONFIG.md`)
3. Haz commit del cambio

Ejemplo:
```bash
# Antes
MYSQL_ROOT_PASSWORD=root

# Después (si añades una nueva)
MYSQL_ROOT_PASSWORD=root
NEW_VARIABLE=example_value
```

## `.gitignore` - Proteger archivos sensibles

El `.gitignore` **debe incluir** `.env` para evitar commitar credenciales:

```
.env
.env.local
.env.*.local
node_modules/
target/
dist/
```

## Resumen

| Archivo | Versionado | Uso |
|---------|-----------|-----|
| `.env.example` | ✅ Sí | Documentación y plantilla |
| `.env` | ❌ No | Valores reales locales |

Esto asegura que:
- ✅ Hay una única fuente de verdad (`.env.example`)
- ✅ Las credenciales no se exponen
- ✅ Nuevo dev puede hacer `cp .env.example .env` y funciona
