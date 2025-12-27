# Políticas de Seguridad y Cumplimiento (ISO 27001 & RGPD)

Este proyecto POC-GPI2 sigue buenas prácticas para cumplir la normativa de seguridad. A continuación se detalla la cobertura de las normas.

## 1. Matriz de Cumplimiento ISO 27001:2013
| Control ISO | Requisito | Implementación Técnica en el Proyecto |
| :--- | :--- | :--- |
| **A.8.1.1** | Inventario de activos | Generación de **SBOM** mediante CycloneDX en cada build. |
| **A.9.2.3** | Gestión de derechos de acceso | Autenticación federada mediante **OAuth2/OpenID Connect** (Google). |
| **A.12.6.1** | Gestión de vulnerabilidades | Escaneos automáticos de **Trivy** (Docker) y **SonarCloud** (Código). |
| **A.14.2.1** | Política de desarrollo seguro | Pipeline de **CI/CD** que bloquea código si no pasa el análisis estático. |
| **A.18.1.1** | Identificación de legislación | Cumplimiento de **RGPD** mediante la minimización de datos. |

## 2. Cumplimiento RGPD (Reglamento General de Protección de Datos)
- **Minimización de datos:** El sistema no almacena contraseñas; delega la identidad a proveedores externos, reduciendo el riesgo de brecha.
- **Confidencialidad (CIA):** Uso de **GitHub Secrets** para que ninguna credencial de acceso a datos personales resida en el código fuente.
- **Integridad:** Firmado de commits y revisiones por pares (Pull Requests) para asegurar que el código que trata datos no es alterado malintencionadamente.