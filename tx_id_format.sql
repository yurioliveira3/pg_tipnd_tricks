CREATE OR REPLACE FUNCTION tx_id_format(tx_id VARCHAR(255), type_tx_id int8) 
	RETURNS VARCHAR(255) AS $$
DECLARE
  tx_id_formatted VARCHAR(255);
  tx_len INTEGER;
BEGIN
	tx_id_formatted := regexp_replace(tx_id, '\D', '', 'g');
	tx_len := LENGTH(tx_id_formatted);

	IF (tx_len < 14 AND type_tx_id = 1) THEN -- CNPJ   
		WHILE tx_len < 14 LOOP 
			tx_id_formatted := '0' || tx_id_formatted;
			tx_len = LENGTH(tx_id_formatted);
		END LOOP;

	ELSEIF (tx_len < 11 AND type_tx_id = 2) THEN -- CPF
		WHILE tx_len < 11 LOOP
			tx_id_formatted := '0' || tx_id_formatted;
			tx_len = LENGTH(tx_id_formatted);
		END LOOP;
	
	END IF;

	-- tx_id_formatted := regexp_replace(tx_id_formatted, '(\\d)(\\d)(\\d)(\\d)', '\\1.\\2.\\3-\\4');

	RETURN tx_id_formatted;
END;
$$ LANGUAGE plpgsql;

-- SELECT tx_id, type_tx_id, tx_id_format(tx_id, type_tx_id) FROM people;
