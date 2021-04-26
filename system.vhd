library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--system entity
entity system is
end system;


architecture RTL of system is
signal RST : std_logic;
signal CLK : std_logic;


--component declaration
component sysdiv
   port(
      RST : in std_logic;
      CLK : in std_logic
   );
end component;


begin
   --portmap
   label_sysdiv : sysdiv port map (
         RST => RST,
         CLK => CLK
      );


   --clk, reset generation
   process
      begin
      RST       <= '1';
      wait for 50 ns;
      RST       <= '0';
      wait;
   end process;

   process(CLK   )
      begin
      if CLK'event and CLK      = '1' then 
         CLK          <= '0' after 25 ns;
      else
         CLK          <= '1' after 25 ns;
      end if;
   end process;

end RTL;
