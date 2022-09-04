codeunit 50164 "UserManagementCUExt"
{
    trigger OnRun()
    begin



    end;

    procedure LookupUser(var UserName: Code[50]): Boolean
    var
        User: Record User;
        SID: Guid;
    begin
        User.Reset;
        User.SetCurrentkey("User Name");
        User."User Name" := UserName;
        if User.Find('=><') then;
        if Page.RunModal(Page::Users, User) = Action::LookupOK then begin
            UserName := User."User Name";
            SID := User."User Security ID";
            exit(true);
        end;

        exit(false);
    end;

    procedure ValidateUserName(NewUser: Record User; OldUser: Record User; WindowsUserName: Text)
    var
        User: Record User;
    begin
        if NewUser."User Name" <> OldUser."User Name" then begin
            User.SetRange("User Name", NewUser."User Name");
            User.SetFilter("User Security ID", '<>%1', OldUser."User Security ID");
            if User.FindFirst then
                Error(Text002, NewUser."User Name");

            if NewUser."Windows Security ID" <> '' then
                NewUser.TestField("User Name", WindowsUserName);

        end;
    end;


    var
        USermanagementcu: Codeunit "User Management";
        user: Record User;
        Text000: label 'The user name %1 does not exist.';
        Text001: label 'You are renaming an existing user. This will also update all related records. Are you sure that you want to rename the user?';
        Text002: label 'The account %1 already exists.';
        Text003: label 'You do not have permissions for this action.';
}