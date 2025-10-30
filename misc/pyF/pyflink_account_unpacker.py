from pyflink.datastream import StreamExecutionEnvironment
from pyflink.table import StreamTableEnvironment, EnvironmentSettings
from pyflink.table.expressions import col, lit
from pyflink.table.udf import udtf
from pyflink.table.types import DataTypes
import json


# Define UDTF to explode account array
@udtf(result_types=[
    DataTypes.STRING(),  # fspiAgentAccountId
    DataTypes.STRING(),  # accountId
    DataTypes.STRING(),  # fspiId
    DataTypes.STRING(),  # fspiAgentId
    DataTypes.STRING(),  # accountType
    DataTypes.STRING(),  # memberName
    DataTypes.STRING(),  # cardHolder
    DataTypes.STRING(),  # cardNumber
    DataTypes.STRING(),  # expDate
    DataTypes.STRING(),  # cardNetwork
    DataTypes.STRING()   # issuingBank
])
class ExplodeAccounts:
    def eval(self, data_json):
        try:
            data = json.loads(data_json)
            accounts = data.get('account', [])
            
            for acc in accounts:
                yield (
                    acc.get('fspiAgentAccountId'),
                    acc.get('accountId'),
                    acc.get('fspiId'),
                    acc.get('fspiAgentId'),
                    acc.get('accountType'),
                    acc.get('memberName'),
                    acc.get('cardHolder'),
                    acc.get('cardNumber'),
                    acc.get('expDate'),
                    acc.get('cardNetwork'),
                    acc.get('issuingBank')
                )
        except Exception as e:
            # Log error or handle as needed
            pass


def main():
    # Initialize environments
    env = StreamExecutionEnvironment.get_execution_environment()
    env.set_parallelism(1)  # Adjust as needed
    
    settings = EnvironmentSettings.new_instance() \
        .in_streaming_mode() \
        .build()
    t_env = StreamTableEnvironment.create(env, environment_settings=settings)
    
    # Register the UDTF
    t_env.create_temporary_function("explode_accounts", ExplodeAccounts())
    
    # Query to unpack accounts using UDTF and insert into Paimon table
    t_env.execute_sql("""
        INSERT INTO c_paimon.outbound.accounts
        SELECT 
            a.nationalid,
            acc.fspi_agent_account_id AS fspiagentaccountid,
            acc.account_id AS accountid,
            acc.fspi_id AS fspiid,
            acc.fspi_agent_id AS fspiagentid,
            acc.account_type AS accounttype,
            acc.member_name AS membername,
            acc.card_holder AS cardholder,
            acc.card_number AS cardnumber,
            acc.exp_date AS expdate,
            acc.card_network AS cardnetwork,
            acc.issuing_bank AS issuingbank,
            a.created_at
        FROM postgres_catalog.inbound.adults AS a
        LEFT JOIN LATERAL TABLE(explode_accounts(a.data)) AS acc(
            fspi_agent_account_id,
            account_id,
            fspi_id,
            fspi_agent_id,
            account_type,
            member_name,
            card_holder,
            card_number,
            exp_date,
            card_network,
            issuing_bank
        ) ON TRUE
    """).wait()


if __name__ == '__main__':
    main()
