----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2024 10:33:41 PM
-- Design Name: 
-- Module Name: main - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( CLK : in STD_LOGIC;
           AUDIO_CLK : in STD_LOGIC;
           MIDI_IN : in STD_LOGIC;
           AUDIO_OUT : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           
           DEBUG_OUT : out STD_LOGIC);
end main;

architecture Behavioral of main is

    COMPONENT FM_Module
    PORT ( 
        CLK : in  STD_LOGIC;
		FM_MIDI_NOTE_In : in STD_LOGIC_VECTOR (6 downto 0);
		MODULATION_IDX_CC : in STD_LOGIC_VECTOR(6 downto 0);
        FM_Out : out  STD_LOGIC_VECTOR (15 downto 0));
    END COMPONENT;
    
    -- FM signals
    signal FM_OUTPUT : std_logic_vector(15 downto 0) := (others => '0');
    constant MODULATION_IDX_CC : natural range 0 to 127 := 72;
    
    COMPONENT MIDI
    PORT(
         CLK : IN  std_logic;
         MIDI_IN : IN  std_logic;
         CHANNEL : OUT  std_logic_vector(3 downto 0);
         NOTE_NUMBER : OUT  std_logic_vector(6 downto 0);
         VELOCITY : OUT  std_logic_vector(6 downto 0);
         NOTE_CHANGE : OUT  std_logic;
         CONTROLLER_NUMBER : OUT  std_logic_vector(6 downto 0);
         CONTROLLER_VALUE : OUT  std_logic_vector(6 downto 0);
         CONTROLLER_CHANGE : OUT  std_logic
        );
    END COMPONENT;
    
    --MIDI signals
	type MIDI_mem is array(natural range <>) of std_logic_vector(6 downto 0);
	signal CC_mem : MIDI_mem(0 to 127) := (others=>(others => '1'));
	
	signal CONTROLLER_NUMBER : std_logic_vector(6 downto 0);
	signal CONTROLLER_VALUE : std_logic_vector(6 downto 0);
	signal CONTROLLER_CHANGE : std_logic;
	signal previous_controller_change_value : std_logic := '0';
	signal NOTE_NUMBER : std_logic_vector(6 downto 0);
	signal NOTE_NUMBER_t : std_logic_vector(6 downto 0) := (others => '0');
	signal NOTE_VELOCITY  : std_logic_vector(6 downto 0);
	signal NOTE_VELOCITY_t  : std_logic_vector(6 downto 0) := (others => '0');
	signal NOTE_CHANGE : std_logic;
	signal previous_note_change_value : std_logic := '0';
	
	constant VOLUME_CC : natural range 0 to 127 := 85;
	
	COMPONENT ANDREW_FILTER_FIXPT  
	PORT( 
		 clk                               :   IN    std_logic;
         reset                             :   IN    std_logic;
         clk_enable                        :   IN    std_logic;
         in_rsvd                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16
         MIDI_CC_FREQ                      :   IN    std_logic_vector(6 DOWNTO 0);  -- ufix7
         CC_RES                            :   IN    std_logic_vector(6 DOWNTO 0);  -- ufix7
         type_rsvd                         :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
         y                                 :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_E1
        );
	END COMPONENT;
	
	--Filter Signals
	signal FILTER_TYPE : std_logic_vector(1 downto 0) := "00";
	signal FILTER_INPUT : std_logic_vector(15 downto 0) := (others => '0');
	signal FILTER_OUTPUT : std_logic_vector(15 downto 0) := (others => '0');
	
	constant FILTER_FREQ_CC : natural range 0 to 127 := 73;
	constant FILTER_RES_CC  : natural range 0 to 127 := 74;
	
	COMPONENT GRAIN_MODULE
	PORT(
         CLK : in std_logic;
         AUDIO_CLK : in std_logic;
         NOTE_FREQ : in std_logic_vector(15 downto 0);
         AUDIO_IN : in signed(15 downto 0);
         AUDIO_OUT : out signed(15 downto 0);
         CC_GRAIN_DENSITY : in unsigned(6 downto 0);
         CC_GRAIN_SIZE : in unsigned(6 downto 0);
         CC_ATTACK : in unsigned(6 downto 0);
         CC_RELEASE : in unsigned(6 downto 0);
         CC_GAIN : in unsigned(6 downto 0)
        );
	END COMPONENT;
	--Grain Module Signals
	signal GRAIN_INPUT : signed(15 downto 0) := (others => '0');
	signal GRAIN_OUTPUT : signed(15 downto 0) := (others => '0');
	
	constant GRAIN_DENSITY_CC : natural range 0 to 127 := 75;
	constant GRAIN_SIZE_CC : natural range 0 to 127 := 76;
	constant GRAIN_ATTACK_CC : natural range 0 to 127 := 77;
	constant GRAIN_RELEASE_CC : natural range 0 to 127 := 78;
	constant GRAIN_GAIN_CC : natural range 0 to 127 := 81;
	
