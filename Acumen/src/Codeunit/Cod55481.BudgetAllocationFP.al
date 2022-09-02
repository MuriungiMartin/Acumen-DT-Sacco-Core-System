#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 55481 "Budget Allocation FP"
{

    trigger OnRun()
    begin
    end;


    procedure AutoAllocatePurch(var Rec: Record UnknownRecord55930)
    var
        Budget: Record "Item Budget Name";
        DimVal: Record "Dimension Value";
        GLBudgetEntry: Record "Item Budget Entry";
        IntC: Integer;
        NewDate: Date;
        Period: Text[30];
        Amnt: Decimal;
        EntryNo: Integer;
        GL: Record Item;
    begin
        with Rec do begin
        
        //check if the date inserted as the start date is greater than the end date
        if ("Start Date">"End Date") then
          begin
            Error('Ending Date must BE greater than or equal to start date');
          end;
        /*Get the new date selected by the user first*/
        NewDate:="Start Date";
        /*Get the period*/
        if "Period Type"="period type"::"0" then
          begin
            Period:='D';
          end
        else if "Period Type"="period type"::"1" then
          begin
            Period:='W';
          end
        else if "Period Type"="period type"::"2" then
          begin
            Period:='M';
          end
        else if "Period Type"="period type"::"3" then
          begin
            Period:='Q';
          end
        else
          begin
            Period:='Y';
          end;
        /*Initiate the loop*/
        while NewDate<="End Date"
          do
            begin
              IntC:=IntC +1;
              NewDate:=CalcDate('1' + Period,NewDate);
            end;
        /*Number of times to divide amount has been identified*/
        /*Get the amount and get the amount per period identified*/
        
        Amnt:=Amount/IntC;
        
        /*Get the entry number*/
        GLBudgetEntry.Reset;
        if GLBudgetEntry.Find('+') then
          begin
            EntryNo:=GLBudgetEntry."Entry No.";
          end
        else
          begin
            EntryNo:=0;
          end;
        
        EntryNo:=EntryNo +1;
        /*Check if the user wishes to overwrite the details already in the system*/
        if Overwrite=true then
          begin
            GLBudgetEntry.Reset;
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Name",Name);
            GLBudgetEntry.SetRange(GLBudgetEntry."Item No.","Item No");
            GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 1 Code","Global Dimension 1 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 2 Code","Global Dimension 2 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 1 Code","Budget Dimension 1 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 2 Code","Budget Dimension 2 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 3 Code","Budget Dimension 3 Code");
            if GLBudgetEntry.Find('-') then
              begin
                GLBudgetEntry.DeleteAll;
              end;
          end;
        
        /*Reset the new date*/
        NewDate:="Start Date";
        /*Initiate the loop to save the details into the table*/
        while NewDate<="End Date"
          do
            begin
            GLBudgetEntry.Init;
            GLBudgetEntry."Entry No.":=EntryNo;
        
            GLBudgetEntry."Analysis Area":=GLBudgetEntry."analysis area"::Purchase;
        
            GLBudgetEntry."Budget Name":=Name;
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Name");
        
            GLBudgetEntry."Item No.":="Item No";
            GLBudgetEntry.Validate(GLBudgetEntry."Item No.");
        //    GL.RESET;
        //    GL.GET("Item No");
        //      Forced to comment out by TChibo
        //    GLBudgetEntry."Item G/L Sales Account":=GL."Item G/L Sales Account";
        //    GLBudgetEntry."Item G/L Cost Account":=GLBudgetEntry."Item G/L Cost Account";
            GLBudgetEntry."Global Dimension 1 Code":="Global Dimension 1 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 1 Code");
        
            GLBudgetEntry."Global Dimension 2 Code":="Global Dimension 2 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 2 Code");
        
            GLBudgetEntry."Budget Dimension 1 Code":="Budget Dimension 1 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 1 Code");
        
            GLBudgetEntry."Budget Dimension 2 Code":="Budget Dimension 2 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 2 Code");
        
            GLBudgetEntry."Budget Dimension 3 Code":="Budget Dimension 3 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 3 Code");
        
            GLBudgetEntry.Date:=NewDate;
        
        
            if "Show As"="show as"::"0" then
              begin
                GLBudgetEntry."Sales Amount":=Amnt;
              end
            else if "Show As"="show as"::"1" then
              begin
                GLBudgetEntry.Quantity:=Amnt;
              end
            else if "Show As"="show as"::"2" then
              begin
                GLBudgetEntry."Cost Amount":=Amnt;
              end;
        
            GLBudgetEntry."User ID":=UserId;
        
            GLBudgetEntry.Insert;
            NewDate:=CalcDate('1' + Period ,NewDate);
            EntryNo:=EntryNo + 1;
            end;
            Processed:=true;
            Rec."User ID":=UserId;
            Modify;
        Message('Budgetary Allocation Complete');
        
        end;
        Rec.Delete;

    end;


    procedure AutoAllocateSale(var Rec: Record UnknownRecord55932)
    var
        Budget: Record "Item Budget Name";
        DimVal: Record "Dimension Value";
        GLBudgetEntry: Record "Item Budget Entry";
        IntC: Integer;
        NewDate: Date;
        Period: Text[30];
        Amnt: Decimal;
        EntryNo: Integer;
        GL: Record Item;
    begin
        with Rec do begin
        
        //check if the date inserted as the start date is greater than the end date
        if ("Start Date">"End Date") then
          begin
            Error('Ending Date must BE greater than or equal to start date');
          end;
        
        /*Get the new date selected by the user first*/
        NewDate:="Start Date";
        /*Get the period*/
        if "Period Type"="period type"::"0" then
          begin
            Period:='D';
          end
        else if "Period Type"="period type"::"1" then
          begin
            Period:='W';
          end
        else if "Period Type"="period type"::"2" then
          begin
            Period:='M';
          end
        else if "Period Type"="period type"::"3" then
          begin
            Period:='Q';
          end
        else
          begin
            Period:='Y';
          end;
        /*Initiate the loop*/
        while NewDate<="End Date"
          do
            begin
              IntC:=IntC +1;
              NewDate:=CalcDate('1' + Period,NewDate);
            end;
        /*Number of times to divide amount has been identified*/
        /*Get the amount and get the amount per period identified*/
        
        Amnt:=Amount/IntC;
        
        /*Get the entry number*/
        GLBudgetEntry.Reset;
        if GLBudgetEntry.Find('+') then
          begin
            EntryNo:=GLBudgetEntry."Entry No.";
          end
        else
          begin
            EntryNo:=0;
          end;
        EntryNo:=EntryNo +1;
        /*Check if the user wishes to overwrite the details already in the system*/
        if Overwrite=true then
          begin
            GLBudgetEntry.Reset;
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Name",Name);
            GLBudgetEntry.SetRange(GLBudgetEntry."Item No.","Item No");
            GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 1 Code","Global Dimension 1 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 2 Code","Global Dimension 2 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 1 Code","Budget Dimension 1 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 2 Code","Budget Dimension 2 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 3 Code","Budget Dimension 3 Code");
            if GLBudgetEntry.Find('-') then
              begin
                GLBudgetEntry.DeleteAll;
              end;
          end;
        /*Reset the new date*/
        NewDate:="Start Date";
        /*Initiate the loop to save the details into the table*/
        while NewDate<="End Date"
          do
            begin
            GLBudgetEntry.Init;
            GLBudgetEntry."Entry No.":=EntryNo;
        
            GLBudgetEntry."Analysis Area":="analysis area"::"0";
        
            GLBudgetEntry."Budget Name":=Name;
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Name");
        
            GLBudgetEntry."Item No.":="Item No";
            GLBudgetEntry.Validate(GLBudgetEntry."Item No.");
            GL.Reset;
            GL.Get("Item No");
        /*
              Forced to comment out by TChibo
        //    GLBudgetEntry."Item G/L Sales Account":=GL."Item G/L Sales Account";
        //    GLBudgetEntry."Item G/L Cost Account":=GLBudgetEntry."Item G/L Cost Account";
        */
            GLBudgetEntry."Global Dimension 1 Code":="Global Dimension 1 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 1 Code");
        
            GLBudgetEntry."Global Dimension 2 Code":="Global Dimension 2 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 2 Code");
        
            GLBudgetEntry."Budget Dimension 1 Code":="Budget Dimension 1 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 1 Code");
        
            GLBudgetEntry."Budget Dimension 2 Code":="Budget Dimension 2 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 2 Code");
        
            GLBudgetEntry."Budget Dimension 3 Code":="Budget Dimension 3 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 3 Code");
        
            GLBudgetEntry.Date:=NewDate;
        
        
            if "Show As"="show as"::"0" then
              begin
                GLBudgetEntry."Sales Amount":=Amnt;
              end
            else if "Show As"="show as"::"1" then
              begin
                GLBudgetEntry.Quantity:=Amnt;
              end
            else if "Show As"="show as"::"2" then
              begin
                GLBudgetEntry."Cost Amount":=Amnt;
              end;
        
            GLBudgetEntry."User ID":=UserId;
        
            GLBudgetEntry.Insert;
            NewDate:=CalcDate('1' + Period ,NewDate);
            EntryNo:=EntryNo + 1;
            end;
            Processed:=true;
            Rec."User ID":=UserId;
            Modify;
        Message('Budgetary Allocation Complete');
        
        end;
        Rec.Delete;

    end;


    procedure AutoAllocateGL(var Rec: Record UnknownRecord55931)
    var
        Budget: Record "G/L Budget Name";
        DimVal: Record "Dimension Value";
        GLBudgetEntry: Record "G/L Budget Entry";
        IntC: Integer;
        NewDate: Date;
        Period: Text[30];
        Amnt: Decimal;
        EntryNo: Integer;
        GL: Record "G/L Account";
    begin
        with Rec do begin
        
        //check if the date inserted as the start date is greater than the end date
        if ("Start Date">"End Date") then
          begin
            Error('Ending Date must BE greater than or equal to start date');
          end;
        
        if "Type of Entry"="type of entry"::"0" then
          begin
            Error('Type Of Entry must not be blank in Line no.' + Format("Line No.") );
          end;
        /*Get the new date selected by the user first*/
        NewDate:="Start Date";
        /*Get the period*/
        if "Period Type"="period type"::"0" then
          begin
            Period:='D';
          end
        else if "Period Type"="period type"::"1" then
          begin
            Period:='W';
          end
        else if "Period Type"="period type"::"2" then
          begin
            Period:='M';
          end
        else if "Period Type"="period type"::"3" then
          begin
            Period:='Q';
          end
        else
          begin
            Period:='Y';
          end;
        /*Initiate the loop*/
        while NewDate<="End Date"
          do
            begin
              IntC:=IntC +1;
              NewDate:=CalcDate('1' + Period,NewDate);
            end;
        /*Number of times to divide amount has been identified*/
        /*Get the amount and get the amount per period identified*/
        
        Amnt:=Amount/IntC;
        
        /*Get the entry number*/
        GLBudgetEntry.Reset;
        if GLBudgetEntry.Find('+') then
          begin
            EntryNo:=GLBudgetEntry."Entry No.";
          end
        else
          begin
            EntryNo:=0;
          end;
        EntryNo:=EntryNo +1;
        /*Check if the user wishes to overwrite the details already in the system*/
        if Overwrite=true then
          begin
            GLBudgetEntry.Reset;
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Name",Name);
            GLBudgetEntry.SetRange(GLBudgetEntry."G/L Account No.","G/L Account");
            GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 1 Code","Global Dimension 1 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 2 Code","Global Dimension 2 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Business Unit Code","Business Unit");
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 1 Code","Budget Dimension 1 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 2 Code","Budget Dimension 2 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 3 Code","Budget Dimension 3 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 4 Code","Budget Dimension 4 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 5 Code","Budget Dimension 5 Code");
            GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 6 Code","Budget Dimension 6 Code");
            if GLBudgetEntry.Find('-') then
              begin
                GLBudgetEntry.DeleteAll;
              end;
          end;
        /*Reset the new date*/
        NewDate:="Start Date";
        /*Initiate the loop to save the details into the table*/
        while NewDate<="End Date"
          do
            begin
            GLBudgetEntry.Init;
            GLBudgetEntry."Entry No.":=EntryNo;
        
            GLBudgetEntry."Budget Name":=Name;
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Name");
        
            GLBudgetEntry."G/L Account No.":="G/L Account";
            GLBudgetEntry.Validate(GLBudgetEntry."G/L Account No.");
        
            GLBudgetEntry."Global Dimension 1 Code":="Global Dimension 1 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 1 Code");
        
            GLBudgetEntry."Global Dimension 2 Code":="Global Dimension 2 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 2 Code");
        
            GLBudgetEntry."Business Unit Code":="Business Unit";
            GLBudgetEntry.Validate(GLBudgetEntry."Business Unit Code");
        
            GLBudgetEntry."Budget Dimension 1 Code":="Budget Dimension 1 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 1 Code");
        
            GLBudgetEntry."Budget Dimension 2 Code":="Budget Dimension 2 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 2 Code");
        
            GLBudgetEntry."Budget Dimension 3 Code":="Budget Dimension 3 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 3 Code");
        
            GLBudgetEntry."Budget Dimension 4 Code":="Budget Dimension 4 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 4 Code");
        
            GLBudgetEntry."Budget Dimension 5 Code":="Budget Dimension 5 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 5 Code");
        
            GLBudgetEntry."Budget Dimension 6 Code":="Budget Dimension 6 Code";
            GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 6 Code");
        
            GLBudgetEntry.Date:=NewDate;
            if "Type of Entry"="type of entry"::"1" then
              begin
                GLBudgetEntry.Amount:=Amnt;
              end
            else if "Type of Entry"="type of entry"::"2" then
              begin
                GLBudgetEntry.Amount:=-Amnt;
              end;
            GLBudgetEntry."User ID":=UserId;
        
            GLBudgetEntry.Insert;
            NewDate:=CalcDate('1' + Period ,NewDate);
            EntryNo:=EntryNo + 1;
            end;
            Processed:=true;
            Rec."User ID":=UserId;
            Modify;
        Message('Budgetary Allocation Complete');
        
        end;
        Rec.Delete;

    end;
}

