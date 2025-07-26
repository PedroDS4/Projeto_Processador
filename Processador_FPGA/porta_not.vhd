library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity porta_not is
	Port(
		a	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
);
end porta_not;

architecture OPnot of porta_not is
begin
	s <= not a;
end OPnot;

