#include <cstdint>

struct CLCResponse { uint32_t data[4]; };

__global__ void cluster_launch_control_test(uint32_t* output) {
  __shared__ CLCResponse clc_resp;
  __shared__ uint64_t mbarrier;
  uint32_t result_addr = static_cast<uint32_t>(__cvta_generic_to_shared(&clc_resp));
  uint32_t mbarrier_addr = static_cast<uint32_t>(__cvta_generic_to_shared(&mbarrier));

  asm volatile(
        "{\n\t"
        "clusterlaunchcontrol.try_cancel.async.shared::cta.mbarrier::complete_tx::bytes.multicast::cluster::all.b128 [%0], [%1];\n\t"
        "}\n"
        :
        : "r"(result_addr), "r"(mbarrier_addr));
  uint32_t m_idx, n_idx, l_idx, valid;
  asm volatile(
        "{\n"
        ".reg .pred p1;\n\t"
        ".reg .b128 clc_result;\n\t"
        "ld.shared.b128 clc_result, [%4];\n\t"
        "clusterlaunchcontrol.query_cancel.is_canceled.pred.b128 p1, clc_result;\n\t"
        "selp.u32 %3, 1, 0, p1;\n\t"
        "@p1 clusterlaunchcontrol.query_cancel.get_first_ctaid.v4.b32.b128 {%0, %1, %2, _}, clc_result;\n\t"
        "}\n"
        : "=r"(m_idx), "=r"(n_idx), "=r"(l_idx), "=r"(valid)
        : "r"(result_addr)
        : "memory"
      );
  output[0] = m_idx + n_idx + l_idx + valid;
}

