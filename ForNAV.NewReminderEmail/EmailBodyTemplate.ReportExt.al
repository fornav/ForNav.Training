reportextension 74100 "PTE E-mail Body Template" extends "ForNAV E-mail Body Template"
{
    // Copyright (c) 2017-2025 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    rendering
    {
        layout(NewEmailLayout)
        {
            Type = Custom;
            MimeType = 'FORNAV';
            LayoutFile = 'Layouts\PTE E-mail Body Template.docx';
        }
    }
}