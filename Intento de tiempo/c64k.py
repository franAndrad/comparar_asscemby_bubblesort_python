import time

filename = 'datos.bin'  # Nombre del archivo
arreglo_bin = []  # Lista para almacenar los datos leídos

# Guarda el tiempo al inicio de la ejecución
tiempo_inicio = time.time()

n = 64000
with open(filename, "rb") as archivo_binario:
    datos = archivo_binario.read(n)  # Lee los primeros 'n' bytes
    for dato in datos:  # Itera a través de los datos leídos
        arreglo_bin.append(dato)  # Almacena los datos en la lista

# Ordenamiento Burbuja
for i in range(n - 1):
    for j in range(0, n - i - 1):
        if arreglo_bin[j] > arreglo_bin[j + 1]:
            arreglo_bin[j], arreglo_bin[j + 1] = arreglo_bin[j + 1], arreglo_bin[j]

# Guarda el tiempo al final de la ejecución
tiempo_fin = time.time()

# Calcula el tiempo total de ejecución
tiempo_total = (tiempo_fin - tiempo_inicio) * 1000  # Se convierte a milisegundos

# Mostrar los datos ordenados
# print("\n\nDatos ordenados:")
# for dato in arreglo_bin:
#     print(chr(dato), end='')  # Imprime el carácter ASCII correspondiente a cada byte

# Muestra el tiempo total de ejecución en milisegundos
print(f"Tiempo total de ejecución: {tiempo_total} milisegundos")