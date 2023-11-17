#include <stdio.h>
#include <cuda_runtime.h>

__global__ void checkIndex(void){
    printf("threadIdx : (%d, %d, %d) blockIdx : (%d, %d, %d), blockDim : (%d, %d, %d) "
            "gridDim : (%d, %d, %d)\n", threadIdx.x , threadIdx.y, threadIdx.z, 
                                        blockIdx.x, blockIdx.y, blockIdx.z,
                                        blockDim.x, blockDim.y, blockDim.z,
                                        gridDim.x, gridDim.y, gridDim.z
            );
}

int main(int argc, char **argv){
    // データの合計数を定義
    int nElem = 6;

    // グリッドとブロックの構造を定義
    dim3 block(3);
    dim3 grid((nElem + block.x - 1) / block.x);

    // グリッドとブロックのサイズをホスト側からチェック
    printf("grid.x %d grid.y %d grid.z %d\n", grid.x, grid.y, grid.z);
    printf("block.x %d block.y %d block.z %d\n", block.x, block.y, block.z);

    // グリッドとブロックのサイズをデバイス側からもチェック
    checkIndex<<<grid, block>>> ();
    
    // デバイスリセット
    cudaDeviceReset();

    return 0;
}