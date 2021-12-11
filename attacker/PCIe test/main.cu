#include <stdio.h> 

__global__
void saxpy(int n, float a, float *x, float *y)
{
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if (i < n) y[i] = a*x[i] + y[i];
}

int main(void)
{
  int N = 20 * (1 << 20);
  float *x, *y, *d_x, *d_y;
  x = (float*)malloc(N*sizeof(float));
  y = (float*)malloc(N*sizeof(float));
  
  cudaMalloc(&d_x, N*sizeof(float)); 
  cudaMalloc(&d_y, N*sizeof(float));

  for (int i = 0; i < N; i++) {
    x[i] = 1.0f;
    y[i] = 2.0f;
  }

  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);

  cudaEvent_t startH2D, stopH2D;
  cudaEventCreate(&startH2D);
  cudaEventCreate(&stopH2D);

  cudaEvent_t startD2H, stopD2H;
  cudaEventCreate(&startD2H);
  cudaEventCreate(&stopD2H);
  
  // host2device
  cudaEventRecord(startH2D);
  cudaMemcpy(d_x, x, N*sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_y, y, N*sizeof(float), cudaMemcpyHostToDevice);

  cudaEventRecord(stopH2D);
  cudaEventSynchronize(stopH2D);
  float millisecondsH2D = 0;
  cudaEventElapsedTime(&millisecondsH2D, startH2D, stopH2D);
//   printf("HostToDevice Latency (ms): %f\n", millisecondsH2D);
  printf("%f,", millisecondsH2D); 
  cudaEventRecord(start);

  // Perform SAXPY on 1M elements
  saxpy<<<(N+511)/512, 512>>>(N, 2.0f, d_x, d_y);

  
  //deice2host
  cudaEventRecord(startD2H);

  cudaMemcpy(y, d_y, N*sizeof(float), cudaMemcpyDeviceToHost);

  cudaEventRecord(stopD2H);
  cudaEventSynchronize(stopD2H);
  float millisecondsD2H = 0;
  cudaEventElapsedTime(&millisecondsD2H, startD2H, stopD2H);
//   printf("DeviceToHost Latency (ms): %f\n", millisecondsD2H);
  printf("%f,", millisecondsD2H);

  cudaEventRecord(stop);
  cudaEventSynchronize(stop);
  float milliseconds = 0;
  cudaEventElapsedTime(&milliseconds, start, stop);

  float duration = milliseconds-millisecondsD2H;
//   printf("Effective Bandwidth (GB/s): %f\n", N*4*3/duration/1e6);
  printf("%f", N*4*3/duration/1e6);
  printf("\n");
}