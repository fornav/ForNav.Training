function BuildPaymentReference() {
  let result = SwissQRBillBuffer.PaymentReference
  let custNo = '';
  let invNo = '';
  let pmtRef = '';
  let pmtRefStart = '';
  let pmtRefPt1 = '';
  let pmtRefPt2 = '';
  let pmtRefEnd = '';
  let tempPmtRef = '';
  let tabl = [0, 9, 4, 6, 8, 2, 7, 1, 3, 5];
  let carry = 0;
  let i = 0;
  let maxLength = 0;
  let pmtRefNo = 0;
  let pos = 0;
  let test = 0;

  if (SwissQRBillBuffer.PaymentReferenceType == SwissQRBillBuffer.FieldOptions.PaymentReferenceType.QRReference) {
    pmtRef = SwissQRBillBuffer.PaymentReference;

    if (!isNaN(Number(Header.Bill_toCustomerNo))) {
      custNo = Header.Bill_toCustomerNo;
    };

    if (!isNaN(Number(Header.No))) {
      invNo = Header.No;
    };

    pmtRefPt1 = pmtRef.slice(0, 2);
    pmtRefNo = Number(pmtRef.slice(2, -1));
    tempPmtRef = CurrReport.DotNetFormat(pmtRefNo, '0000');
    pmtRefPt2 = (custNo + invNo + tempPmtRef).padStart(24, '0');
    pmtRefPt2 = pmtRefPt2.slice(-24);
    pmtRefStart = pmtRefPt1 + pmtRefPt2;
    maxLength = pmtRefStart.length;

    do {
      test = Number(pmtRefStart.substring(pos, pos + 1))
      i = test + carry;
      if (i > 9) { i -= 10 };
      carry = tabl[i];
      pos++
    } while (pos < maxLength)

    if (carry == 0) (
      carry = 10
    )

    pmtRefEnd = (10 - carry).toString()

    result = (pmtRefStart + pmtRefEnd)
  }
  return result;
}