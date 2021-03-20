----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2021 05:28:37 PM
-- Design Name: 
-- Module Name: Core_Logic - Behavioral
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

entity Core_Logic is
    Port ( func_in : in STD_LOGIC_VECTOR (3 downto 0);
           func_out : out STD_LOGIC);
end Core_Logic;

architecture Behavioral of Core_Logic is

begin
func_out <= func_in(0)and func_in(1)and func_in(2)and func_in(3);



end Behavioral;
