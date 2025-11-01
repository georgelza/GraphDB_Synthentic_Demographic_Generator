WITH event as data
UNWIND data.account AS card
WITH data, card WHERE card.cardNumber IS NOT NULL
MERGE (acc:Card {cardNumber: card.cardNumber})
ON CREATE SET acc += {
  nationalId:   data.nationalid,
  cardHolder:   card.cardHolder,
  cardNumber:   card.cardNumber,
  expDate:      card.expDate,
  cardNetwork:  card.cardNetwork,  
  issuingBank:  card.issuingBank,
  createdAt:    timestamp()
}
ON MATCH SET acc += {
  cardHolder:   card.cardHolder,
  cardNumber:   card.cardNumber,
  expDate:      card.expDate,
  cardNetwork:  card.cardNetwork,
  issuingBank:  card.issuingBank,
  updatedAt:    timestamp()
}
