@echo off

::CONFIGURACION DEL SCRIPT
set letra_unidad_sistema=C

::FINALIZA LA SECCION DE CONFIGURACION DEL SCRIPT


set mypath=%cd%
echo Hola a todos hay una variable almacenado en %variable1% %variable2%
call :ProgramaPrincinpal
echo Aqui Finaliza el Script Saludos!
pause
exit



:ProgramaPrincinpal
net session >nul 2>&1
if %errorLevel% neq 0 (
    cls
    echo Error: Debes ejecutar este script como Administrador.
    pause
    exit
)
title Blackknight PerformanceSystem Optimizer
call :Preparativo
call :Cleaner-Zone
::call :ChequeoDisco
::call :Optimizador
exit /B



::Limpieza de Directorios Temporales
:Cleaner-Zone
echo Funcion de Limpieza!
set mytemp=%temp%
set tempuser=%LocalAppData%\Temp
del %mytemp% /S /F /Q
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1
Dism.exe /online /Cleanup-Image /StartComponentCleanup
net stop wuauserv
rd /s /q %SystemRoot%\SoftwareDistribution\Download
net start wuauserv
Dism.exe /Online /Cleanup-Image /CheckHealth
sfc.exe /scannow
powershell.exe -command "Clear-RecycleBin -Confirm:$false" >nul 2>&1
del /s /f /q "%LocalAppData%\D3DSCache\*.*" >nul 2>&1
del /s /f /q "%ProgramData%\Battle.net\Agent\data\cache\*.*" >nul 2>&1
del /s /f /q "%LocalAppData%\Battle.net\BrowserCache\*.*" >nul 2>&1
exit /B

::Preparativos
:Preparativo
taskkill /F /IM edge.exe /IM chrome.exe /IM firefox.exe /IM opera.exe
exit /B

:: Verificacion de Errores
:ChequeoDisco
echo Verificacion de Disco!
chkdsk %letra_unidad_sistema%: /F /X

exit /B

::Optimizacion
:Optimizador


exit /B