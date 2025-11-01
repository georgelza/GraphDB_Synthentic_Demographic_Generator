MERGE (adlt:Adults {nationalId: event.nationalid}) 
ON CREATE SET adlt += {
  nationalId:     event.nationalid, 
  _id:            event._id, 
  name:           event.name, 
  surname:        event.surname, 
  gender:         event.gender, 
  dob:            event.dob, 
  marital_status: event.marital_status, 
  partner:        event.partner, 
  status:         event.status, 
  family_id:      event.family_id,
  parcel_id:      event.address.parcel_id,
  createdAt:      timestamp()
}
ON MATCH SET adlt += { 
  _id:            event._id, 
  name:           event.name, 
  surname:        event.surname, 
  gender:         event.gender, 
  dob:            event.dob, 
  marital_status: event.marital_status, 
  partner:        event.partner, 
  status:         event.status, 
  family_id:      event.family_id,
  parcel_id:      event.address.parcel_id,
  updatedAt:      timestamp()
}
