LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Visualizzatore delle posizioni della password da inserire sui segment display

ENTITY segment_display IS
	PORT(
		rand_stream0: in std_logic_vector(2 downto 0); -- posizione 0
		rand_stream1: in std_logic_vector(2 downto 0); -- posizione 1
		rand_stream2: in std_logic_vector(2 downto 0); -- posizione 2
		rand_stream3: in std_logic_vector(2 downto 0); -- posizione 3
		rand_stream4: in std_logic_vector(2 downto 0); -- posizione 4
		
		flag: in std_logic; -- flag per visualizzare le posizioni
		clk: in std_logic; -- clock
		
		-- Display cifre
		Disp_0: out std_logic_vector(0 to 6);
		Disp_1: out std_logic_vector(0 to 6);
		Disp_2: out std_logic_vector(0 to 6);
		Disp_3: out std_logic_vector(0 to 6);
		Disp_4: out std_logic_vector(0 to 6)
		);
END;

ARCHITECTURE arch_segment_display OF segment_display IS

BEGIN
	-- se il flag cambia
	PROCESS(flag) IS
		BEGIN
		
		-- se il flag è 1, visualizzo sui display la relativa cifra
		if (flag = '1') then 
			-- posizione 0
			if rand_stream0 = "000" then
				Disp_0 <= "1001111";
			elsif rand_stream0 = "001" then
				Disp_0 <= "0010010";
			elsif rand_stream0 = "010" then
				Disp_0 <= "0000110";
			elsif rand_stream0 = "011" then 
				Disp_0 <= "1001100";
			elsif rand_stream0 = "100" then
				Disp_0 <= "0100100";
			END if;
			
			-- posizione 1
			if rand_stream1 = "000" then
				Disp_1 <= "1001111";
			elsif rand_stream1 = "001" then
				Disp_1 <= "0010010";
			elsif rand_stream1 = "010" then
				Disp_1 <= "0000110";
			elsif rand_stream1 = "011" then 
				Disp_1 <= "1001100";
			elsif rand_stream1 = "100" then
				Disp_1 <= "0100100";
			END if;
			
			-- posizione 2
			if rand_stream2 = "000" then
				Disp_2 <= "1001111";
			elsif rand_stream2 = "001" then
				Disp_2 <= "0010010";
			elsif rand_stream2 = "010" then
				Disp_2 <= "0000110";
			elsif rand_stream2 = "011" then 
				Disp_2 <= "1001100";
			elsif rand_stream2 = "100" then
				Disp_2 <= "0100100";
			END if;
			
			-- posizione 3
			if rand_stream3 = "000" then
				Disp_3 <= "1001111";
			elsif rand_stream3 = "001" then
				Disp_3 <= "0010010";
			elsif rand_stream3 = "010" then
				Disp_3 <= "0000110";
			elsif rand_stream3 = "011" then 
				Disp_3 <= "1001100";
			elsif rand_stream3 = "100" then
				Disp_3 <= "0100100";
			END if;
			
			-- posizione 4
			if rand_stream4 = "000" then
				Disp_4 <= "1001111";
			elsif rand_stream4 = "001" then
				Disp_4 <= "0010010";
			elsif rand_stream4 = "010" then
				Disp_4 <= "0000110";
			elsif rand_stream4 = "011" then 
				Disp_4 <= "1001100";
			elsif rand_stream4 = "100" then
				Disp_4 <= "0100100";
			END if;
			
		-- altrimenti mantengo i display spenti
		ELSE 
			Disp_0 <= "1111111";
			Disp_1 <= "1111111";
			Disp_2 <= "1111111";
			Disp_3 <= "1111111";
			Disp_4 <= "1111111";
		end if;
	END PROCESS;
END;	