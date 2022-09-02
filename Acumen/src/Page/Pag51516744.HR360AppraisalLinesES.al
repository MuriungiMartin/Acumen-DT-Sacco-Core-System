#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516744 "HR 360 Appraisal Lines - ES"
{
    Caption = 'HR Appraisal Lines - Employee Subordinates';
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";
    SourceTableView = where("Categorize As"=const("Employee's Subordinates"));

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
                field("Sub-ordinates Rating";"Sub-ordinates Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Subordinates Comments";"Subordinates Comments")
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
        "Categorize As":="categorize as"::"Employee's Subordinates";
    end;
}

