#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 130406 "CAL Test Coverage Map"
{
    Caption = 'CAL Test Coverage Map';
    Direction = Both;
    Format = VariableText;

    schema
    {
        textelement("<coverage>")
        {
            XmlName = 'Coverage';
            tableelement("CAL Test Coverage Map";"CAL Test Coverage Map")
            {
                AutoUpdate = true;
                XmlName = 'TestCoverageMap';
                fieldelement(TestCodeunitID;"CAL Test Coverage Map"."Test Codeunit ID")
                {
                }
                textelement(objtype)
                {
                    XmlName = 'ObjectType';

                    trigger OnBeforePassVariable()
                    var
                        "Integer": Integer;
                    begin
                        Integer := "CAL Test Coverage Map"."Object Type";
                        ObjType := Format(Integer,0,9);
                    end;

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("CAL Test Coverage Map"."Object Type",ObjType);
                    end;
                }
                fieldelement(ObjectID;"CAL Test Coverage Map"."Object ID")
                {
                }
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
}

