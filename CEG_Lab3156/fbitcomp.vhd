LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY fbitcomp IS 
    PORT(
        i_Ai, i_Bi : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        o_LT , o_GT : OUT STD_LOGIC
    );
END ENTITY fbitcomp; 


architecture rtl of fbitcomp is
    SIGNAL gt4,gt3,gt2,gt1,gt0 :  STD_LOGIC;
    SIGNAL lt4,lt3,lt2,lt1,lt0 :  STD_LOGIC;
    
    component oneBitComparator 
        PORT (
            i_GTPrevious, i_LTPrevious	: IN	STD_LOGIC;
            i_Ai, i_Bi			: IN	STD_LOGIC;
            o_GT, o_LT			: OUT	STD_LOGIC
        );
    END COMPONENT oneBitComparator;

    BEGIN 
	 
	 bit4 : oneBitComparator 
        PORT MAP(
            i_GTPrevious => '0',
            i_LTPrevious => '0',
            i_Ai => i_Ai(4),
            i_Bi => i_Bi(4), 
            o_GT => gt4,
            o_LT => lt4
    );
	 
	 bit3 : oneBitComparator 
        PORT MAP(
            i_GTPrevious => gt4,
            i_LTPrevious => lt4,
            i_Ai => i_Ai(3),
            i_Bi => i_Bi(3), 
            o_GT => gt3,
            o_LT => lt3
    );
	 
    bit2 : oneBitComparator 
        PORT MAP(
            i_GTPrevious => gt3,
            i_LTPrevious => lt3,
            i_Ai => i_Ai(2),
            i_Bi => i_Bi(2), 
            o_GT => gt2,
            o_LT => lt2
    );

    bit1 : oneBitComparator 
        PORT MAP(
            i_GTPrevious => gt2,
            i_LTPrevious => lt2,
            i_Ai => i_Ai(1),
            i_Bi => i_Bi(1), 
            o_GT => gt1,
            o_LT => lt1
    );

    bit0 : oneBitComparator 
    PORT MAP(
        i_GTPrevious => gt1,
        i_LTPrevious => lt1,
        i_Ai => i_Ai(0),
        i_Bi => i_Bi(0), 
        o_GT => gt0,
        o_LT => lt0
    );

    o_GT <= gt4 or gt3 or gt2 or gt1 or gt0;
    o_LT <= lt4 or lt3 or lt2 or lt1 or lt0;

end rtl; 