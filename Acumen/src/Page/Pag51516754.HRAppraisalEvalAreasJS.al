#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516754 "HR Appraisal Eval Areas - JS"
{
    ApplicationArea = Basic;
    Caption = 'HR Appraisal Evaluation Areas - Job Specific';
    PageType = List;
    SourceTable = "HR Appraisal Eval Areas";
    SourceTableView = where("Categorize As"=const("Job Specific"));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        TestField(Code);
                    end;
                }
                field("Assign To";"Assign To")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        TestField(Description);
                    end;
                }
                field("Assigned To";"Assigned To")
                {
                    ApplicationArea = Basic;
                }
                field("Categorize As";"Categorize As")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub Category";"Sub Category")
                {
                    ApplicationArea = Basic;
                }
                field("Include in Evaluation Form";"Include in Evaluation Form")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period";"Appraisal Period")
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
        "Categorize As":="categorize as"::"Job Specific";
        "Include in Evaluation Form":=true;
    end;
}

