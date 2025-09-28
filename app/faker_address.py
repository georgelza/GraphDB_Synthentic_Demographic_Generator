#######################################################################################################################
#
#
#  	Project     	: 	Generic Data generator.
#
#   File            :   faker_address_provider.py
#
#   Description     :   OOP-based Address Provider for Faker - Create addresses representing a demographic distribution
#
#   Created     	:   16 Aug 2025 (Refactored from faker_address.py)
#                   :   21 Aug 2025 -   Added get_neighbourhoods, also added to ireland.json seed file.
#                   :                   Added countryCode to the source ireland.json file and added it to the address being created.
#
#
#   Classes         :   GeographicDataProvider - Main provider class for Faker
#
#   Methods         :   __init__ - Initialize with data file path
#                   :   load_data           - Load JSON data from file
#                   :   generate_address    - Generate complete address
#                   :   get_provinces       - Get provinces data with population values
#                   :   get_counties        - Get counties for a specific province
#                   :   get_cities_towns    - Get cities/towns for a specific province and county
#                   :   get_neighbourhoods  - Get Neighbourhood from avail for selected provice/county/city
#
# ########################################################################################################################
__author__      = "Generic Data playground"
__email__       = "georgelza@gmail.com"
__version__     = "0.3"
__copyright__   = "Copyright 2025, - George Leonard"

    
from faker.providers import BaseProvider
import json, random


class ParcelIdGenerator:
    
    """
    Sub class for generating unique parcel IDs.
    
    Takes an input string (like postal_code) and concatenates it with a 5-digit random number
    to create a unique identifier for each address.
    """
    
    def __init__(self):

        """
        Initialize the ParcelId generator.
        Track generated IDs to ensure uniqueness.
        """

        self.generated_ids = set()  # Track all generated parcel IDs to ensure uniqueness
    #end __init__
    
    
    def generate_parcel_id(self, input_string):
        
        """
        Generate a unique parcel ID by concatenating input string with 5-digit random number.
        Ensures uniqueness by checking against previously generated IDs.
        
        Args:
            input_string (str): The string to prefix before the random number (e.g., postal_code)
            
        Returns:
            str: Unique parcel ID (e.g., "D0112345" for Dublin postal code D01)
        """
        
        # Use the provided input string (postal_code)
        prefix = input_string if input_string else "UNKNOWN"
        
        # Keep trying until we get a unique ID
        max_attempts = 500      # Prevent infinite loop in edge cases
        attempt      = 0
        
        while attempt < max_attempts:
            
            # Generate 5-digit random number (00000-99999)
            random_number = random.randint(0, 99999)
            
            # Format as 5-digit string with leading zeros
            formatted_number = f"{random_number:05d}"
            parcel_id        = f"{prefix}-{formatted_number}"
            
            # Check if this parcel_id has been generated before
            if parcel_id not in self.generated_ids:
                # Add to our tracking set and return
                self.generated_ids.add(parcel_id)
                return parcel_id
            
            attempt += 1
        
        # Fallback (very unlikely to reach here)
        # If we somehow can't find a unique random number, use attempt number
        fallback_parcel_id = f"{prefix}-{attempt:05d}"
        self.generated_ids.add(fallback_parcel_id)
        
        return fallback_parcel_id
    #end generate_parcel_id
#end ParcelIdGenerator


