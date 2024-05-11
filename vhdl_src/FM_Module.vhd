
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

entity FM_Module is
    Port ( CLK : in  STD_LOGIC;
		   FM_MIDI_NOTE_In : in STD_LOGIC_VECTOR (6 downto 0);
		   MODULATION_IDX_CC : in STD_LOGIC_VECTOR(6 downto 0);
           FM_Out : out  STD_LOGIC_VECTOR (15 downto 0));
end FM_Module;

architecture Behavioral of FM_Module is
    COMPONENT dds_compiler_0
      PORT (
        aclk : IN STD_LOGIC;
        s_axis_phase_tvalid : IN STD_LOGIC;
        s_axis_phase_tdata : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
        m_axis_data_tvalid : OUT STD_LOGIC;
        m_axis_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) 
      );
    END COMPONENT;
	 
	COMPONENT MIDI_NOTE_PARSER
	 PORT(
		MIDI_NOTE : IN  STD_LOGIC_VECTOR (6 downto 0);
        FREQUENCY : OUT  STD_LOGIC_VECTOR (35 downto 0)
	 );
	END COMPONENT;
	 
    signal tdata_1 : std_logic_vector (79 downto 0);
    signal tdata_2 : std_logic_vector (79 downto 0);
	 
	signal rdy : std_logic_vector(1 downto 0);
	
	signal modulator_increment : std_logic_vector(35 downto 0) := (others => '0');
	signal modulator_out : std_logic_vector(15 downto 0):= (others => '0');
	signal carrier_increment : std_logic_vector(35 downto 0) := (others => '0');
	signal carrier_offset : std_logic_vector(35 downto 0):= (others => '0');
	
	signal sine : std_logic_vector(15 downto 0) := (others => '0');
	
	signal carrier_freq_new : std_logic_vector(35 downto 0) := "000000000000000000101001110000100100";
	
	signal MODULATION_IDX : unsigned(6 downto 0);
	
begin
	U1: dds_compiler_0 PORT MAP (
          aclk => clk,
          s_axis_phase_tvalid => '1',
          s_axis_phase_tdata => tdata_1,
          m_axis_data_tvalid => rdy(0),
          m_axis_data_tdata => modulator_out
        );
    tdata_1 <= "0000" & (75 downto 40 => '0') & "0000" & modulator_increment;
    
    U2: dds_compiler_0 PORT MAP (
          aclk => clk,
          s_axis_phase_tvalid => '1',
          s_axis_phase_tdata => tdata_2,
          m_axis_data_tvalid => rdy(1),
          m_axis_data_tdata => sine
        );
    tdata_2 <= "0000" & carrier_offset & "0000" & carrier_increment;
	
	U3: MIDI_NOTE_PARSER PORT MAP (
			 MIDI_NOTE => FM_MIDI_NOTE_In,
			 FREQUENCY => carrier_freq_new
	     );
	
	--x(t) = sin(w_carrier*t+sin(w_modulator*t))

	modulator_increment <= carrier_freq_new(34 downto 0) & '0';
	carrier_increment <= carrier_freq_new;

	process(clk)
	begin
		if(rising_edge(clk) and rdy = "11") then
				--carrier_offset <= std_logic_vector(signed(modulator_out)+to_signed(32768,modulator_out'length)) & (carrier_offset'high - modulator_out'high -1 downto 0 => '0');
				carrier_offset <= std_logic_vector( to_unsigned(to_integer(MODULATION_IDX) * (to_integer(signed(modulator_out))+32768),24) ) & (11 downto 0 => '0');
		end if;
	end process;
	
	FM_Out <= sine when rdy="11"
				 else (others => '0');

    MODULATION_IDX <= unsigned(MODULATION_IDX_CC);
end Behavioral;


