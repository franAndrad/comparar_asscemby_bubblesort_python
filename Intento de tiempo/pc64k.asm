.model small
.stack 1000h

.data
filename db './datos.bin', 0   ; Nombre del archivo
buffer db 64000 dup(?)          ; Buffer para almacenar los datos le?dos
arr db 64000 dup(?)             ; Arreglo para los datos le?dos
size_arr equ 64000            ; Tamano del arreglo
ticks_start dw 0               ; Contador inicial
ticks_end dw 0                 ; Contador final
ticks_diff dw 0                ; Diferencia de conteos
msg db ' milisegundos$', 0


.code
main PROC
    mov ax, @data
    mov ds, ax 
                    
                    
    ; Obtiene el tiempo inicial
    mov ah, 2Ch         ; Funci�n DOS para obtener el tiempo
    int 21h             ; Llamada al sistema DOS
    mov ticks_start, dx ; Guarda el contador inicial

             
             
    mov ah, 3Dh                ; Funcion DOS para abrir archivo
    lea dx, filename            ; DX apunta al nombre del archivo
    mov al, 0                   ; Modo de apertura: 0 para lectura
    int 21h                     ; Llamada al sistema DOS
    mov bx, ax                  ; Manejador de archivo

    mov ah, 3Fh                ; Funcion DOS para leer archivo
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

    mov ah, 3Eh         ; Funcion DOS para cerrar archivo
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
    
    
    ; Obtiene el tiempo final
    mov ah, 2Ch       ; Funci�n DOS para obtener el tiempo
    int 21h           ; Llamada al sistema DOS
    mov ticks_end, dx ; Guarda el contador final

    ; Calcula la diferencia
    mov ax, ticks_end
    sub ax, ticks_start
    mov ticks_diff, ax

    ; Calcula los milisegundos
    mov ax, ticks_diff
    call DisplayNumber

    mov ah, 4Ch       ; Funci�n DOS para terminar el programa
    int 21h           ; Llamada al sistema DOS    
    
    

    DisplayNumber PROC
        mov bx, 10        ; Dividir por 10 para extraer los d�gitos
        mov cx, 0         ; Inicializa el contador de d�gitos
    
    DisplayLoop:
        xor dx, dx        ; Borra DX para la divisi�n
        div bx            ; Divide AX por 10
        push dx           ; Guarda el d�gito en la pila
        inc cx            ; Incrementa el contador de d�gitos
        test ax, ax       ; Verifica si el valor es cero
        jnz DisplayLoop   ; Si no es cero, sigue dividiendo
    
    DisplayLoop2:
        pop dx            ; Recupera el d�gito desde la pila
        add dl, '0'       ; Convierte el d�gito a ASCII
        mov ah, 2         ; Funci�n DOS para mostrar el car�cter
        int 21h           ; Muestra el car�cter
        loop DisplayLoop2 ; Muestra todos los d�gitos
    
        ; Muestra ' milisegundos'
        mov ah, 9         ; Funci�n DOS para mostrar la cadena
        lea dx, msg       ; Carga la direcci�n de la cadena ' milisegundos'
        int 21h           ; Muestra la cadena
    
        ret
    DisplayNumber ENDP



        
main ENDP
end main