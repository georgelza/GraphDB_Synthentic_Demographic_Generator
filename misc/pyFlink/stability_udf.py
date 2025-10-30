#######################################################################################################################
#
#
#   Project             :   Lab 6.
#
#   File                :   stability_udf.py
#
#   Description         :   UDF to calculate a stability factor of sensor readings.
#
#
########################################################################################################################
__author__      = "George Leonard"
__email__       = "georgelza@gmail.com"
__version__     = "1.0.0"
__copyright__   = "Copyright 2025, - G Leonard"


from pyflink.table import DataTypes
from pyflink.table.udf import udf        # Only need 'udf' decorator


# Define the scalar UDF using the @udf decorator directly on the function
@udf(result_type=DataTypes.DOUBLE())
def calculate_stability_score(min_val, avg_val, max_val):
    
    """
    Calculates a stability score (out of 100) based on min, average, and max values.

    The score reflects how close the min and max values are to the average.
    Higher scores indicate greater stability.

    Args:
        min_val (float or int): The minimum observed value.
        avg_val (float or int): The average observed value.
        max_val (float or int): The maximum observed value.

    Returns:
        double: A stability score between 0 and 100. Returns 0 if avg_val is zero
                to prevent division by zero or if min_val > avg_val or max_val < avg_val.
                Returns 100 if min_val == avg_val == max_val.
    """
    
    if not (min_val <= avg_val <= max_val):
        # This scenario implies invalid input or an unstable state where avg isn't between min/max
        # For simplicity, we'll return 0, indicating no stability or bad input.
        # You might consider raising an error here depending on your application's needs.
        
        return 0.0


    if avg_val == 0:
        # Avoid division by zero. If avg is zero, and min/max are also zero, it's stable.
        # Otherwise, if min/max are non-zero, it's highly unstable relative to a zero average.
        
        return 100.0 if min_val == 0 and max_val == 0 else 0.0

    # Calculate the deviations from the average
    lower_deviation = avg_val - min_val
    upper_deviation = max_val - avg_val


    # The maximum possible deviation from the average, considering the range
    # We take the larger of the two deviations as the primary "instability" indicator
    # relative to the average.
    max_deviation = max(lower_deviation, upper_deviation)


    # To normalize this to a score out of 100, we need a reference point.
    # A common way to think about stability is how much the values deviate
    # as a percentage of the average itself.
    # However, for a score out of 100 where higher is better stability,
    # we can consider the "total spread" (max_val - min_val) relative to the average.

    # A simpler approach that captures the essence of "closeness to avg":
    # Calculate the average percentage deviation from the average.
    # A smaller deviation means higher stability.


    # If min_val == avg_val == max_val, perfect stability.
    if min_val == avg_val and max_val == avg_val:
        return 100.0

    # Calculate the range of the data
    data_range = max_val - min_val

    # If the range is zero (all values are the same), it's perfectly stable
    if data_range == 0:
        return 100.0


    # The core idea is to penalize larger deviations.
    # We can use a normalized deviation from the average.
    # The "ideal" scenario is when lower_deviation and upper_deviation are both 0.
    # The "worst" scenario (within valid min <= avg <= max) is when one of them
    # is very large compared to the average.


    # Let's consider the relative deviation of both min and max from the average.
    # We'll use the maximum of the two relative deviations.
    relative_lower_deviation = lower_deviation / avg_val
    relative_upper_deviation = upper_deviation / avg_val


    # The "instability" is proportional to this maximum relative deviation.
    # We want a score where higher is better, so we subtract from 1 (or 100).
    # We also need to scale it appropriately.
    
    
    # A common way to do this is to consider the "spread" relative to the average.
    # If values are very spread out, stability is low.
    # A simple inverse relationship: score = 100 * (1 - (max_deviation / avg_val))
    # This might go negative if max_deviation > avg_val.


    # Let's define a "stability metric" as 1 - (relative_deviation).
    # We'll take the minimum of the stability metrics for min and max.
    # This ensures that if *either* min or max is far from the average, the score is low.
    
    
    # Let's consider the maximum absolute percentage deviation from the average
    # as the primary indicator of instability.
    max_relative_deviation = max(abs(min_val - avg_val) / avg_val, abs(max_val - avg_val) / avg_val)


    # Now, convert this instability measure to a score out of 100.
    # A simple linear inverse relationship can work, but it might not be ideal
    # if you want more sensitivity to small deviations.


    # Let's try a formula where perfect stability (max_relative_deviation = 0) gives 100,
    # and as max_relative_deviation increases, the score decreases.
    # We need to decide what `max_relative_deviation` corresponds to a score of 0.
    # For instance, if a 100% deviation (value is 0 or double the average) should give 0 score.


    # Let's use a simpler approach based on the ratio of the "closeness" to the total possible "closeness".
    # The "closeness" can be thought of as the inverse of the deviation.
    # The total range is (max_val - min_val).
    # If the values are tightly clustered around the average, this range will be small.


    # Let's consider the distance from the average to the min and max.
    # The ideal "distance" from avg is 0.
    # The "spread" is the difference between min and max.
    # The stability can be inversely proportional to this spread, normalized by the average.


    # A more robust approach might be to consider how "tightly" the min and max
    # are centered around the average relative to the average's magnitude.


    # Let's try a penalty based on the sum of squared relative deviations,
    # or simply the maximum relative deviation.
    
    
    # Let's normalize the deviations by the average.
    # The deviation is 0 for perfect stability.
    # We need to map a deviation to a score from 100 down to 0.


    # Consider the `max_deviation` calculated earlier. This is the largest absolute difference
    # from the average. We want to penalize this.
    # We need a `scaling_factor` to determine how much `max_deviation` impacts the score.
    
    
    # If max_deviation is 0, score is 100.
    # If max_deviation is equal to avg_val, score is 0? (e.g., avg=6, min=0, max=12)
    # This implies a 100% relative deviation means 0 score.


    # So, score = 100 * (1 - (max_deviation / avg_val))
    # This formula works IF max_deviation / avg_val does not exceed 1.
    # If min_val = 0 and avg_val = 6 and max_val = 6, then max_deviation = 6, avg_val = 6. Score = 100 * (1 - 1) = 0.
    # This isn't quite right. min=0, avg=6, max=6 is not perfectly stable but not 0 stable.
    # Max deviation here is 6 (from avg to min).


    # The problem with simply using max_deviation / avg_val is that the ratio can be > 1.
    # E.g., avg=6, min=0, max=7. max_deviation = 6 (6-0). 6/6 = 1. Score = 0.
    # What if avg=6, min=5, max=10? max_deviation = 4 (10-6). avg=6. 4/6 = 0.66. Score = 100 * (1 - 0.66) = 34.


    # Let's use the average percentage deviation as the instability factor.
    # The average of the absolute percentage deviations.
    
    
    percent_dev_min = abs((min_val - avg_val) / avg_val)
    percent_dev_max = abs((max_val - avg_val) / avg_val)
    
    
    # We want the score to be low if either of these is high.
    # So, let's consider the maximum of the two percentage deviations.
    max_percent_deviation = max(percent_dev_min, percent_dev_max)


    # Now, map this `max_percent_deviation` to a score from 0 to 100.
    # If `max_percent_deviation` is 0, score is 100.
    # If `max_percent_deviation` is 1 (100% deviation), score is 0.
    # This is a linear mapping: score = 100 * (1 - max_percent_deviation)
    
    # We need to cap the score at 0 if max_percent_deviation exceeds 1.
    # Or, we can choose a different formula.
    
    # For a score out of 100, where higher is better stability:
    # A simple inverse relationship is often good.
    # Let's consider a `stability_factor` that is between 0 and 1.
    # 0 means completely unstable, 1 means perfectly stable.
    
    # One approach is to use the inverse of the coefficient of variation, but that's for dispersion.
    
    # Let's try this:
    # We define a "tolerance" or "acceptable deviation" as a percentage of the average.
    # For example, if we consider a 20% deviation from the average as "zero stability".
    # Then: score = 100 * (1 - (max_percent_deviation / 0.20))
    # This becomes difficult to generalize without a fixed "tolerance".

    # A more general approach is to use a decaying function.
    # For example, an exponential decay: score = 100 * exp(-k * max_percent_deviation)
    # Where 'k' is a sensitivity constant.

    # Let's stick to a linear mapping, but with a clear definition of what constitutes
    # "zero stability" in terms of relative deviation.
    # If we assume that a relative deviation of `1.0` (100%) should result in a score of `0`,
    # then: `score = 100 * (1 - max_percent_deviation)`
    # And we'll cap the score at 0.

    stability_score = 100 * (1 - max_percent_deviation)

    # Ensure the score is not less than 0
    return max(0.0, stability_score)

#end calculate_stability_score