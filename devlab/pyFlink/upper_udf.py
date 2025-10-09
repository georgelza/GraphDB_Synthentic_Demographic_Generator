#######################################################################################################################
#
#
#   Project             :   Lab 3.
#
#   File                :   upper_udf.py
#
#   Description         :   Scalar UDF to uppercase a string.
#
#
########################################################################################################################
__author__      = "George Leonard"
__email__       = "georgelza@gmail.com"
__version__     = "1.0.0"
__copyright__   = "Copyright 2025, - G Leonard"



from pyflink.table import DataTypes
from pyflink.table.udf import udf # Only need 'udf' decorator

# Define the scalar UDF using the @udf decorator directly on the function
@udf(result_type=DataTypes.STRING())
def uppercase_string_udf(input_string: str) -> str:
    """
    Evaluates the input string and returns its uppercase version.
    """
    if input_string is None:
        return None
    return input_string.upper()
