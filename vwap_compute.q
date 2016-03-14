
//empty table with data types specified
trades:([]date:`date$();time:`time$();sym:`symbol$();price:`real$();size:`int$())


//function to synthesize financial data
createSynthData:{[numDays]

	//1-letter ticker list
	//C:Citigroup, F:Ford, K:Kellogg, L:Loews, M:Macy's, P:Pandora, S:Sprint, T:AT&T, V:Visa, Z:Zillow
	tickers:`C`F`K`L`M`P`S`T`V`Z;

	//trades per day
	tpd:1000;

	//number of tickers
	cnt:count tickers;

	//total number of trades
	len:tpd*cnt*numDays;

	//generate random sample dates
	date:2016.01.01+len?numDays;

	//generate random sample times (without milliseconds)
	time:"t"$raze (cnt*numDays)#enlist 10:00:00+15*til tpd;

	//generate random sample times (with milliseconds)
	time+:len?1000;

	//generate list of tickers randomly
	tickers:len?tickers;

	//generate list of random prices
	price:len?100e;

	//generate list of random volumes
	size:100*len?1000;

	//remove previous data entries from the table
	delete from `trades;

	//sample populate of table, 1st entry insertion
	`trades insert (2016.01.01;10:00:00.000;`Z;49.73e;50000);

	//populate trades table
	`trades insert (date;time;tickers;price;size);

	//sort trades table in ascending order by date and time
	trades:`date`time xasc `trades;

	};


//function to compute vwap
computeVwap:{select vwap:(sum price*size) % (sum size) by date, sym from trades}



//create synthetic financial time series data (trades)
synthTable:createSynthData[30]

//save trades table to comma-separated values files
save `:trades.csv

//memory usage after processing request
.Q.w[]



//compute VWAP
vwap:computeVwap[]

//save vwap table to comma-separated values files
save `:vwap.csv

//memory usage after processing request
.Q.w[]