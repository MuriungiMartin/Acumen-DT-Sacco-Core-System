#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516925 "Crm Nos series Card"
{
    PageType = Card;
    SourceTable = "Crm General Setup.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Lead Nos";"Lead Nos")
                {
                    ApplicationArea = Basic;
                }
                field("General Enquiries Nos";"General Enquiries Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cases nos";"Cases nos")
                {
                    ApplicationArea = Basic;
                }
                field("Crm logs Nos";"Crm logs Nos")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

