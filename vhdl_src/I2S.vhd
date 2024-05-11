----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2024 10:49:50 PM
-- Design Name: 
-- Module Name: I2S - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity I2S is
    Generic ( 
        CLK_FREQ : integer := 100_000_000;
        BCLK_FREQ : integer := 3_072_000
    );
    Port ( CLK : in STD_LOGIC;
           LJ_IN : in STD_LOGIC_VECTOR (15 downto 0);
           LJ_DOUT : out STD_LOGIC;
           DAC_LRCLK : out STD_LOGIC;
           DAC_BCLK : out STD_LOGIC);
end I2S;

architecture Behavioral of I2S is

    constant BCLK_CNT_MAX : integer := CLK_FREQ/BCLK_FREQ/2-1;

    signal BCLK : std_logic := '0';
	signal bclk_cnt : integer := 0;

	signal LRCLK : std_logic := '0';
	signal lr_cnt : integer := 0;
	
	signal DOUT : std_logic := '0';
	
	signal sample : std_logic_vector(15 downto 0) := (others => '0');
begin

process_gen_BCLK : process(CLK)
	begin
		if rising_edge(CLK) then
			bclk_cnt <= bclk_cnt +1;
			if bclk_cnt = BCLK_CNT_MAX then 
				BCLK <= not(BCLK);
				bclk_cnt <= 0;
			end if;
		end if;
	end process;
	
	process_gen_LRCLK : process(BCLK)
	begin
		if falling_edge(BCLK) then
				if lr_cnt = 31 then
					LRCLK <= not(LRCLK);
					lr_cnt <= 0;
				else
					lr_cnt <= lr_cnt+1;
				end if;	
		end if;
	end process;
	
	process_IN : process(LRCLK)
	begin
		if rising_edge(LRCLK) then
			sample <= LJ_IN;
		end if;
	end process;
	
	process_OUT : process(BCLK)
	begin
		if falling_edge(BCLK) then
			if lr_cnt < 16 then
				DOUT <= sample(15-lr_cnt);
			else
				DOUT <= '0';
			end if;
		end if;
	end process;
	
	LJ_DOUT <= DOUT;
	DAC_LRCLK <= LRCLK;
	DAC_BCLK <= BCLK;
	
end Behavioral;
