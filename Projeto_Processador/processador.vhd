library ieee;
use ieee.std_logic_1164.all;

entity processador is
    port (
        clk : in  std_logic;
        rst : in  std_logic
    );
end entity processador;

architecture CKT of processador is


    signal s_pc_addr            : std_logic_vector(7 downto 0);
    signal s_instruction        : std_logic_vector(15 downto 0);
    signal s_ula_out            : std_logic_vector(7 downto 0);
    signal s_reg_b_data_out     : std_logic_vector(7 downto 0);
    signal s_mem_read_data      : std_logic_vector(7 downto 0);
    signal s_zero_flag          : std_logic;
    signal s_carry_flag         : std_logic;
    signal s_reg_write          : std_logic;
    signal s_mem_write          : std_logic;
    signal s_mem_to_reg         : std_logic;
    signal s_ula_key            : std_logic_vector(2 downto 0);
    signal s_addr_a             : std_logic_vector(3 downto 0);
    signal s_addr_b             : std_logic_vector(3 downto 0);
    signal s_addr_c             : std_logic_vector(3 downto 0);
    signal s_Mem_addr           : std_logic_vector(7 downto 0);
    signal s_load_flags         : std_logic;


    component maquina_estados is
        port(clk: in std_logic; 
		reset: in std_logic; 
		Instruction: in std_logic_vector(15 downto 0); 
		z_0: in std_logic; c_0: in std_logic;
                PC_addr: out std_logic_vector(7 downto 0); 
		Reg_write: out std_logic; 
		Mem_write: out std_logic; 
		MemtoReg: out std_logic;
                ULA_key: out std_logic_vector(2 downto 0); 
		addr_A: out std_logic_vector(3 downto 0); 
		addr_B: out std_logic_vector(3 downto 0);
                addr_C: out std_logic_vector(3 downto 0);
		load_flags: out std_logic;
		Mem_addr: out std_logic_vector(7 downto 0)
		);
    end component;

    component datapath is
        port (
		clk: in std_logic; 
		reset: in std_logic; 
	 	RegWrite: in std_logic; 
		MemtoReg: in std_logic; 
                ULA_key: in std_logic_vector(2 downto 0); 
		addr_A: in std_logic_vector(3 downto 0); 
		addr_B: in std_logic_vector(3 downto 0);
                addr_C: in std_logic_vector(3 downto 0); 
		load_flags: in std_logic;
		Mem_data_in: in std_logic_vector(7 downto 0);
                z_0_out: out std_logic; 
		c_0_out: out std_logic; 
		ULA_out: out std_logic_vector(7 downto 0); 
		Reg_out: out std_logic_vector(7 downto 0)
		);
    end component;

    component rom256_16b is
        port(
		clk: in std_logic; 
		addr: in std_logic_vector(7 downto 0); 
		data: out std_logic_vector(15 downto 0));
    end component;

    component ram256_8b is
        port(
		clk: in std_logic; 
		w_en: in std_logic; 
		addr: in std_logic_vector(7 downto 0); 
		w_data: in std_logic_vector(7 downto 0); 
		r_data: out std_logic_vector(7 downto 0)
		);
    end component;

begin

    CONTROLLER_UNIT: maquina_estados
    port map(
        clk          => clk,
        reset        => rst,
        Instruction  => s_instruction,
        z_0          => s_zero_flag,
        c_0          => s_carry_flag,
        PC_addr      => s_pc_addr,
        Reg_write    => s_reg_write,
        Mem_write    => s_mem_write,
        MemtoReg     => s_mem_to_reg,
        ULA_key      => s_ula_key,
        addr_A       => s_addr_a,
        addr_B       => s_addr_b,
        addr_C       => s_addr_c,
	load_flags   => s_load_flags,
	Mem_addr     => s_Mem_addr
    );

    DATAPATH_UNIT: datapath
    port map(
        clk           => clk,
        reset         => rst,
        RegWrite      => s_reg_write,
        MemtoReg      => s_mem_to_reg,
        ULA_key       => s_ula_key,
        addr_A        => s_addr_a,
        addr_B        => s_addr_b,
        addr_C        => s_addr_c,
	load_flags    => s_load_flags,
        Mem_data_in   => s_mem_read_data,
        z_0_out       => s_zero_flag,
        c_0_out       => s_carry_flag,
        ULA_out       => s_ula_out,
        Reg_out       => s_reg_b_data_out
    );

    INSTR_MEM: rom256_16b
    port map(
        clk    => clk,
        addr   => s_pc_addr,
        data => s_instruction
    );

    DATA_MEM: ram256_8b
    port map(
        clk    => clk,
        w_en   => s_mem_write,
        addr   => s_Mem_addr,
        w_data => s_reg_b_data_out,
        r_data => s_mem_read_data
    );

end CKT;