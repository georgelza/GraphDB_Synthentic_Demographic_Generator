MERGE (t:Adults {nationalid: event.nationalid}) 
ON CREATE SET t += {
  nationalid: event.nationalid, 
  _id: event._id, 
  name: event.name, 
  surname: event.surname, 
  gender: event.gender, 
  dob: event.dob, 
  marital_status: event.marital_status, 
  partner: event.partner, 
  status: event.status, 
  parcel_id: event.address.parcel_id
}
ON MATCH SET t += { 
  _id: event._id, 
  name: event.name, 
  surname: event.surname, 
  gender: event.gender, 
  dob: event.dob, 
  marital_status: event.marital_status, 
  partner: event.partner, 
  status: event.status, 
  parcel_id: event.address.parcel_id
}

