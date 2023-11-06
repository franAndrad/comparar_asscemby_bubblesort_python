@echo off

REM Configura la fecha y hora en las variables
for /F "tokens=2" %%I in ('time /t') do set start_time=%%I
for /F "tokens=1" %%I in ('date /t') do set start_date=%%I

REM Inicio del programa
echo Programa iniciado a: %start_time% %start_date%

REM Ejecuta el programa
c10k.exe

REM Captura la hora y la fecha de finalización
for /F "tokens=2" %%I in ('time /t') do set end_time=%%I
for /F "tokens=1" %%I in ('date /t') do set end_date=%%I

REM Muestra la hora y fecha de finalización
echo Programa finalizado a: %end_time% %end_date%