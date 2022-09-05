#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516290 "HR Medical Scheme Members Card"
{
    PageType = Card;
    SourceTable = "HR Medical Schemes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Scheme No"; "Scheme No")
                {
                    ApplicationArea = Basic;
                }
                // field("Employee No";"Employee No")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("First Name";"First Name")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Last Name";"Last Name")
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Designation;Designation)
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Department;Department)
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Scheme Join Date";"Scheme Join Date")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Scheme Anniversary";"Scheme Anniversary")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Out-Patient Limit";"Out-Patient Limit")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Cumm.Amount Spent Out";"Cumm.Amount Spent Out")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Balance Out- Patient";"Balance Out- Patient")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("In-patient Limit";"In-patient Limit")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Cumm.Amount Spent";"Cumm.Amount Spent")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Balance In- Patient";"Balance In- Patient")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Maximum Cover";"Maximum Cover")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Medical Claims")
                {
                    ApplicationArea = Basic;
                    Caption = 'Medical Claims';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Category4;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //  Medscheme.Reset;
        //  Medscheme.SetRange(Medscheme."Scheme No","Scheme No");
        //   if Medscheme.Find('-') then begin
        //  "Out-Patient Limit":=Medscheme."Out-patient limit";
        //  "In-patient Limit":=Medscheme."In-patient limit";
        //  "Balance In- Patient":="In-patient Limit"-"Cumm.Amount Spent";
        //  "Balance Out- Patient":="Out-Patient Limit"-"Cumm.Amount Spent Out";
        //   end;
    end;

    trigger OnInit()
    begin

        //  Medscheme.Reset;
        //  Medscheme.SetRange(Medscheme."Scheme No","Scheme No");
        //   if Medscheme.Find('-') then begin
        //  "Out-Patient Limit":=Medscheme."Out-patient limit";
        //  "In-patient Limit":=Medscheme."In-patient limit";
        //  "Balance In- Patient":="In-patient Limit"-"Cumm.Amount Spent";
        //  "Balance Out- Patient":="Out-Patient Limit"-"Cumm.Amount Spent Out";
        //   end;
    end;

    trigger OnOpenPage()
    begin
        //  Medscheme.Reset;
        //  Medscheme.SetRange(Medscheme."Scheme No","Scheme No");
        //   if Medscheme.Find('-') then begin
        //  "Out-Patient Limit":=Medscheme."Out-patient limit";
        //  "In-patient Limit":=Medscheme."In-patient limit";
        //  "Balance In- Patient":="In-patient Limit"-"Cumm.Amount Spent";
        //  "Balance Out- Patient":="Out-Patient Limit"-"Cumm.Amount Spent Out";
        //   end;
    end;

    var
        // objSchMembers: Record UnknownRecord55770;
        objScmDetails: Record "HR Medical Schemes";
        decInPatientBal: Decimal;
        Medscheme: Record "HR Medical Schemes";
}

