#!/bin/bash

# =================================================================
# Script de inicialización para POC-GPI2
# Crea el cliente OAuth2 y usuarios iniciales
# =================================================================

set -e

AUTH_SERVER_URL="${AUTH_SERVER_URL:-http://localhost:9000}"

echo "🔄 Esperando a que el Authorization Server esté listo..."

# Esperar a que el servidor esté disponible
max_attempts=30
attempt=1
while ! curl -s "${AUTH_SERVER_URL}/actuator/health" > /dev/null 2>&1; do
    if [ $attempt -ge $max_attempts ]; then
        echo "❌ Error: Authorization Server no está disponible después de ${max_attempts} intentos"
        exit 1
    fi
    echo "   Intento ${attempt}/${max_attempts}..."
    sleep 5
    ((attempt++))
done

echo "✅ Authorization Server está listo!"
echo ""

# Crear cliente OAuth2
echo "📝 Creando cliente OAuth2..."
curl -s -X POST "${AUTH_SERVER_URL}/client/create" \
  -H "Content-Type: application/json" \
  -d '{
    "clientId": "client",
    "clientSecret": "secret",
    "authenticationMethods": ["CLIENT_SECRET_BASIC"],
    "authorizationGrantTypes": ["AUTHORIZATION_CODE", "REFRESH_TOKEN"],
    "redirectUris": ["http://127.0.0.1:4200/authorized"],
    "scopes": ["openid", "profile"],
    "requireProofKey": true
  }' && echo ""

echo "✅ Cliente OAuth2 creado"
echo ""

# Crear usuario normal
echo "👤 Creando usuario 'user'..."
curl -s -X POST "${AUTH_SERVER_URL}/auth/create" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "user",
    "password": "password",
    "roles": ["ROLE_USER"]
  }' && echo ""

echo "✅ Usuario 'user' creado (password: password)"
echo ""

# Crear usuario administrador
echo "👑 Creando usuario 'admin'..."
curl -s -X POST "${AUTH_SERVER_URL}/auth/create" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "admin",
    "roles": ["ROLE_ADMIN", "ROLE_USER"]
  }' && echo ""

echo "✅ Usuario 'admin' creado (password: admin)"
echo ""

echo "=========================================="
echo "🎉 ¡Inicialización completada!"
echo "=========================================="
echo ""
echo "📋 Resumen:"
echo "   - Cliente OAuth2: client / secret"
echo "   - Usuario normal: user / password"
echo "   - Usuario admin:  admin / admin"
echo ""
echo "🌐 Accede a la aplicación en: http://127.0.0.1:4200"
echo ""
