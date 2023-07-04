library ieee;
use ieee.std_logic_1164.all; 

entity mux4to1_8bit is
    Port ( sel : in  STD_LOGIC_VECTOR(1 downto 0);
           w0 , w1, w2, w3  : in  STD_LOGIC_VECTOR(7 Downto 0);
           f   : out STD_LOGIC_VECTOR(7 Downto 0));
end entity mux4to1_8bit;

architecture Behavioral of mux4to1_8bit is
begin 
process(sel, w0, w1, w2, w3)
    begin
        case sel is
            when "00" =>
                f <= w0;
            when "01" =>
                f <= w1;
            when "10" =>
                f <= w2;
            when others =>
                f <= w3;
        end case;
    end process;
end Behavioral;