class GeographicDataProvider(BaseProvider):
    
    """
    A Faker provider for generating realistic addresses based on geographic demographic data.
    
    This provider loads census/demographic data from a JSON file and uses population weights
    to generate realistic addresses that reflect actual population distributions.
    """
    
    def __init__(self, generator, file_path=None, mylogger=None):
        
        """
        Initialize the Geographic Data Provider.
        
        Args:
            generator:              The Faker generator instance
            file_path (str):        Path to the JSON data file containing geographic data
            mylogger:               Logger instance for logging operations
        """
        
        super().__init__(generator)
        self.mylogger                   = mylogger
        self.data                       = None
        self.provinces_cache            = None
        self.total_province_population  = 0
        
        # Initialize ParcelId generator sub class
        self.parcel_generator = ParcelIdGenerator()
        
        if file_path:
            self.load_data(file_path)
        #end if
    #end __init__
    
    
    def load_data(self, file_path):
        
        """
        Load geographic data from JSON file.
        
        Args:
            file_path (str): Path to the JSON data file
            
        Raises:
            FileNotFoundError: If the file doesn't exist
            json.JSONDecodeError: If the file contains invalid JSON
        """
        
        try:
            with open(file_path, 'r', encoding='utf-8') as file:
                self.data = json.load(file)
            #end with
                
            # Cache provinces data for efficiency
            self.provinces_cache, self.total_province_population = self._extract_provinces()
            
            if self.mylogger:
                self.mylogger.info("Successfully loaded geographic data from {file_path}".format(
                    file_path = file_path
                ))
                
                self.mylogger.info("Loaded data for {country}/{countryCode} with {provinces} provinces".format(
                    country     = self.data.get('country',     'Unknown'),
                    countryCode = self.data.get('countryCode', 'Unknown'),
                    provinces   = len(self.provinces_cache)
                ))
            #end if
                
        except FileNotFoundError as err:
            error_msg = f"Geographic data file not found: {file_path}"
            
            if self.mylogger:
                self.mylogger.error(error_msg)
            
            #end if
            raise FileNotFoundError(error_msg) from err
            
        except json.JSONDecodeError as err:
            error_msg = f"Invalid JSON in geographic data file: {file_path}"
            
            if self.mylogger:
                self.mylogger.error(error_msg)
            #end if
            
            raise json.JSONDecodeError(error_msg) from err
        #end try
    #end load_data
    
    
    def _extract_provinces(self):
        
        """
        Extract provinces data with total population sum.
        
        Returns:
            tuple: (provinces_list, total_population)
        """
        
        if not self.data or 'provinces' not in self.data:
            return [], 0
        #end if
            
        provinces        = []
        total_population = 0
        
        for province in self.data['provinces']:
            province_data = {
                'name':  province['name'],
                'value': province.get('population', 0)  # Use 'population' instead of 'value'
            }
            
            provinces.append(province_data)
            total_population += province_data['value']
        #end for
        
        return provinces, total_population
    #end _extract_provinces
    
    
    def generate_address(self, neighbourhood=None, town=None, county=None, province_state=None, country=None, postal_code=None):
        
        """
        Generate a complete address with realistic demographic distribution.
        
        Args:
            neighbourhood (str, optional)    Specific neighbourhood to use
            town (str, optional):            Specific town/city to use
            county (str, optional):          Specific county to use
            province_state (str, optional):  Specific province/state to use
            country (str, optional):         Specific country to use
            postal_code (str, optional):     Specified postal_code to use for county
            
        Returns:
            dict: Complete address with street, town, county, state, post_code, country, and parcelId
        """
        
        if not self.data:
            raise ValueError("No geographic data loaded. Call load_data() first.")
        #end if
        
        # Use provided country or get from data
        final_country = country or self.data.get('country', 'Unknown')
        
        # Generate street components
        street_number = self.generator.building_number()
        street_name   = self.generator.street_name()
        street_suffix = self.generator.street_suffix()  # Ave, St, Blvd, etc.
        country_code  = self.data.get('countryCode', 'Unknown')
        
         # Use provided postal_code or default
        final_postal_code = postal_code or 'Unknown Postal Code'
        
        # CALL ParcelIdGenerator sub class using postal_code as input parameter
        parcel_id = self.parcel_generator.generate_parcel_id(final_postal_code)
        
        return {
            'street_1':         f"{street_number} {street_name} {street_suffix}",
            'street_2':         '',
            'neighbourhood':    neighbourhood or    'Unknown Neighbourhood',
            'town':             town or             'Unknown Town',
            'county':           county or           'Unknown County',         # aka district
            'province':         province_state or   'Unknown Province',       # aka state
            'country':          final_country or    'Unknown Country',
            'country_code':     country_code or     'Unknown Country Code',                     
            'postal_code':      postal_code or      'Unknown Postal Code',
            'parcel_id':        parcel_id
        }
    #end generate_address
    
    
    def set_parcel_prefix(self, new_prefix):
        
        """
        Update the default parcel prefix for future address generation.
        
        Args:
            new_prefix (str): New prefix string to use for parcel ID generation
        """
        
        self.parcel_generator.prefix_string = new_prefix
        
        if self.mylogger:
            self.mylogger.info(f"Updated parcel prefix to: {new_prefix}")
    #end set_parcel_prefix
    
    
    def get_parcel_prefix(self):
    
        """
        Get the current parcel prefix being used.
        
        Returns:
            str: Current parcel prefix string
        """
    
        return self.parcel_generator.prefix_string
    #end get_parcel_prefix
    
    
    def get_provinces(self):

        """
        Get provinces data with total population sum.
        
        Returns:
            tuple: (provinces_list, total_population)
            
        Raises:
            ValueError: If no data is loaded
        """

        if not self.data:
            raise ValueError("No geographic data loaded. Call load_data() first.")
        #end if
                    
        return self.provinces_cache.copy(), self.total_province_population
    #end get_provinces
    
    
    def get_counties(self, province_name):
        
        """
        Get counties data for a specific province with total population sum.
        
        Args:
            province_name (str): Name of the province (e.g., "Leinster")
            
        Returns:
            tuple: (counties_list, total_population) or (None, None) if province not found
            
        Raises:
            ValueError: If no data is loaded
        """
        
        if not self.data:
            raise ValueError("No geographic data loaded. Call load_data() first.")
        #end if
        
        counties         = []
        total_population = 0
        
        # Find the specified province
        target_province = None
        for province in self.data['provinces']:
            if province['name'].lower() == province_name.lower():
                target_province = province
                
                break
            #enf if
        #end for
        
        if not target_province:
            if self.mylogger:
                self.mylogger.warning(f"Province '{province_name}' not found in data".format(
                    province_name = province_name
                ))
            #end if
            return None, None
        #end if
        
        # Extract counties data
        if 'counties' in target_province:
            for county in target_province['counties']:
                county_data = {
                    'name':  county['name'],
                    'value': county.get('population', 0)
                }
                 
                counties.append(county_data)
                total_population += county_data['value']
            #end for
        #end if
        return counties, total_population
    #end get_counties
    
    
    def get_cities_towns(self, province_name, county_name):
        
        """
        Get cities/towns data for a specific province and county with total population sum.
        
        Args:
            province_name (str): Name of the province (e.g., "Leinster")
            county_name (str):   Name of the county (e.g., "Dublin")
            
        Returns:
            tuple: (cities_towns_list, total_population) or (None, None) if not found
            
        Raises:
            ValueError: If no data is loaded
        """
        
        if not self.data:
            raise ValueError("No geographic data loaded. Call load_data() first.")
        #end if
        
        cities_towns     = []
        total_population = 0
        
        # Find the specified province
        target_province = None
        for province in self.data['provinces']:
            if province['name'].lower() == province_name.lower():
                target_province = province
                break
            #end if
        #end for
        
        if not target_province:
            if self.mylogger:
                self.mylogger.warning("Province '{province_name}' not found in data".format(
                    province_name = province_name
                ))
            #end if
            return None, None
        #end if
        
        
        # Find the specified county
        target_county = None
        for county in target_province.get('counties', []):
            if county['name'].lower() == county_name.lower():
                target_county = county
                break
            #end if
        #end for
        
        
        if not target_county:
            if self.mylogger:
                self.mylogger.warning("County '{county_name}' not found in province '{province_name}'".format(
                    county_name   = county_name,
                    province_name = province_name
                ))
            #end if
            return None, None
        #end if
        
        
        # Extract cities/towns data
        if 'cities_towns' in target_county:
            for city_town in target_county['cities_towns']:
                city_town_data = {
                    'name':  city_town['name'],
                    'value': city_town.get('population', 0)
                }
                                
                cities_towns.append(city_town_data)
                total_population += city_town_data['value']
            #end for
        #end if
        
        return cities_towns, total_population
    #end get_cities_towns
    
    
    def get_neighbourhoods(self, province_name, county_name, city_town_name):
        """
        Get neighbourhoods data for a specific province, county, and city/town.
        
        Args:
            province_name (str): Name of the province (e.g., "Leinster")
            county_name (str):   Name of the county (e.g., "Dublin")
            city_town_name (str): Name of the city/town (e.g., "Dublin City")
            
        Returns:
            tuple: (neighbourhoods_list, total_count) or (None, None) if not found
            
        Raises:
            ValueError: If no data is loaded
        """
        
        if not self.data:
            raise ValueError("No geographic data loaded. Call load_data() first.")
        #end if
        
        neighbourhoods = []
        total_count = 0
        
        # Find the specified province
        target_province = None
        for province in self.data['provinces']:
            if province['name'].lower() == province_name.lower():
                target_province = province
                break
            #end if
        #end for
        
        if not target_province:
            if self.mylogger:
                self.mylogger.warning("Province '{province_name}' not found in data".format(
                    province_name = province_name
                ))
            #end if
            return None, None
        #end if
        
        # Find the specified county
        target_county = None
        for county in target_province.get('counties', []):
            if county['name'].lower() == county_name.lower():
                target_county = county
                break
            #end if
        #end for
        
        if not target_county:
            if self.mylogger:
                self.mylogger.warning("County '{county_name}' not found in province '{province_name}'".format(
                    county_name   = county_name,
                    province_name = province_name
                ))
            #end if
            return None, None
        #end if
        
        # Find the specified city/town
        target_city_town = None
        for city_town in target_county.get('cities_towns', []):
            if city_town['name'].lower() == city_town_name.lower():
                target_city_town = city_town
                break
            #end if
        #end for
        
        if not target_city_town:
            if self.mylogger:
                self.mylogger.warning("City/Town '{city_town_name}' not found in county '{county_name}', province '{province_name}'".format(
                    city_town_name = city_town_name,
                    county_name    = county_name,
                    province_name  = province_name
                ))
            #end if
            return None, None
        #end if
        
        # Extract neighbourhoods data
        if 'neighbourhood' in target_city_town:
            for neighbourhood in target_city_town['neighbourhood']:
                neighbourhood_data = {
                    'name':                  neighbourhood['name'],
                    'value':                 1
                }
                
                neighbourhoods.append(neighbourhood_data)
                total_count += 1
            #end for
        #end if
                
        return neighbourhoods, total_count
    #end get_neighbourhoods
    
    
    def get_country_info(self):
        
        """
        Get basic country information from loaded data.
        
        Returns:
            dict: Country information including name, population, census_year, etc.
            
        Raises:
            ValueError: If no data is loaded
        """
        
        if not self.data:
            raise ValueError("No geographic data loaded. Call load_data() first.")
        #end if
        
        return {
            'country':                      self.data.get('country'),
            'population':                   self.data.get('population'),
            'census_year':                  self.data.get('census_year'),
            'national_average_age':         self.data.get('national_average_age'),
            'national_male_population':     self.data.get('national_male_population'),
            'national_female_population':   self.data.get('national_female_population')
        }
    #end get_country_info
    
    
    def get_neighbourhood_info(self, neighbourhood_name, city_town_name, county_name, province_name):
        
        """
        Get detailed information for a specific neighbourhood.
        
        Args:
            neighbourhood_name (str): Name of the neighbourhood (e.g., "Temple Bar")
            city_town_name (str):     Name of the city/town (e.g., "Dublin City")
            county_name (str):        Name of the county (e.g., "Dublin")
            province_name (str):      Name of the province (e.g., "Leinster")
            
        Returns:
            dict: Neighbourhood information including name, postal_code, townlands, electoral_ward
            None: If neighbourhood not found
            
        Raises:
            ValueError: If no data is loaded
        """
        
        if not self.data:
            raise ValueError("No geographic data loaded. Call load_data() first.")
        #end if
        
        # Find the specified province
        target_province = None
        for province in self.data['provinces']:
            if province['name'].lower() == province_name.lower():
                target_province = province
                break
            #end if
        #end for
        
        if not target_province:
            if self.mylogger:
                self.mylogger.warning("Province '{province_name}' not found in data".format(
                    province_name = province_name
                ))
            #end if
            return None
        #end if
        
        # Find the specified county
        target_county = None
        for county in target_province.get('counties', []):
            if county['name'].lower() == county_name.lower():
                target_county = county
                break
            #end if
        #end for
        
        if not target_county:
            if self.mylogger:
                self.mylogger.warning("County '{county_name}' not found in province '{province_name}'".format(
                    county_name   = county_name,
                    province_name = province_name
                ))
            #end if
            return None
        #end if
        
        # Find the specified city/town
        target_city_town = None
        for city_town in target_county.get('cities_towns', []):
            if city_town['name'].lower() == city_town_name.lower():
                target_city_town = city_town
                break
            #end if
        #end for
        
        if not target_city_town:
            if self.mylogger:
                self.mylogger.warning("City/Town '{city_town_name}' not found in county '{county_name}', province '{province_name}'".format(
                    city_town_name = city_town_name,
                    county_name    = county_name,
                    province_name  = province_name
                ))
            #end if
            return None
        #end if
        
        # Find the specified neighbourhood
        target_neighbourhood = None
        for neighbourhood in target_city_town.get('neighbourhood', []):
            if neighbourhood['name'].lower() == neighbourhood_name.lower():
                target_neighbourhood = neighbourhood
                break
            #end if
        #end for
        
        if not target_neighbourhood:
            if self.mylogger:
                self.mylogger.warning("Neighbourhood '{neighbourhood_name}' not found in city/town '{city_town_name}', county '{county_name}', province '{province_name}'".format(
                    neighbourhood_name = neighbourhood_name,
                    city_town_name     = city_town_name,
                    county_name        = county_name,
                    province_name      = province_name
                ))
            #end if
            return None
        #end if
                
        
        # Return neighbourhood information
        return {
            'name':             target_neighbourhood.get('name'),
            'townlands':        target_neighbourhood.get('townlands', ''),
            'electoral_ward':   target_neighbourhood.get('electoral_ward', ''),
            'city_town':        city_town_name,
            'county':           county_name,
            'province':         province_name,
            'postal_code':      target_neighbourhood.get('postal_code', '')
        }
    #end get_neighbourhood_info
    
