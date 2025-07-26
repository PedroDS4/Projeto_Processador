library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity porta_xor is
	Port(
		a	: in std_logic_vector(7 downto 0);
		b	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
);
end porta_xor;

architecture OPxor of porta_xor is
begin
	s <= a xor b;
end OPxor;

