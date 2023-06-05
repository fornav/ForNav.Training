codeunit 50100 "PTE Add Aging Buckets"
{
    [EventSubscriber(ObjectType::Table, Database::"ForNAV Aged Accounts Args.", OnBeforeCalcdates, '', false, false)]
    local procedure OnBeforeCalcdates(var PeriodStartDate2: array[31] of Date; var PeriodEndDate2: array[31] of Date; var Handled: Boolean)
    begin

    end;
}