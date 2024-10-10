library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RISC_V_Processor is
    Port (
        clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        debug_step : in  STD_LOGIC;
        instruction : out  STD_LOGIC_VECTOR(31 downto 0);
        data_out : out  STD_LOGIC_VECTOR(31 downto 0);
        data_in : in  STD_LOGIC_VECTOR(31 downto 0);
        mem_write : out  STD_LOGIC;
        mem_read : out  STD_LOGIC;
        address : out  STD_LOGIC_VECTOR(31 downto 0)
    );
end RISC_V_Processor;

architecture Behavioral of RISC_V_Processor is
begin
    -- Define component instances and signal assignments here
    -- Instantiate Instruction_ROM, ControlUnit, BranchPredictor, ExceptionHandler
    -- Connect ports and signals accordingly
end Behavioral;
