--------------------------------------------------------------------------
--                                                                      --
--                                                                      --
-- This source file may be used and distributed without restriction     --
-- provided that this copyright statement is not removed from the file  --
-- and that any derivative work contains this copyright notice.         --
--                                                                      --
--	Package name: STD_LOGIC_ARITHEXT                                 --
--	Purpose: 			                                         --
--	 A set of arithemtic, conversion, and comparison functions       --
--	 STD_LOGIC		               	                             --
--					                                         --
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
package std_logic_arithext is
    function LOGIC_SIGN_EXT(ARG: STD_LOGIC; SIZE: INTEGER) return STD_LOGIC_VECTOR;
    function LOGIC_ZERO_EXT(ARG: STD_LOGIC; SIZE: INTEGER) return STD_LOGIC_VECTOR;
end std_logic_arithext;
library IEEE;
use IEEE.std_logic_1164.all;
package body std_logic_arithext is
    function LOGIC_SIGN_EXT(ARG: STD_LOGIC; SIZE: INTEGER) return STD_LOGIC_VECTOR is
	subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
	variable result: rtype;
	-- synopsys built_in SYN_ZERO_EXTEND
    begin
	if (ARG = '0') then
	    result := rtype'(others => '0');
	elsif (ARG = '1') then
	    result := rtype'(others => '1');	
	elsif (ARG = 'X') then
	    result := rtype'(others => 'X');
	end if;
	return result;
    end;
    function LOGIC_ZERO_EXT(ARG: STD_LOGIC; SIZE: INTEGER) return STD_LOGIC_VECTOR is
	subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
	variable result: rtype;
    begin
	result := rtype'(others => '0');
	result(0) := ARG;
	if (result(0) = 'X') then
	    result := rtype'(others => 'X');
	end if;
	return result;
    end;
end std_logic_arithext;
