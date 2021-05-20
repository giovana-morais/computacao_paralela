# miniEP1
# Giovana Vieira de Morais, 11921908
# python3 crivo.py
import sys

N = 1 << int(sys.argv[1])
primos = 0
primos_especiais = 0
crivo = [True]*(N+1)

for i in range(2, N+1):
    if crivo[i]:
        primos = primos + 1

        if i % 4 != 3:
            primos_especiais = primos_especiais + 1
        for j in range(i*2, N+1, i):
            crivo[j] = False

print(primos, primos_especiais)
