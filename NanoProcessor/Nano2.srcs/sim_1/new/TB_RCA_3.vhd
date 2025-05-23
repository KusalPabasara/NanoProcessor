library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_RCA_3 is
end TB_RCA_3;

architecture Behavioral of TB_RCA_3 is

    component RCA_3
        Port ( 
            A : in STD_LOGIC_VECTOR (2 downto 0);
            B : in STD_LOGIC_VECTOR (2 downto 0);
            C_in : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR (2 downto 0);
            C_out : out STD_LOGIC
        );
    end component;

    signal A, B: STD_LOGIC_VECTOR(2 downto 0);
    signal C_in: STD_LOGIC;
    signal S: STD_LOGIC_VECTOR(2 downto 0);
    signal C_out: STD_LOGIC;

begin

    UUT: RCA_3
    port map(
        A => A,
        B => B,
        C_in => C_in,
        S => S,
        C_out => C_out
    );


process
    begin
        -- Adding 1 + 2 with C_in = 0
        A <= "001"; 
        B <= "010"; 
        C_in <= '0';
        wait for 100 ns;

        -- Adding 4 + 2 with C_in = 1
        A <= "100";
        B <= "010"; 
        C_in <= '1';
        wait for 100 ns;

        -- Adding 0 + 0 with C_in = 0
        A <= "000"; 
        B <= "000"; 
        C_in <= '0';
        wait for 100 ns;

        -- Adding 3 + 4 with C_in = 0
        A <= "011";
        B <= "100";
        C_in <= '0';
        wait for 100 ns;

        -- Adding 2 + 1 with C_in = 1
        A <= "010"; 
        B <= "001"; 
        C_in <= '1';
        wait for 100 ns;

        -- Adding 4 + 1 with C_in = 0
        A <= "100"; 
        B <= "001"; 
        C_in <= '0';
        wait for 100 ns;

        -- Adding 4 + 2 with C_in = 1
        A <= "100"; 
        B <= "010"; 
        C_in <= '1';
        wait for 100 ns;

        wait;
    end process;

end Behavioral;
