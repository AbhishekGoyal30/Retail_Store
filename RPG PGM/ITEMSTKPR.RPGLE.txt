**FREE
ctl-opt dftactgrp(*no) actgrp(*new);

/* Files */
dcl-f ITEMMASTER usage(*input) keyed;
dcl-f PRICEHDR   usage(*input) keyed;
dcl-f WHSTOCK    usage(*input) keyed;
dcl-f ITEMSTKPRT printer;

/* Work fields */
dcl-s totStock  packed(9:0);

/* Print header */
write HEADER;

/* Read ITEMMASTER */
read ITEMMASTER;

dow not %eof(ITEMMASTER);

   /* ----------------------------
      Get TAX Percentage
      ---------------------------- */
   clear TAXPCT;
   chain ITEMNO PRICEHDR;
   if not %found(PRICEHDR);
      TAXPCT = 0;
   endif;

   /* ----------------------------
      Get Total Stock Quantity
      ---------------------------- */
   totStock = 0;

   setll ITEMNO WHSTOCK;
   reade ITEMNO WHSTOCK;

   dow %found(WHSTOCK);
      totStock += QTYONHAND;
      reade ITEMNO WHSTOCK;
   enddo;

   QTYONHAND = totStock;

   /* ----------------------------
      Print detail line
      ---------------------------- */
   write DETAIL;

   read ITEMMASTER;

enddo;

/* Print footer */
write FOOTER;

*inlr = *on;
return;
