#include <cstdint>

__global__ void tmem_alloc_test(uint32_t* output) {
  __shared__ uint32_t val;
  asm volatile ("tcgen05.alloc.cta_group::1.sync.aligned.shared::cta.b32 [%0], 64;"::"l"(&val):"memory");
  output[0] = val;
}

