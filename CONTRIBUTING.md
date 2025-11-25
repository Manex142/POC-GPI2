## ⚙️ Flujo de Trabajo y Gestión de Tareas (Kanban)

Todas las tareas (Work Packages / Issues) se gestionan a través del tablero Kanban de GitHub Projects. El flujo de trabajo se compone de cinco estados principales:

| Columna/Estado | Significado | Regla para Entrar | Responsable Principal |
| :--- | :--- | :--- | :--- |
| **Backlog** | Tareas definidas, priorizadas y estimadas, listas para ser seleccionadas en la siguiente entrega. | La tarea ha sido creada y etiquetada. | Gestor del Proyecto |
| **Ready (Lista para hacer)** | Tareas seleccionadas para la entrega actual. Están listas para que un desarrollador empiece a trabajar. | Decisión del desarrollador al iniciar el trabajo. | Desarrollador |
| **In Progress (En Progreso)** | El desarrollador está activamente escribiendo código o haciendo la configuración. | Se crea la rama de trabajo local. | Desarrollador |
| **Review (Pull Request)** | El código ha terminado y se ha abierto un Pull Request (PR). | El PR ha sido abierto y el CI ha pasado. | Revisores/Tech Lead |
| **Done (Hecho)** | El código ha sido mergeado a `main` y verificado (si aplica, desplegado automáticamente). | El PR ha sido mergeado y la funcionalidad está en producción/entorno de prueba. | Gestor del Proyecto |

### 🛠️ Regla Clave
* **WIP (Work In Progress):** Cada desarrollador debe tener idealmente **solo una tarea** en **"In Progress"** a la vez.
