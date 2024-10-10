library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Instruction_ROM is
    Port (
        address : in  STD_LOGIC_VECTOR(31 downto 0);
        data_out : out  STD_LOGIC_VECTOR(31 downto 0)
    );
end Instruction_ROM;

architecture Behavioral of Instruction_ROM is
    type instruction_array is array (0 to 127) of STD_LOGIC_VECTOR(31 downto 0); -- Define your instruction memory here
    constant instructions : instruction_array := (
        -- Define your instructions here
        -- Example:
        (others => '0'), -- Instruction 0
        (others => '1')  -- Instruction 1
        -- Add more instructions as needed
    );
begin
    process(address)
    begin
        data_out <= instructions(to_integer(unsigned(address)));
    end process;
end Behavioral;

