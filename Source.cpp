#include<stdio.h>
#include <stdlib.h> 
#include "kernel.h"
#define N 256*256
int main()
{
	float *u2 = (float*)malloc(N*sizeof(float));
	float *v2 = (float*)malloc(N*sizeof(float));
	for (int i = 0; i<N; i++)
	{
		u2[i] = 0.25;
		v2[i] = 0.75;
	}
	float *out = (float*)malloc(N*sizeof(float));
	printf("Question number 2c \n N = %u \n", N);
	vector_Add(u2, N, v2, N, out);
	for (int i = 0; i < 14; i++)
	{
		printf("Value at index %u = %e \n", i, out[i]);
	}

	printf("Question number 2d \n N = %u \n", N);
	float s_c = -3.0;
	scale(u2, N, out, s_c);
	float *out1 = (float*)malloc(N*sizeof(float));
	vector_Add(out, N, v2, N, out1);
	for (int i = 0; i < 14; i++)
	{
		printf("Value at index %u = %e \n", i, out1[i]);
	}

	printf("Question Number 2e \n N = %u \n", N);
	component_Prod(u2, N, v2, N, out);
	for (int i = 0; i < 10; i++)
	{
		printf("Value at index %u= %e \n", i, out[i]);
	}



}
