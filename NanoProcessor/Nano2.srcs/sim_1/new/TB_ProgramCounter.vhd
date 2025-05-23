----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2025 02:57:08 AM
-- Design Name: 
-- Module Name: TB_ProgramCounter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_ProgramCounter is
--  Port ( );
end TB_ProgramCounter;

architecture Behavioral of TB_ProgramCounter is
COMPONENT ProgramCounter
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
       Res : in STD_LOGIC;
       Clk : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR (2 downto 0));
 END COMPONENT;
 SIGNAL Res: std_logic := '1';
 signal Clk : std_logic := '1';
 SIGNAL D,Q : std_logic_vector (2 downto 0);
 constant time_period : time := 10 ns;
begin
UUT:ProgramCounter PORT MAP(
D => D, 
Res => Res,
Clk => Clk,
Q => Q
 );
 process
 begin
  wait for time_period / 2;
  Clk <= not(Clk); 
 end process;
 
 process
 begin
  
  Res <= '1';
  D<="110";

  wait for 200ns;
  
  Res <= '0';
  D<= "001";
  wait for 100ns; 
  
  Res <= '0';
  D<= "010";
  wait for 100ns;
  
  Res <= '1'; -- Resetting the counter
  WAIT FOR 100ns; -- Wait after reset to observe
      
  Res<='0';
  D <= "000";
  wait for 100ns;
 
  Res <= '0';
  D<= "011";
  wait for 100ns;
 
  Res <= '1'; -- Resetting the counter
  WAIT FOR 100ns; -- Wait after reset to observe    
  
  Res<='0';      
  D <= "100";    
  wait for 100ns; 

 end process;

end Behavioral;
