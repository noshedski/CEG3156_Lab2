library ieee;
use ieee.std_logic_1164.all; 

entity pbuf_ID_EX is
	PORT(
		WB_IN, Mem_IN : IN STD_LOGIC_VECTOR(1 downto 0);
		EX_IN, instr20_16_IN, instr15_11_IN : IN STD_LOGIC_VECTOR(4 downto 0);
		readData1_IN, readData2_IN, offset_IN, pcp4_IN: IN STD_LOGIC_VECTOR(7 downto 0);
		iClock, iReset: IN STD_LOGIC;
		WB_OUT, Mem_OUT : OUT STD_LOGIC_VECTOR(1 downto 0);
		EX_OUT, pcp4_OUT, instr20_16_OUT, instr15_11_OUT : OUT STD_LOGIC_VECTOR(4 downto 0);
		readData1_OUT, readData2_OUT, offset_OUT: OUT STD_LOGIC_VECTOR(7 downto 0)
	);
end entity pbuf_ID_EX;


architecture rtl of pbuf_ID_EX is



	component eightbitregister 
		PORT(
			i_resetBar, i_load	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
			o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0));
	end component;
	
	component fivebitregister
		PORT(
			i_resetBar, i_load	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_Value			: IN	STD_LOGIC_VECTOR(4 downto 0);
			o_Value			: OUT	STD_LOGIC_VECTOR(4 downto 0));
	end component;
	
	component twobitregister
		PORT(
			i_resetBar, i_load	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_Value			: IN	STD_LOGIC_VECTOR(1 downto 0);
			o_Value			: OUT	STD_LOGIC_VECTOR(1 downto 0));
	end component;
	
begin 


	writeback : twobitregister
		PORT MAP(
			i_resetBar => iReset,
			i_load => '1',
			i_clock => iClock,
			i_value => WB_IN,
			o_Value => WB_OUT,
		);
		
	memorySignals : twobitregister
		PORT MAP(
			i_resetBar => iReset,
			i_load => '1',
			i_clock => iClock,
			i_value => Mem_IN,
			o_Value => Mem_OUT,
		);
		
	executeSignals : fivebitregister
		PORT MAP(
			i_resetBar => iReset,
			i_load => '1',
			i_clock => iClock,
			i_value => EX_IN,
			o_Value => EX_OUT,
		);
		
	pcp4_buf : eightbitregister
		PORT MAP(
			i_resetBar => iReset,
			i_load => '1',
			i_clock => iClock,
			i_value => pcp4_IN,
			o_Value => pcp4_OUT,
		);
		

	fr1 : fivebitregister
		PORT MAP(
			i_resetBar => iReset,
			i_load => '1',
			i_clock => iClock,
			i_value => instr20_16_IN,
			o_Value => instr20_16_OUT,
		);
		
	fr2 : fivebitregister
		PORT MAP(
				i_resetBar => iReset,
				i_load => '1',
				i_clock => iClock,
				i_value => instr15_11_IN
				o_Value => instr15_11_OUT,
			);
	
	rdd1: eightbitregister
		PORT MAP(
			i_resetBar => iReset,
			i_load => '1',
			i_clock => iClock,
			i_value => readData1_IN,
			o_Value => readData1_OUT,
		);
		
	rdd2: eightbitregister
		PORT MAP(
			i_resetBar => iReset,
			i_load => '1',
			i_clock => iClock,
			i_value => readData2_IN,
			o_Value => readData2_OUT,
		);	
		
end rtl;