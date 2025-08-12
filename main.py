import re

opcodes = {
    'lw' : '100011',
    'sw' : '101011',
    'lwi': '001010',
    'adi': '001000',
    'subi': '001001',
    'add': '000000',
    'sub': '000000',
    'and': '000000',
    'or':  '000000',
    'not': '000000',
    'ls':  '000000',
    'urs': '000000',
    'srs': '000000',
    'ror': '000000',
    'rol': '000000',
    'mov': '000000',
    'beq': '000100',
    'bne': '000001',
    'blt': '000011',
    'bge': '000101',
    'j':   '000010',
    'jal': '000110',
    'jr':  '000111',
    'nop': '111111'
}

func_codes = {
    'add': '000000',
    'mov': '000000',
    'sub': '000010',
    'and': '000100',
    'or' : '000101',
    'not': '000001',
    'ls' : '111101',
    'urs': '111001',
    'srs': '111010',
    'ror': '111011',
    'rol': '111110'
}

registers = {
    f"${i}": f"{i:05b}" for i in range(32)
}
registers['$zero'] =registers['$31'] = '11111'

def b(val, bits):
    val = int(val)
    if val < 0:
        val = (1 << bits) + val
    return f"{val:0{bits}b}"[-bits:]

mem_lines = []
full_instrs = []
def emit(instr):
    for i in range(0, 32, 8):
        mem_lines.append(instr[i:i+8])
    full_instrs.append(instr)

def parse_swlw(field):
    rt = registers[field[1]]
    rs = registers[field[2]]
    imm = b(field[3], 8)
    instr = opcodes[field[0]] + rs + rt + "00000000" + imm
    emit(instr.ljust(32, '0'))

def parse_itype(field):
    rt = registers[field[1]]
    rs = registers['$31'] if (field[0]=='lwi') else registers[field[2]]
    imm = b(field[2] if (field[0]=='lwi') else field[3], 8)
    instr = opcodes[field[0]] + rs + rt + "00000000" + imm
    emit(instr.ljust(32, '0'))


def parse_rtype(field):
    if field[0] in ['mov','not']:
        field.append('$31')
    if (field[0] in ['ls','urs','srs','ror','rol']):
        field.insert(3, '$31')

    rd = registers[field[1]]
    rs = registers[field[2]]
    rt = registers[field[3]]
    shamt = b(field[4], 5) if (field[0] in ['ls', 'urs', 'srs', 'ror', 'rol']) else "00000"
    instr = opcodes[field[0]] + rs + rt + rd + shamt + func_codes[field[0]]
    emit(instr)

def parse_branch(field):
    rt = registers[field[2]]
    rs = registers[field[1]]
    offset = b(field[3], 16)
    instr = opcodes[field[0]] + rs + rt + offset
    emit(instr)

def parse_j(field):
    if field[0] == 'jr':
        rs = registers['$30']
        instr = opcodes[field[0]] + rs + '00000000000000000000000000'
        emit(instr)
    else:
        addr = b(field[1], 26)
        instr = opcodes[field[0]] + addr
        emit(instr)

def parse_nop(field):
    instr = opcodes['nop'] + '00000000000000000000000000'
    emit(instr)

parser_map = {
    'lw': parse_swlw,
    'sw': parse_swlw,
    'lwi': parse_itype,
    'adi': parse_itype,
    'subi': parse_itype,
    'add': parse_rtype,
    'mov': parse_rtype,
    'sub': parse_rtype,
    'and': parse_rtype,
    'or': parse_rtype,
    'not': parse_rtype,
    'ls': parse_rtype,
    'urs': parse_rtype,
    'srs': parse_rtype,
    'ror': parse_rtype,
    'rol': parse_rtype,
    'beq': parse_branch,
    'bne': parse_branch,
    'blt': parse_branch,
    'bge': parse_branch,
    'j': parse_j,
    'jal': parse_j,
    'jr': parse_j,
    'nop': parse_nop
}

def assemble(lines):
    for line in lines:
        line = line.split('#')[0].strip()
        if not line:
            continue
        field = line.replace(',', '').split()
        instr = field[0].lower()
        if instr in parser_map:
            parser_map[instr](field)
        else:
            print(f"Unknown instruction: {instr}")

if __name__ == "__main__":
    with open("program.asm", "r") as f:
        lines = f.readlines()
    assemble(lines)
    with open("machinecode.mem", "w") as f:
        f.write('\n'.join(mem_lines))
    with open("machinecode.txt", "w") as f:
        f.write('\n'.join(full_instrs))

def convert_bin_to_mem_format(input_file, output_file):
    """
    Convert binary code from input file to memory format.

    Args:
        input_file: Path to input file containing binary data
        output_file: Path to output file (optional, defaults to stdout)
    """

    try:
        with open(input_file, 'r') as f:
            lines = f.readlines()

        # Clean up lines - remove whitespace and empty lines
        binary_lines = []
        for line in lines:
            line = line.strip()
            if line and all(c in '01' for c in line):
                binary_lines.append(line)

        # Generate memory format
        mem_lines = []
        for i, binary in enumerate(binary_lines):
            mem_line = f"mem[{i}] = 8'b{binary};"
            mem_lines.append(mem_line)

        # Output results
        if output_file:
            with open(output_file, 'w') as f:
                for line in mem_lines:
                    f.write(line + '\n')
            print(f"Conversion complete! Output saved to {output_file}")
        else:
            print("Memory format:")
            for line in mem_lines:
                print(line)

    except FileNotFoundError:
        print(f"Error: File '{input_file}' not found.")
    except Exception as e:
        print(f"Error: {e}")


if __name__ == "__main__":
    # Convert machinecode.mem and print to stdout
    convert_bin_to_mem_format("machinecode.mem", "memory.txt")

    # Uncomment the line below to save output to a file instead
    # convert_bin_to_mem_format("machinecode.mem", "output.mem")