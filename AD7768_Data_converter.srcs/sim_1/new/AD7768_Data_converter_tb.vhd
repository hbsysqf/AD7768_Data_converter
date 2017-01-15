----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/14/2017 10:03:19 PM
-- Design Name: 
-- Module Name: AD7768_Data_converter_tb - Behavioral
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

entity AD7768_Data_converter_tb is
--  Port ( );
end AD7768_Data_converter_tb;

architecture Behavioral of AD7768_Data_converter_tb is

component AD7768_Data_converter is
    Port ( DCLK_IN : in STD_LOGIC;
       DRDY_IN : in STD_LOGIC;
       DATA_IN : in STD_LOGIC;
       DATA_OUT : out STD_LOGIC_VECTOR (31 downto 0);
       DATA_RDY : out STD_LOGIC);

end component;

signal DCLK_IN :  STD_LOGIC := '0';
signal DRDY_IN :  STD_LOGIC := '0';
signal DATA_IN :  STD_LOGIC := '0';
signal DATA_OUT :  STD_LOGIC_VECTOR (31 downto 0);
signal DATA_RDY :  STD_LOGIC;
constant clk_period : time := 50 ns;
signal s_data : std_logic_vector(127 downto 0) := X"FF030201FF060504FF090807FF0C0B0A";
signal s_data_pos : integer := 127;
begin

uut: AD7768_Data_converter
port map(
    DCLK_IN => DCLK_IN,
    DRDY_IN => DRDY_IN,
    DATA_IN => DATA_IN,
    DATA_OUT => DATA_OUT,
    DATA_RDY => DATA_RDY
);


clk_process:
process
begin

    DCLK_IN <= '0';
    wait for clk_period/2;  --for 0.5 ns signal is '0'.
    DCLK_IN <= '1';
    wait for clk_period/2;  --for next 0.5 ns signal is '1'.
    
end process;




data_sender: process (DCLK_IN )
   begin
      if rising_edge(DCLK_IN ) and s_data_pos >= 0 then
         DATA_IN <= s_data(s_data_pos);
         s_data_pos <= s_data_pos - 1;
         if s_data_pos = 0 or s_data_pos = 32 or s_data_pos = 64 or s_data_pos = 96 or s_data_pos = 128 then
            DRDY_IN <= '1';
         else
            DRDY_IN <= '0';
         end if;
         
         if s_data_pos = 0 then
            s_data_pos <= 127;
         end if;
         
      end if;
end process;


end Behavioral;

















