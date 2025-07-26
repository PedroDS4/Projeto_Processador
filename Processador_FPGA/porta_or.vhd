library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity porta_or is
	Port(
		a	: in std_logic_vector(7 downto 0);
		b	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
);
end porta_or;

architecture OPor of porta_or is
begin
	s <= a or b;
end OPor;

