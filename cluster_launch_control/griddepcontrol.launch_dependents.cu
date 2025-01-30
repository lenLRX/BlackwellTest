#include <cstdint>


__global__ void griddep_launch_test(uint32_t* output) {
    asm volatile("griddepcontrol.launch_dependents;");
    output[0] = threadIdx.x;
}

