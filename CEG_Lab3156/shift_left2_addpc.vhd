library ieee;
use ieee.std_logic_1164.all; 

entity shift_left2_addpc is 
	PORT(
		toShift : IN STD_logic_VECTOR(3 downto 0);
		pc_val : IN STD_logic_VECTOR(7 downto 0);
		shifted : OUT StD_logic_VECTOR(7 downto 0)
	);
end shift_left2_addpc;

architecture bhv of shift_left2_addpc is
begin 
	shifted <= pc_val(7 downto 4) & toShift(1 downto 0) & "00" ;
end bhv;