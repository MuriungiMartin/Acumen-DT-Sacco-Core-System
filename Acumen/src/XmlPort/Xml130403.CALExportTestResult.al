#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 130403 "CAL Export Test Result"
{
    Caption = 'CAL Export Test Result';
    Direction = Export;

    schema
    {
        textelement(TestResults)
        {
            tableelement("CAL Test Result";"CAL Test Result")
            {
                XmlName = 'TestResult';
                fieldelement(No;"CAL Test Result"."No.")
                {
                }
                fieldelement(TestRunNo;"CAL Test Result"."Test Run No.")
                {
                }
                fieldelement(CUId;"CAL Test Result"."Codeunit ID")
                {
                }
                fieldelement(CUName;"CAL Test Result"."Codeunit Name")
                {
                }
                fieldelement(FName;"CAL Test Result"."Function Name")
                {
                }
                fieldelement(Platform;"CAL Test Result".Platform)
                {
                }
                fieldelement(Result;"CAL Test Result".Result)
                {
                }
                fieldelement(Restore;"CAL Test Result".Restore)
                {
                }
                fieldelement(ExecutionTime;"CAL Test Result"."Execution Time")
                {
                }
                fieldelement(ErrorCode;"CAL Test Result"."Error Code")
                {
                }
                fieldelement(ErrorMessage;"CAL Test Result"."Error Message")
                {
                }
                fieldelement(File;"CAL Test Result".File)
                {
                }
                textelement(callstacktext)
                {
                    XmlName = 'CallStack';
                }

                trigger OnAfterGetRecord()
                var
                    InStr: InStream;
                begin
                    "CAL Test Result".CalcFields("Call Stack");
                    "CAL Test Result"."Call Stack".CreateInstream(InStr);
                    InStr.ReadText(CallStackText);
                end;

                trigger OnPreXmlItem()
                var
                    TestRunNo: Integer;
                begin
                    if SkipPassed then
                      "CAL Test Result".SetFilter(Result,'<>%1',"CAL Test Result".Result::Passed);

                    if LastTestRun then begin
                      TestRunNo := "CAL Test Result".LastTestRunNo;
                      "CAL Test Result".SetRange("Test Run No.",TestRunNo);
                    end;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        SkipPassed: Boolean;
        LastTestRun: Boolean;

    procedure SetParam(NewSkipPassed: Boolean;NewLastTestRun: Boolean)
    begin
        SkipPassed := NewSkipPassed;
        LastTestRun := NewLastTestRun;
    end;
}