#end Class


# Convenience functions to maintain backward compatibility with existing code
def genAddress(fake, neighbourhood=None, town=None, county=None, provinces_state=None, country=None):
    
    """
    Backward compatibility function for existing code.
    
    Args:
        fake:                   Faker instance (should have GeographicDataProvider added)
        nighbourhood (str):     nighbourhood name
        town (str):             Town name
        county (str):           County name  
        provinces_state (str):  Province/state name
        country (str):          Country name
        
    Returns:
        dict: Address dictionary
    """
    
    if hasattr(fake, 'generate_address'):
        return fake.generate_address(town, county, provinces_state, country)
    
    else:
        # Fallback to original logic if provider not properly registered
        street_number   = fake.building_number()
        street_name     = fake.street_name()
        street_suffix   = fake.street_suffix()
        post_code       = fake.postcode()
        random_number   = random.randint(0, 99999)
        parcel_id       = f"{post_code}-{random_number:05d}"

        return {
            'street':           f"{street_number} {street_name} {street_suffix}",
            'neighbourhood':    neighbourhood, 
            'town':             town,
            'county':           county,
            'state':            provinces_state,
            'post_code':        post_code,
            'country':          country,
            'parcel_id':        parcel_id
        }
    #end if
#end genAddress


def get_provinces(data):
    
    """
    Backward compatibility function for existing code.
    
    Args:
        data (dict): Raw JSON data
        
    Returns:
        tuple: (provinces_list, total_population)
    """
    
    provinces        = []
    total_population = 0
    
    for province in data.get('provinces', []):
        province_data = {
            'name':  province['name'],
            'value': province.get('population', province.get('value', 0))
        }

        provinces.append(province_data)
        total_population += province_data['value']

    #end for
    return provinces, total_population
