library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
  port (
	 instructionCode : IN STD_logic_VECTOR(5 downto 0);
    RegDst: out std_logic;
    RegWrite: out std_logic;
    ALUSrc: out std_logic;
    MemWrite: out std_logic;
    MemRead: out std_logic;
    MemtoReg: out std_logic;
    Jump: out std_logic;
	 ALUop: OUT STD_logic_VECTOR(2 downto 0);
    Branch: out std_logic;
    BNE: out std_logic
  );
end entity ControlUnit;

architecture structural of ControlUnit is

  signal regDst1, regWrite1, ALUSrc1, MemWrite1, MemRead1, MemtoReg1, J1, Branch1, BNE1, A, B, C, D, ALUop11, ALUop12, ALUop13: std_logic;
begin

	A <= instructionCode(3);
	B <= instructionCode(2);
	C <= instructionCode(1);
	D <= instructionCode(0);

  regDst1 <= ((NOT A) AND (NOT B)) OR (A AND (NOT D));
  regWrite1 <= ((NOT A) AND (NOT C)) OR ((NOT A) AND (NOT B));
  ALUSrc1 <= (B AND (NOT C) AND D) OR (B AND C AND (NOT D));
  MemWrite1 <= (B AND C AND (NOT D));
  MemRead1 <= (B AND (NOT C) AND D);
  MemtoReg1 <= (B AND D);
  J1 <= (A AND (NOT D));
  Branch1 <= (B AND C AND D);
  BNE1 <= (A AND D);
  ALUop11 <= ((NOT C) AND (NOT B) AND D) OR (B AND (NOT D) AND (NOT C));
  ALUop12 <= B OR (NOT C);
  ALUop13 <= (C AND D) OR (B AND (NOT C) AND (NOT D));
  
  regDst <= regDst1;
  regWrite <= regWrite1;
  ALUSrc <= ALUSrc1;
  MemWrite <= MemWrite1;
  MemRead <= MemRead1;
  MemtoReg <= MemtoReg1;
  Jump <= J1;
  Branch <= Branch1;
  BNE <= BNE1;
  ALUop <= aluop11 & aluop12 & aluop13;

end structural;

