
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART is
    Generic ( CLOCK_FREQUENCY : integer := 100_000_000;
              BAUD_RATE : integer := 31_250 
    );
    Port ( CLK : in STD_LOGIC;
		   UART_RX : in  STD_LOGIC;
           UART_BYTE_RX : out  STD_LOGIC_VECTOR (7 downto 0);
           UART_RECEIVED : out  STD_LOGIC);
end UART;

architecture Behavioral of UART is

	signal receiving_byte : std_logic := '0';
	signal index : integer := 0;
	signal byte : std_logic_vector (7 downto 0) := (others => '0');
	signal counter : integer := 1;
	signal UART_DONE : std_logic := '0';
	
	--FPGA clock is 100MHZ; 31250 baud rate; 100000000/31250=3200
	constant clock_per_bit : integer := CLOCK_FREQUENCY/BAUD_RATE;
	
begin
	UART_process : process(clk)
	begin
		if rising_edge(clk) then 
			if UART_RX = '0' and receiving_byte = '0' then
				receiving_byte <= '1'; --start bit detected
				counter <= clock_per_bit + clock_per_bit/2; --we need to wait for a time equivelent to 1.5 bits
				index <= 0;
				UART_DONE <= '0';
			end if;
			
			if receiving_byte = '1' then
				if counter = 0 and index < 8 then --read bit into vector
					byte(index) <= UART_RX; --store bit into vector
					counter <= clock_per_bit; --reinitialize counter
					index <= index + 1;
				elsif counter = 0 and index = 8 then --stop bit
					receiving_byte <= '0'; --finished reading byte reset
					if UART_RX = '1' then --if stop bit is read, then we have no framing errors
						UART_DONE <= '1';  --ignores the byte we received unless stop bit is '1'
					end if;
				else
					counter <= counter - 1;
				end if;
			end if;
		end if;
	end process;
	
	UART_RECEIVED <= UART_DONE;
	UART_BYTE_RX <= byte;
end Behavioral;

