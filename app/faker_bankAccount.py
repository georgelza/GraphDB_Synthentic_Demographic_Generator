#######################################################################################################################
#
#
#  	Project     	: 	Generic Data generator.
#
#   File            :   faker_bankAccount.py
#
#   Description     :   Create a dataset representing a demographic distribution
#
#   Created     	:   06 Aug 2025
#                   :   23 Aug 2025 - Aligned Bank document structures data/ie_bank.json to previous GraphDB blog structure.
#
#   Functions       :   IrishBankAccountProvider (Class)
#                   :       irish_iban_account_number
#
#
########################################################################################################################
__author__      = "Generic Data playground"
__email__       = "georgelza@gmail.com"
__version__     = "0.2"
__copyright__   = "Copyright 2025, - George Leonard"


from faker.providers.python import Provider as PythonProvider       # Import Provider from python for numerify
from faker.providers.bank   import Provider as BankProvider         # Can also use bank provider methods if needed


class IrishBankAccountProvider(PythonProvider):
    
    """
    A custom Faker provider for generating Irish bank account numbers
    by combining a given BICFI prefix with a random 8-digit sequence.
    """
    
    def accountNumber(self, bicfiCode: str) -> str:
        
        """
        Generates an Irish BICFI-like bank account number.

        Args:
            bicfi Code as prefix (str): The initial part of the BICFI code.
                               Example: "IPTSIEDD"

        Returns:
            str: A string combining the BICFI prefix with a random 8-digit account number.
        """
        
        # Generate a random 8-digit number
        # '########' ensures exactly 8 digits are generated
        accountId = self.numerify('########')
        
        # Combine the bicfiCode prefix with the random 8-digit suffix
        AgentAccountId = f"{bicfiCode}-{accountId}"
        
        return AgentAccountId, accountId
        #end accountNumber
#end IrishBankAccountProvider


# # --- Demonstration ---

# # Initialize Faker
# fake = Faker('en_IE') # Using 'en_IE' locale for potentially relevant data if other providers were used

# # Add the custom provider to the Faker instance
# fake.add_provider(IrishBankAccountProvider)

# print("Generated Irish Bank Account Numbers:")

# # Example for Allied Irish Banks (AIB)
# aib_iban_prefix = "IE29AIBK931152"
# for _ in range(3):
#     print(f"AIB (IBAN prefix: {aib_iban_prefix}): {fake.irish_iban_account_number(aib_iban_prefix)}")

# print("\n")

# # Example for Bank of Ireland (BOI)
# boi_iban_prefix = "IE79BOFI905838"
# for _ in range(3):
#     print(f"Bank of Ireland (IBAN prefix: {boi_iban_prefix}): {fake.irish_iban_account_number(boi_iban_prefix)}")

# print("\n")

# # Example for Permanent TSB (PTSB)
# ptsb_iban_prefix = "IE55IPBS990602"
# for _ in range(3):
#     print(f"Permanent TSB (IBAN prefix: {ptsb_iban_prefix}): {fake.irish_iban_account_number(ptsb_iban_prefix)}")