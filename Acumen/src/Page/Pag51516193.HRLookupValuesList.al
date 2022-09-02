#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516193 "HR Lookup Values List"
{
    CardPageID = "HR Lookup Values Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Lookup Values";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004;"HR Lookup Values Factbox")
            {
                SubPageLink = Type=field(Type);
            }
        }
    }

    actions
    {
    }
}

