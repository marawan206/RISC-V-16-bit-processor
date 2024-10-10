library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BranchPredictor is
    Port (
        clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        branch_taken : in  STD_LOGIC;
        branch_predict : out  STD_LOGIC;
        branch_address : out  STD_LOGIC_VECTOR(31 downto 0);
        PC : in  STD_LOGIC_VECTOR(31 downto 0);
        target_address : in  STD_LOGIC_VECTOR(31 downto 0)
    );
end BranchPredictor;

architecture Behavioral of BranchPredictor is
    signal prediction_table : array (0 to 127) of STD_LOGIC;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            for i in 0 to 127 loop
                prediction_table(i) <= '0';
            end loop;
            branch_predict <= '0';
            branch_address <= (others => '0');
        elsif rising_edge(clk) then
            if branch_taken = '1' then
                prediction_table(to_integer(unsigned(PC(8 downto 2)))) <= '1';
                branch_predict <= '1';
                branch_address <= target_address;
            else
                branch_predict <= prediction_table(to_integer(unsigned(PC(8 downto 2))));
                if branch_predict = '1' then
                    branch_address <= target_address;
                else
                    branch_address <= PC + 4;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
