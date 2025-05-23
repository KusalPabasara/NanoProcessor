library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProgramCounter is
    Port (
        D   : in  STD_LOGIC_VECTOR (2 downto 0);
        Clk : in  STD_LOGIC;
        Res : in  STD_LOGIC;
        Q   : out STD_LOGIC_VECTOR (2 downto 0)
    );
end ProgramCounter;

architecture Structural of ProgramCounter is

    component D_FF
        Port (
            D   : in  STD_LOGIC;
            Clk : in  STD_LOGIC;
            Res : in  STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component;

    signal q_internal : STD_LOGIC_VECTOR(2 downto 0);

begin

    U0: D_FF port map (D => D(0), Clk => Clk, Res => Res, Q => q_internal(0));
    U1: D_FF port map (D => D(1), Clk => Clk, Res => Res, Q => q_internal(1));
    U2: D_FF port map (D => D(2), Clk => Clk, Res => Res, Q => q_internal(2));

    Q <= q_internal;

end Structural;

