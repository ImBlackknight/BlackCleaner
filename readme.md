# Blackknight Performance System Optimizer

Script de mantenimiento y optimización en Batch (`.bat`) diseñado para preparar y mantener entornos Windows, liberando recursos en segundo plano, limpiando archivos temporales del sistema y verificando la integridad de los archivos y discos.

## Características Principales

* **Verificación de Privilegios:** Comprueba automáticamente si el script se ejecuta con permisos de Administrador antes de realizar cambios en el sistema.
* **Liberación de Recursos (`:Preparativo`):** Cierra procesos de navegadores web populares (`Chrome`, `Edge`, `Firefox`, `Opera`) para liberar memoria RAM y ciclos de CPU.
* **Limpieza Profunda (`:Cleaner-Zone`):**
  * Elimina archivos temporales del usuario (`%TEMP%`, `%LocalAppData%\Temp`) y del sistema (`C:\Windows\Temp`).
  * Detiene el servicio de Windows Update (`wuauserv`), purga la caché de descargas (`SoftwareDistribution\Download`) y reinicia el servicio.
  * Ejecuta comprobaciones de salud e integridad del sistema operativo mediante `DISM` y `SFC`.
  * Vacía la Papelera de Reciclaje de forma silenciosa.
* **Mantenimiento de Almacenamiento (`:ChequeoDisco` y `:Optimizador` - *Opcional*):** Módulos incluidos en el código (desactivados por defecto) para ejecutar `chkdsk` y desfragmentación personalizada mediante *MyDefrag* en una unidad secundaria o de datos.

## Requisitos del Sistema

* **Sistema Operativo:** Windows 10 / Windows 11.
* **Permisos:** Ejecución obligatoria como **Administrador**.
* **Herramientas opcionales:** Si se habilita el módulo `:Optimizador`, se requiere contar con la carpeta `mydefrag` junto con su archivo de perfil (`.MyD`) en el mismo directorio que el script.

## Configuración

Antes de ejecutar el script por primera vez, abrí el archivo `.bat` con un editor de texto (Bloc de notas, VS Code, Notepad++) y ajustá las letras de unidad en la sección superior según la configuración de tus discos:

```batch
::CONFIGURACION DEL SCRIPT
set letra_unidad_sistema=C
set letra_unidad_secundaria=E
::FINALIZA LA SECCION DE CONFIGURACION DEL SCRIPT
```

* `letra_unidad_sistema`: Letra de la unidad donde está instalado Windows (por defecto `C`).
* `letra_unidad_secundaria`: Letra de la unidad secundaria (juegos, programas o datos) sobre la cual se aplicarán los módulos opcionales de disco (por defecto `E`).

## Uso

1. Hacé clic derecho sobre el archivo `.bat`.
2. Seleccioná **Ejecutar como administrador**.
3. Esperá a que finalicen los procesos de limpieza y verificación del sistema.
4. Cuando aparezca el mensaje *"Aqui Finaliza el Script Saludos!"*, presioná cualquier tecla para cerrar la ventana.

### Activar funciones opcionales

Por defecto, el chequeo de disco y la desfragmentación están comentados (`::`) para evitar demoras innecesarias en unidades SSD. Si usás discos mecánicos (HDD) o querés habilitarlos, quitá los dos puntos (`::`) en la sección `:ProgramaPrincinpal`:

```batch
call :Preparativo
call :Cleaner-Zone
call :ChequeoDisco
call :Optimizador
```

## Advertencias y Buenas Prácticas

* **Unidades SSD vs. HDD:** No ejecutes el módulo `:Optimizador` (desfragmentación tradicional) sobre unidades de estado sólido (SSD/NVMe), ya que reduce su vida útil innecesariamente.
* **Cierre de aplicaciones:** Asegurate de guardar cualquier trabajo abierto en tus navegadores antes de ejecutar el script, ya que `taskkill /F` los cerrará de forma forzada.
* **Tiempo de ejecución:** El comando `sfc /scannow` puede demorar varios minutos dependiendo de la velocidad de tu almacenamiento y el estado del sistema.