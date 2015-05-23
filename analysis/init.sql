DROP TABLE IF EXISTS stocks;

CREATE TABLE stocks (
	symbol String,
	date DATETIME, 
	open REAL, 
	high REAL, 
	low REAL, 
	close REAL, 
	volume INTEGER,
	adj_close REAL
);

.separator ","

.import master.csv stocks