library ieee;
use ieee.std_logic_1164.all; 

entity decoder32 is 
	PORT (
		choose : IN STD_LOGIC_VECTOR(4 downto 0);
		sO : OUT STD_LOGIC_VECTOR(31 downto 0)
		);
end entity decoder32;

architecture rtl of decoder32 is 

BEGIN 

	sO(31) <= choose(4) AND choose(3) AND choose(2) AND choose(1) AND choose(0);
	sO(30) <= choose(4) AND choose(3) AND choose(2) AND choose(1) AND NOT choose(0);
	sO(29) <= choose(4) AND choose(3) AND choose(2) AND NOT choose(1) AND choose(0);
	sO(28) <= choose(4) AND choose(3) AND choose(2) AND NOT choose(1) AND NOT choose(0);
	SO(27) <= choose(4) AND choose(3) AND NOT choose(2) AND choose(1) AND choose(0);
	sO(26) <= choose(4) AND choose(3) AND NOT choose(2) AND choose(1) AND NOT choose(0);
	sO(25) <= choose(4) AND choose(3) AND NOT choose(2) AND NOT choose(1) AND choose(0);
	sO(24) <= choose(4) AND choose(3) AND NOT choose(2) AND NOT choose(1) AND NOT choose(0);
	sO(23) <= choose(4) AND NOT choose(3) AND choose(2) AND choose(1) AND choose(0); 
	sO(22) <= choose(4) AND NOT choose(3) AND choose(2) AND choose(1) AND NOT choose(0);
	sO(21) <= choose(4) AND NOT choose(3) AND choose(2) AND NOT choose(1) AND choose(0); 
	sO(20) <= choose(4) AND NOT choose(3) AND choose(2) AND NOT choose(1) AND NOT choose(0); 
	sO(19) <= choose(4) AND NOT choose(3) AND NOT choose(2) AND choose(1) AND choose(0); 
	sO(18) <= choose(4) AND NOT choose(3) AND NOT choose(2) AND choose(1) AND NOT choose(0); 
	sO(17) <= choose(4) AND NOT choose(3) AND NOT choose(2) AND NOT choose(1) AND choose(0); 
	sO(16) <= choose(4) AND NOT choose(3) AND NOT choose(2) AND NOT choose(1) AND NOT choose(0); 
	sO(15) <= NOT choose(4) AND choose(3) AND choose(2) AND choose(1) AND choose(0);
	sO(14) <= NOT choose(4) AND choose(3) AND choose(2) AND choose(1) AND NOT choose(0);
	sO(13) <= NOT choose(4) AND choose(3) AND choose(2) AND NOT choose(1) AND choose(0);
	sO(12) <= NOT choose(4) AND choose(3) AND choose(2) AND NOT choose(1) AND NOT choose(0);
	SO(11) <= NOT choose(4) AND choose(3) AND NOT choose(2) AND choose(1) AND choose(0);
	sO(10) <= NOT choose(4) AND choose(3) AND NOT choose(2) AND choose(1) AND NOT choose(0);
	sO(9) <= NOT choose(4) AND choose(3) AND NOT choose(2) AND NOT choose(1) AND choose(0);
	sO(8) <= NOT choose(4) AND choose(3) AND NOT choose(2) AND NOT choose(1) AND NOT choose(0);
	sO(7) <= NOT choose(4) AND NOT choose(3) AND choose(2) AND choose(1) AND choose(0); 
	sO(6) <= NOT choose(4) AND NOT choose(3) AND choose(2) AND choose(1) AND NOT choose(0);
	sO(5) <= NOT choose(4) AND NOT choose(3) AND choose(2) AND NOT choose(1) AND choose(0); 
	sO(4) <= NOT choose(4) AND NOT choose(3) AND choose(2) AND NOT choose(1) AND NOT choose(0); 
	sO(3) <= NOT choose(4) AND NOT choose(3) AND NOT choose(2) AND choose(1) AND choose(0); 
	sO(2) <= NOT choose(4) AND NOT choose(3) AND NOT choose(2) AND choose(1) AND NOT choose(0); 
	sO(1) <= NOT choose(4) AND NOT choose(3) AND NOT choose(2) AND NOT choose(1) AND choose(0); 
	sO(0) <= NOT choose(4) AND NOT choose(3) AND NOT choose(2) AND NOT choose(1) AND NOT choose(0); 
	
end rtl;