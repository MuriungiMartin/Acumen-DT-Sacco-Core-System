#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516161 "HR Appraisal Period List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Lookup Values";
    SourceTableView = where(Type=filter("Appraisal Period"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Current Appraisal Period";"Current Appraisal Period")
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
                field("Last Date Modified";"Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control21;Outlook)
            {
            }
            systempart(Control22;Notes)
            {
            }
            systempart(Control23;MyNotes)
            {
            }
            systempart(Control24;Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Close Period")
            {
                ApplicationArea = Basic;
                Caption = 'Close Period';
                Image = CloseYear;
                Promoted = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close the current period') then begin
                     //----Mark this current period as closed---------------------------------------------------
                      objCurrPeriod.Reset;
                      objCurrPeriod.SetRange(objCurrPeriod.Type,objCurrPeriod.Type::"Appraisal Period");
                      objCurrPeriod.SetRange(objCurrPeriod."Current Appraisal Period",true);
                      if objCurrPeriod.Find('-') then begin
                         NewToDate:=CalcDate('3M',objCurrPeriod."To");
                         NewFromDate:=CalcDate('3M',objCurrPeriod.From);
                         CurrFromDate:=objCurrPeriod.From;
                         CurrToDate:=objCurrPeriod."To";
                         currPeriod:=objCurrPeriod.Code;
                         objCurrPeriod."Current Appraisal Period":=false;
                         objCurrPeriod.Closed:=true;
                         objCurrPeriod.Modify;

                         strNewPeriodDesc:=Format(NewFromDate,0,'<Month Text,3> <Year4>');

                     //---Insert the new appraisal period-------------------------------------------------------
                           objNewPeriod.Init;
                           objNewPeriod.Code:=strNewPeriodDesc;
                           objNewPeriod.Type:=objNewPeriod.Type::"Appraisal Period";
                           objNewPeriod.Description:=strNewPeriodDesc;
                           objNewPeriod.Closed:=false;
                           objNewPeriod."Current Appraisal Period":=true;
                           objNewPeriod.From:=NewFromDate;
                           objNewPeriod."To":=NewToDate;
                           objNewPeriod."Previous Appraisal Code":=objCurrPeriod.Code;
                           if objCurrPeriod."Appraisal Stage"=objCurrPeriod."appraisal stage"::"Target Setting" then
                            objNewPeriod."Appraisal Stage":=objNewPeriod."appraisal stage"::FirstQuarter
                           else if objCurrPeriod."Appraisal Stage"=objCurrPeriod."appraisal stage"::FirstQuarter then
                            objNewPeriod."Appraisal Stage":=objNewPeriod."appraisal stage"::SecondQuarter
                           else if objCurrPeriod."Appraisal Stage"=objCurrPeriod."appraisal stage"::SecondQuarter then
                            objNewPeriod."Appraisal Stage":=objNewPeriod."appraisal stage"::ThirdQuarter
                           else if objCurrPeriod."Appraisal Stage"=objCurrPeriod."appraisal stage"::ThirdQuarter then
                            objNewPeriod."Appraisal Stage":=objNewPeriod."appraisal stage"::EndYearEvaluation;

                           objNewPeriod.Insert;

                       Message('You have successfully closed and Created a new period');
                     end;
                    end;
                end;
            }
        }
    }

    var
        objCurrPeriod: Record "HR Lookup Values";
        objHRSetup: Record "HR Setup";
        decMonths: Decimal;
        objNewPeriod: Record "HR Lookup Values";
        strNewPeriodDesc: Text;
        NewFromDate: Date;
        NewToDate: Date;
        objAppraisalHeader: Record "HR Appraisal Header";
        objAppraisalLine: Record "HR Appraisal Lines";
        CurrFromDate: Date;
        CurrToDate: Date;
        currPeriod: Code[50];
        objNewAppraisalHeader: Record "HR Appraisal Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "HR Setup";
        objNewAppraisalHeaderX: Record "HR Appraisal Header";


    procedure newAppraisalStage() newAppraisalStage: Text
    begin
    end;
}

