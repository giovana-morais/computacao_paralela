#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>

#define MAX_STR 1000
#define MAX_DELAY 1000000
#define DELAY_STEP 100000

void main() {
	FILE *gcc_fp, *python_fp;
	char gcc_command[MAX_STR] = "gcc -DDELAY=";
	char python_command[MAX_STR] = "python corretude.py ";
	char delay_str[10], executavel[MAX_STR];
	char ch;
	char *N = "200";

	// 100 microsegundos
	/* int delay = 100000; */

	#pragma omp parallel for
	for (int delay = 100000; delay < MAX_DELAY; delay += DELAY_STEP) {
		printf("delay = %d\n", delay);
		sprintf(delay_str, "%d", delay);
		strcat(executavel, "ss_");
		strcat(executavel, delay_str);
		printf("executavel %s\n", executavel);

		strcat(gcc_command, delay_str);
		strcat(gcc_command, " sleepSort.c -o ");
		strcat(gcc_command, executavel);

		strcat(python_command, executavel);
		strcat(python_command, " ");
		strcat(python_command, N);

		char *output = malloc(sizeof(char)*MAX_STR);
		printf("python: %s\n", python_command);

		// compila gcc
		gcc_fp = popen(gcc_command, "r");
		pclose(gcc_fp);

		// roda python
		python_fp = popen(python_command, "r");
		/* fscanf(python_fp, "%s", output); */

		while ((ch = fgetc(python_fp)) != EOF)
			putchar(ch);
		pclose(python_fp);

		printf("%s\n", output);
	}


}

