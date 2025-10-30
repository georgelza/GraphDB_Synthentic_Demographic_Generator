#######################################################################################################################
#
#
#   Project             :   Lab 4.
#
#   File                :   complex_udf.py
#
#   Description         :   Scalar UDF to join 2 columns into a string.
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
def join_string_udf(val1: int, val2: int) -> str:
    """
    concatenates the 2 input integers together after converting to strings.
    """
    if val1 is None or val2 is None:
        return None
    
    return (str(val1) + "_" + str(val2))
