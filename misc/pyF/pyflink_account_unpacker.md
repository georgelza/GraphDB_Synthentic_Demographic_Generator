Perfect! I've simplified the code to:

Remove the source table creation - assumes postgres_catalog.inbound.adults already exists
Remove the sink table creation - assumes c_paimon.outbound.accounts already exists
Direct INSERT statement - unpacks the accounts and inserts directly into your Paimon table

Key Changes:

The query now maps to your Paimon table's lowercase column names (fspiagentaccountid, accountid, etc.)
Includes the created_at timestamp from the source
Uses a simple INSERT INTO ... SELECT pattern
The LATERAL JOIN explodes each account entry and writes it as a separate row to Paimon

How It Works:
For Fergal Freeley's record, this will create 5 rows in c_paimon.outbound.accounts:

4 rows for his bank accounts (with bank-specific fields populated)
1 row for his card (with card-specific fields populated)

The job will continuously process CDC events from the PostgreSQL source and write unpacked account records to your Paimon table.



RUN: flink run -py your_script.py	


Misc older notes:

Key Features:

UDTF (User-Defined Table Function): ExplodeAccounts that parses the JSON data field and explodes the account array into individual rows
Handles Both Account Types: The UDTF accommodates both bank accounts (with fields like fspiAgentAccountId, accountId) and card accounts (with cardHolder, cardNumber, etc.)
CDC Integration: Connects to your PostgreSQL CDC source table and preserves key fields (nationalid, id, created_at)
LATERAL JOIN: Uses Flink SQL's LATERAL TABLE join to explode each account entry into separate rows

Output Structure:
Each record from adults with multiple accounts will produce multiple output rows:

Fergal Freeley would produce 5 rows (4 bank accounts + 1 card)
Each row contains the person's identifying information plus one unpacked account/card

To Deploy:

Update the sink connector in CREATE TABLE unpacked_accounts to your target (Kafka, PostgreSQL, etc.)
Adjust parallelism based on your cluster capacity
Add dependencies to your Flink job:

flink-connector-postgres-cdc
flink-sql-connector-postgres-cdc



