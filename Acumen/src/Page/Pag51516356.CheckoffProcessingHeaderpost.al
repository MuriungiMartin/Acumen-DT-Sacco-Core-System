#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516356 "Checkoff Processing Headerpost"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "CheckoffHeader-Distribut poly";
    SourceTableView = where(Posted=const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By";"Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Entered";"Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date";"Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date";"Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count";"Total Count")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";"Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Name";"Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount";"Scheduled Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Interest Amount";"Interest Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
            }
            part("Checkoff Lines-Distributed";"Checkoff Proc Lines-D")
            {
                Caption = 'Checkoff Lines-Distributed';
                SubPageLink = "Receipt Header No"=field(No);
            }
        }
    }

    actions
    {
    }
}

