library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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

    -- Define the internal signals
    signal PC : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal IF_ID_Reg : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal ID_EX_Reg : STD_LOGIC_VECTOR(159 downto 0) := (others => '0');
    signal EX_MEM_Reg : STD_LOGIC_VECTOR(108 downto 0) := (others => '0');
    signal MEM_WB_Reg : STD_LOGIC_VECTOR(70 downto 0) := (others => '0');

    -- Define the control signals
    signal control_signals : STD_LOGIC_VECTOR(9 downto 0);

    -- Define branch prediction signals
    signal branch_predict : STD_LOGIC := '0';
    signal branch_taken : STD_LOGIC := '0';
    signal branch_address : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

    -- Define the hazard detection signals
    signal hazard_detected : STD_LOGIC := '0';

    -- Define exception signals
    signal exception_flag : STD_LOGIC;
    signal exception_addr : STD_LOGIC_VECTOR(31 downto 0);
    signal exception_signal : STD_LOGIC;

    -- Internal signal for instruction
    signal instruction_internal : STD_LOGIC_VECTOR(31 downto 0);

    -- Component Declarations
    component Instruction_ROM
        Port (
            address : in  STD_LOGIC_VECTOR(31 downto 0);
            data_out : out  STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component Data_RAM
        Port (
            address : in  STD_LOGIC_VECTOR(31 downto 0);
            data_in : in  STD_LOGIC_VECTOR(31 downto 0);
            data_out : out  STD_LOGIC_VECTOR(31 downto 0);
            mem_write : in  STD_LOGIC;
            mem_read : in  STD_LOGIC
        );
    end component;

    component ControlUnit
        Port (
            opcode : in  STD_LOGIC_VECTOR(6 downto 0);
            control_signals : out  STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;

    component BranchPredictor
        Port (
            clk : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            branch_taken : in  STD_LOGIC;
            branch_predict : out  STD_LOGIC;
            branch_address : out  STD_LOGIC_VECTOR(31 downto 0);
            PC : in  STD_LOGIC_VECTOR(31 downto 0);
            target_address : in  STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component ExceptionHandler
        Port (
            clk : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            exception : out  STD_LOGIC;
            exception_addr : out  STD_LOGIC_VECTOR(31 downto 0);
            PC : in  STD_LOGIC_VECTOR(31 downto 0);
            exception_signal : in  STD_LOGIC
        );
    end component;

begin

    -- Fetch Stage
    Fetch: process(clk, reset)
    begin
        if reset = '1' then
            PC <= (others => '0');
        elsif rising_edge(clk) then
            if debug_step = '1' then
                -- Hold the PC in debug mode
                PC <= PC;
            else
                if branch_predict = '1' then
                    PC <= branch_address;
                else
                    PC <= PC + 4;
                end if;
            end if;
        end if;
    end process Fetch;

    -- Instruction Memory
    InstructionMemory: entity work.Instruction_ROM
        port map (
            address => PC,
            data_out => instruction_internal
        );

    -- Assign internal instruction signal to the output port
    instruction <= instruction_internal;

    -- Control Unit
    Control: entity work.ControlUnit
        port map (
            opcode => instruction_internal(6 downto 0),
            control_signals => control_signals
        );

    -- Branch Predictor
    Predictor: entity work.BranchPredictor
        port map (
            clk => clk,
            reset => reset,
            branch_taken => branch_taken,
            branch_predict => branch_predict,
            branch_address => branch_address,
            PC => PC,
            target_address => ID_EX_Reg(63 downto 32) -- example target address
        );

    -- Exception Handler
    Exception: entity work.ExceptionHandler
        port map (
            clk => clk,
            reset => reset,
            exception => exception_flag,
            exception_addr => exception_addr,
            PC => PC,
            exception_signal => exception_signal
        );

    -- Fetch-Decode Pipeline Register
    process(clk)
    begin
        if rising_edge(clk) then
            IF_ID_Reg <= PC & instruction_internal;
        end if;
    end process;

    -- Decode Stage
    -- Example decode logic (should be expanded)
    Decode: process(clk)
    begin
        if rising_edge(clk) then
            -- Decode the instruction
            -- Read registers, etc.
        end if;
    end process Decode;

    -- Decode-Execute Pipeline Register
    process(clk)
    begin
        if rising_edge(clk) then
            ID_EX_Reg(31 downto 0) <= IF_ID_Reg(31 downto 0); -- Pass PC
            ID_EX_Reg(63 downto 32) <= IF_ID_Reg(63 downto 32); -- Pass instruction
            ID_EX_Reg(73 downto 64) <= control_signals; -- Pass control signals
            -- Add other required signals here
        end if;
    end process;

    -- Execute Stage
    Execute: process(clk)
    begin
        if rising_edge(clk) then
            -- Execute the instruction
            -- ALU operations
            -- Branch calculation
        end if;
    end process Execute;

    -- Execute-Memory Pipeline Register
    process(clk)
    begin
        if rising_edge(clk) then
            EX_MEM_Reg(31 downto 0) <= ID_EX_Reg(31 downto 0); -- ALU result
            EX_MEM_Reg(63 downto 32) <= ID_EX_Reg(63 downto 32); -- Operand or immediate value
            EX_MEM_Reg(73 downto 64) <= ID_EX_Reg(73 downto 64); -- Control signals
            EX_MEM_Reg(103 downto 74) <= ID_EX_Reg(103 downto 74); -- Intermediate values
            EX_MEM_Reg(108 downto 104) <= ID_EX_Reg(108 downto 104); -- Destination register address
        end if;
    end process;

    -- Memory Stage
    Memory: process(clk)
    begin
        if rising_edge(clk) then
            -- Memory read/write operations
        end if;
    end process Memory;

    -- Memory-Write Back Pipeline Register
    process(clk)
    begin
        if rising_edge(clk) then
            MEM_WB_Reg(31 downto 0) <= EX_MEM_Reg(31 downto 0); -- Memory read data or ALU result
            MEM_WB_Reg(63 downto 32) <= EX_MEM_Reg(63 downto 32); -- Address or data
            MEM_WB_Reg(70 downto 64) <= EX_MEM_Reg(70 downto 64); -- Control signals
        end if;
    end process;

    -- Write Back Stage
    WriteBack: process(clk)
    begin
        if rising_edge(clk) then
            -- Write back to the register file
        end if;
    end process WriteBack;

end Behavioral;

