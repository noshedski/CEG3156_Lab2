library ieee;
use ieee.std_logic_1164.all; 

entity pbuf_EX_MEM is
	PORT(
		WB_IN, Mem_IN : IN STD_LOGIC_VECTOR(1 downto 0);
		bORjadd_IN, aluResult_IN, readData2_IN : IN STD_LOGIC_VECTOR(7 downto 0);
		wRdata_IN  : IN STD_LOGIC_VECTOR(4 downto 0);
		iReset, iClock, zero_IN: IN STD_LOGIC;
		WB_OUT, Mem_OUT : OUT STD_LOGIC_VECTOR(1 downto 0);
		zero_OUT : OUT STD_LOGIC;
		wRdata_OUT  : IN STD_LOGIC_VECTOR(4 downto 0);
		bORjadd_OUT, aluResult_OUT, readData2_OUT : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
end entity pbuf_EX_MEM;

architecture rtl of pbuf_EX_MEM is

	SIGNAL notZout : STD_LOGIC;

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
			o_Value			: OUT	STD_LOGIC_VECTOR(1 downto 0)
	end component; 
	
	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;
	
begin 

	zeroBit: enaRdFF_2
		PORT MAP(
			i_resetBar => iReset,
			i_d => zero_IN,
			i_enable => '1',
			i_clock => iClock,
			o_q => zero_OUT,
			o_qBar => notZout
		);
		
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
		
		

	wrd_buf : fivebitregister
		PORT MAP(
			i_resetBar => iReset,
			i_load => '1',
			i_clock => iClock,
			i_value => wrData_IN,
			o_Value => wrData_Out,
		);
	
	rdd2: eightbitregister
		PORT MAP(
			i_resetBar => iReset,
			i_load => '1',
			i_clock => iClock,
			i_value => readData2_IN,
			o_Value => readData2_OUT,
		);	
		
	alures_buf : eightbitregister
		PORT MAP(
			i_resetBar => iReset,
			i_load => '1',
			i_clock => iClock,
			i_value => aluResult_IN,
			o_Value => aluResult_OUT,
		);	
		
	jORb_buf : eightbitregister
		PORT MAP(
			i_resetBar => iReset,
			i_load => '1',
			i_clock => iClock,
			i_value => borjadd_IN,
			o_Value => borjadd_OUT,
		);	
	
end rtl;