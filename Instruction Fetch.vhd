-- Instruction Fetch Stage
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

-- Fetch instruction from instruction memory
-- Assuming a memory module instantiated here
InstructionMemory: entity work.Instruction_ROM
    port map (
        address => PC,
        data_out => instruction
    );

-- Fetch-Decode Pipeline Register
IF_ID_Reg <= PC & instruction;

