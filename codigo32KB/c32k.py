filename = 'datos.bin' 
arreglo_bin = []  

n = 32768  # 32KB

# Almacena los datos en la lista
m = open(filename, 'rb')
datos = m.read(n)  
arreglo_bin.extend(datos)  
m.close()

# Ordenamiento Burbuja
for i in range(len(arreglo_bin) - 1):
    for j in range(0, len(arreglo_bin) - i - 1):
        if arreglo_bin[j] > arreglo_bin[j + 1]:
            arreglo_bin[j], arreglo_bin[j + 1] = arreglo_bin[j + 1], arreglo_bin[j]

# Mostrar los datos ordenados en ASCII
print("Datos ordenados:")
for dato in arreglo_bin:
    print(chr(dato), end='') 
