library ieee;
use ieee.std_logic_1164.all;


entity ula is
	port(
	A,B : in std_logic_vector(7 downto 0);
	key : in std_logic_vector(2 downto 0);
	
	c_0 :out std_logic;
	z_0: out std_logic;
	
	S_mux: out std_logic_vector(7 downto 0)
	);
end ula;




architecture CKT of ula is 
	
	
	component somador_8_bits
		port(
			A: in std_logic_vector(7 downto 0);
			B: in std_logic_vector(7 downto 0);

			C_0: out std_logic;
			S: out std_logic_vector(7 downto 0)
			);
	end component;
	
	component subtrator_8_bit
		port(
			A: in std_logic_vector(7 downto 0);
			B: in std_logic_vector(7 downto 0);

			C_0: out std_logic;
			S: out std_logic_vector(7 downto 0)
			);
	end component;
	
  
	component porta_and
	port(
		a,b	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
  	);	
  	end component;
	
	component porta_or
	port(
		a,b	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
  	);	
  	end component;
  
  	component porta_xor
		port(
		a,b	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
	  );	
	  end component;
	  
	  component porta_not
		port(
		a : in std_logic_vector(7 downto 0);
		s : out  std_logic_vector(7 downto 0)
	  );	
	  end component;
  

	  component comparador_8
	     port (
	        A      : in  std_logic_vector(7 downto 0);
	        B      : in  std_logic_vector(7 downto 0);
	        maior  : out std_logic;
	        igual  : out std_logic;
	        menor  : out std_logic
	    );
	     end component;


	  component mux_8
	  port(
		A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		C: in std_logic_vector(7 downto 0);
		D: in std_logic_vector(7 downto 0);
		E: in std_logic_vector(7 downto 0);
		F: in std_logic_vector(7 downto 0);
		G: in std_logic_vector(7 downto 0);
		H: in std_logic_vector(7 downto 0);

		S: in std_logic_vector(2 downto 0);

		Y_8: out std_logic_vector(7 downto 0)
	);
	end component;

  
  
  signal R1,R2,R3,R4,R5,R6,R7,R8: std_logic_vector(7 downto 0);
  
  signal zero_flag,c_01,c_02,c_03,c_04,c_05, maior, menor: std_logic;

  signal c_0_v,c_01_v,c_02_v,c_03_v,c_04_v,c_05_v: std_logic_vector(7 downto 0);
  
  
  
begin 
	
   Canal1: somador_8_bits port map(
  	A => A,
  	B => B,
  	C_0 => c_01,      -- carry-out vai pro pr ximo est gio
  	S => R1
);

   Canal2: subtrator_8_bit port map(
  	A => A,
  	B => B,
  	C_0 => c_02,      -- carry-out vai pro pr ximo est gio
  	S => R2
);
  

   Canal3: porta_and port map(
  	A => A,
  	B => B,
  	S => R3
);
 
   Canal4: porta_or port map(
	A => A,
  	B => B,
  	S => R4
	);

   Canal5: porta_xor port map(
  	A => A,
  	B => B,
  	S => R5
	);

   Canal6: porta_not port map(
  	A => A,
  	S => R6
	);

   Canal7CMP: comparador_8 port map(
	 A => R2,
	 B => "00000000",
	 maior => maior,
	 igual => zero_flag,
	 menor => menor
	 
	 );

	z_0 <= zero_flag;-- and not(key(0)) and key(1) and key(2);

	R7 <= "000000" & c_02 & zero_flag;
    	R8 <= B;

	

    mux_8_c0: mux_8 port map(
	A => c_01_v,
	B => c_02_v,
	C => c_03_v,
	D => c_04_v,
	E => c_05_v,
	F => "00000000",
	G => "00000000",
	H => "00000000",

	S=> key,
	Y_8 => c_0_v

	);
		
			
  
    mux16: mux_8 port map(
    	A => R1,
	B => R2,
	C => R3,
	D => R4,
	E => R5,
	F => R6,
	G => R7,
	H => R8,
	S => key,
	Y_8 => S_mux
	);
	
	 
 ---Bit de Carrie out---
  --c_0 <= c_0_v(0); --and not(key(0)) and key(1) and key(2);
    c_0 <= c_02;



end CKT;