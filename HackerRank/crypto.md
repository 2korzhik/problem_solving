# Crypto Market Transaction Monitoring Solution

There is a log [crypto.csv](crypto.csv)  with transactions with `dt,sender,recipient,amount` fields.

Create a query which returns a list of suspicious transactions. 
Suspicious transactions are defined as: 
1. a series of two or more transactions occurred at intervals of an hour or less
2. they are from the same sender 
3. the sum of transactions in a sequence is 150 or greater

A sequence of suspicious transactions may occur over time periods greater than one hour.

The result should have the following columns: `sender, sequence_start, sequence_end, trans transactions_sum,  transactions_count`