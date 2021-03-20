----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2021 10:57:13 AM
-- Design Name: 
-- Module Name: BS_Cell - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BS_Cell is
    Port ( rst 	: in STD_LOGIC;
           clk 	: in STD_LOGIC;
           mic 	: in STD_LOGIC;
           mlc  : in STD_LOGIC;
           pin 	: in STD_LOGIC;
           sin 	: in STD_LOGIC;
           moc 	: in STD_LOGIC;
		   mcsc	: in STD_LOGIC;
           pout : out STD_LOGIC;	   
           sout : out STD_LOGIC);
end BS_Cell;

architecture Behavioral of BS_Cell is


signal cs_reg, l_reg, cs_next, l_next, mio : std_logic;

begin

---state register
process(clk, rst, cs_reg, l_reg)
begin
	if rst = '1' then
		cs_reg <= '0';
		l_reg <= '0';
	else
		if (rising_edge(clk)) then
			cs_reg	 <= cs_next;
			l_reg <= l_next;		
		end if;	
	end if;
end process;

-----combinational block

mio <= sin when mic = '1' else	
			pin;

cs_next <= mio when mcsc = '1' else
			cs_reg; 

l_next <= cs_reg when mlc = '1' else
			l_reg;
			
pout <= l_reg when moc = '1' else
			pin;
			
			sout <= cs_reg;

end Behavioral;























