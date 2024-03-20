tableextension 50100 "PTE Sales Header" extends "Sales Header"
{
    fields
    {
        field(50100; "CoffeeBreakName"; Text[100])
        {
            Caption = 'Coffee Break Name';
            DataClassification = CustomerContent;
        }
        field(50101; "CoffeeBreakName2"; Text[50])
        {
            Caption = 'Coffee Break Name 2';
            DataClassification = CustomerContent;
        }
        field(50102; "CoffeeBreakAddress"; Text[100])
        {
            Caption = 'Coffee Break Address';
            DataClassification = CustomerContent;
        }
        field(50103; "CoffeeBreakAddress2"; Text[50])
        {
            Caption = 'Coffee Break Address 2';
            DataClassification = CustomerContent;
        }
        field(50104; "CoffeeBreakPostCode"; Code[20])
        {
            Caption = 'Coffee Break Post Code';
            DataClassification = CustomerContent;
        }
        field(50105; "CoffeeBreakCity"; Text[30])
        {
            Caption = 'Coffee Break City';
            DataClassification = CustomerContent;
        }
        field(50106; "CoffeeBreakCounty"; Text[30])
        {
            Caption = 'Coffee Break County';
            DataClassification = CustomerContent;
        }
        field(50107; "CoffeeBreakCountry/RegionCode"; Code[10])
        {
            Caption = 'Coffee Break Country/Region Code';
            DataClassification = CustomerContent;
        }
        field(50108; "CoffeeBreakLocationCode"; Code[10])
        {
            Caption = 'Coffee Break Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
    }

}