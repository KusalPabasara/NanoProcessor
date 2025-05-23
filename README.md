# Improved Nano Processor (Group 17)

## 🔍 Summary

This project is a university-level implementation of an improved 14-bit Nano Processor, developed using Xilinx Vivado. The processor introduces an extended instruction set to perform logical, shift, and rotate operations alongside basic arithmetic and control flow instructions. It features a structured register-based instruction format and integrates real-time debugging through LED outputs and status flags. This work showcases practical CPU architecture design, custom assembly language development, and FPGA-based implementation.

## 🚀 Project Overview

The Improved Nano Processor expands on a basic nano-architecture to support more versatile operations essential for modern computing applications. Developed as part of a digital systems coursework, it offers a hands-on exploration into CPU design, instruction set architecture (ISA), and hardware synthesis using FPGAs.

## 🛠 Features

- ✅ Custom 14-bit instruction format  
- 🔁 Logical operations: AND, OR, XOR, NOT  
- 🔄 Shift & Rotate operations: SHL, SHR, ROL, ROR  
- ➕ Arithmetic & Control instructions: ADD, NEG, MOV, JRZ  
- 💡 Real-time debug with LEDs and flag indicators  
- 📂 Fully integrated Vivado project with simulation support  

## 🧠 Instruction Format

Each instruction is 14 bits:
- **4 bits**: Opcode (defines operation type)
- **6 bits**: Source registers (RA, RB or Rs)
- **4 bits**: Destination register (Rd) or immediate data

### Example Instructions

- `AND RA, RB, Rd` → `0100 RARARA RBRBRB RdRdRdRd`  
- `SHL Rd, Rs, n`  → `1000 RdRdRd RsRsRs 00nn`  
- `NOT RA, Rd`     → `0111 RARARA 000 RdRdRdRd`  

## 💡 LED & Flag Indicators

- **Output (R7)**:  
  - Bit 4: V19  
  - Bit 3: U19  
  - Bit 2: E19  
  - Bit 1: U16  

- **Flags**:  
  - Overflow: L1  
  - Zero: P1  
  - Carry: N3  
  - Sign: P3  


## 🧪 Requirements

- Xilinx Vivado (FPGA development environment)
- FPGA development board compatible with the provided pin configuration

## 📜 License

This project is developed for educational purposes and coursework evaluation. Please contact the authors before reuse or modification.

---

Developed by **Group 17**  
Department of Computer Science and Engineering  
University Project – 2025
