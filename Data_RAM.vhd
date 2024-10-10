library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Data_RAM is
    Port (
        address : in  STD_LOGIC_VECTOR(31 downto 0);
        data_in : in  STD_LOGIC_VECTOR(31 downto 0);
        data_out : out  STD_LOGIC_VECTOR(31 downto 0);
        mem_write : in  STD_LOGIC;
        mem_read : in  STD_LOGIC
    );
end Data_RAM;

architecture Behavioral of Data_RAM is
    type ram_array is array (natural range <>) of STD_LOGIC_VECTOR(31 downto 0);
    signal ram : ram_array := (others => (others => '0')); -- Initialize RAM with zeros

    -- Custom function to convert binary vector to integer
    function conv_integer(input_vector : STD_LOGIC_VECTOR) return natural is
        variable result : natural := 0;
    begin
        for i in input_vector'range loop
            result := result * 2 + (if input_vector(i) = '1' then 1 else 0);
        end loop;
        return result;
    end conv_integer;
begin
    process(address, data_in, mem_write, mem_read)
        variable addr_int : natural;
    begin
        addr_int := conv_integer(address); -- Convert address to integer

        if mem_write = '1' then
            ram(addr_int) <= data_in; -- Write data to RAM
        elsif mem_read = '1' then
            data_out <= ram(addr_int); -- Read data from RAM
        end if;
    end process;
end Behavioral;

