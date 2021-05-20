// miniEP1
// Giovana Vieira de Morais, 11921908
// gcc crivo.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void main(int argc, char *argv[]) {
	int N, *crivo;
	char *ptr;
	unsigned long int primos = 0, primos_especiais = 0;
	
	// criar um vetor com metade do tamanho pra economizar memória
	N = 1 << strtol(argv[1], &ptr, 10);
	crivo = (int*) malloc(sizeof(int) * (N+1));

	for (unsigned long int i = 2; i <= N; i++) 
		crivo[i] = 1;

	for (unsigned long int i = 2; i <= N; i++) { 
		if (crivo[i]) {
			primos += 1;

			if (i % 4 != 3) 
				primos_especiais += 1;

			for (unsigned long int j = i*2; j <= N; j += i) 
				crivo[j] = 0;
		}
	}
	printf("%lu %lu\n", primos, primos_especiais);
	free(crivo);
}
