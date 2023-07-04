library ieee;
use ieee.std_logic_1164.all; 

entity scproc is 
	PORT(
	gClck, gRset, clk_2, clk_8: in STD_LOGIC;
	valueSelect : IN STD_LOGIC_VECTOR(2 downto 0);
	MuxOUT,  brAddress, jAddress : OUT STD_LOGIC_VECTOR(7 downto 0);
	instruction_OUT : OUT STD_LOGIC_VECTOR(31 downto 0);
	-- wrAddress : OUT STD_LOGIC_VECTOR(4 downto 0); -- , memOUT, rdA, rdB,
	zeroOut, MemWriteOUT, RegWriteOUT, branchOUT, jOUT : OUT STD_LOGIC
	);
end entity scproc;


architecture rtl of scproc is

	SIGNAL sigAluOP : STD_LOGIC_VECTOR(2 downto 0);
	sigNAL aluFunction : STD_LOGIC_VECTOR(2 downto 0);
	signal chosenWRaddr  : STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL bufALUOut, bufBranchAddress, bufChosenBranchorPCP4, bufChosenPC, bufCurrentPC, bufDataSelect, bufJumpADDRESS, bufSignExtend, bufWriteData, bufOTHERS, readA, readB, nextPC, aluB : STD_LOGIC_VECTOR(7 downto 0);
	SigNAL cInstruction : STD_LOGIC_VECTOR(31 downto 0);
	signal sigAluSRC, sigBNE, sigBranch, sigChooseAddress, sigJump, sigMem2Reg, sigMemRead, sigMemWrite, sigRegDest, sigRegWrite, zeroFlag, carryoutBranch, oflowBranch, sigSkip : STD_LOGIC;

	component addsub8bit 
		port( OP: in std_logic;
				 A,B  : in std_logic_vector(7 downto 0);
				 R  : out std_logic_vector(7 downto 0);
				 Cout, OVERFLOW : out std_logic);
	end component addsub8bit;

	component fileRegister 
		PORT(
			gClock, gReset, regWrite : IN STD_LOGIC;
			addRR1, addRR2 : IN STD_logic_vector(4 downto 0);
			writeData  : IN STD_logic_vector(7 downto 0);
			writeRegister : IN STD_logic_vector(4 downto 0);
			readReg1: OUT STD_logic_vector(7 downto 0);
			readReg2 : OUT STD_logic_vector(7 downto 0)
		);
	end component fileRegister;
	
	component pc_plus4 
		PORT(
			pcin : IN STD_LOGIC_VECTOR(7 downto 0);
			gClock, clk8, gReset, skip : IN STD_LOGIC;
			pcp4, pcCurrent : OUT STD_LOGIC_VECTOR(7 downto 0);
			instructionOUT : OUT STD_LOGIC_VECTOR( 31 downto 0)
		);
	end component pc_plus4;
	
	component alu8bit 
		PORT(
			rA,rB : IN STD_LOGIC_VECTOR(7 downto 0);
			aluOP: IN STD_LOGIC_VECTOR(2 downto 0);
			alurOUT : OUT STD_LOGIC_VECTOR(7 downto 0);
			zeroes : OUT STD_logic
		);
	end component alu8bit;
	
	component mux2to18bit 
		 Port ( s : in  STD_LOGIC;
				  w0 , w1  : in  STD_LOGIC_VECTOR(7 Downto 0);
				  f   : out STD_LOGIC_VECTOR(7 Downto 0));
	end component mux2to18bit;
	
	component mux2to1_5bit 
		 Port ( s : in  STD_LOGIC;
				  w0 , w1  : in  STD_LOGIC_VECTOR(4 Downto 0);
				  f   : out STD_LOGIC_VECTOR(4 Downto 0));
	end component mux2to1_5bit;
	
	component mux4to1_8bit 
		 Port ( sel : in  STD_LOGIC_VECTOR(1 downto 0);
				  w0 , w1, w2, w3  : in  STD_LOGIC_VECTOR(7 Downto 0);
				  f   : out STD_LOGIC_VECTOR(7 Downto 0));
	end component mux4to1_8bit;
	
	component mux6to1_8bit
		Port ( sel : in  STD_LOGIC_VECTOR(2 downto 0);
           w0 , w1, w2, w3, w4, w5  : in  STD_LOGIC_VECTOR(7 Downto 0);
           f   : out STD_LOGIC_VECTOR(7 Downto 0));
	end component mux6to1_8bit;
	
	component shift_left2_addpc 
		PORT(
			toShift : IN STD_logic_VECTOR(3 downto 0);
			pc_val : IN STD_logic_VECTOR(7 downto 0);
			shifted : OUT StD_logic_VECTOR(7 downto 0)
		);
	end component shift_left2_addpc;
	
	component controlUnit 
		PORT (
			instructionCode : IN STD_LOGIC_VECTOR(5 downto 0);
			RegWrite, Jump, Branch, MemRead, MemToReg, MemWrite, ALUSrc, BNE, RegDst: OUT STD_LOGIC;
			ALUop : OUT STD_LOGIC_VECTOR(2 downto 0)
		);
	end component;
	
	COMPONENT dataMem
		PORT
		(
			clk		:	 IN STD_LOGIC;
			clk2		 :  IN STD_LOGIC;
			writeData		:	 IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			address		:	 IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			mWrite		:	 IN STD_LOGIC;
			valu		:	 OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	

begin 

	sigSkip <= sigJump OR sigBranch;

	pc4 : pc_plus4
		PORT MAP(
			pcin => bufChosenPC,
			gClock => gClck,
			clk8 => clk_8,
			skip => sigSkip,
			gReset => gRset ,
			pcCurrent => bufCurrentPC,
			pcp4 => nextPC,
			instructionOUT => cInstruction
		);
	
	jumpADDr : shift_left2_addpc
		PORT MAP(
			toShift => cInstruction(3 downto 0),
			pc_val => nextPC, 
			shifted=> bufJumpADDRESS
		);
	
	chooseWriteRegister : mux2to1_5bit
		PORT MAP(
			s => sigRegDest,
			w0 => cInstruction(20 downto 16),
			w1 => cInstruction(15 downto 11),
			f => chosenWRaddr
		);
		
	fReg : fileRegister
		PORT MAP(
			gClock => clk_8,
			gReset => gRset,
			regWrite => sigRegWrite,
			addRR1 => cInstruction(25 downto 21),
			addRR2 => cInstruction(20 downto 16),
			writeData => bufWriteData,
			writeRegister => chosenWRaddr,
			readReg1 => readA,
			readReg2 => readB
		);
	
	cU: controlUnit
		PORT MAP(
			instructionCode => cInstruction(31 downto 26),
			RegWrite => sigRegWrite,
			Jump => sigJump,
			Branch => sigBranch,
			MemRead => sigMemRead,
			MemToReg => sigMem2Reg,
			MemWrite => sigMemWrite,
			ALUSrc => sigAluSRC,
			RegDst => sigRegDest,
			BNE => sigBNE,
			ALUop => sigAluOP
		);
	
	
	bufSignExtend <= cInstruction(7 downto 0);
		
	chooseB : mux2to18bit
		PORT MAP(
			s => sigAluSRC,
			w0 => readB,
			w1 => bufSignExtend,
			f => aluB
		);
	
	a_alu_b : alu8bit
		PORT MAP(
			rA => readA,
			rB => aluB,
			aluOP => sigAluOP,
			alurOUT => bufALUOut,
			zeroes => zeroFlag
		);
		
	dM : dataMem
		PORT MAP(
			clk => clk_2,
			clk2 => clk_8,
			writeData => readB,
			address => bufALUOut,
			mWrite => sigMemWrite,
			valu => bufDataSelect
		);
		
	chooseEndValu : mux2to18bit
		PORT MAP(
			s => sigMem2Reg,
			w0 => bufALUOut,
			w1 => bufDataSelect,
			f => bufWriteData
		);
		
	
	addpcp4 : addsub8bit
		PORT MAP(
			OP => '0',
			A => nextPC,
			B => bufSignExtend,
			R => bufBranchAddress,
			Cout => carryoutBranch,
			OVERFLOW => oflowBranch
		);
	
	sigChooseAddress <= (sigBranch AND zeroFlag) OR (sigBNE AND NOT zeroFlag);
	 
	chooseAddress : mux2to18bit
		PORT MAP(
			s => sigChooseAddress,
			w0 => nextPC,
			w1 => bufBranchAddress,
			f => bufChosenBranchorPCP4
		);
		
	chooseJBrPCP4 : mux2to18bit
		PORT MAP(
			s => sigJump,
			w0 => bufChosenBranchorPCP4,
			w1 => bufJumpADDRESS,
			f => bufChosenPC
		);
		
	bufOTHERS <= sigRegDest & sigJump & sigMemRead &  sigMem2Reg & sigAluOP & sigAluSRC;
	
	chooseResult : mux6to1_8bit
		PORT MAP(
			sel => valueSelect,
			w0 => bufCurrentPC,
			w1 => bufALUOut,
			w2 => readA,
			w3 => readB,
			w4 => bufWriteData,
			w5 => bufOTHERS,
			f => muxOUT
		);
	
	instruction_OUT <= cInstruction;
	branchOUT <= sigBranch;
	zeroOut <= zeroFlag;
	memWriteOUT <= sigMemWrite;
	RegWriteOUT <= sigRegWrite;
	--memOUT <= bufDataSelect;
	--wrAddress <= chosenWRaddr;
	--rdA <= readA;
	--rdB <= readB;
	brAddress <= bufBranchAddress;
	jAddress <= bufJumpADDRESS;
	jOuT <= sigJump;
end rtl;
