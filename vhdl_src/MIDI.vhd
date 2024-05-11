
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIDI is
    Port ( CLK : in  STD_LOGIC;
        MIDI_IN : in  STD_LOGIC;
			  
		CHANNEL : out STD_LOGIC_VECTOR(3 downto 0);
			  
        NOTE_NUMBER : out STD_LOGIC_VECTOR(6 downto 0);
		VELOCITY : out STD_LOGIC_VECTOR(6 downto 0); --a note off is 0 velocity
		NOTE_CHANGE : out STD_LOGIC;
			  
		CONTROLLER_NUMBER  : out  STD_LOGIC_VECTOR(6 downto 0);
        CONTROLLER_VALUE : out  STD_LOGIC_VECTOR(6 downto 0);
		CONTROLLER_CHANGE : out STD_LOGIC);
end MIDI;

architecture Behavioral of MIDI is
	COMPONENT UART
    PORT(
         CLK : IN  std_logic;
         UART_RX : IN  std_logic;
         UART_BYTE_RX : OUT  std_logic_vector(7 downto 0);
         UART_RECEIVED : OUT  std_logic
        );
    END COMPONENT;
	 
	 procedure reset_change_outs (signal OUT1 : OUT std_logic;
											signal OUT2 : OUT std_logic) is
	 begin
		OUT1 <= '0';
		OUT2 <= '0';
	 end procedure;
	 
	 signal NOTE_CHANGEs : std_logic := '0';
	 signal CONTROLLER_NUMBERs  : std_logic_vector(6 downto 0) := (others => '0');
	 signal CONTROLLER_VALUEs : std_logic_vector(6 downto 0) := (others => '0');
	 signal CONTROLLER_CHANGEs : std_logic := '0';
	 signal NOTE_NUMBERs : std_logic_vector(6 downto 0) := "1000101";
	 signal CHANNELs : std_logic_vector(3 downto 0) := (others => '0');
	 signal VELOCITYs : std_logic_vector(6 downto 0) := (others => '0');
	 
	 signal message : std_logic_vector(7 downto 0) := (others => '0');
	 signal UART_message : std_logic := '0';
	 signal new_message : std_logic := '0';
	 
	 signal last_status_message : std_logic_vector(7 downto 0) := (others => '0');
	 signal number_of_data_bytes : integer := 0; --the number of databytes required for the last message
	 signal data_bytes_received : integer := 0; --this will work as a counter to know which data byte we should be parsing
	 
begin
	uut: UART
	   PORT MAP (
          CLK => CLK,
          UART_RX => MIDI_IN,
          UART_BYTE_RX => message,
          UART_RECEIVED => UART_message
        );
		  
	new_message_process : process(UART_message)
	begin
		if(rising_edge(UART_message)) then
			if(message(7) = '1') then  --if it's a new status message we simply store it in the last_status_message
				last_status_message <= message;
				
				case message(7 downto 4) is --set the number of data bytes appropriate for the type of message
 					when x"C"|x"D" => 
						number_of_data_bytes <= 1;
						CHANNELs <= message(3 downto 0); --set the channel appropriately
					when x"F" => --System 
						--number of bytes is variable
					when others => 
						number_of_data_bytes <= 2;
						CHANNELs <= message(3 downto 0); --set the channel appropriately
				end case;
				data_bytes_received <= 0;
				
			else --this means we received a data byte
				case last_status_message(7 downto 4) is --the way we parse the data byte depends on the type of message of the last status message
					when x"8" => --NOTE OFF						
						if(data_bytes_received = 0) then
							NOTE_NUMBERs <= message(6 downto 0);
							data_bytes_received <=  1;
						else 
							VELOCITYs <= (others => '0');
							data_bytes_received <=  0; --resetting data bytes here allows for  the next byte to be a note off data byte without having to resend the status byte (MIDI protocol)
							NOTE_CHANGEs <= '1';
						end if;
						
					when x"9" =>  --NOTE ON					
						if(data_bytes_received = 0) then
							NOTE_NUMBERs <= message(6 downto 0);
							data_bytes_received <=  1;
						else 
							VELOCITYs <= message(6 downto 0);
							data_bytes_received <=  0;
							NOTE_CHANGEs <= '1';
						end if;
						
					when x"A" => --NOT IMPLEMENTED
					when x"B" => 
						if(data_bytes_received = 0) then 
							CONTROLLER_NUMBERs <= message(6 downto 0);
							data_bytes_received <= 1;
						else
							CONTROLLER_VALUEs <= message(6 downto 0);
							data_bytes_received <= 0;
							CONTROLLER_CHANGEs <= '1';
						end if;
						
					when x"C" => --NOT IMPLEMENTED
					when x"D" => --NOT IMPLEMENTED
					when x"E" => --NOT IMPLEMENTED
					when x"F" => --NOT IMPLEMENTED
					when others => 
				end case;
			end if;
			
			if(data_bytes_received = 0) then
				reset_change_outs(NOTE_CHANGEs, CONTROLLER_CHANGEs);
			end if;
			
		end if;
	end process;
    
    CHANNEL <= CHANNELs;
	NOTE_NUMBER <= NOTE_NUMBERs;
	NOTE_CHANGE <=  NOTE_CHANGEs;
	VELOCITY <= VELOCITYs;
	CONTROLLER_CHANGE <=  CONTROLLER_CHANGEs;
	CONTROLLER_NUMBER <= CONTROLLER_NUMBERs;
	CONTROLLER_VALUE <= CONTROLLER_VALUEs;
end Behavioral;