--	COMPONENT ASR_GEN_fixpt
--    PORT( CLK                             :   IN    std_logic;
--        rst                               :   IN    std_logic;
--        ce                                :   IN    std_logic;
--        ATTACK_CC                         :   IN    unsigned(6 DOWNTO 0);
--        RELEASE_CC                        :   IN    unsigned(6 DOWNTO 0);
--        MAX_ATTACK_MS                     :   IN    unsigned(9 DOWNTO 0);
--        MAX_RELEASE_MS                    :   IN    unsigned(9 DOWNTO 0);
--        CLK_FREQ                          :   IN    unsigned(26 DOWNTO 0);
--        NOTE_ON                           :   IN    std_logic;
--        ASR_IN                            :   IN    signed(15 DOWNTO 0);
--        ce_out                            :   OUT   std_logic;
--        ASR_OUT                           :   OUT   signed(15 DOWNTO 0)
--     );
--    END COMPONENT;
	--ASR Signals
	constant ATTACK_CC  : natural range 0 to 127 := 79;
	constant RELEASE_CC : natural range 0 to 127 := 80;
	constant MAX_ATTACK_MS  : std_logic_vector(9 downto 0) := "0111110100"; --Initialized with 500ms
	constant MAX_RELEASE_MS : std_logic_vector(9 downto 0) := "0111110100";
	constant CLK_FREQ : unsigned(26 downto 0) := "101111101011110000100000000";
	signal isNoteOn : std_logic := '0';
    signal WINDOW_INPUT  : signed(15 downto 0) := (others => '0');
    signal WINDOW_OUTPUT : signed(15 downto 0) := (others => '0');
	
	-- General signals
    signal AUDIO_BUS : std_logic_vector(15 downto 0) := (others => '0');
    
    signal cnt : integer := 0;
    signal note : std_logic_vector(6 downto 0) := "0100011";
    
begin
  
  U1: MIDI PORT MAP (
          CLK               => CLK,
          MIDI_IN           => MIDI_IN,
          CHANNEL           => open,
          NOTE_NUMBER       => NOTE_NUMBER,
          VELOCITY          => NOTE_VELOCITY,
          NOTE_CHANGE       => NOTE_CHANGE,
          CONTROLLER_NUMBER => CONTROLLER_NUMBER,
          CONTROLLER_VALUE  => CONTROLLER_VALUE,
          CONTROLLER_CHANGE => CONTROLLER_CHANGE
	);
	
	U2: FM_Module PORT MAP (
       CLK               => CLK,
	   FM_MIDI_NOTE_In   => NOTE_NUMBER_t,
       MODULATION_IDX_CC => CC_mem(MODULATION_IDX_CC),
       FM_Out            => FM_OUTPUT
    );
    
	U3: ANDREW_FILTER_FIXPT PORT MAP (
		 clk          => AUDIO_CLK,                  
         reset        => '0',                    
         clk_enable   => '1',                     
         in_rsvd      => FILTER_INPUT,                    
         MIDI_CC_FREQ => CC_mem(FILTER_FREQ_CC),                    
         CC_RES       => CC_mem(FILTER_RES_CC),                                        
         type_rsvd    => FILTER_TYPE,                    
         y            => FILTER_OUTPUT        
	);
	
	U4: GRAIN_MODULE PORT MAP (
	   CLK              => CLK,
       AUDIO_CLK        => AUDIO_CLK,
       NOTE_FREQ        => (others => '0'),
       AUDIO_IN         => GRAIN_INPUT,
       AUDIO_OUT        => GRAIN_OUTPUT,
       CC_GRAIN_DENSITY => unsigned(CC_mem(GRAIN_DENSITY_CC)),
       CC_GRAIN_SIZE    => unsigned(CC_mem(GRAIN_SIZE_CC)),
       CC_ATTACK        => unsigned(CC_mem(GRAIN_ATTACK_CC)),
       CC_RELEASE       => unsigned(CC_mem(GRAIN_RELEASE_CC)),
       CC_GAIN          => unsigned(CC_mem(GRAIN_GAIN_CC))
	);
	
