# 8 Bit Microprocessor

**Select dev branch for source and simulation code text.** Read instructions before pushing/commiting any files. 

All refernece documents and project details are in this [notion teamspace](https://www.notion.so/1f8672bc2d6b808e9c27cb4ff6534a75?v=1f8672bc2d6b80278d6d000cef808db9&source=copy_link). Use IIT Indore's institute email to access drive folder.


## INSTRUCTIONS
1. Complete structural modelling must be mentioned for each module in a separate file that should be added in the folder of that module (for multi cycle).
2. Structural modelling file must contain the reference image used to design the module (the image you drew before writing the Verilog code).
3. Add the testbench that was used to verify the design. This will be useful for debugging.
4. Add a top file that has the basic overview of that module (for multi cycle). It should contain:
  > * Name of all input and output buses and their sizes
  > * Mention whether module is combinational or procedural
  > * If possible add a simple diagram that shows all input and output lines. This will be useful in assembly as we won't have to check the Verilog code often.

5. ALU should use carry look ahead adder.
6. Clone dev branch on your computer. After adding code, push into dev branch. Don't bother with main branch.
7. After all modules are made, we will instantiate and assemble them in 8bit_microprocessor.v.

---
## Single Cycle

![Datapath with module names, ports and wire declarations](SingleCycle.jpg)

### Pending:



### Completed:

1. ALU
2. ALU Control Unit
3. RAM64k
4. Register File (32 Bytes)
5. Instruction Memory
6. Program Counter
7. Control Unit
8. Datapath

---
