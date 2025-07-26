library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparador_8 is
    port (
        A      : in  std_logic_vector(7 downto 0);
        B      : in  std_logic_vector(7 downto 0);
        maior  : out std_logic;
        igual  : out std_logic;
        menor  : out std_logic
    );
end comparador_8;


architecture CKT of comparador_8 is

    component comparador1
        port (
            A      : in  std_logic;
            B      : in  std_logic;
            maior_in  : in  std_logic;
            igual_in  : in  std_logic;
            menor_in  : in  std_logic;
            maior : out std_logic;
            igual : out std_logic;
            menor : out std_logic
        );
    end component;

    -- Sinais para propaga��o
    signal maior_s : std_logic_vector(8 downto 0);
    signal igual_s : std_logic_vector(8 downto 0);
    signal menor_s : std_logic_vector(8 downto 0);

begin

    -- Inicializa os sinais de entrada no MSB
    maior_s(8) <= '0';
    igual_s(8) <= '1';	
    menor_s(8) <= '0';
    
    -- Gera��o das inst�ncias em cascata (bit mais significativo primeiro)
    gen_comparadores : for i in 7 downto 0 generate
        comp : comparador1
            port map (
                A         => A(i),
                B         => B(i),
                maior_in  => maior_s(i+1),
                igual_in  => igual_s(i+1),
                menor_in  => menor_s(i+1),
                maior => maior_s(i),
                igual => igual_s(i),
                menor => menor_s(i)
            );
    end generate;

    -- Sa�da final
    maior <= maior_s(0);
    igual <= igual_s(0);
    menor <= menor_s(0);

end CKT;
