LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_arith.all;

-- Dopo 10 secondi, salva i valori degli switch e controlla se questi coincidono con la password specificata da codice

ENTITY input IS
	PORT(
	swt: in std_logic_vector(4 downto 0); -- switch
	clk: in std_logic; -- clock
	
	led: out std_logic_vector(4 downto 0); -- led per gli switch
	led_debug: out std_logic; -- led per verifica password
	q_cont: out std_logic_vector(28 downto 0); -- uscita contatore 10 s
	Disp_e: out std_logic_vector(0 to 6); -- Display E in caso di errore
	Disp_r: out std_logic_vector(0 to 6) -- Display r in caso di errore
	);
END;

ARCHITECTURE arch_input OF input IS

SIGNAL en, cout: std_logic;

COMPONENT counter
	PORT
	(
		clock: IN STD_LOGIC ; -- clock
		cnt_en: IN STD_LOGIC; -- counter enable (1: conta, 0: non conta)
		cout: OUT STD_LOGIC ; -- carry out (1: se arriva a 10 s, 0: se non ci è arrivato)
		q: OUT STD_LOGIC_VECTOR (28 DOWNTO 0) -- sequenza di 28 bit che da 28 zeri "000...000" arriva a 28 uno "111...111"
	);
END COMPONENT;

signal bit_stream: std_logic_vector(4 downto 0);

BEGIN
en <= NOT cout; -- cnt_en di counter: appena finiscono 10 s, cout 0->1, en = NOT cout -> 0. Così il contatore conta UNA SOLA VOLTA 10 s
x1: counter PORT MAP (clk, en, cout, q_cont);
	PROCESS (clk) IS
		BEGIN
		
		-- inizializzazione led, led_debug e display di errore spenti
		led <= "11111";
		led_debug <= '0';
		Disp_e <= "1111111";
		Disp_r <= "1111111";
		
		-- Se ho finito di contare 10 s
		IF cout = '1' then
			-- Estraggo i valori dagli switch
			bit_stream(0) <= swt(0);
			bit_stream(1) <= swt(1);
			bit_stream(2) <= swt(2);
			bit_stream(3) <= swt(3);
			bit_stream(4) <= swt(4);

			-- Se la password è corretta, spengo i led e i display di errore, e accendo led_debug
			IF bit_stream = "10110" THEN
				led <= "00000";
				led_debug <= '1';
				Disp_e <= "1111111";
				Disp_r <= "1111111";
			-- altrimenti mostro "Er" sui display di errore
			ELSE
				Disp_e <= "0110000"; 
				Disp_r <= "1111010";
			END IF;
		END IF;
	END PROCESS;
END;