library ieee;
use ieee.std_logic_1164.all; 

entity fileRegister is 
	PORT(
		gClock, gReset, regWrite : IN STD_LOGIC;
		addRR1, addRR2 : IN STD_logic_vector(4 downto 0);
		writeData  : IN STD_logic_vector(7 downto 0);
		writeRegister : IN STD_logic_vector(4 downto 0);
		readReg1: OUT STD_logic_vector(7 downto 0); -- , rtest2, rtest3
		-- enable : OUT STD_LOGIC_VECTOR(31 downto 0);
		readReg2 : OUT STD_logic_vector(7 downto 0)
	);
end entity fileRegister;

architecture rtl of fileRegister is

	SIGNAL enrr1 , en : STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL rr1, rr2, rD31, rD30, rD29, rD28, rD27, rD26, rD25, rD24, rD23, rD22, rD21, rD20 : STD_LOGIC_VECTOR(7 downto 0);
	SIGNAl rD19, rD18, rD17, rD16, rD15, rD14, rD13, rD12, rD11, rD10 : STD_LOGIC_VECTOR( 7 downto 0);
	SIGNAL rD9, rD8, rD7, rD6, rD5, rD4, rD3, rD2, rD1, rD0 : STD_LOGIC_VECTOR(7 downto 0);
	
	
	component decoder32 is 
		PORT (
			choose : IN STD_LOGIC_VECTOR(4 downto 0);
			sO : OUT STD_LOGIC_VECTOR(31 downto 0)
			);
	end component decoder32;
	
	component mux32to1_8bit is
		PORT(
			sel : IN STD_LOGIC_VECTOR(4 downto 0);
			w0, w1, w2, w3, w4, w5, w6, w7, w8, w9 : IN STD_LOGIC_VECTOR(7 downto 0); 
			w10, w11, w12, w13, w14, w15, w16, w17 : IN STD_LOGIC_VECTOR(7 downto 0); 
			w18, w19, w20, w21, w22, w23, w24, w25 : IN STD_LOGIC_VECTOR(7 downto 0);
			w26, w27, w28, w29, w30, w31 : IN STD_LOGIC_VECTOR(7 downto 0);
			fout : OUT STD_LOGIC_VECTOR(7 downto 0)
		);
	end component mux32to1_8bit;
	
	component eightbitregister is 
		PORT (i_value : IN STD_LOGIC_VECTOR(7 downto 0);
				i_load, i_clock, i_resetBar : IN STD_LOGIC;
				o_Value : OUT STD_LOGIC_VECTOR(7 downto 0)
		);
	end component eightbitregister;
	
