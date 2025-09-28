// MOBILE DEVICE NUMBERS (Irish Format)
// Linked with Person based on ID Number.
// A single Id Number can have multiple mobile_numbers associated with it.

MERGE (n:Mobile_device {mobile_number: "087-652-3328"})
ON CREATE SET n = {
    mobile_number: "087-652-3328",
    pps: "1234567A"
}
RETURN n;

MERGE (n:Mobile_device {mobile_number: "085-652-3378"})
ON CREATE SET n = {
    mobile_number: "085-652-3378",
    pps: "4682851D"
}
RETURN n;

MERGE (n:Mobile_device {mobile_number: "086-552-3328"})
ON CREATE SET n = {
    mobile_number: "086-552-3328",
    pps: "3519274C"
}
RETURN n;

MERGE (n:Mobile_device {mobile_number: "083-552-3289"})
ON CREATE SET n = {
    mobile_number: "083-552-3289",
    pps: "3519274C"
}
RETURN n;

MERGE (n:Mobile_device {mobile_number: "089-322-3328"})
ON CREATE SET n = {
    mobile_number: "089-322-3328",
    pps: "7395168G"
}
RETURN n;
