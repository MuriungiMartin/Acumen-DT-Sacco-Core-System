#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516993 "CRM Training Suppliers"
{
    PageType = ListPart;
    SourceTable = "CRM Training Suppliers";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supplier Vendor No";"Supplier Vendor No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Trainer/Supplier No';
                }
                field("Supplier Name";"Supplier Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Narration;Narration)
                {
                    ApplicationArea = Basic;
                }
                field(Cost;Cost)
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

