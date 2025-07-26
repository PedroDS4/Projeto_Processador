

library ieee;
use ieee.std_logic_1164.all;


entity comparador8 is
	port(
	A: in std_logic_vector(7 downto 0);
	B: in std_logic_vector(7 downto 0);


	geq:   out std_logic
	);
end comparador8;


architecture estrutural of comparador8 is
    signal e7, e6, e5, e4, e3, e2, e1, e0 : std_logic;
    signal maior7, maior6, maior5, maior4, maior3, maior2, maior1, maior0 : std_logic;
begin
    -- bit 7 (mais significativo)
    e7 <= not (A(7) xor B(7));
    maior7 <= A(7) and (not B(7));

    -- bit 6
    e6 <= not (A(6) xor B(6));
    maior6 <= e7 and A(6) and (not B(6));

    -- bit 5
    e5 <= not (A(5) xor B(5));
    maior5 <= e7 and e6 and A(5) and (not B(5));

    -- bit 4
    e4 <= not (A(4) xor B(4));
    maior4 <= e7 and e6 and e5 and A(4) and (not B(4));

    -- bit 3
    e3 <= not (A(3) xor B(3));
    maior3 <= e7 and e6 and e5 and e4 and A(3) and (not B(3));

    -- bit 2
    e2 <= not (A(2) xor B(2));
    maior2 <= e7 and e6 and e5 and e4 and e3 and A(2) and (not B(2));

    -- bit 1
    e1 <= not (A(1) xor B(1));
    maior1 <= e7 and e6 and e5 and e4 and e3 and e2 and A(1) and (not B(1));

    -- bit 0 (menos significativo)
    e0 <= not (A(0) xor B(0));
    maior0 <= e7 and e6 and e5 and e4 and e3 and e2 and e1 and A(0) and (not B(0));

    -- A ? B se um dos bits de A for maior ou se todos forem iguais
    geq <= maior7 or maior6 or maior5 or maior4 or maior3 or maior2 or maior1 or maior0 or (e7 and e6 and e5 and e4 and e3 and e2 and e1 and e0);

end estrutural;