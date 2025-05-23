----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 03:05:30 AM
-- Design Name: 
-- Module Name: TB_RegBank - Behavioral
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

entity TB_RegBank is
--  Port ( );
end TB_RegBank;

architecture Behavioral of TB_RegBank is
component RegBank
    Port ( RegData : in STD_LOGIC_VECTOR (3 downto 0);--from MUX_2way_4bit
           RegEn : in STD_LOGIC_VECTOR (2 downto 0); -- from instruction decoder
           Clk : in STD_LOGIC; 
           Reset : in STD_LOGIC; -- resets all the registers at the same time (additional feature)
           R0 : out STD_LOGIC_VECTOR (3 downto 0);
           R1 : out STD_LOGIC_VECTOR (3 downto 0);
           R2 : out STD_LOGIC_VECTOR (3 downto 0);
           R3 : out STD_LOGIC_VECTOR (3 downto 0);
           R4 : out STD_LOGIC_VECTOR (3 downto 0);
           R5 : out STD_LOGIC_VECTOR (3 downto 0);
           R6 : out STD_LOGIC_VECTOR (3 downto 0);
           R7 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal RegData: STD_LOGIC_VECTOR (3 downto 0);
signal RegEn: STD_LOGIC_VECTOR (2 downto 0);
signal Clk: STD_LOGIC:='1';
signal Reset: STD_LOGIC:='1'; --when starting the processor all the registors are reset to 0000.(otherwise it's undefined) 
signal R0,R1,R2,R3,R4,R5,R6,R7: STD_LOGIC_VECTOR (3 downto 0);

begin
UUT: RegBank
port map(RegData => RegData,
         RegEn => RegEn,
         Clk => Clk,
         Reset => Reset,
         R0 => R0,
         R1 => R1,
         R2 => R2,
         R3 => R3,
         R4 => R4,
         R5 => R5,
         R6 => R6,
         R7 => R7);

 process
 begin
    wait for 5ns;
    Clk <= not(Clk); 
 end process;

process
begin

            RegData <= "1111";
            RegEn <= "111";
            Reset <= '0';

            
            wait for 100ns;
            RegData <= "1001";
            RegEn <= "110";


            wait for 100ns;
            RegData <= "1011";
            RegEn <= "101";
    
            
            wait for 100ns;
            RegData <= "1001";
            RegEn <= "100";

                        
            wait for 100ns;
            RegData <= "1010";
            RegEn <= "011";

            
            wait for 100ns;
            RegData <= "1001";
            RegEn <= "010";
                                 

            wait for 100ns;
            RegData <= "0011";
            RegEn <= "001";

            
            wait for 100ns;
            RegData <= "1000";
            RegEn <= "000";
          
                                    
            wait for 100ns;
            Reset <= '1';   -- reset all  
            wait;         
end process;
end Behavioral;

