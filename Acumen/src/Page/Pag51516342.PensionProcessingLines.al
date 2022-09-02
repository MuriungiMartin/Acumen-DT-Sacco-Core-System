#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516342 "Pension Processing Lines"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "Pension Processing Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Pension No";"Pension No")
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
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Reff.";"Branch Reff.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Original Account No.";"Original Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Not Found";"Account Not Found")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Document No.";"Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("BOSA Schedule";"BOSA Schedule")
                {
                    ApplicationArea = Basic;
                }
                field(Closed;Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Multiple Salary";"Multiple Salary")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Bosa No";"Bosa No")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Header No.";"Salary Header No.")
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

        //SETRANGE(USER,USERID);
    end;
}

