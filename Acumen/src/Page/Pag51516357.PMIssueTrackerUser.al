#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516357 "PM Issue Tracker(User)"
{
    ApplicationArea = Basic;
    CardPageID = "Issue Input Card";
    Editable = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "PM Issue Tracker";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Module Code";"Module Code")
                {
                    ApplicationArea = Basic;
                }
                field("UAT Level";"UAT Level")
                {
                    ApplicationArea = Basic;
                }
                field("UAT Item";"UAT Item")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("USER ID";"USER ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assigned to";"Assigned to")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("surestep status";"surestep status")
                {
                    ApplicationArea = Basic;
                }
                field("Date Resolved SS";"Date Resolved SS")
                {
                    ApplicationArea = Basic;
                }
                field("Surestep Comments";"Surestep Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Status";"Customer Status")
                {
                    ApplicationArea = Basic;
                }
                field("User Comments";"User Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Date Raised";"Date Raised")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Resolved";"Date Resolved")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No";"Entry No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CoveragePercentStyle:='None';
        SetStyles;
    end;

    trigger OnOpenPage()
    begin
        SetRange("USER ID",UserId);
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle:='None';
        if "Customer Status"="customer status"::WIP then
          CoveragePercentStyle := 'Unfavorable';
        if "Customer Status"="customer status"::Rejected then
            CoveragePercentStyle := 'Unfavorable';
        if "Customer Status"="customer status"::Resolved then
            CoveragePercentStyle := 'favorable';
    end;
}

