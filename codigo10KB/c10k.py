filename = 'datos.bin' 

n = 10240  # 10KB

# Almacena los datos en la lista
m = open(filename, 'rb')
datos = m.read(n)  
datos = list(datos)
m.close()

# Ordenamiento Burbuja
for i in range(len(datos) - 1):
    for j in range(0, len(datos) - i - 1):
        if datos[j] > datos[j + 1]:
            datos[j], datos[j + 1] = datos[j + 1], datos[j]

# Mostrar los datos ordenados en ASCII
print("Datos ordenados:")
for dato in datos:
    print(chr(dato), end='') 
