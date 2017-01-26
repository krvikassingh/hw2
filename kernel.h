#ifndef KERNEL_H_INCLUDED
#define KERNEL_H_INCLUDED

void scale(float *inp, int len, float *out, float scale);

void vector_Add(float *inp1, int len1, float *inp2, int len2, float *out);

void component_Prod(float *inp1, int len1, float *inp2, int len2, float *out);


#endif