#end get_provinces

def get_counties(data, province_name):
    
    """
    Backward compatibility function for existing code.
    
    Args:
        data (dict):         Raw JSON data
        province_name (str): Name of the province
        
    Returns:
        tuple: (counties_list, total_population) or (None, None)
    """
    
    counties         = []
    total_population = 0
    
    # Find the specified province
    target_province = None
    for province in data.get('provinces', []):
        if province['name'].lower() == province_name.lower():
            target_province = province
            
            break
        #end if
    #end for
    
    if not target_province:
        return None, None
    #end if
    
    # Extract counties data
    for county in target_province.get('counties', []):
        county_data = {
            'name':  county['name'],
            'value': county.get('population', county.get('value', 0))
        }
    
        if 'average_age' in county:
            county_data['average_age'] = county['average_age']
        #end if
        
        counties.append(county_data)
        total_population += county_data['value']
    #end fo
    
    return counties, total_population
#end get_counties

def get_cities_towns(data, province_name, county_name):
    
    """
    Backward compatibility function for existing code.
    
    Args:
        data (dict):         Raw JSON data
        province_name (str): Name of the province
        county_name (str):   Name of the county
        
    Returns:
        tuple: (cities_towns_list, total_population) or (None, None)
    """
    
    cities_towns     = []
    total_population = 0
    
    # Find the specified province
    target_province = None
    for province in data.get('provinces', []):
        if province['name'].lower() == province_name.lower():
            target_province = province
            break
        #end if
    #end for
    
    if not target_province:
        return None, None
    #end if
    
    # Find the specified county
    target_county = None
    for county in target_province.get('counties', []):
        if county['name'].lower() == county_name.lower():
            target_county = county
            
            break
        #end if
    #end for
    
    if not target_county:
        return None, None
    #end if
    
    # Extract cities/towns data
    if 'cities_towns' in target_county:
        for city_town in target_county['cities_towns']:
            city_town_data = {
                'name':  city_town['name'],
                'value': city_town.get('population', city_town.get('value', 0))
            }
            
            # Add optional fields if they exist
            optional_fields = [
                'average_age', 
                'male_population', 
                'female_population', 
                'male_children', 
                'female_children', 
                'marital_status_percentages'
            ]
            for field in optional_fields:
                if field in city_town:
                    city_town_data[field] = city_town[field]
            #end for
            
            cities_towns.append(city_town_data)
            total_population += city_town_data['value']
        #end for
    #end if
    return cities_towns, total_population
