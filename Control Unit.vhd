library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControlUnit is
    Port ( opcode : in  STD_LOGIC_VECTOR(6 downto 0);
           control_signals : out  STD_LOGIC_VECTOR(9 downto 0));
end ControlUnit;

architecture Behavioral of ControlUnit is
begin
    process(opcode)
    begin
        case opcode is
            when "0110011" =>  -- R-type
                control_signals <= "0000000001";
            when "0010011" =>  -- I-type
                control_signals <= "0000000010";
            when "0000011" =>  -- Load
                control_signals <= "0000000100";
            when "0100011" =>  -- Store
                control_signals <= "0000001000";
            when "1100011" =>  -- Branch
                control_signals <= "0000010000";
            when others =>
                control_signals <= (others => '0');
        end case;
    end process;
end Behavioral;
