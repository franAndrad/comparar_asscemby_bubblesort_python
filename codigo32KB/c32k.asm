.model small    ; Codigo, datos y stack son todos de tamaño limitado, no superen los 64KB
.stack 1000h    ; Reservo 4096 bytes en la memoria

.data
filename db 'datos.bin', 0   ; Nombre del archivo
buffer db 32768 dup(?)       ; Buffer para almacenar los datos leidos 32KB
arr db 32768 dup(?)          ; Arreglo para los datos leidos 32KB
size_arr equ 32768           ; Tamaño del arreglo 

.code
main PROC
    mov ax, @data      ; Carga la direccion de inicio de los datos en el registro AX
    mov ds, ax         ; Asigna a DS la direccion de inicio de los datos

    mov ah, 3Dh        ; Funcion DOS para abrir archivo
    lea dx, filename   ; DX apunta al nombre del archivo
    mov al, 0          ; Modo de apertura: 0 para lectura
    int 21h            ; Llamada al sistema DOS
    mov bx, ax         ; Guarda el manejador de archivo devuelto por DOS

    mov ah, 3Fh        ; Funcion DOS para leer archivo
    mov cx, size_arr   ; Cantidad de bytes a leer (tamaño del buffer)
    lea dx, buffer     ; Puntero al buffer de lectura
    int 21h            ; Llamada al sistema DOS para leer el archivo

    ; Cargar los datos en el arreglo "arr"
    mov si, offset buffer
    mov di, offset arr
    mov cx, size_arr

    load_data_loop:
        mov al, [si]   ; Lee un byte del buffer
        mov [di], al   ; Almacena el byte en el arreglo "arr"
        inc si         ; Incrementa el puntero del buffer
        inc di         ; Incrementa el puntero del arreglo
        loop load_data_loop   ; Repite el bucle para todos los bytes

    mov ah, 3Eh       ; Funcion DOS para cerrar archivo
    mov bx, bx        ; Manejador de archivo a cerrar (se coloca en BX)
    int 21h           ; Llamada al sistema DOS para cerrar el archivo

    ; Algoritmo de ordenamiento (Bubble Sort) para el arreglo "arr"
    mov cx, size_arr - 1  ; Establece el contador del bucle exterior

    ciclo1:
        push cx   ; Guarda el contador actual del bucle exterior
        mov si, 0 ; Reinicia el indice si para el bucle interior
        mov di, 0 ; Reinicia el indice di para el bucle interior

    ciclo2:
        inc di        ; Incrementa el indice di
        mov al, arr[si]   ; Carga el byte actual desde el arreglo
        cmp al, arr[di]   ; Compara con el siguiente byte en el arreglo
        ja intercambio   ; Salta si se debe intercambiar
        jb menor         ; Salta si el byte actual es menor

    intercambio:
        mov ah, arr[di]   ; Intercambia los valores
        mov arr[di], al
        mov arr[si], ah

    menor:
        inc si        ; Incrementa el indice si
        loop ciclo2   ; Repite el bucle interior
        pop cx        ; Restaura el contador del bucle exterior
        loop ciclo1   ; Repite el bucle exterior

    ; Mostrar el arreglo ordenado
    lea si, arr   ; Carga el puntero al arreglo
    mov cx, size_arr   ; Carga el contador con el tamaño del arreglo

print_loop:
    mov dl, [si]   ; Carga el byte actual
    mov ah, 2      ; Establece la funcion de DOS para mostrar un caracter
    int 21h        ; Llamada al sistema DOS para mostrar un caracter

    inc si         ; Incrementa el puntero del arreglo
    loop print_loop   ; Repite para todos los bytes

    mov ah, 4Ch   ; Funcion DOS para terminar el programa
    int 21h       ; Llamada al sistema DOS para finalizar

main ENDP
end main