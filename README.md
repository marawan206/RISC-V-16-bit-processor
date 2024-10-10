# RISC-V 16-bit Processor Architecture

## Table of Contents
1. [Introduction](#introduction)
2. [Key Features of RISC-V 16-bit Processor](#key-features-of-risc-v-16-bit-processor)
3. [Background and Literature Review](#background-and-literature-review)
4. [Comparison Between CISC and RISC Architectures](#comparison-between-cisc-and-risc-architectures)
5. [The Resurgence of RISC and the Evolution of RISC-V 16-bit Processors](#the-resurgence-of-risc-and-the-evolution-of-risc-v-16-bit-processors)
6. [Applications of RISC-V Architecture](#applications-of-risc-v-architecture)
7. [Methodology](#methodology)
8. [RISC-V Architecture](#risc-v-architecture)
9. [Datapath of RISC-V Architecture](#datapath-of-risc-v-architecture)
10. [Simulation Steps](#simulation-steps)
11. [Optimization](#optimization)
12. [Results](#results)
13. [Waveform Outputs](#waveform-outputs)

---

## Introduction

The development of Very Large-Scale Integration (VLSI) technology in the 1970s initiated the microprocessor revolution, giving rise to processors that serve as the "brain" of modern electronic systems. This project explores the RISC-V 16-bit processor architecture, which leverages the simplicity and efficiency of RISC (Reduced Instruction Set Computing) in combination with an open-source, modular design.

RISC-V, a free and open Instruction Set Architecture (ISA), was developed at Berkeley in 2010. It has since gained popularity for its simplicity, modularity, and open-source licensing, making it a significant contender for applications in the IoT era.

---

## Key Features of RISC-V 16-bit Processor

1. **Compact Instruction Set**:  
   Uses the Compressed (C) extension, reducing instruction size to 16 bits, lowering memory usage and power consumption.
   
2. **Three-Operand Load-Store Architecture**:  
   Memory access is limited to load and store instructions, while all other operations are performed on registers.
   
3. **Modular Design**:  
   Supports extensions such as multiplication/division (M) and atomic operations (A) to tailor the processor for specific applications.
   
4. **Simplicity and Efficiency**:  
   The processor is easier to implement and verify, while being power-efficient and ideal for embedded systems.

5. **Open-Source Ecosystem**:  
   RISC-V has a robust open-source community, facilitating collaboration and innovation.

---

## Background and Literature Review

VLSI integration has revolutionized processor design by enabling the integration of the CPU, RAM, ROM, and other components onto a single chip. The RISC-V architecture is part of this technological evolution, bringing a flexible, open-source ISA that is gaining traction in the semiconductor industry.

---

## Comparison Between CISC and RISC Architectures

CISC and RISC architectures offer different design philosophies. While CISC focuses on minimizing the number of instructions per program, RISC emphasizes simplicity, using fewer instruction types that execute in a single clock cycle.

---

## The Resurgence of RISC and the Evolution of RISC-V 16-bit Processors

RISC-V represents the culmination of decades of research and development in reduced instruction set computing. Its open-source nature and adaptability make it a key player in the resurgence of RISC, particularly in applications where power efficiency and simplicity are paramount.

---

## Applications of RISC-V Architecture

RISC-V is suited for a variety of applications, including:
- Embedded systems
- IoT devices
- Low-power computing
- Custom processors for academic research and development

---

## Methodology

### RISC-V Architecture Components

1. **Arithmetic Logic Unit (ALU)**:  
   Performs arithmetic and logical operations essential for executing instructions.
   
2. **Registers**:  
   General-purpose and special-purpose registers store temporary data and control values like the program counter (PC).
   
3. **Program Counter (PC)**:  
   Holds the address of the next instruction to be executed.

4. **Instruction Decoder**:  
   Decodes instructions to determine the operation and operands involved.
   ![[Screenshot 2024-10-10 125407.png]]

5. **Control Unit**:  
   Manages instruction execution by coordinating processor components.

6. **Sign Extend**:  
   Extends smaller bit fields (e.g., jump or branch offsets) to larger widths.

7. **Memory Interface**:  
   Manages connections to external memory for data and instruction fetching.

8. **I/O Ports**:  
   Interfaces for external devices such as sensors and communication modules.
   
![[Screenshot 2024-10-10 125356.png]]

9. **Timers/Counters**:  
   Provide timing functions for control and scheduling tasks.

10. **Data Bus**:  
    Transfers data between processor, memory, and I/O devices.

11. **Address Bus**:  
    Carries the address of memory locations or I/O ports to be accessed.

12. **Control Bus**:  
    Coordinates the activities of various components through control signals.

---

## RISC-V Architecture

![[Screenshot 2024-10-10 125424.png]]
---
## Datapath of RISC-V Architecture

![[Screenshot 2024-10-10 125435.png]]

---

## Simulation Steps

### Instruction Set Overview

- **Instruction Format**: 16 bits total, with a 4-bit opcode and 12 bits for operands or immediate values.
- **Instruction Types**:
   - **R-Type Instructions**: Operate on registers.
   - **I-Type Instructions**: Use immediate values for operations like load and store.
   - **Branch Instructions**: Execute conditional operations based on register comparisons.

---

## Optimization

The RISC-V 16-bit processor's design optimizes both performance and power consumption, making it particularly well-suited for resource-constrained environments like IoT.

---

## Results

The simulation was carried out using XILINIX VIVADO, showcasing the functionality of key instructions, including load, store, add, jump, and immediate instructions.

---

## Waveform Outputs

- **Load Instruction Implementation**  
Load Instruction Waveform Image![[Screenshot 2024-10-10 125749.png]]**_

- **Load Immediate Instruction**  
  Load Immediate Instruction Waveform Image![[2.png]]**_

- **Add Instruction**  
  Instruction Waveform Image![[3.png]]**_

- **Jump Instruction**  
   JMP Instruction Waveform Image![[4.png]]**_

- **Store Instruction**  
  Store Instruction Waveform Image![[5.png]]**_

- **Load Instruction**  
  Load Instruction Waveform Image![[6.png]]**_

---

## Conclusion

The RISC-V 16-bit processor architecture demonstrates a balance between simplicity and flexibility, offering a robust platform for embedded systems and IoT applications. Its open-source nature encourages further research and development, contributing to the advancement of VLSI and processor design.

