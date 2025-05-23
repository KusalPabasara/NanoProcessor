library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_Subtractor is
    Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           M  : in STD_LOGIC;-- M=0  for addition   M=1 for subtraction
           S : out STD_LOGIC_VECTOR(3 downto 0);
           C_out : out STD_LOGIC;
           ZeroFlag : out STD_LOGIC;
           Overflow : out STD_LOGIC);
end Adder_Subtractor;

architecture Behavioral of Adder_Subtractor is
  component FA
   port(
     A : in std_logic;
     B : in std_logic;
     C_in : in std_logic;
     S : out std_logic;
     C_out : out std_logic
   );
  end component; 
  
  signal Carry_4, FA0_C, FA1_C, FA2_C, B_0, B_1, B_2, B_3, S_0, S_1, S_2, S_3 : std_logic;

begin
B_0<=B(0) XOR M;
B_1<=B(1) XOR M;
B_2<=B(2) XOR M;
B_3<=B(3) XOR M;
    FA_0: FA
       port map(
        A => A(0),
        B => B_0,
        C_in =>M,
        S => S_0,
        C_out => FA0_C
       );
    
    FA_1: FA
        port map(
         A => A(1),
         B => B_1,
         C_in => FA0_C,
         S => S_1,
         C_out => FA1_C
       );   
     
    FA_2: FA
         port map(
          A => A(2),
          B => B_2,
          C_in => FA1_C,
          S => S_2,
          C_out => FA2_C
         );
    FA_3: FA
         port map(
          A => A(3),
          B => B_3,
          C_in => FA2_C,
          S => S_3,
          C_out => Carry_4
        );
C_out<=Carry_4;
 S(0)<=S_0;
 S(1)<=S_1;
 S(2)<=S_2;
 S(3)<=S_3;
 --ZeroFlag <= (NOT S_0)and(NOT S_1)and(NOT S_2)and(NOT S_3); -- 7 logic gates
 ZeroFlag <= NOT (S_0 OR S_1 OR S_2 OR S_3); --4 logic gates . Used instead of above one to reduce the no. of logic gates. 
 Overflow <= (Carry_4)XOR(FA2_C);
end Behavioral;
