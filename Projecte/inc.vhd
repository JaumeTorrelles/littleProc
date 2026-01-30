-- include de les llibreries per treballar recomanades
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- definicio entitat inc
entity inc is
	port (
		A : in std_logic_vector(7 downto 0); -- vol dir entrada de 8 bits
		A_plus : out std_logic_vector(7 downto 0) -- vol dir sortida de 8 bits
	);
end entity;

-- definim com es comporta el incrementador
architecture behavior of inc is
	-- senyal (intern) per guardar el valor incrementat pq si fem vector es conta com a entrada
	-- i nosaltres no volem entrada ja que es un valor intern!!!
	signal A_int : unsigned(7 downto 0);
	
	-- truco per mantenir senyal per despres de compilacio!
	attribute keep: boolean;
	attribute keep of A_int: signal is true;
begin
	-- swapea entrada A a tipus unsigned li suma 1 i sela guarda a A_int
	A_int <= unsigned(A) + 1;
	
	-- swpea A_int a std_logic_vector per enviar el resultat per sortida A_plus
	A_plus <= std_logic_vector(A_int);
end architecture;
