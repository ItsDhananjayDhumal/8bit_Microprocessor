# 8bit_Modules

Create the modules for assembly here

## INSTRUCTIONS
1. Complete structural modelling must be mentioned for each module in a separate file that should be added in the folder of that module.
2. Structural modelling file must contain the reference image used to design the module (the image you drew before writing the Verilog code).
3. Add the testbench that was used to verify the design. This will be useful for debugging.
4. Add a top file that has the basic overview of that module. It should contain:
  > * Name of all input and output buses and their sizes
  > * Mention whether module is combinational or procedural
  > * If possible add a simple diagram that shows all input and output lines. This will be useful in assembly as we won't have to check the Verilog code often.

5. ALU should use carry look ahead adder.
6. Clone dev branch on your computer. After adding code, push into dev branch. Don't bother with main.
7. After all modules are made, we will instantiate them in 8bit_microprocessor and assemble them.

---

## Pending:

1. Control Unit

---

## Completed:

1. ALU
2. RAM64k
3. Index Registers (X, Y, Z, Accumulator, etc)
4. Special Registers (Stack pointer, Frame pointer, Instruction Reg, etc)
5. Program Counter

---
