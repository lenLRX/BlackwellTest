#include <cstdint>

__global__ void tmem_relinquish_test(uint32_t* output, uint32_t* input) {
  uint32_t val = input[0];
  asm volatile ("tcgen05.relinquish_alloc_permit.cta_group::2.sync.aligned;":::"memory");
  output[0] = val;
}

