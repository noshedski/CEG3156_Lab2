library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit_TB is
end ControlUnit_TB;

architecture ControlUnit_TB of ControlUnit_TB is 
component ControlUnit is
  port (
    a: in std_logic;
    b: in std_logic;
    c: in std_logic;
    d: in std_logic;
    RegDst: out std_logic;
    RegWrite: out std_logic;
    ALUSrc: out std_logic;
    MemWrite: out std_logic;
    MemRead: out std_logic;
    MemtoReg: out std_logic;
    J: out std_logic;
    Branch: out std_logic;
    BNE: out std_logic;
    ALUOp1: out std_logic;
    ALUOp2: out std_logic;
    ALUOp3: out std_logic;
    ALUOp: out std_logic_vector(2 downto 0)
    );
end component;

   signal a: std_logic;
   signal b: std_logic;
   signal c: std_logic;
   signal d: std_logic;
   signal RegDst: std_logic;
   signal RegWrite: std_logic;
   signal ALUSrc: std_logic;
   signal MemWrite: std_logic;
   signal MemRead: std_logic;
   signal MemtoReg: std_logic;
   signal J: std_logic;
   signal Branch: std_logic;
   signal BNE: std_logic;
   signal ALUOp1: std_logic;
   signal ALUOp2: std_logic;
   signal ALUOp3: std_logic;
   signal ALUOp: std_logic_vector(2 downto 0);
   
   begin
     U0 : ControlUnit port map ( a, b, c, d, RegDst, RegWrite, ALUSrc, MemWrite, MemRead, MemtoReg, J, Branch, BNE,ALUOp1, ALUOp2, ALUOp3, ALUOp);
       
       process
begin
  a <= '0';
  b <= '0';
  c <= '0';
  d <= '0';
  wait for 20 ns;
  
  a <= '0';
  b <= '0';
  c <= '0';
  d <= '1';
  wait for 20 ns;
  
  a <= '0';
  b <= '0';
  c <= '1';
  d <= '0';
  wait for 20 ns;
  
  a <= '0';
  b <= '0';
  c <= '1';
  d <= '1';
  wait for 20 ns;
  
  a <= '0';
  b <= '1';
  c <= '0';
  d <= '0';
  wait for 20 ns;
  
  a <= '0';
  b <= '1';
  c <= '0';
  d <= '1';
  wait for 20 ns;
  
  a <= '0';
  b <= '1';
  c <= '1';
  d <= '0';
  wait for 20 ns;
  
  a <= '0';
  b <= '1';
  c <= '1';
  d <= '1';
  wait for 20 ns;
  
  a <= '1';
  b <= '0';
  c <= '0';
  d <= '0';
  wait for 20 ns;
  
  a <= '1';
  b <= '0';
  c <= '0';
  d <= '1';
  wait;
  
  
end process;
    
  end ControlUnit_TB;
       
     