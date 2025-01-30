#include <cstdint>

__global__ void sm100_mma_mxf4_ss_test(uint32_t *input, uint32_t *output, uint64_t desc_a,
      uint64_t desc_b,
      uint32_t tmem_c,
      uint32_t scaleC,
      uint64_t idescE,
      uint32_t tsfa_addr,
      uint32_t tsfb_addr) {
    asm volatile(
          "{\n\t"
          ".reg .pred p;\n\t"
          "setp.ne.b32 p, %4, 0;\n\t"
          "tcgen05.mma.cta_group::1.kind::mxf4nvf4.block_scale.scale_vec::4X [%0], %1, %2, %3, [%5], [%6], p; \n\t"
          "}\n"
          :
          : "r"(tmem_c), "l"(desc_a), "l"(desc_b), "r"(uint32_t(idescE>>32)), "r"(scaleC),
            "r"(tsfa_addr), "r"(tsfb_addr));
}
