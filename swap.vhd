LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Il generatore di numeri casuali genera due numeri tra 0 e 7
-- 5/6/7 vengono sostituiti con numeri tra 0 e 4 (nel range di interesse, posizioni da 0 a 4)
-- Partendo da un vettore in decimale "01234" i numeri casuali generati sono le posizioni da scambiare in questo vettore
-- Così facendo non avrò mai ripetizioni dei numeri all'interno del vettore delle posizioni
-- Se capitano due numeri uguali le cifre non si scambiano

ENTITY swap IS
	PORT(
	rand_stream1: in std_logic_vector(2 downto 0); -- posizione casuale 1
	rand_stream2: in std_logic_vector(2 downto 0); -- posizione casuale 2
	flag : in std_logic; -- flag per interrompere la generazione di numeri casuali
	clk : in std_logic; -- clock
	
	pos_vet0_out: out std_logic_vector(2 downto 0); -- posizione della password sul led 0
	pos_vet1_out: out std_logic_vector(2 downto 0); -- posizione della password sul led 1
	pos_vet2_out: out std_logic_vector(2 downto 0); -- posizione della password sul led 2
	pos_vet3_out: out std_logic_vector(2 downto 0); -- posizione della password sul led 3
	pos_vet4_out: out std_logic_vector(2 downto 0) -- posizione della password sul led 4
	);
END;

ARCHITECTURE arch_swap OF swap IS

SIGNAL rand_stream1_sig: std_logic_vector(2 downto 0); -- signal di appoggio
SIGNAL rand_stream2_sig: std_logic_vector(2 downto 0); -- signal di appoggio
-- vettori signal inizializzati a "01234"
SIGNAL pos_vet0_sig: std_logic_vector(2 downto 0) := "000";
SIGNAL pos_vet1_sig: std_logic_vector(2 downto 0) := "001";
SIGNAL pos_vet2_sig: std_logic_vector(2 downto 0) := "010";
SIGNAL pos_vet3_sig: std_logic_vector(2 downto 0) := "011";
SIGNAL pos_vet4_sig: std_logic_vector(2 downto 0) := "100";

