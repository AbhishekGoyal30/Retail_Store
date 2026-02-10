**FREE
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*srcstmt:*nodebugio)
        commit(*none);

/* ================================================= */
/* File Declarations                                 */
/* ================================================= */

dcl-f ITEMMASTER usage(*input) keyed;
dcl-f WHSTOCK  usage(*update) keyed;
dcl-f PRICEHDR usage(*input) keyed;
dcl-f SALESHIST    usage(*output);

/* ================================================= */
/* Parameters                                        */
/* ================================================= */

dcl-pi *n;
   pItemNo  char(15);
   pWhCode  char(5);
   pQty     packed(9:0);
end-pi;

/* ================================================= */
/* Variables                                         */
/* ================================================= */

dcl-s saleId    packed(10:0) inz(%timestamp());
dcl-s taxAmt   packed(9:2);
dcl-s totalAmt packed(9:2);

/* ================================================= */
/* Validate Item                                     */
/* ================================================= */

chain pItemNo ITEMMASTER;
if not %found(ITEMMASTER) or ACTIVE <> 'Y';
   dsply 'Invalid or inactive item';
   return;
endif;

/* ================================================= */
/* Check Stock                                       */
/* ================================================= */

chain (pItemNo : pWhCode) WHSTOCK;
if not %found(WHSTOCK);
   dsply 'Item not available in warehouse';
   return;
endif;

if QTYONHAND < pQty;
   dsply 'Insufficient stock';
   return;
endif;

/* ================================================= */
/* Fetch Pricing                                     */
/* ================================================= */

chain pItemNo PRICEHDR;
if not %found(PRICEHDR);
   dsply 'Pricing not defined';
   return;
endif;

/* ================================================= */
/* Calculate Amounts                                 */
/* ================================================= */

taxAmt   = (PRICE * pQty) * (TAXPCT / 100);
totalAmt = (PRICE * pQty) + taxAmt;

/* ================================================= */
/* Update Stock                                      */
/* ================================================= */

QTYONHAND -= pQty;
update WHSR;

/* ================================================= */
/* Write Sales Record                                */
/* ================================================= */

SALEID   = saleId;
ITEMNO   = pItemNo;
WHCODE   = pWhCode;
QTY      = pQty;
PRICE    = PRICE;
TAXAMT   = taxAmt;
TOTALAMT = totalAmt;
SALEDATE = %date();

write SALESR;

/* ================================================= */
/* End Program                                       */
/* ================================================= */

*inlr = *on;
