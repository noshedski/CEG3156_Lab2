library ieee;
use ieee.std_logic_1164.all; 

entity mux2to18bit is
    Port ( s : in  STD_LOGIC;
           w0 , w1  : in  STD_LOGIC_VECTOR(7 Downto 0);
           f   : out STD_LOGIC_VECTOR(7 Downto 0));
end mux2to18bit;

architecture Behavioral of mux2to18bit is
begin
    f <= w1 when (s = '1') else w0;
end Behavioral;