----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 03:07:33 AM
-- Design Name: 
-- Module Name: nanoprocessor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity nanoprocessor is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           R7_OUT : out STD_LOGIC_VECTOR (3 downto 0);--for LEDs
           R7_7Seg : out STD_LOGIC_VECTOR (6 downto 0);
           CarryFlag : out STD_LOGIC; --additional feature
           SignFlag : out STD_LOGIC; --additional feature
           Zero : out STD_LOGIC;
           Overflow : out STD_LOGIC;
           anode: out STD_LOGIC_VECTOR(3 downto 0)
           );
end nanoprocessor;

architecture Behavioral of nanoprocessor is

component RegBank
    Port ( RegData : in STD_LOGIC_VECTOR (3 downto 0);--from MUX_2way_4bit
           RegEn : in STD_LOGIC_VECTOR (2 downto 0); -- from instruction decoder
           Clk : in STD_LOGIC; 
           Reset : in STD_LOGIC; -- resets all the registers at the same time 
           R0 : out STD_LOGIC_VECTOR (3 downto 0);
           R1 : out STD_LOGIC_VECTOR (3 downto 0);
           R2 : out STD_LOGIC_VECTOR (3 downto 0);
           R3 : out STD_LOGIC_VECTOR (3 downto 0);
           R4 : out STD_LOGIC_VECTOR (3 downto 0);
           R5 : out STD_LOGIC_VECTOR (3 downto 0);
           R6 : out STD_LOGIC_VECTOR (3 downto 0);
           R7 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Adder_Subtractor 
    Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           M  : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR(3 downto 0);
           C_out : out STD_LOGIC;
           ZeroFlag : out STD_LOGIC;
           Overflow : out STD_LOGIC);
end component;

component ProgramCounter 
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component RCA_3 is
    Port ( A : in STD_LOGIC_VECTOR(2 downto 0);
           B : in STD_LOGIC_VECTOR(2 downto 0);
           C_in : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR(2 downto 0);
           C_out : out STD_LOGIC);
end component;

