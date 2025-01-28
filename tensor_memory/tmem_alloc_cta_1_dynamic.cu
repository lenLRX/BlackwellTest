#include <cstdint>

__global__ void tmem_alloc_test(uint32_t* output, uint32_t* alloc_size, int alloc_n) {
  __shared__ uint32_t val;
  for (int i = 0; i < alloc_n; ++i) {
    asm volatile ("tcgen05.alloc.cta_group::1.sync.aligned.shared::cta.b32 [%0], %1;"::"l"(&val), "r"(alloc_size[i]):"memory");
    output[i] = val;
  }
}

