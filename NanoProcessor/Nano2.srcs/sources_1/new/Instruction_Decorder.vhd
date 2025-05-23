library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_Decoder is
    Port ( Instruction_bus : in STD_LOGIC_VECTOR (13 downto 0); -- 14bit bus
           RegCheckForJMP : in STD_LOGIC_VECTOR (3 downto 0); 
           LoadSelect : out STD_LOGIC:= '0';
           RegEnable : out STD_LOGIC_VECTOR (2 downto 0):= "000"; -- to 3-8 Decoder
           ImmediateValue : out STD_LOGIC_VECTOR (3 downto 0):= "0000";
           RegSel1 : out STD_LOGIC_VECTOR (2 downto 0);
           RegSel2 : out STD_LOGIC_VECTOR (2 downto 0);
           MUX1_out : in STD_LOGIC_VECTOR (3 downto 0); -- to get the output from MUX1
           MUX2_out : in STD_LOGIC_VECTOR (3 downto 0); -- to get the output from MUX2
           AddSubSel : out STD_LOGIC:= '0';
           JMP_Flag : out STD_LOGIC:= '0';
           AddressToJump : out STD_LOGIC_VECTOR (2 downto 0));
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is


    signal regA, regB, regC : std_logic_vector(2 downto 0);
    signal n : std_logic_vector(1 downto 0);
    signal instruction_type : std_logic_vector(3 downto 0); -- 4bit inst. type
    signal shiftL,shiftR,leftRotation,rightRotation : std_logic_vector(3 downto 0);
begin

    regA <= Instruction_bus(9 downto 7); -- Control signals of MUX to select a register from RegBank
    regB <= Instruction_bus(6 downto 4);
    regC <= Instruction_bus(2 downto 0); -- for logical operations.indicates where to store the result
    n <= Instruction_bus(1 downto 0); -- number of positions to shift/rotate
    instruction_type <= Instruction_bus(13 downto 10);
  
    LoadSelect <= '0' when instruction_type = "0000" else-- ADD
                  '1' when instruction_type = "0010" else-- MOV
                  '1' when instruction_type = "0011" else -- JRZ
                  '1' when instruction_type = "0100" else -- AND
                  '1' when instruction_type = "0101" else -- OR
                  '1' when instruction_type = "0110" else -- XOR
                  '1' when instruction_type = "0111" else -- NOT
                  '1' when instruction_type = "1000" else -- SHL
                  '1' when instruction_type = "1001" else -- SHR
                  '1' when instruction_type = "1010" else -- ROL
                  '1' when instruction_type = "1011" else -- ROR
                  '0'; -- Default value for NEG

    AddSubSel <= '0' when instruction_type = "0000" else
                 '1' when instruction_type = "0001" else
                 '0'; -- Default value for MOV/JRZ
    
    -- where to save data in RegBank
    RegEnable <= regA when instruction_type = "0000" or instruction_type = "0001" or instruction_type = "0010" else --ADD/MOV/NEG
                 regC when instruction_type = "0100" or instruction_type = "0101" or instruction_type = "0110" or instruction_type = "0111" else -- logical operations
                 regA when instruction_type = "1000" or instruction_type = "1001" or instruction_type = "1010" or instruction_type = "1011" else --SHL/SHR/ROL/ROR
                 (others => '0'); -- Default value for JRZ

    RegSel1 <= regA when instruction_type = "0000" else -- ADD
               regB when instruction_type = "0001" else -- NEG
               regA when instruction_type = "0011" else -- select value for RegCheckForJump, to sent back to Instruction decoder via 'Register Check For Jump' line( in JRZ)  
               regA when instruction_type = "0100" else -- AND
               regA when instruction_type = "0101" else -- OR
               regA when instruction_type = "0110" else -- XOR
               regA when instruction_type = "0111" else -- NOT
               regB when instruction_type = "1000" else -- SHL
               regB when instruction_type = "1001" else -- SHR
               regB when instruction_type = "1010" else -- ROL
               regB when instruction_type = "1011" else -- ROR
               (others => '0'); -- Default value for MOV;

    RegSel2 <= regB when instruction_type = "0000" else -- ADD
               regA when instruction_type = "0001" else -- NEG
               regB when instruction_type = "0100" else -- AND
               regB when instruction_type = "0101" else -- OR
               regB when instruction_type = "0110" else -- XOR
               (others => '0'); -- Default value for MOV/JRZ/NOT/SHL/SHR/ROL/ROR

    ImmediateValue <= Instruction_bus(3 downto 0) when instruction_type = "0010" else --MOVE
                      (MUX1_out and MUX2_out) when instruction_type = "0100" else --ADD 
                      (MUX1_out or MUX2_out) when instruction_type = "0101" else --OR
                      (MUX1_out xor MUX2_out) when instruction_type = "0110" else --XOR 
                      (not MUX1_out) when instruction_type = "0111" else --NOT
                      shiftL when instruction_type = "1000" else --SHL
                      shiftR when instruction_type = "1001" else --SHR  
                      leftRotation when instruction_type = "1010" else --ROL  
                      rightRotation when instruction_type = "1011" else --ROR
                      (others => '0'); -- Default value for ADD/SUB/JRZ

     -- for left shift
     shiftL <= MUX1_out when n = "00" else
               MUX1_out(2 downto 0) & '0' when n = "01" else
               MUX1_out(1 downto 0) & "00" when n = "10" else
               MUX1_out(0)& "000"  when n = "11" ; 
               --(others => '0'); 
     
     -- for right shift
     shiftR <= MUX1_out when n = "00" else
               '0' & MUX1_out(3 downto 1)  when n = "01" else
               "00" & MUX1_out(3 downto 2) when n = "10" else
               "000" & MUX1_out(3)  when n = "11" else 
               (others => '0');     
     
 -- For left rotation (ROL)
             leftRotation<= MUX1_out when n = "00" else               -- no rotation
                  MUX1_out(0) & MUX1_out(3 downto 1) when n = "01" else -- rotate leftt by 1
                  MUX1_out(1 downto 0) & MUX1_out(3 downto 2) when n = "10" else -- rotate leftt by 2
                  MUX1_out(2 downto 0) & MUX1_out(3) when n = "11" else -- rotate leftt by 3 (same as right by 1)
                  (others => '0');

               -- For right rotation (ROR)
              rightRotation<= MUX1_out when n = "00" else                -- no rotation
                               MUX1_out(2 downto 0) & MUX1_out(3) when n = "01" else  -- rotate right by 1
                               MUX1_out(1 downto 0) & MUX1_out(3 downto 2) when n = "10" else -- rotate right by 2
                               MUX1_out(0) & MUX1_out(3 downto 1) when n = "11" else -- rotate right by 3 (same as left by 1)
                               (others => '0');

    JMP_Flag <= '1' when instruction_type = "0011" and RegCheckForJMP = "0000" else
                '0'; -- Default value

    AddressToJump <= Instruction_bus(2 downto 0) when instruction_type = "0011" and RegCheckForJMP = "0000" else
                     (others => '0'); -- Default value

end Behavioral;