component Instruction_Decoder is
    Port ( Instruction_bus : in STD_LOGIC_VECTOR (13 downto 0);
           RegCheckForJMP : in STD_LOGIC_VECTOR (3 downto 0);
           LoadSelect : out STD_LOGIC;
           RegEnable : out STD_LOGIC_VECTOR (2 downto 0); -- to 3-8 Decoder
           ImmediateValue : out STD_LOGIC_VECTOR (3 downto 0);
           RegSel1 : out STD_LOGIC_VECTOR (2 downto 0);
           RegSel2 : out STD_LOGIC_VECTOR (2 downto 0);
           MUX1_out : in STD_LOGIC_VECTOR (3 downto 0); -- to get the output from MUX1
           MUX2_out : in STD_LOGIC_VECTOR (3 downto 0); -- to get the output from MUX2
           AddSubSel : out STD_LOGIC;
           JMP_Flag : out STD_LOGIC;
           AddressToJump : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component MUX_2way_3bit is
    Port ( A0 : in STD_LOGIC_VECTOR (2 downto 0);-- from 3 bit adder
           A1 : in STD_LOGIC_VECTOR (2 downto 0);-- from instruction decoder. indicates the address to jump.
           JMP_FLAG : in STD_LOGIC; -- selection signal
           M2_3_out : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component MUX_2way_4bit is
    Port ( B0 : in STD_LOGIC_VECTOR (3 downto 0);--from  4bit add/sub unit
           B1 : in STD_LOGIC_VECTOR (3 downto 0);-- from instruction decoder. Immedaite value.
           LoadSel : in STD_LOGIC;-- from instruction decoder
           M2_4_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component MUX_8way_4bit is
    Port ( R0 : in STD_LOGIC_VECTOR (3 downto 0);
           R1 : in STD_LOGIC_VECTOR (3 downto 0);
           R2 : in STD_LOGIC_VECTOR (3 downto 0);
           R3 : in STD_LOGIC_VECTOR (3 downto 0);
           R4 : in STD_LOGIC_VECTOR (3 downto 0);
           R5 : in STD_LOGIC_VECTOR (3 downto 0);
           R6 : in STD_LOGIC_VECTOR (3 downto 0);
           R7 : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC_VECTOR (2 downto 0);
           M8_4_out : out STD_LOGIC_VECTOR (3 downto 0));
           
end component;

component ROM is
    Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
           data : out STD_LOGIC_VECTOR (13 downto 0));
end component;

component Slow_Clk is
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end component;

component LUT_16_7 
Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
       data : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal Clock : std_logic;
signal R0,R1,R2,R3,R4,R5,R6,R7 : std_logic_vector(3 downto 0); --from RegBank to MUX_8way_4bit
signal MUX_1,MUX_2 :  std_logic_vector(3 downto 0); --from MUXes to Adder_Subtractor  
signal ADD_SUB_Out : std_logic_vector(3 downto 0); -- from Adder_Subtractor to MUX_2way_4bit
signal ADD_SUB_Cout,ADD_SUB_Overflow, ADD_SUB_Zero : std_logic; 


signal ImmediateValue : std_logic_vector(3 downto 0);-- from Instruction decoder to MUX_2way_4bit
signal ValueToRegBank : std_logic_vector(3 downto 0);-- from  MUX_2way_4bit to RegBank
signal LoadSel : std_logic; -- from Instruction decoder to MUX_2way_4bit


signal InstructionBus : std_logic_vector(13 downto 0);
signal RegSel : std_logic_vector(2 downto 0); -- Instruction decoder to RegBank
signal RegSelMux_1 : std_logic_vector(2 downto 0); --from Instruction decoder to MUX_8way_4bit_0
signal RegSelMux_2 : std_logic_vector(2 downto 0);--from Instruction decoder to MUX_8way_4bit_1
signal AddSubSel : std_logic; -- from Instruction decoder to Adder_Subtractor
signal JumpFlag : std_logic; -- from Instruction decoder to MUX_2way_3bit
signal InsJMPAddress : std_logic_vector(2 downto 0);-- from Instruction decoder to MUX_2way_3bit

signal Res : std_logic:='1'; -- reset is set to 0 initially to ensure all the registers are reset at the begining of the program 

signal PC_Out, nextInsAddress, MUX_2_3bit_Out : std_logic_vector(2 downto 0);

signal slowedClock : std_logic;

begin

RegBank_0 : RegBank
     port map(
        RegData => ValueToRegBank, 
        RegEn => RegSel,
        Clk => slowedClock, 
        Reset => Res, 
        R0 => R0,
        R1 => R1,
        R2 => R2,
        R3 => R3,
        R4 => R4,
        R5 => R5,
        R6 => R6,
        R7 => R7
);

MUX_8way_4bit_0 : MUX_8way_4bit 
    port map(
        R0 => R0,
        R1 => R1,
        R2 => R2,
        R3 => R3,
        R4 => R4,
        R5 => R5,
        R6 => R6,
        R7 => R7,
        Sel => RegSelMux_1, 
        M8_4_out => MUX_1
    );
    
MUX_8way_4bit_1 : MUX_8way_4bit 
        port map(
            R0 => R0,
            R1 => R1,
            R2 => R2,
            R3 => R3,
            R4 => R4,
            R5 => R5,
            R6 => R6,
            R7 => R7,
            Sel => RegSelMux_2, 
            M8_4_out => MUX_2
        );    

Adder_Subtractor_0 : Adder_Subtractor port map
    (
       M => AddSubSel,
       A => MUX_1,
       B => MUX_2,
       S => ADD_SUB_Out,
       C_out => ADD_SUB_Cout,
       Overflow => ADD_SUB_Overflow,
       ZeroFlag => ADD_SUB_Zero 
       --C_out is not included since there's no usage.
    );
 

MUX_2way_4bit_0 : MUX_2way_4bit
 port map(
        B0 => ADD_SUB_Out,
        B1 => ImmediateValue,
        LoadSel => LoadSel,
        M2_4_out => ValueToRegBank
    );    
    
Instruction_Decoder_0 : Instruction_Decoder
 port map
        (
            Instruction_bus => InstructionBus,
            RegCheckForJMP => MUX_1,
            LoadSelect => LoadSel,
            RegEnable => RegSel,
            ImmediateValue => ImmediateValue,
            RegSel1 => RegSelMux_1,
            RegSel2 => RegSelMux_2,
            MUX1_out => MUX_1,
            MUX2_out => MUX_2,
            AddSubSel => AddSubSel,
            JMP_Flag => JumpFlag,
            AddressToJump => InsJMPAddress
        );   
        
ROM_0 : ROM port map(
            address => PC_Out,
            data => InstructionBus
        );        
    
ProgramCounter_0 : ProgramCounter
 port map(
      D => MUX_2_3bit_Out,  
      Res => Res,
      Clk => slowedClock,
      Q => PC_out      
     );    

RCA_3_0 : RCA_3 
port map(
        A => PC_out,
        B => "001",
        C_in => '0',
        S => nextInsAddress
        --C_out is not included since there's no usage
    );     
    
MUX_2way_3bit_0 : MUX_2way_3bit
 port map(
            A0 => nextInsAddress,
            A1 => InsJmpAddress,
            JMP_FLAG => JumpFlag,
            M2_3_out => MUX_2_3bit_Out
        );

Slow_Clk_0 : Slow_Clk port 
    map(
        Clk_in => Clock,
        Clk_out => slowedClock
        );    
        
LUT_16_7_0 :LUT_16_7
 port map 
        (
            address => R7,
            data =>  R7_7Seg
        );             
  
        
Clock <= Clk;
Res <= Reset;
R7_OUT <= R7;
CarryFlag <= ADD_SUB_Cout;
SignFlag <= ADD_SUB_Out(3); -- If SignFlag= 1 and Overflow = 0, the result is negative 
                            -- If SignFlag= 0 and Overflow = 0, the result is positive
                            -- If Overflow = 1, the result is incorrect and an overflow has occured 
Zero <= ADD_SUB_Zero;
Overflow <= ADD_SUB_Overflow;
anode <= "1110"; -- to switch ON only one 7segment display
     
           
end Behavioral;

