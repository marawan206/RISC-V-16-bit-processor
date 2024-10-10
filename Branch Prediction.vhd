library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BranchPredictor is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           branch_taken : in  STD_LOGIC;
           branch_predict : out  STD_LOGIC;
           branch_address : out  STD_LOGIC_VECTOR(31 downto 0);
           PC : in  STD_LOGIC_VECTOR(31 downto 0);
           target_address : in  STD_LOGIC_VECTOR(31 downto 0));
end BranchPredictor;

architecture Behavioral of BranchPredictor is
    signal predictor : STD_LOGIC_VECTOR(1 downto 0) := "00"; -- 2-bit counter
begin
    process(clk, reset)
    begin
        if reset = '1' then
            predictor <= "00";
        elsif rising_edge(clk) then
            if branch_taken = '1' then
                if predictor < "11" then
                    predictor <= predictor + 1;
                end if;
            else
                if predictor > "00" then
                    predictor <= predictor - 1;
                end if;
            end if;
        end if;
    end process;

    branch_predict <= '1' when predictor > "01" else '0';
    branch_address <= target_address;
end Behavioral;

