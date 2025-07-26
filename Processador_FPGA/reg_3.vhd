library ieee;
use ieee.std_logic_1164.all;

entity reg_3 is
   port (ck, load, clr, set: in  std_logic;
   I : in std_logic_vector(15 downto 0);
   q : out std_logic_vector(15 downto 0) 
);
end reg_3;


architecture logica of reg_3 is

  component mux_2x16
     port(
        A  : in std_logic_vector(15 downto 0);
        B  : in std_logic_vector(15 downto 0);
        Sl : in std_logic;
        Y  : out std_logic_vector(15 downto 0)
    );
  end component;

  component ffd3
      port (ck, clr, set: in  std_logic;
   	d : in std_logic_vector(15 downto 0);
   	q : out std_logic_vector(15 downto 0)
	);
   
  end component;

  
  signal q_reg, S_mux: std_logic_vector(15 downto 0);	-- Saida do mux


		
begin
	
   S0_MUX: mux_2x16 port map(
	A  => q_reg,		
        B  => I,
        Sl => load,
        Y  => S_mux
	);

   FF_D: ffd3 port map( 
	ck => ck,
        clr => clr,
        set => set,
        d => S_mux,
        q => q_reg
	);
  
    q <= q_reg; 
   
end logica;