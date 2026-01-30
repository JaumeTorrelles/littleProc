-- include de les llibreries per treballar recomanades
library ieee;
use ieee.std_logic_1164.all;

-- definicio entitat PC
entity PC is
    port (
        asynResetn : in std_logic; -- reset actiu a baixa
        ck : in std_logic; -- rellotge actiu per flanc de pujada
        init : in std_logic; -- senyal inicialitzacio (init)
        load : in std_logic; -- load normal com a teoria
        datain : in std_logic_vector(11 downto 0); -- vol dir entrada de 12 bits
        dataout : out std_logic_vector(11 downto 0) -- vol dir sortida de 12 bits
    );
end entity;

-- definim com es comporta el PC
architecture behavior of PC is
    -- senyal (intern) per guardar el valor del PC
    signal pc_data : std_logic_vector(11 downto 0);
    
    -- truco per mantenir senyal per despres de compilacio!
    attribute keep: boolean;
    attribute keep of pc_data: signal is true;
begin
    -- proces amb entrades: rellotge i reset
    process (ck, asynResetn)
    begin
        if asynResetn = '0' then
            -- si reset actiu (baix) -> reg = 0
            pc_data <= (others => '0');
        elsif rising_edge(ck) then
            if load = '1' then
                if init = '1' then
                    -- si hi ha flanc de rellotge + load actiu (alt) + init actiu (alt): pc = init
                    pc_data <= "000000000110"; -- init del  nostre grup 6
                else
                    -- si hi ha flanc de rellotge + load actiu (alt) + init no actiu (baix): pc = datain
                    pc_data <= datain;
                end if;
            end if;
        end if;
    end process;

    -- enviar el resultat (pc_data) per sortida (dataout)
    dataout <= pc_data;
end architecture;