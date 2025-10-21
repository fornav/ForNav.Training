table 74100 "PTE Email Text"
{
    // Copyright (c) 2017-2025 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    Caption = 'PTE Email Text';
    TableType = Temporary;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
        }
        field(2; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            NotBlank = true;
            TableRelation = Language;
            DataClassification = SystemMetadata;
        }
        field(4; Subject; Text[128])
        {
            Caption = 'Subject';
            DataClassification = CustomerContent;
        }
        field(5; Greeting; Text[128])
        {
            Caption = 'Greeting';
            DataClassification = CustomerContent;
        }
        field(6; "Body Text"; Blob)
        {
            Caption = 'Body Text';
            DataClassification = CustomerContent;
        }
        field(7; Closing; Text[128])
        {
            Caption = 'Closing';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}

