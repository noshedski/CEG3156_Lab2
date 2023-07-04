library ieee;
use ieee.std_logic_1164.all;
entity oneBitAdder is
   port( X, Y, Cin : in std_logic;
         sum, Cout : out std_logic);
end oneBitAdder;
 
architecture bhv of oneBitAdder is
begin
   sum <= (X xor Y) xor Cin;
   Cout <= (X and (Y or Cin)) or (Cin and Y);
end bhv;
