----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2021 05:27:48 PM
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           tdo : out STD_LOGIC;
           tdi : in STD_LOGIC;
           tms : in STD_LOGIC;
           tck : in STD_LOGIC;
           func_in : in STD_LOGIC_VECTOR (3 downto 0);
           func_out : out STD_LOGIC);
end top_level;

architecture Behavioral of top_level is


component Core_Logic is
    Port ( func_in : in STD_LOGIC_VECTOR (3 downto 0);
           func_out : out STD_LOGIC);
end component Core_Logic;

component BS_Cell is
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
end component BS_Cell;

Component IR_Reg is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           pin : in STD_LOGIC_VECTOR (3 downto 0);
           pout : out STD_LOGIC_VECTOR (3 downto 0);
           sin : in STD_LOGIC;
           sout : out STD_LOGIC;
           mic : in STD_LOGIC;
           mcsc : in STD_LOGIC;
           mlc : in STD_LOGIC);
end component IR_Reg;

component ID_Decoder is
    Port ( rst      : in STD_LOGIC;
           pin      : in STD_LOGIC_VECTOR (3 downto 0);
           dmux     : out STD_LOGIC;
           BYPASS   : out STD_LOGIC;
           EXTERNAL_TEST : out STD_LOGIC;
           SAMPLE_AND_PRELOAD : out STD_LOGIC);
end component ID_Decoder;

component Tap is
   port ( clk, rst, tms: in std_logic;
          cpdr_now, shdr_now, updr_now, cpir_now, shir_now, upir_now: out std_logic
        );
end component Tap;

component BP_Reg is
    Port ( BP_in : in STD_LOGIC;
           BP_out : out STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end component BP_Reg;


signal sout_to_sin_0, sout_to_sin_1, sout_to_sin_2, sout_to_sin_3 : std_logic;
signal Core_logic_func_out : std_logic;
signal Core_logic_func_in : std_logic_vector(3 downto 0);
signal bs_mic, bs_mlc, bs_mcsc, bs_moc : std_logic;
signal IR_mic, IR_mlc, IR_mcsc : std_logic;
signal bs_cell_to_dmux : std_logic;
signal IR_sout : std_logic;
signal IR_Reg_pout : std_logic_vector(3 downto 0);
signal BYPASS, EXTERNAL_TEST, SAMPLE_AND_PRELOAD, dmux : std_logic;
signal cpdr_now, shdr_now, updr_now, cpir_now, shir_now, upir_now: std_logic;
signal BP_out :std_logic;
signal dmux_out : std_logic;
signal ID_dmux_control : std_logic;
begin

BP_register : BP_Reg
port map(BP_in => tdi, BP_out => BP_out, clk => clk , rst => rst);

TAP_Controller : Tap
port map (cpdr_now => cpdr_now, cpir_now => cpir_now, shdr_now => shdr_now,
		  updr_now => updr_now, upir_now => upir_now, shir_now => shir_now,
		  clk => clk, rst => rst, tms => tms);


ID_Dec : ID_Decoder
port map(rst => rst, pin => IR_Reg_pout, BYPASS => BYPASS, SAMPLE_AND_PRELOAD => SAMPLE_AND_PRELOAD,
		EXTERNAL_TEST => EXTERNAL_TEST, dmux => ID_dmux_control);


IR_register : IR_Reg
port map(pin(0) => '1', pin(1) => '0', pin(2) => '0', pin(3) => '1',
		clk => clk, mic => IR_mic, mcsc => IR_mcsc, mlc => IR_mlc,
		sin => tdi, sout => IR_sout, pout => IR_Reg_pout, rst => rst);



core : Core_Logic
port map(func_out => Core_logic_func_out, func_in(0) => Core_logic_func_in(0),
		func_in(1) => Core_logic_func_in(1),func_in(2) => Core_logic_func_in(2),
		func_in(3) => Core_logic_func_in(3));

BS_cell_0 : BS_cell
port map(rst => rst, clk => clk, pin => func_in(0), mic => bs_mic, mlc => bs_mlc ,sin => tdi, 
moc => bs_moc, mcsc => bs_mcsc, sout => sout_to_sin_0, pout => Core_logic_func_in(0));

BS_cell_1 : BS_cell
port map(rst => rst, clk => clk, pin => func_in(1), mic => bs_mic, mlc => bs_mlc  ,sin => sout_to_sin_0, 
moc => bs_moc, mcsc => bs_mcsc, sout => sout_to_sin_1, pout => Core_logic_func_in(1));

BS_cell_2 : BS_cell
port map(rst => rst, clk => clk, pin => func_in(2), mic => bs_mic, mlc => bs_mlc  ,sin => sout_to_sin_1, 
moc => bs_moc, mcsc => bs_mcsc, sout => sout_to_sin_2, pout => Core_logic_func_in(2));

BS_cell_3 : BS_cell
port map(rst => rst, clk => clk, pin => func_in(3),mic => bs_mic, mlc => bs_mlc  ,sin => sout_to_sin_2, 
moc => bs_moc, mcsc => bs_mcsc, sout =>sout_to_sin_3, pout => Core_logic_func_in(3));

BS_cell_4 : BS_cell
port map(rst => rst, clk => clk, pin => Core_logic_func_out, mic => bs_mic, mlc => bs_mlc  ,sin => sout_to_sin_3, 
moc => bs_moc, mcsc => bs_mcsc, sout => bs_cell_to_dmux, pout => func_out);


------------------BS cell
bs_mic 	<= '1' when shdr_now = '1' else '0';
bs_moc 	<= '1' when EXTERNAL_TEST = '1' else '0';
bs_mcsc <= '1' when (EXTERNAL_TEST = '1' or SAMPLE_AND_PRELOAD = '1') and 
					(shdr_now = '1' or cpdr_now = '1') else '0';
bs_mlc  <= '1' when (EXTERNAL_TEST = '1' or SAMPLE_AND_PRELOAD = '1') and updr_now = '1';

-----------------ID cell

IR_mic  <= '1' when shir_now = '1' else '0';
IR_mcsc <= '1' when shir_now = '1' or cpir_now = '1' else '0';
IR_mlc  <= '1' when upir_now = '1' else '0';

-----------------Data Mux;
dmux_out <= BP_out when ID_dmux_control = '0' else bs_cell_to_dmux;


------------------Instruction mux
tdo <= IR_sout when shir_now = '0' else dmux_out;

end Behavioral;



















