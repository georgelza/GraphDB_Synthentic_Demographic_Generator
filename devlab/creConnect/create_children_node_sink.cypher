MERGE (t:Children {nationalid: event.nationalid}) 
ON CREATE SET t += {
  nationalid:         event.nationalid, 
  _id:                event._id, 
  name:               event.name, 
  surname:            event.surname, 
  gender:             event.gender, 
  dob:                event.dob, 
  family_id:          event.family_id, 
  father_nationalid:  event.father_nationalid, 
  mother_nationalid:  event.mother_nationalid, 
  parcel_id:          event.address.parcel_id,
  createdAt:          timestamp()
}
ON MATCH SET t += { 
  _id:                event._id, 
  name:               event.name, 
  surname:            event.surname, 
  gender:             event.gender, 
  dob:                event.dob, 
  family_id:          event.family_id, 
  father_nationalid:  event.father_nationalid, 
  mother_nationalid:  event.mother_nationalid, 
  parcel_id:          event.address.parcel_id,
  updatedAt:          timestamp()
}

