#include "kernel.h"
#include<stdio.h>
#include <stdlib.h> 
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#define TPB 32

__global__ void scale_Kernel(float *d_inp, int len, float *d_out, float scale)
{
	const int i = blockIdx.x*blockDim.x + threadIdx.x;
	if (i<len)
		d_out[i] = d_inp[i] * scale;

}
__global__ void vector_AddKernel(float *d_inp1, int len1, float *d_inp2, int len2, float *d_out)
{
	const int i = blockIdx.x*blockDim.x + threadIdx.x;
	if (i<len1)
		d_out[i] = d_inp1[i] + d_inp2[i];



}

__global__ void component_ProdKernel(float *d_inp1, int len1, float *d_inp2, int len2, float *d_out)
{
	const int i = blockIdx.x*blockDim.x + threadIdx.x;
	if (i<len1)
		d_out[i] = d_inp1[i] * d_inp2[i];


}


void scale(float *inp, int len, float *out, float scale)
{
	float *d_inp = 0;
	float *d_out = 0;

	cudaMalloc(&d_inp, len*sizeof(float));
	cudaMalloc(&d_out, len*sizeof(float));

	cudaMemcpy(d_inp, inp, len*sizeof(float), cudaMemcpyHostToDevice);
	scale_Kernel << <(len / TPB), TPB >> >(d_inp, len, d_out, scale);

	cudaMemcpy(out, d_out, len*sizeof(float), cudaMemcpyDeviceToHost);
	cudaFree(d_inp);
	cudaFree(d_out);
}

void vector_Add(float *inp1, int len1, float *inp2, int len2, float *out)
{
		float *d_inp1 = 0;
		float *d_inp2 = 0;
		float *d_out = 0;

		cudaMalloc(&d_inp1, len1*sizeof(float));
		cudaMalloc(&d_inp2, len1*sizeof(float));
		cudaMalloc(&d_out, len1*sizeof(float));

		cudaMemcpy(d_inp1, inp1, len1*sizeof(float), cudaMemcpyHostToDevice);
		cudaMemcpy(d_inp2, inp2, len1*sizeof(float), cudaMemcpyHostToDevice);

		vector_AddKernel << <(len1 / TPB), TPB >> >(d_inp1, len1, d_inp2, len2, d_out);

		cudaMemcpy(out, d_out, len1*sizeof(float), cudaMemcpyDeviceToHost);
		cudaFree(d_inp1);
		cudaFree(d_inp2);
		cudaFree(d_out);
}

void component_Prod(float *inp1, int len1, float *inp2, int len2, float *out)
{
	
		float *d_inp1 = 0;
		float *d_inp2 = 0;
		float *d_out = 0;

		cudaMalloc(&d_inp1, len1*sizeof(float));
		cudaMalloc(&d_inp2, len1*sizeof(float));
		cudaMalloc(&d_out, len1*sizeof(float));

		cudaMemcpy(d_inp1, inp1, len1*sizeof(float), cudaMemcpyHostToDevice);
		cudaMemcpy(d_inp2, inp2, len1*sizeof(float), cudaMemcpyHostToDevice);

		component_ProdKernel << <(len1 / TPB), TPB >> >(d_inp1, len1, d_inp2, len2, d_out);

		cudaMemcpy(out, d_out, len1*sizeof(float), cudaMemcpyDeviceToHost);
		cudaFree(d_inp1);
		cudaFree(d_inp2);
		cudaFree(d_out);
}


