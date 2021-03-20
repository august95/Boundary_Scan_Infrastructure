----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2021 01:17:45 PM
-- Design Name: 
-- Module Name: IR_Reg - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
--use UNISIM.VComponents.all;

entity IR_Reg is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           pin : in STD_LOGIC_VECTOR (3 downto 0);
           pout : out STD_LOGIC_VECTOR (3 downto 0);
           sin : in STD_LOGIC;
           sout : out STD_LOGIC;
           mic : in STD_LOGIC;
           mcsc : in STD_LOGIC;
           mlc : in STD_LOGIC);
end IR_Reg;

architecture Behavioral of IR_Reg is

component IR_Cell is
    Port ( rst 	: in STD_LOGIC;
           clk 	: in STD_LOGIC;
           mic 	: in STD_LOGIC;
           mlc  : in STD_LOGIC;
           pin 	: in STD_LOGIC;
           sin 	: in STD_LOGIC;
		   mcsc	: in STD_LOGIC;
           pout : out STD_LOGIC;	   
           sout : out STD_LOGIC);
end component IR_Cell;
begin

cell_0 : IR_Cell
port map(	rst => rst, clk => clk, mic => mic, mlc => mlc,
			pin => pin(0), sin => sin,
			mcsc => mcsc, pout => pout(0), sout => sout);
cell_1 : IR_Cell
port map(	rst => rst, clk => clk, mic => mic, mlc => mlc,
			pin => pin(1), sin => sin, 
			mcsc => mcsc, pout => pout(1), sout => sout);
			
			
cell_2 : IR_Cell
port map(	rst => rst, clk => clk, mic => mic, mlc => mlc,
			pin => pin(2), sin => sin, 
			mcsc => mcsc, pout => pout(2), sout => sout);
			
cell_3 : IR_Cell
port map(	rst => rst, clk => clk, mic => mic, mlc => mlc,
			pin => pin(3), sin => sin, 
			mcsc => mcsc, pout => pout(3), sout => sout);




end Behavioral;




















