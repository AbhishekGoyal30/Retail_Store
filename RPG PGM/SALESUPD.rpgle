**FREE
ctl-opt dftactgrp(*no) actgrp(*new);

/* Files */
dcl-f SALESHIST usage(*update) keyed;
dcl-f SALEUPD workstn;

/* Indicators */
dcl-s exit ind inz(*off);

/* Main loop */
dow not exit;

   exfmt SALEUPD;

   /* Exit */
   if *in03;
      exit = *on;
      leave;
   endif;

   /* Fetch record */
   chain SALEID SALESHIST;

   if %found(SALESHIST);

      /* Update request */
      if *in05;

         /* Optional recalculation */
         TOTALAMT = (QTY * PRICE) + TAXAMT;

         update SALESHIST;

      endif;

   else;
      /* Record not found – simple handling */
      clear ITEMNO;
      clear WHCODE;
      clear QTY;
      clear PRICE;
      clear TAXAMT;
      clear TOTALAMT;
      clear SALEDATE;
   endif;

enddo;

*inlr = *on;
return;
