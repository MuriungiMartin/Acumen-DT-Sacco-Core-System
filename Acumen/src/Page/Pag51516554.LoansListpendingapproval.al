#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516554 "Loans  List- pending approval"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Application Card(Pending)";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted=filter(false),
                            "Approval Status"=filter(Pending),
                            Source=const(BOSA));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No.";"Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";"Application Date")
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
                    Caption = 'Member  No';
                }
                field("Group Code";"Group Code")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name";"Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount";"Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount";"Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code";"Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status";"Loan Status")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By";"Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date";"Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Date of Completion";"Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                }
                field(Installments;Installments)
                {
                    ApplicationArea = Basic;
                }
                field(Repayment;Repayment)
                {
                    ApplicationArea = Basic;
                }
                field("Rejection  Remark";"Rejection  Remark")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Oustanding Interest";"Oustanding Interest")
                {
                    ApplicationArea = Basic;
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
        // ObjUserSetup.RESET;
        // ObjUserSetup.SETRANGE("User ID",USERID);
        // IF ObjUserSetup.FIND('-') THEN BEGIN
        //  IF ObjUserSetup."Approval Administrator"<>TRUE THEN
        //    SETRANGE("Captured By",USERID);
        //  END;
    end;

    var
        UserSet: Record User;
        ObjUserSetup: Record "User Setup";
}

