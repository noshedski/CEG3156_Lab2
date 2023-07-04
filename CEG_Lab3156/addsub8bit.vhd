library ieee;
use ieee.std_logic_1164.all;

entity addsub8bit is
   port( OP: in std_logic;
          A,B  : in std_logic_vector(7 downto 0);
          R  : out std_logic_vector(7 downto 0);
          Cout, OVERFLOW : out std_logic);
end addsub8bit;
 
architecture struct of addsub8bit is
component oneBitAdder is
  port( X, Y, Cin : in std_logic;
        sum, Cout : out std_logic);
end component;
signal C1, C2, C3, C4, C5, C6, C7, C8: std_logic;
signal TMP: std_logic_vector(7 downto 0);
 
begin
TMP(0) <= OP XOR B(0);
TMP(1)<= OP xor B(1);
TMP(2)<= OP xor B(2);
TMP(3)<= OP xor B(3);
TMP(4) <= OP xor B(4);
TMP(5) <= OP xor B(5);
TMP(6) <= OP xor B(6);
TMP(7) <= OP xor B(7);
FA0:oneBitAdder port map(A(0),TMP(0),OP, R(0),C1); 
FA1:oneBitAdder port map(A(1),TMP(1),C1, R(1),C2); 
FA2:oneBitAdder port map(A(2),TMP(2),C2, R(2),C3); 
FA3:oneBitAdder port map(A(3),TMP(3),C3, R(3),C4); 
FA4:oneBitAdder port map(A(4),TMP(4),C4, R(4),C5);
FA5:oneBitAdder port map(A(5),TMP(5),C5, R(5),C6);
FA6:oneBitAdder port map(A(6),TMP(6),C6, R(6),C7);
FA7:oneBitAdder port map(A(7),TMP(7),C7, R(7),C8);
OVERFLOW <= C7 XOR C8 ;
Cout <= C8;
end struct;