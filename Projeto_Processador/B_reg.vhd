library ieee;
use ieee.std_logic_1164.all;

entity B_reg is
    port (
        w_data : in std_logic_vector(7 downto 0);
        addr_r1, addr_r2, addr_w : in std_logic_vector(3 downto 0); -- leitura dupla
        en_wr: in std_logic;
        clk, clr : in std_logic;
        r_data1, r_data2: out std_logic_vector(7 downto 0)
    );
end B_reg;

architecture logica of B_reg is

    type reg_array is array (0 to 15) of std_logic_vector(7 downto 0);
    signal V : reg_array;
    signal d : std_logic_vector(15 downto 0);

    component mux_16
        port(
            A, B, C, D, E, F, G, H,
            I, J, K, L, M, N, O, P: in std_logic_vector(7 downto 0);
            S : in std_logic_vector(3 downto 0);
            Y_16 : out std_logic_vector(7 downto 0)
        );
    end component;

    component reg_N
        port (
            ck, load, clr, set: in std_logic;
            I : in std_logic_vector(7 downto 0);
            q : out std_logic_vector(7 downto 0)
        );
    end component;

    component decoder_4x16
        port (
            en : in std_logic;
            s  : in std_logic_vector(3 downto 0);
            d  : out std_logic_vector(15 downto 0)
        );
    end component;

    signal r_out1, r_out2 : std_logic_vector(7 downto 0);

begin

    Decoder: decoder_4x16 port map(
        en => en_wr,
        s  => addr_w,
        d  => d
    );

    gen_regs: for i in 0 to 15 generate
        reg_inst: reg_N port map(
            ck => clk,
            load => d(i),
            clr => clr,
            set => '0',
            I => w_data,
            q => V(i)
        );
    end generate;

    mux_read1: mux_16 port map(
        A => V(0),  B => V(1),  C => V(2),  D => V(3),
        E => V(4),  F => V(5),  G => V(6),  H => V(7),
        I => V(8),  J => V(9),  K => V(10), L => V(11),
        M => V(12), N => V(13), O => V(14), P => V(15),
        S => addr_r1,
        Y_16 => r_out1
    );

    mux_read2: mux_16 port map(
        A => V(0),  B => V(1),  C => V(2),  D => V(3),
        E => V(4),  F => V(5),  G => V(6),  H => V(7),
        I => V(8),  J => V(9),  K => V(10), L => V(11),
        M => V(12), N => V(13), O => V(14), P => V(15),
        S => addr_r2,
        Y_16 => r_out2
    );

    r_data1 <= r_out1;
    r_data2 <= r_out2;

end logica;

