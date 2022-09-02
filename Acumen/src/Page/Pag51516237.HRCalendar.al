#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516237 "HR Calendar"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Functions';
    SourceTable = "HR Setup1";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                label(Control2)
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755006)
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755008)
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755005)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
            }
            part(Control1102755000;"HR Non Working Days & Dates")
            {
            }
            part(Control1102755001;"Base Calendar Entries Subform")
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Effect Changes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Effect Changes';
                    Image = Save;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //HRCalendarList.SETRANGE(HRCalendarList.Code,Year);
                        HRCalendarList.SetRange("Non Working",true);
                        if HRCalendarList.Find('-') then
                        repeat
                        HRCalendarList."Non Working":=false;
                        HRCalendarList.Modify;
                        until HRCalendarList.Next=0;




                        HRCalendarList.Reset;
                        Report.Run(55529,true,true,HRCalendarList);
                        CurrPage.Update;
                    end;
                }
            }
        }
    }

    var
        HRCalendarList: Record "HR Calendar List";
        Day: Date;
}

