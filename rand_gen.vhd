library ieee;
use ieee.std_logic_1164.all;

-- RANDOM GENERATOR WITH LINEAR SHIFT REGISTER
-- a partire da un seme, i numeri casuali sono generati shiftando le cifre del seme di una posizione
-- la posizione mancante viene generata in seguito a XOR casuali scelte
-- la generazione non sarà mai casuale, ma pseudocasuale (le sequenze si ripeteranno periodicamente)

entity rand_gen is
    port (
        por:                in  std_logic; -- abilitatore generazione numeri casuali
        sys_clk:            in  std_logic; -- clock
        random_flag:        in  std_logic; -- flag per interrompere la generazione dei numeri casuali
		  random_data1:        out std_logic_vector (2 downto 0); -- posizione 1 casuale generata
        random_data2:        out std_logic_vector (2 downto 0) -- posizione 2 casuale generata
    );
end entity rand_gen;

architecture arch_rand_gen of rand_gen is
    signal q1, q2: std_logic_vector(2 downto 0); -- numeri casuali generati
    signal n1_1, n2_1, n3_1, n1_2, n2_2, n3_2: std_logic;
	 
begin
    process (por, sys_clk) -- ADDED por to sensitivity list
    begin
        if por = '0' then -- inizializzazione semi per la generazione pseudo casuale
            q1 <= "100";
				q2 <= "010";
        elsif falling_edge(sys_clk) then -- sul fronte di caduta del clock, se il flag è 1, scorro ii bit di q
            if random_flag = '1' then
                -- REMOVED intermediary products as flip flops
                q1 <= q1(1 downto 0) & n3_1;  -- REMOVED after 10 ns;
					 q2 <= q2(1 downto 0) & n3_2;
            end if;
        end if;
		  
    end process;
    -- MOVED intermediary products to concurrent signal assignments:
    n1_1 <= q1(2) xor q1(0);
    n2_1 <= n1_1 xor q1(1); --  REMOVED after 10 ns;
    n3_1 <= n2_1 xor q1(0); --  REMOVED after 10 ns;
	 
	 n1_2 <= q2(2) xor q2(0);
    n2_2 <= n1_2 xor q2(1);
    n3_2 <= n2_2 xor q2(0);

    random_data1 <= q1;
	 random_data2 <= q2;
	 
end architecture arch_rand_gen;