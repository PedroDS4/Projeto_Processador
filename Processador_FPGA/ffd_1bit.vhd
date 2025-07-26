library ieee;
use ieee.std_logic_1164.all;

entity ffd_1bit is
   port (ck, clr, set: in  std_logic;
   d : in std_logic;
   q : out std_logic
);
end ffd_1bit;

architecture logica of ffd_1bit is

begin

   process(ck, clr, set)
   begin
      if    (set = '1')            then q <= '1';
      elsif (clr = '1')            then q <= '0';
      elsif (ck'event and ck ='1') then q <= d;   
      end if;   
   end process;
   
end logica;
