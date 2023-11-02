import random

def generar_datos_binarios():
    caracteres = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    longitud = 65536  # Longitud del archivo en bytes
    datos = ''.join(random.choice(caracteres) for _ in range(longitud))
    with open("datos.bin", "wb") as archivo_binario:
        archivo_binario.write(datos.encode('utf-8'))
    return datos

def mostrar_datos_binarios():
    with open("datos.bin", "rb") as archivo_binario:
        datos = archivo_binario.read().decode('utf-8')
        print("Datos del archivo binario:", datos)
        
def mostrar_datos_ordenados():
    with open("datos.bin", "rb") as archivo_binario:
        datos = archivo_binario.read().decode('utf-8')
        datos_ordenados = ''.join(sorted(datos, reverse=True))
        print("Datos ordenados:", datos_ordenados)

# Generar el archivo binario con los datos aleatorios
generar_datos_binarios()
mostrar_datos_binarios()
mostrar_datos_ordenados()