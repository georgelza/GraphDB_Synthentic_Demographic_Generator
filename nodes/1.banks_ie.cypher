// Irish Bank SWIFT Codes:
//
// Bank of Ireland (BOI):       BOFIIE2D
// Allied Irish Banks (AIB):    AIBKIE2D
// Permanent TSB (PTSB):        IPTSIEDD
// Ulster Bank Ireland (UBI):   ULSBIE2D
//
// Code Breakdown:
//
// BOFI + IE + 2D = Bank of Ireland + Ireland + Dublin
// AIBK + IE + 2D = AIB + Ireland + Dublin
// IPTS + IE + DD = Permanent TSB + Ireland + Dublin
// ULSB + IE + 2D = Ulster Bank + Ireland + Dublin

// 4 letters: Bank identifier
// 2 letters: Country code (IE for Ireland)
// 2 characters: Location code (2D/DD for Dublin)

// => See project_root/data/ie_banks.json for the source data,
// => see project_root/data/load_banks.cypher for loading the bank information.
