#include <cstdint>

__global__ void tmem_dealloc_test(uint32_t* input) {
  uint32_t val = input[0];
  asm volatile ("tcgen05.dealloc.cta_group::2.sync.aligned.b32 %0, 32;"::"r"(val):"memory");
}

