MERGE (t:Address {parcel_id: event.address.parcel_id}) 
ON CREATE SET t += {
  parcel_id: event.address.parcel_id, 
  street_1: event.address.street_1, 
  street_2: event.address.street_2, 
  town: event.address.town, 
  county: event.address.county, 
  province: event.address.province, 
  country: event.address.country, 
  postal_code: event.address.postal_code, 
  country_code: event.address.country_code, 
  neighbourhood: event.address.neighbourhood
} 
ON MATCH SET t += {
  street_1: event.address.street_1, 
  street_2: event.address.street_2, 
  town: event.address.town, 
  county: event.address.county, 
  province: event.address.province, 
  country: event.address.country, 
  postal_code: event.address.postal_code, 
  country_code: event.address.country_code, 
  neighbourhood: event.address.neighbourhood
}


