#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50001 "FA DEP BOOK"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("FA Depreciation Book";"FA Depreciation Book")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(Mobile_No;"FA Depreciation Book"."FA No.")
                {
                }
                fieldelement(mn;"FA Depreciation Book"."Depreciation Book Code")
                {
                }
                fieldelement(a;"FA Depreciation Book"."Depreciation Method")
                {
                }
                fieldelement(b;"FA Depreciation Book"."Straight-Line %")
                {
                }
                fieldelement(c;"FA Depreciation Book"."FA Posting Group")
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

