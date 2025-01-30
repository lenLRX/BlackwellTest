import fileinput

for line in fileinput.input():
    line = line.strip()
    val = int(line, base=16)
    binary_str = format(val, "#064b")[2:]
    reuse = binary_str[:4]
    wait_bitmask = binary_str[4:10]
    rd_idx = int(binary_str[10:13], base=2)
    wr_idx = int(binary_str[13:16], base=2)
    yield_flag = binary_str[16]
    stall_cycle = int(binary_str[17:21], base=2)
    print("wait_bitmask", wait_bitmask)
    print(f"rd_idx {rd_idx} wr_idx {wr_idx} stall cycle {stall_cycle}")
