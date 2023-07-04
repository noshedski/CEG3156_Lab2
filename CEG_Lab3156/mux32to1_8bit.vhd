library ieee;
use ieee.std_logic_1164.all; 

entity mux32to1_8bit is
	PORT(
		sel : IN STD_LOGIC_VECTOR(4 downto 0);
		w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31 : IN STD_LOGIC_VECTOR(7 downto 0);
		fout : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
end entity mux32to1_8bit;

architecture bhv of mux32to1_8bit is 

begin
    process(sel)
    begin
        case sel is
            when "11111" =>
                fout <= w31;
            when "11110" =>
                fout <= w30;
            when "11101" =>
                fout <= w29;
            when "11100" =>
                fout <= w28;
            when "11011" =>
                fout <= w27;
            when "11010" =>
                fout <= w26;
            when "11001" =>
                fout <= w25;
            when "11000" =>
                fout <= w24;
            when "10111" =>
                fout <= w23;
            when "10110" =>
                fout <= w22;
            when "10101" =>
                fout <= w21;
            when "10100" =>
                fout <= w20;
            when "10011" =>
                fout <= w19;
            when "10010" =>
                fout <= w18;
            when "10001" =>
                fout <= w17;
            when "10000" =>
                fout <= w16;
            when "01111" =>
                fout <= w15;
            when "01110" =>
                fout <= w14;
            when "01101" =>
                fout <= w13;
            when "01100" =>
                fout <= w12;
            when "01011" =>
                fout <= w11;
            when "01010" =>
                fout <= w10;
            when "01001" =>
                fout <= w9;
            when "01000" =>
                fout <= w8;
            when "00111" =>
                fout <= w7;
            when "00110" =>
                fout <= w6;
            when "00101" =>
                fout <= w5;
            when "00100" =>
                fout <= w4;
            when "00011" =>
                fout <= w3;
            when "00010" =>
                fout <= w2;
            when "00001" =>
                fout <= w1;
            when others =>
                fout <= w0;
        end case;
    end process;
end bhv;
