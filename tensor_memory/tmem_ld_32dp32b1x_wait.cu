#include <cstdint>

__global__ void tmem_ld_test(uint32_t* output, uint32_t tmem_addr) {
  uint32_t output_val;
  asm volatile ("tcgen05.ld.sync.aligned.32x32b.x1.b32"
                    "{%0},"
                    "[%1];\n"
    :  "=r"(output_val)
    :  "r"(tmem_addr));
  
  asm volatile ("tcgen05.wait::ld.sync.aligned;"::);

  output[0] = output_val;
}

