library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom256_16b is
    port (
        clk  : in  std_logic;
        addr : in  std_logic_vector(7 downto 0);
        data : out std_logic_vector(15 downto 0)
    );
end entity rom256_16b;

architecture logica of rom256_16b is

    type rom_array is array (0 to 255) of std_logic_vector(15 downto 0);

    constant ROM_CONTENT : rom_array := (
        -- Endereço | Assembly      | Binário (Linguagem de Máquina)
        0          => B"0001000000000000", -- LDR R0, Mem[0] ; R0 = M
        1          => B"0001000100000001", -- LDR R1, Mem[1] ; R1 = N
        2          => B"0001001000000110", -- LDR R2, Mem[6] ; R2 = 0 (resultado)
        3          => B"0001001100000110", -- LDR R3, Mem[6] ; R3 = 0 (contador i)
        4          => B"0001010000000100", -- LDR R4, Mem[4] ; R4 = 1 (constante)
        
        5          => B"1010010100110001", -- loop: CMP R5, R3, R1
        6          => B"1111000000001011", -- JZ fim (salta para endereço 11 se Z=1)
        7          => B"0100001000100000", -- ADD R2, R2, R0 ; resultado += M
        8          => B"0100001100110100", -- ADD R3, R3, R4 ; contador i++
        9          => B"1011000000000101", -- JMP loop (salta para endereço 5)

        10         => B"0010001000000010", -- fim: STR R2, Mem[2] ; Salva resultado
        11         => B"0000000000000000", -- HLT

        others     => B"0000000000000000"
    );

begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= ROM_CONTENT(to_integer(unsigned(addr)));
        end if;
    end process;
    
end logica;
