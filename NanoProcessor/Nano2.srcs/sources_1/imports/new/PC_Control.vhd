library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_Control is
    Port ( 
        JMP_Flag    : in  STD_LOGIC;                     
        JMP_Address : in  STD_LOGIC_VECTOR (2 downto 0);  
        Clk         : in  STD_LOGIC;                      
        Reset       : in  STD_LOGIC;                      
        PC_Out      : out STD_LOGIC_VECTOR (2 downto 0)   
    );
end PC_Control;

architecture Behavioral of PC_Control is

    component ProgramCounter is
        Port ( 
            D      : in  STD_LOGIC_VECTOR (2 downto 0);
            Res    : in  STD_LOGIC;
            Clk    : in  STD_LOGIC;
            Q      : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;
    
    component PC_Incrementer is
        Port ( 
            PC_in  : in  STD_LOGIC_VECTOR (2 downto 0);
            PC_out : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;
    
    
    signal current_PC, next_PC, PC_plus_1 : STD_LOGIC_VECTOR (2 downto 0);
    
begin
    
    PC_Reg: ProgramCounter port map(
        D => next_PC,
        Res => Reset,
        Clk => Clk,
        Q => current_PC
    );
    
   
    PC_Inc: PC_Incrementer port map(
        PC_in => current_PC,
        PC_out => PC_plus_1
    );
    
    -- Next Address Multiplexer
    -- This is a 2-way 3-bit multiplexer for selecting between PC+1 and jump address
    next_PC <= JMP_Address when JMP_Flag = '1' else PC_plus_1;
    
   
    PC_Out <= current_PC;
    
end Behavioral;