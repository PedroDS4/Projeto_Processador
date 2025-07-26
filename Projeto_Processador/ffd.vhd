library ieee;
use ieee.std_logic_1164.all;

entity ffd is
   port (ck, clr, set: in  std_logic;
   d : in std_logic_vector(7 downto 0);
   q : out std_logic_vector(7 downto 0)
);
end ffd;

architecture logica of ffd is

begin

   process(ck, clr, set)
   begin
      if    (set = '1')            then q <= "11111111";
      elsif (clr = '1')            then q <= "00000000";
      elsif (ck'event and ck ='1') then q <= d;   
      end if;   
   end process;
   
end logica;