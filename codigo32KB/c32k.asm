.model small
.stack 1000h

.data
filename db './datos.bin', 0   ; Nombre del archivo
buffer db 32000 dup(?)          ; Buffer para almacenar los datos le?dos
arr db 32000 dup(?)             ; Arreglo para los datos le?dos
size_arr equ 32000          ; Tama?o del arreglo

.code
main PROC
    mov ax, @data
    mov ds, ax

    mov ah, 3Dh                ; Funci?n DOS para abrir archivo
    lea dx, filename            ; DX apunta al nombre del archivo
    mov al, 0                   ; Modo de apertura: 0 para lectura
    int 21h                     ; Llamada al sistema DOS
    mov bx, ax                  ; Manejador de archivo

    mov ah, 3Fh                ; Funci?n DOS para leer archivo
    mov cx, size_arr           ; Cantidad de bytes a leer (tama?o del buffer)
    lea dx, buffer              ; Puntero al buffer de lectura
    int 21h

    ; Cargar los datos en el arreglo "arr"
    mov si, offset buffer
    mov di, offset arr
    mov cx, size_arr

    load_data_loop:
        mov al, [si]
        mov [di], al
        inc si
        inc di
        loop load_data_loop

    mov ah, 3Eh         ; Funci?n DOS para cerrar archivo
    mov bx, bx          ; Manejador de archivo a cerrar (se coloca en BX)
    int 21h             ; Llamada al sistema DOS para cerrar el archivo
    
    ; Ordenamiento del arreglo "arr" usando el algoritmo de burbuja
    mov cx, size_arr - 1

   
    ciclo1:
    push cx
    mov si,0
    mov di,0
        
    ciclo2:
    inc di
    mov al, arr[si]
    cmp al, arr[di]
    ja intercambio
    jb menor
    
    intercambio:
    mov ah, arr[di]
    mov arr[di],al
    mov arr[si],ah
    
    menor:
    inc si
    loop ciclo2
    pop cx
    loop ciclo1

exit_outer_loop: 
    
    ; Mostrar el arreglo ordenado
    lea si, arr
    mov cx, size_arr

print_loop:
    mov dl, [si]
    ;add dl, 30h    ; Convertir n?mero a car?cter ASCII
    mov ah, 2
    int 21h
    
    inc si
    loop print_loop
    
    mov ah, 4Ch       ; Funci?n DOS para terminar el programa
    int 21h           ; Llamada al sistema DOS

main ENDP
end main