----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2025 02:52:08 AM
-- Design Name: 
-- Module Name: D_FF - Behavioral
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

entity D_FF is
    Port (
        D   : in  STD_LOGIC;
        Clk : in  STD_LOGIC;
        Res : in  STD_LOGIC;
        Q   : out STD_LOGIC
    );
end D_FF;

architecture Behavioral of D_FF is
    signal state : STD_LOGIC := '0';
begin
    process(Clk)
    begin
        if rising_edge(Clk) then
            if Res = '1' then
                state <= '0';
            else
                state <= D;
            end if;
        end if;
    end process;

    Q <= state;
end Behavioral;


