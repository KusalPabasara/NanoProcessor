----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 03:04:34 AM
-- Design Name: 
-- Module Name: RegBank - Behavioral
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

entity RegBank is
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
end RegBank;

architecture Behavioral of RegBank is

component Reg
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0); -- from MUX_2way_4bit
           En : in STD_LOGIC; -- from 3-8 decoder
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Decoder_3_to_8 is
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal DecoderOut_0 : std_logic_vector(7 downto 0);-- selects/enables the register to assign data

begin

    -- selects/enables the register to assign data
    Decoder_3_to_8_0 : Decoder_3_to_8 port map(
        I => RegEn,
        EN => '1',
        Y => DecoderOut_0
    );
    
    
    -- registers

    R0 <= "0000"; -- R0 is a read only register.
    
    Reg_1 : Reg port map(
        D => RegData,
        EN => DecoderOut_0(1),
        Clk => Clk,
        Q => R1,
        Reset => Reset
    );
    Reg_2 : Reg port map(
        D => RegData,
        EN => DecoderOut_0(2),
        Clk => Clk,
        Q => R2,
        Reset => Reset
    );
    Reg_3 : Reg port map(
        D => RegData,
        EN => DecoderOut_0(3),
        Clk => Clk,
        Q => R3,
        Reset => Reset
    );
    Reg_4 : Reg port map(
        D => RegData,
        EN => DecoderOut_0(4),
        Clk => Clk,
        Q => R4,
        Reset => Reset
    );
    Reg_5 : Reg port map(
        D => RegData,
        EN => DecoderOut_0(5),
        Clk => Clk,
        Q => R5,
        Reset => Reset
    );
    Reg_6 : Reg port map(
        D => RegData,
        EN => DecoderOut_0(6),
        Clk => Clk,
        Q => R6,
        Reset => Reset
    );
    Reg_7 : Reg port map(
        D => RegData,
        EN => DecoderOut_0(7),
        Clk => Clk,
        Q => R7,
        Reset => Reset
    );
   
end Behavioral;

