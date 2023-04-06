LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_arith.all;

-- RICONOSCITORE DI PASSWORD E GENERATORE DI NUMERI CASUALI DA 1 a 5 PER IL REINSERIMENTO CON POSIZIONI MISCHIATE
--
-- ELETTRONICA DIGITALE A.A. 2022/2023
--
-- Professoressa: Annunziata Sanseverino
--
-- Alunni: Coviello Federico, Russo Giulio, Soave Sara

ENTITY main IS
	PORT(
	por: in std_logic; -- switch per la generazione dei numeri casuali
	flag: in std_logic; -- switch per bloccare la generazione dei numeri casuali e visualizzarli sui segment display
	clk: in std_logic; -- clock
	swt: in std_logic_vector(4 downto 0); -- switch per l'inserimento della password
	swt_pos: in std_logic_vector(4 downto 0); -- switch per l'inserimento della password in base alle posizioni visualizzate sul segment display
	
	led: out std_logic_vector(4 downto 0); -- led rossi per swt
	led_debug: out std_logic; -- led verde per controllo password
	led_true: out std_logic; -- led verde per controllo password mischiata
	led_pos: out std_logic_vector(4 downto 0); -- led rossi per swt_pos
	q_cont: out std_logic_vector(28 downto 0); -- uscita contatore 10 s
	Disp_0: out std_logic_vector(0 to 6); -- Display cifra posizione 0
	Disp_1: out std_logic_vector(0 to 6); -- Display cifra posizione 1
	Disp_2: out std_logic_vector(0 to 6); -- Display cifra posizione 2
	Disp_3: out std_logic_vector(0 to 6); -- Display cifra posizione 3
	Disp_4: out std_logic_vector(0 to 6); -- Display cifra posizione 4
	Disp_r: out std_logic_vector(0 to 6); -- Display lettera E in caso di errore
	Disp_e: out std_logic_vector(0 to 6); -- Display lettera r in caso di errore
	Disp_6: out std_logic_vector(0 to 6) -- Display HEX5 sempre spento
	);
END;

ARCHITECTURE arch_main OF main IS

COMPONENT input 
	PORT(
		swt: in std_logic_vector(4 downto 0);
		clk: in std_logic;
		
		led: out std_logic_vector(4 downto 0);
		led_debug: out std_logic;
		q_cont: out std_logic_vector(28 downto 0);
		Disp_e: out std_logic_vector(0 to 6);
		Disp_r: out std_logic_vector(0 to 6)
	);
END COMPONENT;

COMPONENT rand_gen 
	port (
        por: in  std_logic;
        sys_clk: in  std_logic;
        random_flag: in  std_logic;
		  
        random_data1: OUT std_logic_vector (2 downto 0);
		  random_data2: OUT std_logic_vector (2 downto 0)
    );
END COMPONENT;

COMPONENT comparator IS
	PORT(
	clk: in std_logic;
	flag: in std_logic;
	pos_vet0: in std_logic_vector(2 downto 0);
	pos_vet1: in std_logic_vector(2 downto 0);
	pos_vet2: in std_logic_vector(2 downto 0);
	pos_vet3: in std_logic_vector(2 downto 0);
	pos_vet4: in std_logic_vector(2 downto 0);
	swt_pos: in std_logic_vector(4 downto 0);
	
	led_true: out std_logic;
	led_pos: out std_logic_vector(4 downto 0)
	);
END COMPONENT;

COMPONENT swap IS
	PORT(
	rand_stream1: in std_logic_vector(2 downto 0);
	rand_stream2: in std_logic_vector(2 downto 0);
	flag : in std_logic;
	clk : in std_logic;
	
	pos_vet0_out: out std_logic_vector(2 downto 0);
	pos_vet1_out: out std_logic_vector(2 downto 0);
	pos_vet2_out: out std_logic_vector(2 downto 0);
	pos_vet3_out: out std_logic_vector(2 downto 0);
	pos_vet4_out: out std_logic_vector(2 downto 0)
	);
END COMPONENT;

COMPONENT segment_display IS
	PORT(
		rand_stream0: in std_logic_vector(2 downto 0);
		rand_stream1: in std_logic_vector(2 downto 0);
		rand_stream2: in std_logic_vector(2 downto 0);
		rand_stream3: in std_logic_vector(2 downto 0);
		rand_stream4: in std_logic_vector(2 downto 0);
		
		flag: in std_logic;
		clk: in std_logic;
		
		Disp_0: out std_logic_vector(0 to 6);
		Disp_1: out std_logic_vector(0 to 6);
		Disp_2: out std_logic_vector(0 to 6);
		Disp_3: out std_logic_vector(0 to 6);
		Disp_4: out std_logic_vector(0 to 6)
		);
END COMPONENT;


SIGNAL rand_stream1: std_logic_vector(2 downto 0);
SIGNAL rand_stream2: std_logic_vector(2 downto 0);
SIGNAL pos_vet0: std_logic_vector(2 downto 0);
SIGNAL pos_vet1: std_logic_vector(2 downto 0);
SIGNAL pos_vet2: std_logic_vector(2 downto 0);
SIGNAL pos_vet3: std_logic_vector(2 downto 0);
SIGNAL pos_vet4: std_logic_vector(2 downto 0);

BEGIN
x1: input PORT MAP (swt, clk, led, led_debug, q_cont, Disp_e, Disp_r);
x2: rand_gen PORT MAP (por, clk, flag, rand_stream1, rand_stream2);
X3: swap PORT MAP (rand_stream1, rand_stream2, flag, clk, pos_vet0, pos_vet1, pos_vet2, pos_vet3, pos_vet4);
x4: segment_display PORT MAP (pos_vet0, pos_vet1, pos_vet2, pos_vet3, pos_vet4, flag, clk, Disp_0, Disp_1, Disp_2, Disp_3, Disp_4);
x9: comparator PORT MAP (clk, flag, pos_vet0, pos_vet1, pos_vet2, pos_vet3, pos_vet4, swt_pos, led_true, led_pos);

Disp_6 <= "1111111"; -- Disp_6 sempre spento
END;