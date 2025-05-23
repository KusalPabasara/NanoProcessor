library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ROM is
    Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
           data : out STD_LOGIC_VECTOR (13 downto 0));
end ROM;

architecture Behavioral of ROM is
type rom_type is array (0 to 7) of std_logic_vector(13 downto 0);
 
-- NOTE: You can uncomment the instruction sets one at a time, generate bit stream and test on BASYS3 board.
  
--  1 + 2 + 3  Page 4 Step 4

--signal PROGRAM_ROM : rom_type := (
--    "00101110000001", --0     MOVI R7,1 
--    "00101100000010", --1     MOVI R6,2
--    "00101010000011", --2     MOVI R5,3
--   "00001111100000", --3     ADD R7 <- R7 + R6 
--    "00001111010000", --4     ADD R7 <- R7 + R5
--    "00110000000000", --5     JZR R0,0
--    "00000000000000", --6
--    "00000000000000"  --7     
--);

-- Page 3 bottom . I have replaced 10 with -6. since 10 cannot be represented using only 4 bits in 2s complement form.
-- example for the functionality of Overflow

--  signal PROGRAM_ROM : rom_type := (
-- "00100010001010", -- 0  MOV R1, -6
-- "00100100000001", -- 1  MOV R2, 1
-- "00010100000000", -- 2  NEG R2 
-- "00000010100000", -- 3  ADD R1, R2  
-- "00001110010000", -- 4  ADD R7, R1
-- "00110010000111", -- 5  JZR R1,7 jump to 7th line if value(R1)=0000  
-- "00110000000011", -- 6  JZR R0,3 jump to 3rd line if value(R0)=0000 
-- "00100010000010" -- 7  
   
-- );

-- example for logical operations
--signal PROGRAM_ROM : rom_type := (
--    "00101110000001", --0     MOVI R7,1 
--    "00101100000010", --1     MOVI R6,2
--    "00101010100011", --2     MOVI R5,3
--    "01001101010111", --3     AND R6,R5,R7  
--    "01011101010111", --4     OR R6,R5,R7
--    "01101101010111", --5     XOR R6,R5,R7
--    "01111110000111", --6     NOT R7,R7   
--    "00110000000000" --7     JZR R0,0
--);

--- example for left shift operations
--signal PROGRAM_ROM : rom_type := (
--    "00101110000001", --0     MOVI R7,1 
--    "00101100000010", --1     MOVI R6,2
--    "00101010100011", --2     MOVI R5,3
--    "10001111100000", --3     SHL R7,R6,0  
--    "10001111100001", --4     SHL R7,R6,1 
--    "10001111100010", --5     SHL R7,R6,2 
--    "10001111100011", --6     SHL R7,R6,3     
--    "00110000000000"  --7     JZR R0,0  
--);

-- example for right shift operations
--signal PROGRAM_ROM : rom_type := (
--    "00101110000001", --0     MOVI R7,1 
--    "00101100000010", --1     MOVI R6,2
--    "00101010100011", --2     MOVI R5,3
--    "10011111100000", --3     SHR R7,R6,0  
--    "10011111100001", --4     SHR R7,R6,1 
--    "10011111100010", --5     SHR R7,R6,2 
--    "10011111100011", --6     SHR R7,R6,3     
--    "00110000000000"  --7     JZR R0,0     
--);

---- example for left rotation
--signal PROGRAM_ROM : rom_type := (
--    "00101110000001", --0     MOVI R7,1 
--    "00101100000010", --1     MOVI R6,2
--    "00101010100011", --2     MOVI R5,3
--    "10101111100000", --3     ROL R7,R6,0  
--    "10101111100001", --4     ROL R7,R6,1 
--    "10101111100010", --5     ROL R7,R6,2 
--    "10101111100011", --6     ROL R7,R6,3     
--    "00110000000000"  --7     JZR R0,0    
--);

-- example for right rotation
signal PROGRAM_ROM : rom_type := (
    "00101110000001", --0     MOVI R7,1 
    "00101100000010", --1     MOVI R6,2
    "00101010100011", --2     MOVI R5,3
    "10111111100000", --3     ROR R7,R6,0  
    "10111111100001", --4     ROR R7,R6,1 
    "10111111100010", --5     ROR R7,R6,2 
    "10111111100011", --6     ROR R7,R6,3     
    "00110000000000"  --7     JZR R0,0    
);



-- signal PROGRAM_ROM : rom_type := (
-- "00101110000001", -- 0  MOV RRR=111 dddd=1
-- "00101110000010", -- 1  MOV RRR=111 dddd=2
-- "00101110000011", -- 2  MOV RRR=111 dddd=3
-- "00101110000100", -- 3  MOV RRR=111 dddd=4
-- "00101110000101", -- 4  MOV RRR=111 dddd=5
-- "00101110000110", -- 5  MOV RRR=111 dddd=6
-- "00101110000111", -- 6  MOV RRR=111 dddd=7
-- "00101110001000"  -- 7  MOV RRR=111 dddd=8
  
-- );
 



begin
data <= PROGRAM_ROM(to_integer(unsigned(address)));


end Behavioral;
