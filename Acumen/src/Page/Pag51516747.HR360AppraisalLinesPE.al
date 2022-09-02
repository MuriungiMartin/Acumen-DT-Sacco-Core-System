#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516747 "HR 360 Appraisal Lines - PE"
{
    Caption = 'HR Appraisal Lines - Employee Peers';
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";
    SourceTableView = where("Categorize As"=const("Employee's Peers"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sub Category";"Sub Category")
                {
                    ApplicationArea = Basic;
                }
                field("Perfomance Goals and Targets";"Perfomance Goals and Targets")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Target Score";"Min. Target Score")
                {
                    ApplicationArea = Basic;
                }
                field("Max Target Score";"Max Target Score")
                {
                    ApplicationArea = Basic;
                }
                field("Peer Rating";"Peer Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Peer Comments";"Peer Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Comments";"Employee Comments")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Categorize As":="categorize as"::"Employee's Peers";
    end;
}

