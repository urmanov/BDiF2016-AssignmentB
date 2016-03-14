createSynthData{[numDays]
//1-letter ticker list
tickers:`C`F`K`L`M`P`S`T`V`Z

//empty table
trades:([]date:`date$();time:`time$();sym:`symbol$();price:`real$();size:`int$())

//sample populate table, 1st ticker insert
`trades insert (2016.01.01;10:00:00.000;`Z;49.73e;50000)


};
