library ieee;
use ieee.std_logic_1164.all; 

entity pc_plus4 is
	PORT(
		pcin : IN STD_LOGIC_VECTOR(7 downto 0);
		gClock, clk8, gReset, skip : IN STD_LOGIC;
		pcp4, pcCurrent : OUT STD_LOGIC_VECTOR(7 downto 0);
	   instructionOUT : OUT STD_LOGIC_VECTOR( 31 downto 0)
	);
end entity pc_plus4;


architecture rtl of pc_plus4 is 

	SIGNAL readyToAdd : STD_LOGIC_VECTOR(2 downto 0);
	SIGNAL coutPC, oflowPC, four : STD_LOGIC;
	SIGNAL pgrc, add4, instructionAddress : STD_LOGIC_VECTOR(7 downto 0);
	
	component addsub8bit 
		port( OP: in std_logic;
          A,B  : in std_logic_vector(7 downto 0);
          R  : out std_logic_vector(7 downto 0);
          Cout, OVERFLOW : out std_logic);
	end component;

	component eightbitregister
		PORT(
			i_resetBar, i_load	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
			o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0));
	end component;

	COMPONENT instructionMem
		PORT
		(
			address		:	 IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			clk		:	 IN STD_LOGIC;
			oClk     :   IN STD_LOGIC;
			valu		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	component mux2to18bit 
		 Port ( s : in  STD_LOGIC;
				  w0 , w1  : in  STD_LOGIC_VECTOR(7 Downto 0);
				  f   : out STD_LOGIC_VECTOR(7 Downto 0));
	end component mux2to18bit;
	
begin

	programCounter : eightbitregister
		PORT MAP(
			i_resetBar => gReset,
			i_load => '1',
			i_clock => gClock,
			i_value => pcin,
			o_Value => pgrc
		);
	
	add4 <= "00000100";
		
	pcAdder : addsub8bit
		PORT MAP(
			OP => '0',
			A => pgrc,
			B => add4,
			R => pcp4,
			cout => coutPC,
			OVERFLOW => oflowPC
		);
		
	chooseJorPC: mux2to18bit
		PORT MAP(
			s => skip,
			w0 => pgrc,
			w1 => pcin,
			f => instructionAddress
		);
		
	instrMEM : instructionMem
		PORT MAP(
			address => instructionAddress,
			clk => gClock,
			oClk => clk8,
			valu => instructionOUT
		);

	pcCurrent <= pgrc;
end rtl;