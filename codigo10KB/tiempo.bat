@echo off

REM Obtenemos la hora de inicio
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do (
    set start_date=%%c-%%b-%%a
)
for /f "tokens=1-2 delims=: " %%a in ('time /t') do (
    set start_time=%%a:%%b
)

REM Inicias el programa
c10k.exe

REM Obtenemos la hora de finalización
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do (
    set end_date=%%c-%%b-%%a
)
for /f "tokens=1-2 delims=: " %%a in ('time /t') do (
    set end_time=%%a:%%b
)

REM Mostramos la hora de inicio y la hora de finalización
echo Programa iniciado a: %start_date% %start_time%
echo Programa finalizado a: %end_date% %end_time%

REM Calculamos la diferencia de tiempo
echo.
echo Duración de la ejecución:
time /t