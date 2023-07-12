LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity alu8bit IS 
	PORT(
		rA,rB : IN STD_LOGIC_VECTOR(7 downto 0);
		aluOP: IN STD_LOGIC_VECTOR(2 downto 0);
		alurOUT : OUT STD_LOGIC_VECTOR(7 downto 0);
		zeroes : OUT STD_logic
	);
end alu8bit;

architecture rtl of alu8bit is 
	
	SIGNAL logicOR, logicAND, addANDSub, result, setLessTHAN, subtractedVal, lessOne :  STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL carryout, oflow, csubout, subOFLOW : STD_logic;

	component mux6to1_8bitALU is
		 Port ( sel : in  STD_LOGIC_VECTOR(2 downto 0);
           w0 , w1, w2, w3, w4, w5  : in  STD_LOGIC_VECTOR(7 Downto 0);
           f   : out STD_LOGIC_VECTOR(7 Downto 0));
	end component mux6to1_8bitALU;

	component addsub8bit is
		port( OP: in std_logic;
				 A,B  : in std_logic_vector(7 downto 0);
				 R  : out std_logic_vector(7 downto 0);
				 Cout, OVERFLOW : out std_logic);
	end component addsub8bit;
	
begin 

	addORsub : addsub8bit
		PORT MAP(
			OP => aluOP(2),
			A => rA,
			B => rB,
			R => addANDSub,
			cout => carryout,
			OVERFLOW => oflow
		);
		
		setLessTHAN <= "00000000";
		logicAND <= rA AND rB;
		logicOR <= rA OR rB;
		
		chooseALU : mux6to1_8bitALU
			PORT MAP(
				sel => ALUOP,
				w0 => logicAND,
				w1 => logicOR,
				w2 => addANDSub,
				w3 => setLessTHAN,
				w4 => subtractedVal,
				w5 => "00000000",
				f => result	
			);

	addORsub2 : addsub8bit
		PORT MAP(
			OP => '1',
			A => addANDSub,
			B => "00000001",
			R => lessOne,
			cout => csubout,
			OVERFLOW => subOFLOW
		);
		
	subtractedVal <= lessOne XOR "11111111";
	
	zeroes <= NOT result(7) AND NOT result(6) AND NOT result(5) AND NOT result(4) AND NOT result(3) AND NOT result(2) AND NOT result(1) AND NOT result(0);
	alurOUT <= result;
end rtl;

