#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516246 "HR Appraisal Assignment"
{
    // DrillDownPageID = UnknownPage55558;
    // LookupPageID = UnknownPage55558;

    fields
    {
        field(1;"Employee Code";Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(2;"Line No";Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(3;"Categorize As";Option)
        {
            Description = 'Employee''s Subordinates,Employee''s Peers,External Sources,Job Specific,Self Evaluation';
            OptionCaption = ' ,Employee''s Subordinates,Employee''s Peers,Vendor,Customer';
            OptionMembers = " ","Employee's Subordinates","Employee's Peers",Vendor,Customer;
        }
        field(4;No;Code[20])
        {
            TableRelation = if ("Categorize As"=const(Vendor)) Vendor."No."
                            else if ("Categorize As"=const(Customer)) Customer."No."
                            else if ("Categorize As"=const("Employee's Subordinates")) "HR Employees"."No."
                            else if ("Categorize As"=const("Employee's Peers")) "HR Employees"."No.";

            trigger OnValidate()
            begin
                case "Categorize As" of
                  //Vendor
                  "categorize as"::Vendor:
                      begin
                          Vendor.Reset;
                          if Vendor.Get(No) then
                          begin
                              Name:=Vendor.Name;
                              "E-Mail":=Vendor."E-Mail";
                          end else
                          begin
                              Name:='';
                              "E-Mail":='';
                          end;
                       end;

                  //Customer
                  "categorize as"::Customer:
                      begin
                          Customer.Reset;
                          if Customer.Get(No) then
                          begin
                              Name:=Customer.Name;
                              "E-Mail":=Customer."E-Mail";
                          end else
                          begin
                              Name:='';
                              "E-Mail":='';
                          end;
                       end;

                  //Subordinates
                  "categorize as"::"Employee's Subordinates":
                      begin
                          HREmp.Reset;
                          if HREmp.Get(No) then
                          begin
                              Name:=HREmp."First Name" + ' ' +HREmp."Middle Name" + ' ' + HREmp."Last Name";
                              "E-Mail":=HREmp."E-Mail";
                          end else
                          begin
                              Name:='';
                              "E-Mail":='';
                          end;
                       end;

                  //Employee Peers
                  "categorize as"::"Employee's Peers":
                      begin
                          HREmp.Reset;
                          if HREmp.Get(No) then
                          begin
                              Name:=HREmp."First Name" + ' ' +HREmp."Middle Name" + ' ' + HREmp."Last Name";
                              "E-Mail":=HREmp."E-Mail";
                          end else
                          begin
                              Name:='';
                              "E-Mail":='';
                          end;
                       end;

                  //Blank
                  "categorize as"::" ":
                      begin
                         Name:='';
                         "E-Mail":='';
                       end;

                end;
            end;
        }
        field(5;Name;Text[100])
        {
        }
        field(6;"E-Mail";Text[100])
        {
            FieldClass = Normal;
        }
    }

    keys
    {
        key(Key1;"Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Vendor: Record Vendor;
        Customer: Record Customer;
        HREmp: Record "HR Employees";
}

