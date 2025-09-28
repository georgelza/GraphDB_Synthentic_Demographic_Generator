//
MERGE (n:emailAddresss {email: "seanbrien@hotmail.com"})
ON CREATE SET n = {
    email: "seanbrien@hotmail.com",
    pps: "1234567A",
    issueDate: "2016/08/12"
}
ON MATCH SET n = {
    pps: "1234567A",
    issueDate: "2016/08/12"
}
RETURN n;


MERGE (n:emailAddresss {email: "brienfamily@gmail.com"})
ON CREATE SET n = {
    email: "brienfamily@gmail.com",
    pps: "1234567A",
    issueDate: "2018/08/12"
}
ON MATCH SET n = {
    pps: "1234567A",
    issueDate: "2018/08/12"
}
RETURN n;


MERGE (n:emailAddresss {email: "Murphy@eastcork.com"})
ON CREATE SET n = {
    email: "Murphy@eastcork.com",
    pps: "3519274C",
    issueDate: "1996/08/12"
}
ON MATCH SET n = {
    pps: "3519274C",
    issueDate: "1996/08/12"
}
RETURN n;

MERGE (n:emailAddresss {email: "McMcMurphy@orixcomlimited.com"})
ON CREATE SET n = {
    email: "McMcMurphy@orixcomlimited.com",
    pps: "3519274C",
    issueDate: "1996/08/12"
}
ON MATCH SET n = {
    pps: "3519274C",
    issueDate: "1996/08/12"
}
RETURN n;


// Corporate
// AeroMat
MERGE (n:emailAddresss {email: "customer@AeroMat.com"})
ON CREATE SET n = {
    email: "customer@AeroMat.com",
    regId: "1978/0001/1022",
    issueDate: "2002/08/12"
}
ON MATCH SET n = {
    regId: "1978/0001/1022",
    issueDate: "2002/08/12"
}
RETURN n;

MERGE (n:emailAddresss {email: "sales@AeroMat.com"})
ON CREATE SET n = {
    email: "sales@AeroMat.com",
    regId: "1978/0001/1022",
    issueDate: "2002/08/12"
}
ON MATCH SET n = {
    regId: "1978/0001/1022",
    issueDate: "2002/08/12"
}
RETURN n;

MERGE (n:emailAddresss {email: "support@AeroMat.com"})
ON CREATE SET n = {
    email: "support@AeroMat.com",
    regId: "1978/0001/1022",
    issueDate: "2002/08/12"
}
ON MATCH SET n = {
    regId: "1978/0001/1022",
    issueDate: "2002/08/12"
}
RETURN n;

MERGE (n:emailAddresss {email: "McCarthy0102@telemat.com"})
ON CREATE SET n = {
    email: "McCarthy0102@telemat.com",
    pps: "4682851D",
    issueDate: "2002/08/12"
}
ON MATCH SET n = {
    pps: "4682851D",
    issueDate: "2002/08/12"
}
RETURN n;


MERGE (n:emailAddresss {email: "Walsh@AeroMat.com"})
ON CREATE SET n = {
    email: "Walsh@AeroMat.com",
    pps: "5746392E",
    regId: "1978/0001/1022",
    issueDate: "2004/08/12"
}
ON MATCH SET n = {
    pps: "5746392E",
    regId: "1978/0001/1022",
    issueDate: "2004/08/12"
}
RETURN n;

MERGE (n:emailAddresss {email: "darwal@gmail.com"})
ON CREATE SET n = {
    email: "darwal@gmail.com",
    pps: "5746392E",
    issueDate: "2004/08/12"
}
ON MATCH SET n = {
    pps: "5746392E",
    issueDate: "2004/08/12"
}
RETURN n;

MERGE (n:emailAddresss {email: "ConorB04@gmail.com"})
ON CREATE SET n = {
    email: "ConorB04@gmail.com",
    pps: "6283947F",
    issueDate: "2010/02/12"
}
ON MATCH SET n = {
    pps: "6283947F",
    issueDate: "2010/02/12"
}
RETURN n;

MERGE (n:emailAddresss {email: "redcian@rapibservices.com"})
ON CREATE SET n = {
    email: "redcian@rapibservices.com",
    pps: "7395168G",
    issueDate: "2015/03/12"
}
ON MATCH SET n = {
    pps: "7395168G",
    issueDate: "2015/03/12"
}
RETURN n;

MERGE (n:emailAddresss {email: "irishConnor@limerick.com"})
ON CREATE SET n = {
    email: "irishConnor@limerick.com",
    pps: "8461725H",
    issueDate: "2022/03/12"
}
ON MATCH SET n = {
    pps: "8461725H",
    issueDate: "2022/03/12"
}
RETURN n;

MERGE (n:emailAddresss {email: "Connor@aluaengineering.com"})
ON CREATE SET n = {
    email: "Connor@aluaengineering.com",
    regId: "2011/0201/1185",
    issueDate: "2022/03/12"
}
ON MATCH SET n = {
    regId: "2011/0201/1185",
    issueDate: "2022/03/12"
}
RETURN n;

MERGE (n:emailAddresss {email: "niamh011@hotmail.com"})
ON CREATE SET n = {
    email: "niamh011@hotmail.com",
    pps: "9572840J",
    issueDate: "2023/11/12"
}
ON MATCH SET n = {
    pps: "9572840J",
    issueDate: "2023/11/12"
}
RETURN n;

MERGE (n:emailAddresss {email: "marketing@aluaengineering.com"})
ON CREATE SET n = {
    email: "marketing@aluaengineering.com",
    regId: "2011/0201/1185",
    pps: "9572840J",
    issueDate: "2020/11/12"
}
ON MATCH SET n = {
    regId: "2011/0201/1185",
    pps: "9572840J",
    issueDate: "2020/11/12"
}
RETURN n;
