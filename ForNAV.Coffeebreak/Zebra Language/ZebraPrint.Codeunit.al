codeunit 50100 "PTE Zebra Print"
{
    internal procedure GetLayoutFromFileStorage(Code: Code[20]; Type: code[20]) Result: Text
    var
        FileStorage: Record "ForNAV File Storage";
        Instr: InStream;
        Line: Text;
    begin
        // Get the Zebra layout from the File Storage
        FileStorage.SetAutoCalcFields(Data);
        if not FileStorage.Get(Code, Type) then
            exit('');

        if not FileStorage.Data.HasValue then
            exit('');

        FileStorage.Data.CreateInStream(Instr);

        // Read the Zebra layout line by line into the text variable
        while InStr.Read(Line) > 0 do
            Result += Line;
    end;

    internal procedure ReplacePlaceholders(Item: Record "Item"; var ZebraLayout: Text)
    begin
        // Replace the text placeholders with BC data
        ZebraLayout := ZebraLayout.Replace('{NO}', Item."No.").Replace('{DESCRIPTION}', Item.Description);
    end;


}