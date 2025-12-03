# 🐳 Docker Setup para POC-GPI2

Este documento explica cómo ejecutar el proyecto usando Docker y Docker Compose.

## Requisitos

- Docker 20.10+
- Docker Compose 2.0+

## Arquitectura

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   Frontend      │────▶│ Authorization   │────▶│    MySQL        │
│   Angular       │     │    Server       │     │   Database      │
│   :4200         │     │    :9000        │     │    :3306        │
└─────────────────┘     └─────────────────┘     └─────────────────┘
         │                      
         │                      
         ▼                      
┌─────────────────┐     
│   Resource      │     
│    Server       │     
│    :8080        │     
└─────────────────┘     
```

## 🚀 Inicio Rápido

### 1. Levantar todos los servicios

```bash
# Desde la raíz del proyecto
docker-compose up -d --build
```

> ⏱️ La primera vez tardará varios minutos en construir las imágenes.

### 2. Verificar que los servicios están corriendo

```bash
docker-compose ps
```

### 3. Ver logs en tiempo real

```bash
# Todos los servicios
docker-compose logs -f

# Solo un servicio específico
docker-compose logs -f authorization-server
```

### 4. Inicializar datos (cliente OAuth2 y usuarios)

Una vez que todos los servicios estén corriendo:

```bash
# Dar permisos de ejecución al script
chmod +x scripts/init-data.sh

# Ejecutar el script
./scripts/init-data.sh
```

### 5. Acceder a la aplicación

Abre tu navegador en: **http://127.0.0.1:4200**

## 📋 Servicios

| Servicio | Puerto | URL | Descripción |
|----------|--------|-----|-------------|
| MySQL | 3306 | - | Base de datos |
| Authorization Server | 9000 | http://localhost:9000 | Servidor OAuth2 |
| Resource Server | 8080 | http://localhost:8080 | API protegida |
| Frontend | 4200 | http://127.0.0.1:4200 | Aplicación Angular |

## 🔐 Credenciales por defecto

### Base de datos MySQL
- **Usuario:** root
- **Contraseña:** root
- **Base de datos:** agprueba

### Cliente OAuth2 (después de ejecutar init-data.sh)
- **Client ID:** client
- **Client Secret:** secret

### Usuarios (después de ejecutar init-data.sh)
| Usuario | Contraseña | Rol |
|---------|------------|-----|
| user | password | ROLE_USER |
| admin | admin | ROLE_ADMIN, ROLE_USER |

## 🛠️ Comandos útiles

```bash
# Parar todos los servicios
docker-compose down

# Parar y eliminar volúmenes (BORRA la base de datos)
docker-compose down -v

# Reconstruir un servicio específico
docker-compose up -d --build authorization-server

# Reiniciar un servicio
docker-compose restart resource-server

# Ver logs de un servicio
docker-compose logs -f frontend

# Acceder al shell de un contenedor
docker exec -it poc-auth-server sh

# Ver uso de recursos
docker stats
```

## 🔧 Configuración de Google OAuth (Opcional)

Para usar tus propias credenciales de Google, crea un archivo `.env` en la raíz:

```bash
# .env
GOOGLE_CLIENT_ID=tu-client-id-de-google
GOOGLE_CLIENT_SECRET=tu-client-secret-de-google
```

Luego reinicia los servicios:

```bash
docker-compose down
docker-compose up -d
```

## ⚠️ Solución de problemas

### Los contenedores no arrancan
```bash
# Ver logs detallados
docker-compose logs

# Verificar que Docker está corriendo
docker info
```

### Error de conexión a MySQL
El Authorization Server espera a que MySQL esté listo. Si falla:
```bash
# Reiniciar el servicio
docker-compose restart authorization-server
```

### Puerto en uso
```bash
# Ver qué usa el puerto
lsof -i :9000

# Cambiar el puerto en docker-compose.yml
ports:
  - "9001:9000"  # Cambia 9001 por el puerto que quieras
```

### Limpiar todo y empezar de nuevo
```bash
docker-compose down -v --rmi all
docker-compose up -d --build
```

## 📁 Estructura de archivos Docker

```
POC-GPI2/
├── docker-compose.yml           # Orquestación de servicios
├── DOCKER.md                    # Esta documentación
├── scripts/
│   └── init-data.sh            # Script de inicialización
├── authorization-server/
│   ├── Dockerfile
│   └── .dockerignore
├── resource-server/
│   ├── Dockerfile
│   └── .dockerignore
└── ag-prueba-front/
    ├── Dockerfile
    ├── .dockerignore
    └── nginx.conf
```