BEGIN
	PROCESS (flag) IS
	begin
	-- se flag è 0 non è richiesta la visualizzazione, continuo con gli scambi
		if (flag = '0') then
			-- assegno il valore dell'input al signal per poterlo operare
			-- se capito nei casi 5/6/7 sostituisco il numero con un altro
			-- in ogni caso nell'else finale lo sostituisco
			IF rand_stream1 = "101" then -- 5
				rand_stream1_sig <= "000";
			elsif rand_stream1 = "110" then -- 6
				rand_stream1_sig <= "010";
			elsif rand_stream1 = "111" then -- 7
				rand_stream1_sig <= "100";
			else
				rand_stream1_sig <= rand_stream1; -- negli altri casi assegno comunque l'input al signal
			end if;
			
			-- uguale per rand_stream2
			IF rand_stream2 = "101" then
				rand_stream2_sig <= "001";
			elsif rand_stream2 = "110" then
				rand_stream2_sig <= "011";
			elsif rand_stream2 = "111" then
				rand_stream2_sig <= "010";
			else
				rand_stream2_sig <= rand_stream2;
			end if;
			
			-- SWAP

			IF rand_stream1_sig = "000" THEN --scambio 0 e altri
				
				IF rand_stream2_sig = "001" THEN
					pos_vet1_sig <= pos_vet0_sig;
					pos_vet0_sig <= pos_vet1_sig;
				ELSIF rand_stream2 = "010" THEN
					pos_vet2_sig <= pos_vet0_sig;
					pos_vet0_sig <= pos_vet2_sig;
				ELSIF rand_stream2 = "011" THEN
					pos_vet3_sig <= pos_vet0_sig;
					pos_vet0_sig <= pos_vet3_sig;
				ELSIF rand_stream2 = "100" THEN
					pos_vet4_sig <= pos_vet0_sig;
					pos_vet0_sig <= pos_vet4_sig;
				END IF;
				
			ELSIF rand_stream1_sig = "001" THEN --scambio 1 e altri
				
				IF rand_stream2_sig = "000" THEN
					pos_vet0_sig <= pos_vet1_sig;
					pos_vet1_sig <= pos_vet0_sig;
				ELSIF rand_stream2_sig = "010" THEN
					pos_vet2_sig <= pos_vet1_sig;
					pos_vet1_sig <= pos_vet2_sig;
				ELSIF rand_stream2_sig = "011" THEN
					pos_vet3_sig <= pos_vet1_sig;
					pos_vet1_sig <= pos_vet3_sig;
				ELSIF rand_stream2_sig = "100" THEN
					pos_vet4_sig <= pos_vet1_sig;
					pos_vet1_sig <= pos_vet4_sig;
				END IF;
				
			ELSIF rand_stream1_sig = "010" THEN --scambio 2 con gli altri
				
				IF rand_stream2_sig = "000" THEN
					pos_vet0_sig <= pos_vet2_sig;
					pos_vet2_sig <= pos_vet0_sig;
				ELSIF rand_stream2_sig = "001" THEN
					pos_vet1_sig <= pos_vet2_sig;
					pos_vet2_sig <= pos_vet1_sig;
				ELSIF rand_stream2_sig = "011" THEN
					pos_vet3_sig <= pos_vet2_sig;
					pos_vet2_sig <= pos_vet3_sig;
				ELSIF rand_stream2_sig = "100" THEN
					pos_vet4_sig <= pos_vet2_sig;
					pos_vet2_sig <= pos_vet4_sig;
				END IF;
				
			ELSIF rand_stream1_sig = "011" THEN --scambio 3 con gli altri
				
				IF rand_stream2_sig = "000" THEN
					pos_vet0_sig <= pos_vet3_sig;
					pos_vet3_sig <= pos_vet0_sig;
				ELSIF rand_stream2_sig = "001" THEN
					pos_vet1_sig <= pos_vet3_sig;
					pos_vet3_sig <= pos_vet1_sig;
					--pos_vet1_sig <= n1;
				ELSIF rand_stream2_sig = "010" THEN
					pos_vet2_sig <= pos_vet3_sig;
					pos_vet3_sig <= pos_vet2_sig;
				ELSIF rand_stream2_sig = "100" THEN
					pos_vet4_sig <= pos_vet3_sig;
					pos_vet3_sig <= pos_vet4_sig;
				END IF;
				
			ELSIF rand_stream1_sig = "100" THEN --scambio 4 con gli altri
				
				IF rand_stream2_sig = "000" THEN
					pos_vet0_sig <= pos_vet4_sig;
					pos_vet4_sig <= pos_vet0_sig;
				ELSIF rand_stream2_sig = "001" THEN
					pos_vet1_sig <= pos_vet4_sig;
					pos_vet4_sig <= pos_vet1_sig;
				ELSIF rand_stream2_sig = "010" THEN
					pos_vet2_sig <= pos_vet4_sig;
					pos_vet4_sig <= pos_vet2_sig;
				ELSIF rand_stream2_sig = "011" THEN
					pos_vet3_sig <= pos_vet4_sig;
					pos_vet4_sig <= pos_vet3_sig;
				END IF;
			END IF;
		
		-- altrimenti sul fronte di salita del flag, salvo i segnali nelle variabili di uscita
		elsif (rising_edge(flag)) then 
		
			pos_vet0_out <= pos_vet0_sig;
			pos_vet1_out <= pos_vet1_sig;
			pos_vet2_out <= pos_vet2_sig;
			pos_vet3_out <= pos_vet3_sig;
			pos_vet4_out <= pos_vet4_sig;
			
		end if;
END PROCESS;

END;