BEGIN

	enDecod1 : decoder32
		PORT MAP(
			choose => writeRegister,
			sO => enrr1
		);
	
	en(31) <= (enrr1(31) ) AND regWrite;
	en(30) <= (enrr1(30) ) AND regWrite;
	en(29) <= (enrr1(29) ) AND regWrite;
	en(28) <= (enrr1(28) ) AND regWrite;
	en(27) <= (enrr1(27) ) AND regWrite;
	en(26) <= (enrr1(26) ) AND regWrite;
	en(25) <= (enrr1(25) ) AND regWrite;
	en(24) <= (enrr1(24) ) AND regWrite;
	en(23) <= (enrr1(23) ) AND regWrite;
	en(22) <= (enrr1(22) ) AND regWrite;
	en(21) <= (enrr1(21) ) AND regWrite;
	en(20) <= (enrr1(20) ) AND regWrite;
	en(19) <= (enrr1(19) ) AND regWrite;
	en(18) <= (enrr1(18) ) AND regWrite;
	en(17) <= (enrr1(17) ) AND regWrite;
	en(16) <= (enrr1(16) ) AND regWrite;
	en(15) <= (enrr1(15) ) AND regWrite;
	en(14) <= (enrr1(14) ) AND regWrite;
	en(13) <= (enrr1(13) ) AND regWrite;
	en(12) <= (enrr1(12) ) AND regWrite;
	en(11) <= (enrr1(11) ) AND regWrite;
	en(10) <= (enrr1(10) ) AND regWrite;
	en(9) <= (enrr1(9) ) AND regWrite;
	en(8) <= (enrr1(8) ) AND regWrite;
	en(7) <= (enrr1(7) ) AND regWrite;
	en(6) <= (enrr1(6) ) AND regWrite;
	en(5) <= (enrr1(5) ) AND regWrite;
	en(4) <= (enrr1(4) ) AND regWrite;
	en(3) <= (enrr1(3) ) AND regWrite;
	en(2) <= (enrr1(2) ) AND regWrite;
	en(1) <= (enrr1(1) ) AND regWrite;
	en(0) <= (enrr1(0) ) AND regWrite;
	
	reg31: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(31),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD31
			);
			
	reg30: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(30),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD30
			);
			
	reg29: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(29),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD29
			);
			
	reg28: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(28),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD28
			);
			
	reg27: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(27),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD27
			);
			
	reg26: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(26),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD26
			);
			
	reg25: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(25),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD25
			);
			
	reg24: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(24),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD24
			);
			
	reg23: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(23),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD23
			);
			
	reg22: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(22),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD22
			);
			
			
	reg21: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(21),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD21
			);
			
	reg20: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(20),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD20
			);
			
	reg19: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(19),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD19
			);
			
	reg18: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(18),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD18
			);
			
	reg17: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(17),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD17
			);
			
	reg16: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(16),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD16
			);
			
	reg15: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(15),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD15
			);
			
	reg14: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(14),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD14
			);
			
	reg13: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(13),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD13
			);
			
	reg12: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(12),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD12
			);
			
	reg11: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(11),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD11
			);
			
	reg10: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(10),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD10
			);
			
	reg9: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(9),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD9
			);
			
	reg8: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(8),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD8
			);
			
	reg7: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(7),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD7
			);
			
	reg6: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(6),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD6
			);
			
			
	reg5: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(5),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD5
			);
			
	reg4: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(4),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD4
			);
			
	reg3: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(3),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD3
			);
			
	reg2: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(2),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD2
			);
			
	reg1: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(1),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD1
			);
			
	reg0: eightbitregister 
		PORT MAP(
			i_value => writeData,
			i_load => en(0),
			i_clock => gClock,
			i_resetBar => gReset,
			o_Value => rD0
			);
			
			
	chooseRR1: mux32to1_8bit
		PORT MAP(
			sel => addRR1,
			w0 => rD0,
			w1 => rD1,
			w2 => rD2,
			w3 => rD3,
			w4 => rD4,
			w5 => rD5,
			w6 => rD6,
			w7 => rD7,
			w8 => rD8,
			w9 => rD9,
			w10 => rD10,
			w11 => rD11,
			w12 => rD12,
			w13 => rD13,
			w14 => rD14,
			w15 => rD15,
			w16 => rD16,
			w17 => rD17,
			w18 => rD18,
			w19 => rD19,
			w20 => rD20,
			w21 => rD21,
			w22 => rD22,
			w23 => rD23,
			w24 => rD24,
			w25 => rD25,
			w26 => rD26,
			w27 => rD27,
			w28 => rD28,
			w29 => rD29,
			w30 => rD30,
			w31 => rD31,
			fout => rr1
		);
		
	chooseRR2: mux32to1_8bit
		PORT MAP(
			sel => addRR2,
			w0 => rD0,
			w1 => rD1,
			w2 => rD2,
			w3 => rD3,
			w4 => rD4,
			w5 => rD5,
			w6 => rD6,
			w7 => rD7,
			w8 => rD8,
			w9 => rD9,
			w10 => rD10,
			w11 => rD11,
			w12 => rD12,
			w13 => rD13,
			w14 => rD14,
			w15 => rD15,
			w16 => rD16,
			w17 => rD17,
			w18 => rD18,
			w19 => rD19,
			w20 => rD20,
			w21 => rD21,
			w22 => rD22,
			w23 => rD23,
			w24 => rD24,
			w25 => rD25,
			w26 => rD26,
			w27 => rD27,
			w28 => rD28,
			w29 => rD29,
			w30 => rD30,
			w31 => rD31,
			fout => rr2
		);
		
		readReg1 <= rr1;
		readReg2 <= rr2;
		--rtest2 <= rd2;
		--rtest3 <= rd3;
		--enable <= en;
end rtl;