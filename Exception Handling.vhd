library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ExceptionHandler is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           exception : out  STD_LOGIC;
           exception_addr : out  STD_LOGIC_VECTOR(31 downto 0);
           PC : in  STD_LOGIC_VECTOR(31 downto 0);
           exception_signal : in  STD_LOGIC);
end ExceptionHandler;

architecture Behavioral of ExceptionHandler is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            exception <= '0';
            exception_addr <= (others => '0');
        elsif rising_edge(clk) then
            if exception_signal = '1' then
                exception <= '1';
                exception_addr <= PC;
            else
                exception <= '0';
            end if;
        end if;
    end process;
end Behavioral;

