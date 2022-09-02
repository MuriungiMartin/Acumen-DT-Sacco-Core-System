#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516219 "HR Lookup Values Card"
{
    PageType = Card;
    SourceTable = "HR Lookup Values";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Only";"Supervisor Only")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Notice Period";"Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field(Closed;Closed)
                {
                    ApplicationArea = Basic;
                }
                field("Contract Length";"Contract Length")
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755023)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19024457;
                }
                field(Score;Score)
                {
                    ApplicationArea = Basic;
                }
                field("Current Appraisal Period";"Current Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Case Rating";"Disciplinary Case Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Action";"Disciplinary Action")
                {
                    ApplicationArea = Basic;
                }
                field(From;From)
                {
                    ApplicationArea = Basic;
                }
                field("To";"To")
                {
                    ApplicationArea = Basic;
                }
                field("Basic Salary";"Basic Salary")
                {
                    ApplicationArea = Basic;
                }
                field("To be cleared by";"To be cleared by")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified";"Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text19024457: label 'Months';
}

