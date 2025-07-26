library ieee;
use ieee.std_logic_1164.all;

entity reg_1bit is
   port (ck, load, clr, set: in  std_logic;
   I : in std_logic;
   q : out std_logic
);
end reg_1bit;


architecture logica of reg_1bit is

  component mux_1x1
     port(
        A  : in std_logic;
        B  : in std_logic;
        Sl : in std_logic;
        Y  : out std_logic
    );
  end component;

  component ffd_1bit
      port (ck, clr, set: in  std_logic;
   	d : in std_logic;
   	q : out std_logic
	);
   
  end component;

  
  signal q_reg, S_mux: std_logic;	-- Saida do mux


		
begin
	
   S0_MUX: mux_1x1 port map(
	A  => q_reg,		
        B  => I,
        Sl => load,
        Y  => S_mux
	);

   FF_D: ffd_1bit port map( 
	ck => ck,
        clr => clr,
        set => set,
        d => S_mux,
        q => q_reg
	);
  
    q <= q_reg; 
   
end logica;
