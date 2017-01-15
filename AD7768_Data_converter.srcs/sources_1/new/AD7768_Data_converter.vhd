----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Gustavo Martin
-- 
-- Create Date: 01/14/2017 09:15:30 PM
-- Design Name: 
-- Module Name: AD7768_Data_converter - Behavioral
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
-- El dato en parelelo convertido se debe tomar en el flanco de bajada de DATA_RDY
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

entity AD7768_Data_converter is
    Port ( DCLK_IN : in STD_LOGIC;
           DRDY_IN : in STD_LOGIC;
           DATA_IN : in STD_LOGIC;
           DATA_OUT : out STD_LOGIC_VECTOR (31 downto 0);
           DATA_RDY : out STD_LOGIC);
end AD7768_Data_converter;

architecture Behavioral of AD7768_Data_converter is

signal data32: std_logic_vector(31 downto 0);
signal data_valid : std_logic := '0';
begin

process(DCLK_IN)
begin

    if(DCLK_IN'event and DCLK_IN = '0') then 
        data32(31 downto 1) <= data32(30 downto 0);
        data32(0) <= DATA_IN;
        data_valid <= '0';
        if(DRDY_IN = '1') then
            data_valid <= '1';
        end if;
        
    end if;
    
    if(DCLK_IN'event and DCLK_IN = '1' and data_valid = '1') then 
        DATA_OUT <= data32;
        DATA_RDY <= '1';
    end if;

    if(DCLK_IN'event and DCLK_IN = '1' and data_valid = '0') then 
        DATA_RDY <= '0';
    end if;

end process;



end Behavioral;






