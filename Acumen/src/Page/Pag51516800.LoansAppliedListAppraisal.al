#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516800 "Loans Applied  List(Appraisal)"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Application Card(New)";
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted=filter(false),
                            "Approval Status"=filter(Open),
                            Source=filter(BOSA),
                            Discard=filter(true),
                            "Loan Status"=const(Appraisal));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000010)
            {
                field("Loan  No.";"Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code";"Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name";"Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID NO";"ID NO")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No";"Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
                field(Source;Source)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status";"Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001;"Member Statistics FactBox")
            {
                SubPageLink = "No."=field("Client Code");
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //IF UserSet.GET(USERID) THEN BEGIN
        //SETRANGE("Captured By",USERID);
        //END;
        ObjUserSetup.Reset;
        ObjUserSetup.SetRange("User ID",UserId);
        if ObjUserSetup.Find('-') then begin
          if ObjUserSetup."Approval Administrator"<>true then
            SetRange("Captured By",UserId);
          end;
    end;

    var
        UserSet: Record User;
        ObjUserSetup: Record "User Setup";
}

