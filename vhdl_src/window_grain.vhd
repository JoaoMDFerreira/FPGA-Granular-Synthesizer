----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2024 04:56:44 PM
-- Design Name: 
-- Module Name: window_grain - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity window_grain is
    Port ( CLK          : in STD_LOGIC;
           INPUT_VALID  : in STD_LOGIC;
           OUTPUT_VALID : out STD_LOGIC;
           CC_ATTACK    : in UNSIGNED (6 downto 0);
           CC_RELEASE   : in UNSIGNED (6 downto 0);
           CURRENT      : in UNSIGNED (15 downto 0);
           SIZE         : in UNSIGNED (15 downto 0);
           WINDOW_IN    : in SIGNED (15 downto 0);
           WINDOW_OUT   : out SIGNED (15 downto 0));
end window_grain;

architecture Behavioral of window_grain is
    signal output_valid_internal : std_logic := '0';
    COMPONENT division_ip
      PORT (
        aclk : IN STD_LOGIC;
        s_axis_divisor_tvalid : IN STD_LOGIC;
        s_axis_divisor_tready : OUT STD_LOGIC;
        s_axis_divisor_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axis_dividend_tvalid : IN STD_LOGIC;
        s_axis_dividend_tready : OUT STD_LOGIC;
        s_axis_dividend_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axis_dout_tvalid : OUT STD_LOGIC;
        m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
      );
    END COMPONENT;
    signal div_divisor_valid_in : std_logic := '0';
    signal div_divisor_data_in : std_logic_vector (15 downto 0);
    signal div_dividend_valid_in : std_logic := '0';
    signal div_dividend_data_in : std_logic_vector (31 downto 0);
    signal div_valid_out : std_logic;
    signal div_out : std_logic_vector (31 downto 0);

    signal attack  : positive := 1;
    signal release : positive := 1;
    signal release_beggining : positive := 1;
    
    --signal interrim_1 : signed (31 downto 0) := (others => '0');
    --signal interrim_2 : signed (31 downto 0) := (others => '0');
begin
U1: division_ip
  PORT MAP (
    aclk => clk,
    s_axis_divisor_tvalid => div_divisor_valid_in,
    s_axis_divisor_tready => open,
    s_axis_divisor_tdata => div_divisor_data_in,
    s_axis_dividend_tvalid => div_dividend_valid_in,
    s_axis_dividend_tready => open,
    s_axis_dividend_tdata => div_dividend_data_in,
    m_axis_dout_tvalid => div_valid_out,
    m_axis_dout_tdata => div_out
  );
      
    UPDATE_VALUES: process(CLK)
    begin
        if rising_edge(CLK) then
            attack <= (((to_integer(CC_ATTACK)) * to_integer(SIZE))/256 +1);
            release <= (((to_integer(CC_RELEASE)) * to_integer(SIZE))/256 +1);
            
            release_beggining <= to_integer(SIZE) - release;
        end if;
    end process;
    
    UPDATE_OUTPUT: process(CLK)
        variable interrim_1 : integer := 0;
    begin
        if rising_edge(CLK) then
            if div_divisor_valid_in = '1' and  div_dividend_valid_in = '1' then
                if div_valid_out = '1' then
                    output_valid_internal <= '1';
                    WINDOW_OUT <= signed(div_out(15 downto 0));
                    div_divisor_valid_in <= '0';
                    div_dividend_valid_in <= '0';
                end if;
            elsif INPUT_VALID = '1' and output_valid_internal = '0' then
                if CURRENT <= to_unsigned(attack,16) then
                    output_valid_internal <= '0';
                    interrim_1 := (to_integer(CURRENT) - 1) * to_integer(WINDOW_IN);
                    --DO division
                    div_divisor_valid_in <= '1';
                    div_divisor_data_in <= std_logic_vector(to_unsigned(attack,16));
                    div_dividend_valid_in <= '1';
                    div_dividend_data_in <= std_logic_vector(to_signed(interrim_1,32));
                    
                    --WINDOW_OUT <= interrim_1/attack; --will not compile due to division
                elsif CURRENT < to_unsigned(release_beggining,16) then
                    WINDOW_OUT <= WINDOW_IN;
                    output_valid_internal <= '1';
                else
                    output_valid_internal <= '0';
                    interrim_1 := (to_integer(SIZE)-to_integer(CURRENT)) * to_integer(WINDOW_IN);
                    --DO division
                    div_divisor_valid_in <= '1';
                    div_divisor_data_in <= std_logic_vector(to_unsigned(release,16));
                    div_dividend_valid_in <= '1';
                    div_dividend_data_in <= std_logic_vector(to_signed(interrim_1,32));
                    
                    --WINDOW_OUT <= (1 - (CURRENT - attack - sustain)/release) *WINDOW_IN;
                end if;
            else
                output_valid_internal <= '0';
            end if;
        end if;
    end process;
    
    OUTPUT_VALID <= output_valid_internal;

end Behavioral;
