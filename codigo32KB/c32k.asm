.model medium    ; Usamos el modelo medium para manejar mayores cantidades de datos
.stack 4000h ; 4KB de espacio de pila


.data
fd db 'datos.bin', 0           ; Nombre del archivo
datos db 32768 dup(?)          ; Buffer para almacenar los datos leidos 32KB
cant_bytes equ 32768           ; Tamanio del arreglo 
    
    
.code
main PROC
    
    
    ;Abrir un archivo y guardarlo en un arreglo datos
    
    mov ax, @data   
    mov ds, ax         
    
    ;Abro el archivo
    mov ah, 3Dh        
    lea dx, fd         
    mov al, 0          
    int 21h            
    mov bx, ax         
    
    ;Leo el archivo y lo guardo en datos
    mov ah, 3Fh        
    mov cx, cant_bytes 
    lea dx, datos      
    int 21h            
    
    ;Cierro el archivo
    mov ah, 3Eh       
    mov bx, bx        
    int 21h           


    ; Algoritmo de ordenamiento (Bubble Sort) para el arreglo "datos"

    mov cx, cant_bytes - 1  ; Establece el contador del bucle exterior

    bucle_exterior:
        mov si, 0
        mov di, si
    
        bucle_interior:
            inc di
            mov al, datos[si]  ; Carga el byte actual desde el arreglo
            cmp al, datos[di]  ; Compara con el siguiente byte en el arreglo
            jbe no_intercambio  ; Si el byte actual es menor o igual, no intercambiar
    
            ; Intercambio los valores
            mov ah, datos[di]
            mov datos[di], al
            mov datos[si], ah
    
        no_intercambio:
            inc si
            cmp si, cx         ; Compara si ha llegado al final del bucle interior
            jb bucle_interior  ; Salta de regreso al bucle interior si no se ha completado (SI < CX)
    
        dec cx
        cmp cx, 0
        jne bucle_exterior  ; Salta de regreso al bucle exterior si no se ha completado (CX != 0)
    
    
    ;Mostrar Datos ordenados
    
    lea si, datos     
    mov cx, cant_bytes  
    
    print_loop:
        mov dl, [si]    
        mov ah, 2       
        int 21h         
    
        inc si          
        dec cx          
        jnz print_loop  
    
    ; Terminar el programa
    mov ah, 4Ch   
    int 21h       

main ENDP
end main