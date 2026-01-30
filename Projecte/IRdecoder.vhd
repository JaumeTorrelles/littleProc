-- include de les llibreries per treballar recomanades
library ieee;
use ieee.std_logic_1164.all;

-- definicio entitat IRdecoder
entity IRdecoder is
    port (
        opcode : in std_logic_vector(3 downto 0); -- vol dir entrada de de 4 bits
        initAddress : out std_logic_vector(7 downto 0) -- vol dir sortida 8 bits
    );
end entity;

-- definim com es comporta el IRdecoder
architecture behavior of IRdecoder is
	-- truco per mantenir senyal per despres de compilacio!
	attribute keep: boolean;
	attribute keep of initAddress: signal is true;
begin
	-- definim un process amb entrada opcode
	process (opcode)
	begin
		-- sortida segons el valor opcode
		case opcode is
			when "0000" => initAddress <= "00001000";
			when "0001" => initAddress <= "00001101";
			when "0010" => initAddress <= "00010010";
            when "0011" => initAddress <= "00010101";
            when "0100" => initAddress <= "00011001";
            when "0101" => initAddress <= "00011100";
            when "0110" => initAddress <= "00011111";
            when "0111" => initAddress <= "00100001";
            when "1000" => initAddress <= "00101000";
            when "1001" => initAddress <= "00000111";
            when "1010" => initAddress <= "00100100";
            when others => initAddress <= "00000000";  -- redundant
        end case;
    end process;
end architecture;
