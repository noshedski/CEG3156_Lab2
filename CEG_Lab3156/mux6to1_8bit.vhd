library ieee;
use ieee.std_logic_1164.all; 

entity mux6to1_8bit is
    Port ( sel : in  STD_LOGIC_VECTOR(2 downto 0);
           w0 , w1, w2, w3, w4, w5  : in  STD_LOGIC_VECTOR(7 Downto 0);
           f   : out STD_LOGIC_VECTOR(7 Downto 0));
end entity mux6to1_8bit;

architecture Behavioral of mux6to1_8bit is
begin 
process(sel, w0, w1, w2, w3, w4, w5)
    begin
        case sel is
            when "000" =>
                f <= w0;
            when "001" =>
                f <= w1;
            when "010" =>
                f <= w2;
				when "011" =>
					 f <= w3;
				when "100" =>
					 f <= w4;
            when others =>
                f <= w5;
        end case;
    end process;
end Behavioral;