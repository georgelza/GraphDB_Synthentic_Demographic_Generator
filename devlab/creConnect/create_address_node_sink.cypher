MERGE (addr:Address {parcel_id: event.address.parcel_id}) 
ON CREATE SET addr += {
  parcel_id:      event.address.parcel_id, 
  street_1:       event.address.street_1, 
  street_2:       event.address.street_2, 
  town:           event.address.town, 
  county:         event.address.county, 
  province:       event.address.province, 
  country:        event.address.country, 
  postal_code:    event.address.postal_code, 
  country_code:   event.address.country_code, 
  neighbourhood:  event.address.neighbourhood,
  createdAt:      timestamp()
} 
ON MATCH SET addr += {
  street_1:       event.address.street_1, 
  street_2:       event.address.street_2, 
  town:           event.address.town, 
  county:         event.address.county, 
  province:       event.address.province, 
  country:        event.address.country, 
  postal_code:    event.address.postal_code, 
  country_code:   event.address.country_code, 
  neighbourhood:  event.address.neighbourhood,
  updatedAt:      timestamp()
}
