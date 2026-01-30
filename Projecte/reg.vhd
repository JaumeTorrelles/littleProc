-- include de les llibreries per treballar recomanades
library ieee;
use ieee.std_logic_1164.all;

-- definicio entitat reg
entity reg is
    port (
        asynResetn : in std_logic; -- reset actiu a baixa
        ck : in std_logic; -- rellotge actiu per flanc de pujada
        load : in std_logic; -- load normal com a teoria
        datain : in std_logic_vector(11 downto 0); -- vol dir entrada de 12 bits
        dataout : out std_logic_vector(11 downto 0) -- vol dir sortida de 12 bits
    );
end entity;

-- definim com es comporta el reg
architecture behavior of reg is
    -- senyal (intern) per guardar el valor del registre
    signal reg_data : std_logic_vector(11 downto 0);

	-- truco per mantenir senyal per despres de compilacio!
    attribute keep: boolean;
    attribute keep of reg_data: signal is true;
begin
    -- proces amb entrades: rellotge i reset
    process (ck, asynResetn)
    begin
        if asynResetn = '0' then
            -- si reset actiu (baix) -> reg = 0
            reg_data <= (others => '0');
        elsif rising_edge(ck) then
            -- si hi ha flanc de rellotge + load actiu (alt): reg = datain
            if load = '1' then
                reg_data <= datain;
            end if;
        end if;
    end process;

    -- enviar el resultat (reg_data) per sortida (dataout)
    dataout <= reg_data;
end architecture;
