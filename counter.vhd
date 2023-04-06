LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.all;

ENTITY counter IS
	PORT
	(
		clock		: IN STD_LOGIC ;
		cnt_en		: IN STD_LOGIC;
		cout		: OUT STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (28 DOWNTO 0)
	);
END counter;


ARCHITECTURE SYN OF counter IS

	SIGNAL sub_wire0	: STD_LOGIC ;
	SIGNAL sub_wire1	: STD_LOGIC_VECTOR (28 DOWNTO 0);



	COMPONENT lpm_counter
	GENERIC (
		lpm_direction		: STRING;
		lpm_modulus		: NATURAL;
		lpm_port_updown		: STRING;
		lpm_type		: STRING;
		lpm_width		: NATURAL
	);
	PORT (
			clock	: IN STD_LOGIC ;
			cnt_en	: IN STD_LOGIC ;
			cout	: OUT STD_LOGIC ;
			q	: OUT STD_LOGIC_VECTOR (28 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	cout    <= sub_wire0;
	q    <= sub_wire1(28 DOWNTO 0);

	LPM_COUNTER_component : LPM_COUNTER
	GENERIC MAP (
		lpm_direction => "UP",
		lpm_modulus => 500000000,
		lpm_port_updown => "PORT_UNUSED",
		lpm_type => "LPM_COUNTER",
		lpm_width => 29
	)
	PORT MAP (
		clock => clock,
		cnt_en => cnt_en,
		cout => sub_wire0,
		q => sub_wire1
	);



END SYN;