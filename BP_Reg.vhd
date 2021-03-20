----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2021 08:12:33 PM
-- Design Name: 
-- Module Name: BP_Reg - Behavioral
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

entity BP_Reg is
    Port ( BP_in : in STD_LOGIC;
           BP_out : out STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end BP_Reg;

architecture Behavioral of BP_Reg is
signal state_reg, state_next : std_logic;
begin
process(rst, clk)
begin
    if rst = '1' then
        state_reg <= '0';
    elsif rising_edge(clk) then
        state_reg <= state_next;        
    end if;
end process;

state_next <= BP_in;
BP_out <= state_reg;
end Behavioral;












