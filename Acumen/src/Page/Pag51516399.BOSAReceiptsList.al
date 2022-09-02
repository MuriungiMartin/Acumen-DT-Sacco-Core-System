#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516399 "BOSA Receipts List"
{
    ApplicationArea = Basic;
    CardPageID = "BOSA Receipt Card";
    Editable = false;
    PageType = List;
    SourceTable = "Receipts & Payments";
    SourceTableView = where(Posted=filter(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction No.";"Transaction No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No.";"Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employer No.";"Employer No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipting Bank';
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        ObjUserSetup.Reset;
        ObjUserSetup.SetRange("User ID",UserId);
        if ObjUserSetup.Find('-') then begin
          //IF ObjUserSetup."Approval Administrator"<>TRUE THEN
            SetRange("User ID",UserId);
          end;
    end;

    var
        ObjUserSetup: Record "User Setup";
}

