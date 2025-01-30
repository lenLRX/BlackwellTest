#include <cstdint>


__global__ void griddep_wait_test(uint32_t* output) {
    asm volatile("griddepcontrol.wait;");
    output[0] = threadIdx.x;
}

