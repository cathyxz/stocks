select * from 
(select symbol, count(*) as cnt 
	from stocks 
	where close > open 
	and date between date("2015-05-19") AND date("2015-05-22") 
	group by symbol) 
where cnt = 4;