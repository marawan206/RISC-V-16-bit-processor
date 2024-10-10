library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port (
        opcode : in  STD_LOGIC_VECTOR(6 downto 0);
        control_signals : out  STD_LOGIC_VECTOR(9 downto 0)
    );
end ControlUnit;

architecture Behavioral of ControlUnit is
begin
    process(opcode)
    begin
        -- Initialize all control signals to default values
        control_signals <= (others => '0');
        case opcode is
            when "0000011" => -- Example for load instruction
                control_signals(0) <= '1'; -- Set control signals accordingly
            -- Add cases for other instructions
            when others =>
                control_signals <= (others => '0'); -- Default case
        end case;
    end process;
end Behavioral;

