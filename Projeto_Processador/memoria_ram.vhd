library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram256_8b is
    port (
        clk    : in  std_logic;
        w_en   : in  std_logic;
        addr   : in  std_logic_vector(7 downto 0);
        w_data : in  std_logic_vector(7 downto 0);
        r_data : out std_logic_vector(7 downto 0)
    );
end entity ram256_8b;

architecture ckt of ram256_8b is

    type memoria_ram is array (0 to 255) of std_logic_vector (7 downto 0);

    signal RAM : memoria_ram := (
        0      => B"00000101",  -- Valor M = 5
        1      => B"00000011",  -- Valor N = 3
        4      => B"00000001",  -- Constante 1
        6      => B"00000000",  -- Constante 0
        others => B"00000000"
    );
    
begin

    process (clk)
    begin
        if rising_edge(clk) then
            if w_en = '1' then
                RAM(to_integer(unsigned(addr))) <= w_data;
            end if;
        end if;
    end process;
    
    r_data <= RAM(to_integer(unsigned(addr)));

end ckt;
