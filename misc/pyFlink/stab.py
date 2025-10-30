#######################################################################################################################
#
#
#   Project             :   Lab 6.
#
#   File                :   stab.py
#
#   Description         :   .
#
#
########################################################################################################################
__author__      = "George Leonard"
__email__       = "georgelza@gmail.com"
__version__     = "1.0.0"
__copyright__   = "Copyright 2025, - G Leonard"


from stability_udf import *


# --- Examples ---
print("Example 1: High Stability (avg=6, min=5, max=7)")
# avg=6, min=5, max=7
# abs((5-6)/6) = 1/6 = 0.166...
# abs((7-6)/6) = 1/6 = 0.166...
# max_percent_deviation = 0.166...
# score = 100 * (1 - 0.166...) = 100 * 0.833... = 83.33
print(f"Score: {calculate_stability_score(5, 6, 7):.2f}") # Expected: High score, around 80-90

print("\nExample 2: Low Stability (avg=6, min=3, max=7)")
# avg=6, min=3, max=7
# abs((3-6)/6) = 3/6 = 0.5
# abs((7-6)/6) = 1/6 = 0.166...
# max_percent_deviation = 0.5
# score = 100 * (1 - 0.5) = 50
print(f"Score: {calculate_stability_score(3, 6, 7):.2f}") # Expected: Medium-low score, around 50

print("\nExample 3: Low Stability (avg=6, min=5, max=10)")
# avg=6, min=5, max=10
# abs((5-6)/6) = 1/6 = 0.166...
# abs((10-6)/6) = 4/6 = 0.666...
# max_percent_deviation = 0.666...
# score = 100 * (1 - 0.666...) = 100 * 0.333... = 33.33
print(f"Score: {calculate_stability_score(5, 6, 10):.2f}") # Expected: Low score, around 30-40

print("\nExample 4: High Stability (avg=550, min=520, max=580)")
# avg=550, min=520, max=580
# abs((520-550)/550) = 30/550 = 0.0545...
# abs((580-550)/550) = 30/550 = 0.0545...
# max_percent_deviation = 0.0545...
# score = 100 * (1 - 0.0545...) = 100 * 0.945... = 94.54
print(f"Score: {calculate_stability_score(520, 550, 580):.2f}") # Expected: Very high score

print("\nExample 5: Low Stability (avg=550, min=400, max=560)")
# avg=550, min=400, max=560
# abs((400-550)/550) = 150/550 = 0.2727...
# abs((560-550)/550) = 10/550 = 0.0181...
# max_percent_deviation = 0.2727...
# score = 100 * (1 - 0.2727...) = 100 * 0.7272... = 72.72
print(f"Score: {calculate_stability_score(400, 550, 560):.2f}") # Expected: Moderate score

print("\nExample 6: Perfect Stability (min=avg=max)")
print(f"Score: {calculate_stability_score(10, 10, 10):.2f}") # Expected: 100.00

print("\nExample 7: Avg is 0, but min/max are also 0")
print(f"Score: {calculate_stability_score(0, 0, 0):.2f}") # Expected: 100.00

print("\nExample 8: Avg is 0, but min/max are not 0 (highly unstable)")
print(f"Score: {calculate_stability_score(-5, 0, 5):.2f}") # Expected: 0.00

print("\nExample 9: Invalid input (min > avg)")
print(f"Score: {calculate_stability_score(7, 6, 8):.2f}") # Expected: 0.00