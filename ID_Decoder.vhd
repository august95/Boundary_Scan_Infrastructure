----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2021 01:35:55 PM
-- Design Name: 
-- Module Name: ID_Decoder - Behavioral
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

entity ID_Decoder is
    Port ( rst      : in STD_LOGIC;
           pin      : in STD_LOGIC_VECTOR (3 downto 0);
           dmux     : out STD_LOGIC;
           BYPASS   : out STD_LOGIC;
           EXTERNAL_TEST : out STD_LOGIC;
           SAMPLE_AND_PRELOAD : out STD_LOGIC);
end ID_Decoder;

architecture Behavioral of ID_Decoder is

begin



process(rst)
begin
	if(rst = '1')then 
		BYPASS <= '1';
	end if;
end process;


process(pin)
begin
BYPASS <=  '0';
EXTERNAL_TEST <= '0';
SAMPLE_AND_PRELOAD <= '0';
	case pin is 
		when "0000" => -- EXTERNAL_TEST
			EXTERNAL_TEST <= '1';
			dmux <= '1';
		
		when "1001" => -- SAMPLE_AND_PRELOAD
			SAMPLE_AND_PRELOAD <= '1';
			dmux <= '1';
		
		when others => -- BYPASS
			BYPASS <= '1';
			dmux <= '0';
	end case;
end process;

end Behavioral;












