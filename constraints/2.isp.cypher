
// Create indexes for efficient querying
CREATE INDEX ie_isp_id_index FOR (i:ISP) ON (i.id);
CREATE INDEX ie_isp_name_index FOR (i:ISP) ON (i.name);
CREATE INDEX ie_isp_asn_index FOR (i:ISP) ON (i.asn);
CREATE INDEX ie_isp_country_index FOR (i:ISP) ON (i.country);
CREATE INDEX ie_isp_type_index FOR (i:ISP) ON (i.type);
