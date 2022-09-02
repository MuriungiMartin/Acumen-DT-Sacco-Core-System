#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516347 "Products Signatories Details"
{
    CardPageID = "FOSA Account Signatories Card";
    Editable = false;
    PageType = List;
    SourceTable = "FOSA Account Sign. Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Names;Names)
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No.";"BOSA No.")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth";"Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Signatory;Signatory)
                {
                    ApplicationArea = Basic;
                }
                field("Must Sign";"Must Sign")
                {
                    ApplicationArea = Basic;
                }
                field("Must be Present";"Must be Present")
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date";"Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Sections Code";"Sections Code")
                {
                    ApplicationArea = Basic;
                }
                field("Company Code";"Company Code")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address";"Email Address")
                {
                    ApplicationArea = Basic;
                }
                field(Picture;Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature;Signature)
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

