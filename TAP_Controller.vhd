----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2021 02:02:18 PM
-- Design Name: 
-- Module Name: TAP_Controller - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:<zxc
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


entity Tap is
   port ( clk, rst, tms: in std_logic;
          cpdr_now, shdr_now, updr_now, cpir_now, shir_now, upir_now: out std_logic
        );
end Tap;
architecture arch of Tap is
type state is (TLR, RTI, SDRS, CPDR, SHDR, E1DR, PADR, E2DR, UPDR, 
            SIRS, CPIR, SHIR, E1IR, PAIR, E2IR, UPIR);
signal st_reg, st_nxt: state;  -- present state, next state
begin
-- state register
process (clk, rst)
begin
   if (rst = '1') then
      st_reg <= TLR; -- initial state
   elsif rising_edge(clk) then
      st_reg <= st_nxt;
   end if;
end process;
-- next-state and output logic
process (st_reg, tms)
begin
   st_nxt <= st_reg; -- stay in current state by default
   cpdr_now <= '0';
   shdr_now <= '0';
   updr_now <= '0';
   cpir_now <= '0';
   shir_now <= '0';
   upir_now <= '0';
   case st_reg is
      when TLR =>
         if tms = '0' then
        st_nxt <= RTI;
         end if;
      when RTI =>
         if tms = '1' then
        st_nxt <= SDRS;
         end if;
      when SDRS =>
         if tms = '1' then
        st_nxt <= SIRS; 
         else
            st_nxt <= CPDR;
         end if;
       when CPDR =>
         cpdr_now <= '1';
         if tms = '1' then
        st_nxt <= E1DR; 
         else
            st_nxt <= SHDR;
         end if;
       when SHDR =>
     shdr_now <= '1';
         if tms = '1' then
        st_nxt <= E1DR; 
         end if;
       when E1DR =>
         if tms = '1' then
        st_nxt <= UPDR; 
         else
            st_nxt <= PADR;
         end if;
       when PADR =>
         if tms = '1' then
        st_nxt <= E2DR; 
         end if;
        when E2DR =>
         if tms = '1' then
        st_nxt <= UPDR; 
         else
            st_nxt <= SHDR;
         end if;
        when UPDR =>
         updr_now <= '1';
         if tms = '1' then
        st_nxt <= SDRS; 
         else
            st_nxt <= RTI;
         end if;
       when SIRS =>
         if tms = '1' then
        st_nxt <= TLR; 
         else
            st_nxt <= CPIR;
         end if;
       when CPIR =>
         cpir_now <= '1';
         if tms = '1' then
        st_nxt <= E1IR; 
         else
            st_nxt <= SHIR;
         end if;
       when SHIR =>
    shir_now <= '1';
         if tms = '1' then
        st_nxt <= E1IR; 
         end if;
       when E1IR =>
         if tms = '1' then
        st_nxt <= UPIR; 
         else
            st_nxt <= PAIR;
         end if;
       when PAIR =>
         if tms = '1' then
        st_nxt <= E2IR; 
         end if;
        when E2IR =>
         if tms = '1' then
        st_nxt <= UPIR; 
         else
            st_nxt <= SHIR;
         end if;
        when UPIR =>
         upir_now <= '1';
         if tms = '1' then
        st_nxt <= SIRS; 
         else
            st_nxt <= RTI;
         end if;
   end case;
end process;
-- Moore outputs logic
end arch;



