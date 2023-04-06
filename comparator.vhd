LIBRARY ieee;
USE ieee.std_logic_1164.all; 

-- Comparatore per confrontare in maniera combinatoria la password inserita nell'ordine visualizzato sui display e la password vera

ENTITY comparator IS
	PORT(
	clk: in std_logic; -- clock
	flag: in std_logic; -- flag per interrompere la generazione dei numeri casuali e iniziare il confronto
	pos_vet0: in std_logic_vector(2 downto 0); -- posizione 0
	pos_vet1: in std_logic_vector(2 downto 0); -- posizione 1
	pos_vet2: in std_logic_vector(2 downto 0); -- posizione 2
	pos_vet3: in std_logic_vector(2 downto 0); -- posizione 3
	pos_vet4: in std_logic_vector(2 downto 0); -- posizione 4
	swt_pos: in std_logic_vector(4 downto 0); -- switch per la password inserita in maniera casuale

	led_true: out std_logic := '0'; -- led per la verifica della correttezza dell'inserimento della password mischiata
	led_pos: out std_logic_vector(4 downto 0) -- led rossi per gli switch su cui inserire la password mischiata
	);
END;

ARCHITECTURE arch_comparator OF comparator IS

SIGNAL done: std_logic_vector(4 downto 0); -- se la password mischiata è corretta la stringa passa da "00000" a "11111" (0->1 per ogni posizione inserita bene)

BEGIN

PROCESS (clk) IS -- O COUT 
	BEGIN
		
		-- inizializzo i led spenti, e la stringa di controllo a 0
		led_true <= '0';
		done <= "00000";
		led_pos <= "00000";
		
		-- termino la generazione dei numeri casuali e visualizzo le posizioni
		IF(flag = '1') THEN
		
			-- accendo i led in corrispondenza degli swt_pos da usare
			led_pos <= "11111";
			
			-- se ho inserito bene tutte le posizioni della password, accendo il led verde e spengo i led_pos
			if (done = "11111") then
				led_true <= '1';
				led_pos <= "00000";
			end if;
			
			-- confronto per ogni posizione, lo switch corretto
			
			-- pos_vet0
			IF pos_vet0 = "000" THEN
				IF swt_pos(0) = '0' THEN
					done(0) <= '1';
				else
					done(0) <= '0';
				END IF;
			ELSIF pos_vet0 = "001" THEN
				IF swt_pos(0) = '1' THEN
					done(0) <= '1';
				else
					done(0) <= '0';
				END IF;
			ELSIF pos_vet0 = "010" THEN
				IF swt_pos(0) = '1' THEN
					done(0) <= '1';
				else
					done(0) <= '0';
				END IF;
			ELSIF pos_vet0 = "011" THEN
				IF swt_pos(0) = '0' THEN
					done(0) <= '1';
				else
					done(0) <= '0';
				END IF;
			ELSIF pos_vet0 = "100" THEN
				IF swt_pos(0) = '1' THEN
					done(0) <= '1';
				else
					done(0) <= '0';
				END IF;
			END IF;
			
			-- pos_vet1
			IF pos_vet1 = "000" THEN
				IF swt_pos(1) = '0' THEN
					done(1) <= '1';
				else
					done(1) <= '0';
				END IF;
			ELSIF pos_vet1 = "001" THEN
				IF swt_pos(1) = '1' THEN
					done(1) <= '1';
				else
					done(1) <= '0';
				END IF;
			ELSIF pos_vet1 = "010" THEN
				IF swt_pos(1) = '1' THEN
					done(1) <= '1';
				else
					done(1) <= '0';
				END IF;
			ELSIF pos_vet1 = "011" THEN
				IF swt_pos(1) = '0' THEN
					done(1) <= '1';
				else
					done(1) <= '0';
				END IF;
			ELSIF pos_vet1 = "100" THEN
				IF swt_pos(1) = '1' THEN
					done(1) <= '1';
				else
					done(1) <= '0';
				END IF;
			END IF;
			
			-- pos_vet2
			IF pos_vet2 = "000" THEN
				IF swt_pos(2) = '0' THEN
					done(2) <= '1';
				else
					done(2) <= '0';
				END IF;
			ELSIF pos_vet2 = "001" THEN
				IF swt_pos(2) = '1' THEN
					done(2) <= '1';
				else
					done(2) <= '0';
				END IF;
			ELSIF pos_vet2 = "010" THEN
				IF swt_pos(2) = '1' THEN
					done(2) <= '1';
				else
					done(2) <= '0';
				END IF;
			ELSIF pos_vet2 = "011" THEN
				IF swt_pos(2) = '0' THEN
					done(2) <= '1';
				else
					done(2) <= '0';
				END IF;
			ELSIF pos_vet2 = "100" THEN
				IF swt_pos(2) = '1' THEN
					done(2) <= '1';
				else
					done(2) <= '0';
				END IF;
			END IF;
			
			-- pos_vet3
			IF pos_vet3 = "000" THEN
				IF swt_pos(3) = '0' THEN
					done(3) <= '1';
				else
					done(3) <= '0';
				END IF;
			ELSIF pos_vet3 = "001" THEN
				IF swt_pos(3) = '1' THEN
					done(3) <= '1';
				else
					done(3) <= '0';
				END IF;
			ELSIF pos_vet3 = "010" THEN
				IF swt_pos(3) = '1' THEN
					done(3) <= '1';
				else
					done(3) <= '0';
				END IF;
			ELSIF pos_vet3 = "011" THEN
				IF swt_pos(3) = '0' THEN
					done(3) <= '1';
				else
					done(3) <= '0';
				END IF;
			ELSIF pos_vet3 = "100" THEN
				IF swt_pos(3) = '1' THEN
					done(3) <= '1';
				else
					done(3) <= '0';
				END IF;
			END IF;
			
			-- pos_vet4
			IF pos_vet4 = "000" THEN
				IF swt_pos(4) = '0' THEN
					done(4) <= '1';
				else
					done(4) <= '0';
				END IF;
			ELSIF pos_vet4 = "001" THEN
				IF swt_pos(4) = '1' THEN
					done(4) <= '1';
				else
					done(4) <= '0';
				END IF;
			ELSIF pos_vet4 = "010" THEN
				IF swt_pos(4) = '1' THEN
					done(4) <= '1';
				else
					done(4) <= '0';
				END IF;
			ELSIF pos_vet4 = "011" THEN
				IF swt_pos(4) = '0' THEN
					done(4) <= '1';
				else
					done(4) <= '0';
				END IF;
			ELSIF pos_vet4 = "100" THEN
				IF swt_pos(4) = '1' THEN
					done(4) <= '1';
				else
					done(4) <= '0';
				END IF;
			END IF;
			
		END IF;
	END PROCESS;
END;