#end get_cities_towns


def get_neighbourhoods(data, province_name, county_name, city_town_name):
    """
    Backward compatibility function for existing code.
    
    Args:
        data (dict):         Raw JSON data
        province_name (str): Name of the province
        county_name (str):   Name of the county
        city_town_name (str): Name of the city/town
        
    Returns:
        tuple: (neighbourhoods_list, total_count) or (None, None)
    """
    
    neighbourhoods = []
    total_count = 0
    
    # Find the specified province
    target_province = None
    for province in data.get('provinces', []):
        if province['name'].lower() == province_name.lower():
            target_province = province
            break
        #end if
    #end for
    
    if not target_province:
        return None, None
    #end if
    
    # Find the specified county
    target_county = None
    for county in target_province.get('counties', []):
        if county['name'].lower() == county_name.lower():
            target_county = county
            break
        #end if
    #end for
    
    if not target_county:
        return None, None
    #end if
    
    # Find the specified city/town
    target_city_town = None
    for city_town in target_county.get('cities_towns', []):
        if city_town['name'].lower() == city_town_name.lower():
            target_city_town = city_town
            break
        #end if
    #end for
    
    if not target_city_town:
        return None, None
    #end if
    
    # Extract neighbourhoods data
    if 'neighbourhood' in target_city_town:
        for neighbourhood in target_city_town['neighbourhood']:
            neighbourhood_data = {
                'name': neighbourhood['name'],
                'value': 1,  # Equal weight since no population data
                'postal_code': neighbourhood.get('postal_code', ''),
                'townlands': neighbourhood.get('townlands', ''),
                'electoral_ward': neighbourhood.get('electoral_ward', '')
            }
            
            neighbourhoods.append(neighbourhood_data)
            total_count += 1
        #end for
    #end if
    
    return neighbourhoods, total_count
#end get_neighbourhoods