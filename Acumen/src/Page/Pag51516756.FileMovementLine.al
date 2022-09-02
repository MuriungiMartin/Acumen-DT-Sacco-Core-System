#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516756 "File Movement Line"
{
    PageType = ListPart;
    SourceTable = "File Movement Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("File Type";"File Type")
                {
                    ApplicationArea = Basic;
                }
                field("File Number";"File Number")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Destination File Location";"Destination File Location")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Purpose/Description";"Purpose/Description")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
            }
        }
    }

    actions
    {
    }
}

