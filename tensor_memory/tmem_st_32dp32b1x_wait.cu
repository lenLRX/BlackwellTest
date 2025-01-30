#include <cstdint>

__global__ void tmem__test(uint32_t* input, uint32_t* output, uint32_t tmem_addr) {
  uint32_t input_val = input[0];
  asm volatile ("tcgen05.st.sync.aligned.32x32b.x1.b32"
                    "[%0],"
                    "{%1};\n"
    :
    :  "r"(tmem_addr), "r"(input_val) );
  asm volatile (
    "{\n\t"
    "tcgen05.wait::st.sync.aligned; \n"
    "}"
    ::);
  uint32_t output_val;
  asm volatile ("tcgen05.ld.sync.aligned.32x32b.x1.b32"
                    "{%0},"
                    "[%1];\n"
    :  "=r"(output_val)
    :  "r"(tmem_addr));
  output[0] = output_val;
}

