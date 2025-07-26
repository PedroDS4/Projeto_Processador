library ieee;

use ieee.std_logic_1164.all;





entity datapath is

    port (

        clk           : in  std_logic;
        reset        : in  std_logic;        -- Sinais de Controle
        RegWrite      : in  std_logic;
        MemtoReg      : in  std_logic;
        ULA_key       : in  std_logic_vector(2 downto 0);
        addr_A       : in  std_logic_vector(3 downto 0);
        addr_B       : in  std_logic_vector(3 downto 0);
        addr_C       : in  std_logic_vector(3 downto 0);
          load_flags       : in   std_logic;



        -- Saídas de Status para o Controlador
        z_0_out      : out std_logic;
        c_0_out      : out std_logic;

        Mem_data_in    : in std_logic_vector(7 downto 0);
        -- Saída do Datapath para a Memória de Dados
        ULA_out      : out std_logic_vector(7 downto 0);
        Reg_out    : out std_logic_vector(7 downto 0)
    );



end entity datapath;





architecture CKT of datapath is

    component mux_1 is
     port(

	A: in std_logic_vector(7 downto 0); 
	B: in std_logic_vector(7 downto 0);
	Sl: in std_logic;
	Y: out std_logic_vector(7 downto 0)
	);

    end component;



    component ula is

	port(

	A,B: in std_logic_vector(7 downto 0);
	key: in std_logic_vector(2 downto 0); 
	c_0: out std_logic; 
	z_0: out std_logic; 
	S_mux: out std_logic_vector(7 downto 0)
);
    end component;


	component reg_1bit is

	port (ck, load, clr, set: in  std_logic;
	    I : in std_logic;
	    q : out std_logic
);
      end component; 





    component B_reg is
      port (w_data: in std_logic_vector(7 downto 0); 
	addr_r1, addr_r2, addr_w: in std_logic_vector(3 downto 0); 
	en_wr: in std_logic; 
	clk, clr: in std_logic; 
	r_data1, r_data2: out std_logic_vector(7 downto 0)
);
    end component;



    signal reg_read_data1, reg_read_data2 : std_logic_vector(7 downto 0);
    signal alu_result                 : std_logic_vector(7 downto 0);
    signal reg_write_data             : std_logic_vector(7 downto 0);
    signal z_0_internal, c_0_internal : std_logic;



begin

      Write_Back_Mux: mux_1 port map(
        A  => alu_result,
        B  => Mem_data_in,
        Sl  => MemtoReg,
        Y  => reg_write_data
    );

    Reg_File: B_reg port map(
        clk   => clk,
        clr   => reset,
        en_wr  => RegWrite,
        addr_r1 => addr_B,
        addr_r2 => addr_C,
        addr_w => addr_A,
        w_data => reg_write_data,
        r_data1 => reg_read_data1,
        r_data2 => reg_read_data2
    );


    Main_ALU: ula port map(
        A     => reg_read_data1,
        B     => reg_read_data2,
        key   => ULA_key,
        c_0   => c_0_internal,
        z_0   => z_0_internal,
        S_mux => alu_result
    );


      ZERO_FLAG_Reg: reg_1bit port map(
   	ck => clk, 
     load => load_flags, 
   	clr => reset, 
   	set  => '0', 
     I    => z_0_internal, 
   	q    => z_0_out
);



      CARRY_FLAG_Reg: reg_1bit port map(
      ck     => clk, 
     load   => load_flags, 
	clr    => reset, 
      set   => '0', 
     I    => c_0_internal, 
      q    => c_0_out
);



    

    ULA_out <= alu_result;
    Reg_out <= reg_read_data1;

end CKT;
