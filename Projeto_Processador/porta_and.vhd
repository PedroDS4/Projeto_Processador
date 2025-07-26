library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity porta_and is
	Port(
		a	: in std_logic_vector(7 downto 0);
		b	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
);
end porta_and;

architecture OPand of porta_and is
begin
	s <= b and a;
end OPand;

