#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516931 "Customer Risk Rating"
{

    fields
    {
        field(1;Category;Option)
        {
            OptionCaption = ' ,Individuals,Entities,Residency Status,Industry,Length Of Relationship,International Trade';
            OptionMembers = " ",Individuals,Entities,"Residency Status",Industry,"Length Of Relationship","International Trade";
        }
        field(2;"Sub Category";Text[50])
        {
        }
        field(3;"Inherent Risk Rating";Option)
        {
            OptionCaption = 'Low,Medium,High';
            OptionMembers = Low,Medium,High;
        }
        field(4;"Risk Score";Decimal)
        {
        }
        field(5;"Min Relationship Length(Years)";Integer)
        {
        }
        field(6;"Max Relationship Length(Years)";Integer)
        {
        }
        field(7;"Sub Category Option";Option)
        {
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 to 1 Year,1 to 3 Years,Trade/Export Finance,Local Trade,>3';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade",">3";
        }
    }

    keys
    {
        key(Key1;Category,"Sub Category","Sub Category Option","Min Relationship Length(Years)")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

