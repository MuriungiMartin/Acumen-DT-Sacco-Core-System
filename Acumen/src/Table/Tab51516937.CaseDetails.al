#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516937 "Case Details"
{

    fields
    {
        field(1;"Case No";Code[20])
        {
        }
        field(2;"Case Type";Option)
        {
            OptionCaption = ' ,Enquiry,Request,Appreciation,Complaint,Criticism,Payment,Receipt,Loan Form,Housing';
            OptionMembers = " ",Enquiry,Request,Appreciation,Complaint,Criticism,Payment,Receipt,"Loan Form",Housing;
        }
        field(3;"Case Details";Text[100])
        {
        }
    }

    keys
    {
        key(Key1;"Case No","Case Type","Case Details")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

