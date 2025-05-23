----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 02:51:49 AM
-- Design Name: 
-- Module Name: TB_Instruction_Decorder - Behavioral
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

entity TB_Instruction_Decorder is
--  Port ( );
end TB_Instruction_Decorder;

architecture Behavioral of TB_Instruction_Decorder is
component Instruction_Decoder is
    Port ( Instruction_bus : in STD_LOGIC_VECTOR (11 downto 0);
           RegCheckForJMP : in STD_LOGIC_VECTOR (3 downto 0);
           LoadSelect : out STD_LOGIC;
           RegEnable : out STD_LOGIC_VECTOR (2 downto 0); -- to 3-8 Decoder
           ImmediateValue : out STD_LOGIC_VECTOR (3 downto 0);
           RegSel1 : out STD_LOGIC_VECTOR (2 downto 0);
           RegSel2 : out STD_LOGIC_VECTOR (2 downto 0);
           AddSubSel : out STD_LOGIC;
           JMP_Flag : out STD_LOGIC;
           AddressToJump : out STD_LOGIC_VECTOR (2 downto 0));
end component;

           signal Instruction_bus : STD_LOGIC_VECTOR (11 downto 0);
           signal RegCheckForJMP : STD_LOGIC_VECTOR (3 downto 0);
           signal LoadSelect : STD_LOGIC;
           signal RegisterEnable : STD_LOGIC_VECTOR (2 downto 0);
           signal ImmediateValue : STD_LOGIC_VECTOR (3 downto 0);
           signal RegisterSelect_1 : STD_LOGIC_VECTOR (2 downto 0);
           signal RegisterSelect_2 : STD_LOGIC_VECTOR (2 downto 0);
           signal Add_Sub_select : STD_LOGIC;
           signal JumpFlag : STD_LOGIC;
           signal AddresstoJump : STD_LOGIC_VECTOR (2 downto 0);
begin
UUT : Instruction_Decoder port map(
           Instruction_bus => Instruction_bus,
           RegCheckForJMP => RegCheckForJMP,
           LoadSelect=> LoadSelect,
           RegEnable => RegisterEnable,
           ImmediateValue=>ImmediateValue,
           RegSel1 => RegisterSelect_1,
           RegSel2 => RegisterSelect_2,
           AddSubSel => Add_Sub_select,
           JMP_Flag => JumpFlag,
           AddresstoJump=>AddresstoJump
);

    process 
    begin
    --RegReset <= "000"; -- sends a signal to RegBank to reset R0 
    
    Instruction_Bus <= "100010001010"; 
    wait for 100 ns;
    Instruction_Bus <= "100100000001";
    wait for 100 ns;
    Instruction_Bus <= "010100000000";
    wait for 100 ns;
    Instruction_Bus <= "000010100000";
    wait for 100 ns;
    
    Instruction_Bus <= "110010000111";
    wait for 100 ns;
    RegCheckForJMP <="0000";
    Instruction_Bus <= "110000000111";
    
    wait for 100ns;
end process;

end Behavioral;

