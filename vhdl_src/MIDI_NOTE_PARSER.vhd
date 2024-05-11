
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity MIDI_NOTE_PARSER is
    Port ( MIDI_NOTE : in  STD_LOGIC_VECTOR (6 downto 0);
           FREQUENCY : out  STD_LOGIC_VECTOR (35 downto 0));
end MIDI_NOTE_PARSER;

architecture Behavioral of MIDI_NOTE_PARSER is

begin
	FREQUENCY <=     std_logic_vector( to_unsigned(5618,36) ) when MIDI_NOTE = "0000000" else
                     std_logic_vector( to_unsigned(5952,36) ) when MIDI_NOTE = "0000001" else
                     std_logic_vector( to_unsigned(6306,36) ) when MIDI_NOTE = "0000010" else
                     std_logic_vector( to_unsigned(6681,36) ) when MIDI_NOTE = "0000011" else
                     std_logic_vector( to_unsigned(7079,36) ) when MIDI_NOTE = "0000100" else
                     std_logic_vector( to_unsigned(7500,36) ) when MIDI_NOTE = "0000101" else
                     std_logic_vector( to_unsigned(7946,36) ) when MIDI_NOTE = "0000110" else
                     std_logic_vector( to_unsigned(8418,36) ) when MIDI_NOTE = "0000111" else
                     std_logic_vector( to_unsigned(8919,36) ) when MIDI_NOTE = "0001000" else
                     std_logic_vector( to_unsigned(9449,36) ) when MIDI_NOTE = "0001001" else
                     std_logic_vector( to_unsigned(10011,36) ) when MIDI_NOTE = "0001010" else
                     std_logic_vector( to_unsigned(10606,36) ) when MIDI_NOTE = "0001011" else
                     std_logic_vector( to_unsigned(11237,36) ) when MIDI_NOTE = "0001100" else
                     std_logic_vector( to_unsigned(11905,36) ) when MIDI_NOTE = "0001101" else
                     std_logic_vector( to_unsigned(12613,36) ) when MIDI_NOTE = "0001110" else
                     std_logic_vector( to_unsigned(13363,36) ) when MIDI_NOTE = "0001111" else
                     std_logic_vector( to_unsigned(14157,36) ) when MIDI_NOTE = "0010000" else
                     std_logic_vector( to_unsigned(14999,36) ) when MIDI_NOTE = "0010001" else
                     std_logic_vector( to_unsigned(15891,36) ) when MIDI_NOTE = "0010010" else
                     std_logic_vector( to_unsigned(16836,36) ) when MIDI_NOTE = "0010011" else
                     std_logic_vector( to_unsigned(17837,36) ) when MIDI_NOTE = "0010100" else
                     std_logic_vector( to_unsigned(18898,36) ) when MIDI_NOTE = "0010101" else
                     std_logic_vector( to_unsigned(20022,36) ) when MIDI_NOTE = "0010110" else
                     std_logic_vector( to_unsigned(21212,36) ) when MIDI_NOTE = "0010111" else
                     std_logic_vector( to_unsigned(22473,36) ) when MIDI_NOTE = "0011000" else
                     std_logic_vector( to_unsigned(23810,36) ) when MIDI_NOTE = "0011001" else
                     std_logic_vector( to_unsigned(25226,36) ) when MIDI_NOTE = "0011010" else
                     std_logic_vector( to_unsigned(26726,36) ) when MIDI_NOTE = "0011011" else
                     std_logic_vector( to_unsigned(28315,36) ) when MIDI_NOTE = "0011100" else
                     std_logic_vector( to_unsigned(29998,36) ) when MIDI_NOTE = "0011101" else
                     std_logic_vector( to_unsigned(31782,36) ) when MIDI_NOTE = "0011110" else
                     std_logic_vector( to_unsigned(33672,36) ) when MIDI_NOTE = "0011111" else
                     std_logic_vector( to_unsigned(35674,36) ) when MIDI_NOTE = "0100000" else
                     std_logic_vector( to_unsigned(37796,36) ) when MIDI_NOTE = "0100001" else
                     std_logic_vector( to_unsigned(40043,36) ) when MIDI_NOTE = "0100010" else
                     std_logic_vector( to_unsigned(42424,36) ) when MIDI_NOTE = "0100011" else
                     std_logic_vector( to_unsigned(44947,36) ) when MIDI_NOTE = "0100100" else
                     std_logic_vector( to_unsigned(47620,36) ) when MIDI_NOTE = "0100101" else
                     std_logic_vector( to_unsigned(50451,36) ) when MIDI_NOTE = "0100110" else
                     std_logic_vector( to_unsigned(53451,36) ) when MIDI_NOTE = "0100111" else
                     std_logic_vector( to_unsigned(56630,36) ) when MIDI_NOTE = "0101000" else
                     std_logic_vector( to_unsigned(59997,36) ) when MIDI_NOTE = "0101001" else
                     std_logic_vector( to_unsigned(63565,36) ) when MIDI_NOTE = "0101010" else
                     std_logic_vector( to_unsigned(67344,36) ) when MIDI_NOTE = "0101011" else
                     std_logic_vector( to_unsigned(71349,36) ) when MIDI_NOTE = "0101100" else
                     std_logic_vector( to_unsigned(75591,36) ) when MIDI_NOTE = "0101101" else
                     std_logic_vector( to_unsigned(80086,36) ) when MIDI_NOTE = "0101110" else
                     std_logic_vector( to_unsigned(84849,36) ) when MIDI_NOTE = "0101111" else
                     std_logic_vector( to_unsigned(89894,36) ) when MIDI_NOTE = "0110000" else
                     std_logic_vector( to_unsigned(95239,36) ) when MIDI_NOTE = "0110001" else
                     std_logic_vector( to_unsigned(100902,36) ) when MIDI_NOTE = "0110010" else
                     std_logic_vector( to_unsigned(106902,36) ) when MIDI_NOTE = "0110011" else
                     std_logic_vector( to_unsigned(113259,36) ) when MIDI_NOTE = "0110100" else
                     std_logic_vector( to_unsigned(119994,36) ) when MIDI_NOTE = "0110101" else
                     std_logic_vector( to_unsigned(127129,36) ) when MIDI_NOTE = "0110110" else
                     std_logic_vector( to_unsigned(134689,36) ) when MIDI_NOTE = "0110111" else
                     std_logic_vector( to_unsigned(142698,36) ) when MIDI_NOTE = "0111000" else
                     std_logic_vector( to_unsigned(151183,36) ) when MIDI_NOTE = "0111001" else
                     std_logic_vector( to_unsigned(160173,36) ) when MIDI_NOTE = "0111010" else
                     std_logic_vector( to_unsigned(169697,36) ) when MIDI_NOTE = "0111011" else
                     std_logic_vector( to_unsigned(179788,36) ) when MIDI_NOTE = "0111100" else
                     std_logic_vector( to_unsigned(190478,36) ) when MIDI_NOTE = "0111101" else
                     std_logic_vector( to_unsigned(201805,36) ) when MIDI_NOTE = "0111110" else
                     std_logic_vector( to_unsigned(213805,36) ) when MIDI_NOTE = "0111111" else
                     std_logic_vector( to_unsigned(226518,36) ) when MIDI_NOTE = "1000000" else
                     std_logic_vector( to_unsigned(239988,36) ) when MIDI_NOTE = "1000001" else
                     std_logic_vector( to_unsigned(254258,36) ) when MIDI_NOTE = "1000010" else
                     std_logic_vector( to_unsigned(269377,36) ) when MIDI_NOTE = "1000011" else
                     std_logic_vector( to_unsigned(285395,36) ) when MIDI_NOTE = "1000100" else
                     std_logic_vector( to_unsigned(302366,36) ) when MIDI_NOTE = "1000101" else
                     std_logic_vector( to_unsigned(320345,36) ) when MIDI_NOTE = "1000110" else
                     std_logic_vector( to_unsigned(339394,36) ) when MIDI_NOTE = "1000111" else
                     std_logic_vector( to_unsigned(359575,36) ) when MIDI_NOTE = "1001000" else
                     std_logic_vector( to_unsigned(380957,36) ) when MIDI_NOTE = "1001001" else
                     std_logic_vector( to_unsigned(403610,36) ) when MIDI_NOTE = "1001010" else
                     std_logic_vector( to_unsigned(427610,36) ) when MIDI_NOTE = "1001011" else
                     std_logic_vector( to_unsigned(453037,36) ) when MIDI_NOTE = "1001100" else
                     std_logic_vector( to_unsigned(479976,36) ) when MIDI_NOTE = "1001101" else
                     std_logic_vector( to_unsigned(508516,36) ) when MIDI_NOTE = "1001110" else
                     std_logic_vector( to_unsigned(538754,36) ) when MIDI_NOTE = "1001111" else
                     std_logic_vector( to_unsigned(570790,36) ) when MIDI_NOTE = "1010000" else
                     std_logic_vector( to_unsigned(604731,36) ) when MIDI_NOTE = "1010001" else
                     std_logic_vector( to_unsigned(640691,36) ) when MIDI_NOTE = "1010010" else
                     std_logic_vector( to_unsigned(678788,36) ) when MIDI_NOTE = "1010011" else
                     std_logic_vector( to_unsigned(719151,36) ) when MIDI_NOTE = "1010100" else
                     std_logic_vector( to_unsigned(761914,36) ) when MIDI_NOTE = "1010101" else
                     std_logic_vector( to_unsigned(807220,36) ) when MIDI_NOTE = "1010110" else
                     std_logic_vector( to_unsigned(855219,36) ) when MIDI_NOTE = "1010111" else
                     std_logic_vector( to_unsigned(906073,36) ) when MIDI_NOTE = "1011000" else
                     std_logic_vector( to_unsigned(959951,36) ) when MIDI_NOTE = "1011001" else
                     std_logic_vector( to_unsigned(1017033,36) ) when MIDI_NOTE = "1011010" else
                     std_logic_vector( to_unsigned(1077509,36) ) when MIDI_NOTE = "1011011" else
                     std_logic_vector( to_unsigned(1141581,36) ) when MIDI_NOTE = "1011100" else
                     std_logic_vector( to_unsigned(1209463,36) ) when MIDI_NOTE = "1011101" else
                     std_logic_vector( to_unsigned(1281381,36) ) when MIDI_NOTE = "1011110" else
                     std_logic_vector( to_unsigned(1357576,36) ) when MIDI_NOTE = "1011111" else
                     std_logic_vector( to_unsigned(1438302,36) ) when MIDI_NOTE = "1100000" else
                     std_logic_vector( to_unsigned(1523828,36) ) when MIDI_NOTE = "1100001" else
                     std_logic_vector( to_unsigned(1614439,36) ) when MIDI_NOTE = "1100010" else
                     std_logic_vector( to_unsigned(1710439,36) ) when MIDI_NOTE = "1100011" else
                     std_logic_vector( to_unsigned(1812147,36) ) when MIDI_NOTE = "1100100" else
                     std_logic_vector( to_unsigned(1919903,36) ) when MIDI_NOTE = "1100101" else
                     std_logic_vector( to_unsigned(2034066,36) ) when MIDI_NOTE = "1100110" else
                     std_logic_vector( to_unsigned(2155018,36) ) when MIDI_NOTE = "1100111" else
                     std_logic_vector( to_unsigned(2283162,36) ) when MIDI_NOTE = "1101000" else
                     std_logic_vector( to_unsigned(2418926,36) ) when MIDI_NOTE = "1101001" else
                     std_logic_vector( to_unsigned(2562762,36) ) when MIDI_NOTE = "1101010" else
                     std_logic_vector( to_unsigned(2715152,36) ) when MIDI_NOTE = "1101011" else
                     std_logic_vector( to_unsigned(2876604,36) ) when MIDI_NOTE = "1101100" else
                     std_logic_vector( to_unsigned(3047655,36) ) when MIDI_NOTE = "1101101" else
                     std_logic_vector( to_unsigned(3228878,36) ) when MIDI_NOTE = "1101110" else
                     std_logic_vector( to_unsigned(3420877,36) ) when MIDI_NOTE = "1101111" else
                     std_logic_vector( to_unsigned(3624293,36) ) when MIDI_NOTE = "1110000" else
                     std_logic_vector( to_unsigned(3839805,36) ) when MIDI_NOTE = "1110001" else
                     std_logic_vector( to_unsigned(4068132,36) ) when MIDI_NOTE = "1110010" else
                     std_logic_vector( to_unsigned(4310035,36) ) when MIDI_NOTE = "1110011" else
                     std_logic_vector( to_unsigned(4566323,36) ) when MIDI_NOTE = "1110100" else
                     std_logic_vector( to_unsigned(4837851,36) ) when MIDI_NOTE = "1110101" else
                     std_logic_vector( to_unsigned(5125525,36) ) when MIDI_NOTE = "1110110" else
                     std_logic_vector( to_unsigned(5430304,36) ) when MIDI_NOTE = "1110111" else
                     std_logic_vector( to_unsigned(5753207,36) ) when MIDI_NOTE = "1111000" else
                     std_logic_vector( to_unsigned(6095311,36) ) when MIDI_NOTE = "1111001" else
                     std_logic_vector( to_unsigned(6457757,36) ) when MIDI_NOTE = "1111010" else
                     std_logic_vector( to_unsigned(6841755,36) ) when MIDI_NOTE = "1111011" else
                     std_logic_vector( to_unsigned(7248587,36) ) when MIDI_NOTE = "1111100" else
                     std_logic_vector( to_unsigned(7679610,36) ) when MIDI_NOTE = "1111101" else
                     std_logic_vector( to_unsigned(8136263,36) ) when MIDI_NOTE = "1111110" else
                     std_logic_vector( to_unsigned(8620071,36) ) when MIDI_NOTE = "1111111" else
					 (others => '0');
	
end Behavioral;

