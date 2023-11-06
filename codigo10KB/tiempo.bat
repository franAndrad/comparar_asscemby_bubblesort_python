@echo off

REM Captura la fecha y hora inicial
echo Programa iniciado a: > timestamp.txt
echo %time% >> timestamp.txt
echo %date% >> timestamp.txt

REM Ejecuta el programa
c10k.exe

REM Captura la fecha y hora al finalizar el programa
echo Programa finalizado a: >> timestamp.txt
echo %time% >> timestamp.txt
echo %date% >> timestamp.txt