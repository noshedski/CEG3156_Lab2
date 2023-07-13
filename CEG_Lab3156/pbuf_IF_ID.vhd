library ieee;
use ieee.std_logic_1164.all; 

entity pbuf_IF_ID is
	PORT(
		instructionIN : IN STD_LOGIC_VECTOR(31 downto 0);
		pcp4_IN : IN STD_LOGIC_VECTOR(7 downto 0);
		iClock, iReset, eFLUSH : IN STD_LOGIC;
		instructionOUT: OUT STD_LOGIC_VECTOR(31 downto 0);
		pcp4_OUT : OUT STD_LOGIC_VECTOR(7 downto 0);
	);
end entity pbuf_IF_ID;

architecture rtl of pbuf_IF_ID
	
	
	SIGNAL  instrMEM, instrMEM_not : STD_LOGIC_VECTOR(31 downto 0);
	
	
	component thirtytwobitregister
		PORT (
			A : IN STD_LOGIC_VECTOR(31 downto 0);
			gEn, gClk, gRst : IN STD_LOGIC;
			output : OUT STD_LOGIC_VECTOR(31 downto 0);
			output_not : OUT STD_LOGIC_VECTOR(31 downto 0)
		);
	end component thirtytwobitregister;
	
	component eightbitregister
		PORT(
			i_resetBar, i_load	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
			o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0));
	end component eightbitregister;
	
	component mux2to1_32bit is
		Port ( s : in  STD_LOGIC;
				  w0 , w1  : in  STD_LOGIC_VECTOR(31 Downto 0);
				  f   : out STD_LOGIC_VECTOR(31 Downto 0));
	end mux2to1_32bit;
	
begin 

	instr: thirtytwobitregister
		PORT MAP(
			A => instructionIN,
			gEn => '1',
			gClk => iClock,
			gRst => iReset,
			output => instrMEM,
			output_not => instrMEM_not
		);

	
	pcVal : eightbitregister
		PORT MAP(
			i_Value => pcp4_IN,
			i_resetBar => iReset,
			i_clock => iClock,
			i_load => '1',
			o_Value => pcp4_OUT
		);
	
	
	chooseInstruction : mux2to1_32bit
		PORT MAP(
			s => eFLUSH,
			w0 => instrMEM,
			w1 => "00000000000000000000000000000000"
			f => instructionOUT
		);
end rtl;