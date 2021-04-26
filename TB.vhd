library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--datapath entity
entity TB is
port(
   x:out std_logic_vector(7 downto 0);
   y:out std_logic_vector(7 downto 0);
   start:out std_logic
);
end TB;


--signal declaration
architecture RTL of TB is
signal start_int:std_logic;
signal x_int:std_logic_vector(7 downto 0);
signal y_int:std_logic_vector(7 downto 0);


begin


--combinational logics
dpCMB: process (start_int,x_int,y_int)
   begin
      start_int <= '0';
      x_int <= (others=>'0');
      y_int <= (others=>'0');
      x <= (others=>'0');
      y <= (others=>'0');
      start <= '0';

      start <= start_int;
      x <= x_int;
      y <= y_int;
      start_int <= '1';
      x_int <= conv_std_logic_vector(14,8);
      y_int <= conv_std_logic_vector(4,8);
   end process dpCMB;
end RTL;