--	U5: ASR_GEN_fixpt PORT MAP (
--	    CLK            => CLK,
--        rst            => '0',
--        ce             => '1',
--        ATTACK_CC      => unsigned(CC_mem(ATTACK_CC)),
--        RELEASE_CC     => unsigned(CC_mem(RELEASE_CC)),
--        MAX_ATTACK_MS  => unsigned(MAX_ATTACK_MS),
--        MAX_RELEASE_MS => unsigned(MAX_RELEASE_MS),
--        CLK_FREQ       => CLK_FREQ,
--        NOTE_ON        => isNoteOn,
--        ASR_IN         => WINDOW_INPUT,
--        ce_out         => open,
--        ASR_OUT        => WINDOW_OUTPUT
--    );

--MIDI LOGIC---------------------------------------------------------------------------------------------------------------------
	MIDI_CC_UPDATE: process(CLK)
	begin
	   if rising_edge(CLK) then
	       if CONTROLLER_CHANGE = '1' and previous_controller_change_value = '0' then
	           CC_mem(to_integer(unsigned(CONTROLLER_NUMBER))) <= CONTROLLER_VALUE;
	       end if;
	       previous_controller_change_value <= CONTROLLER_CHANGE;
	   end if;    	           
	end process;
	
	MIDI_NOTE_UPDATE: process(CLK)
	begin
	   if rising_edge(CLK) then
	       if NOTE_CHANGE = '1' and previous_note_change_value = '0' then
	           NOTE_NUMBER_t <= NOTE_NUMBER;
	           NOTE_VELOCITY_t <= NOTE_VELOCITY;
               if NOTE_VELOCITY = "0000000" then
                   isNoteOn <= '0';
               else
                   isNoteOn <= '1';
			   end if;
		   end if;
		   previous_note_change_value <= NOTE_CHANGE;
	   end if;
	end process;
--WINDOW LOGIC------------------------------------------------------------------------------------------------------------------
    
	
--INTERNAL AUDIO PATH------------------------------------------------------------------------------------------------------------
    UPDATE_AUDIO: process(CLK)
    begin
        if rising_edge(CLK) then
--            GRAIN_INPUT <= signed(FM_OUTPUT);
            
--            FILTER_INPUT <=  std_logic_vector( to_signed((to_integer(GRAIN_OUTPUT)*to_integer(unsigned('0' & NOTE_VELOCITY_t)))/128,16) );
--            FILTER_INPUT <= std_logic_vector(GRAIN_OUTPUT);
            --FILTER_INPUT <= FM_OUTPUT;
            
            --WINDOW_INPUT <= (signed(FILTER_OUTPUT) * signed(NOTE_VELOCITY) )/ to_signed(128,16);
--            WINDOW_INPUT <= signed(FILTER_OUTPUT);
            --AUDIO_OUT <= std_logic_vector( ((signed(FILTER_OUTPUT)*signed('0' & CC_mem(VOLUME_CC)))/to_signed(128,16)) + to_signed(32768,16) );
--            AUDIO_OUT <= std_logic_vector( WINDOW_OUTPUT );
            
            GRAIN_INPUT <= signed(FM_OUTPUT);
            FILTER_INPUT <=  std_logic_vector( to_signed((to_integer(GRAIN_OUTPUT)*to_integer(unsigned('0' & NOTE_VELOCITY_t)))/128,16) );
            AUDIO_OUT <= FILTER_OUTPUT;
            
            DEBUG_OUT <= isNoteOn;
        end if;
    end process;

end Behavioral;










