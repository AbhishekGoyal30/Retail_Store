**FREE
ctl-opt dftactgrp(*no) actgrp(*new);

/* Files */
dcl-f ITEMMASTER usage(*update) keyed;
dcl-f ITEMUPD     workstn;

/* Indicators */
dcl-s exit ind inz(*off);

/* Main Loop */
dow not exit;

   exfmt ITEMUPD;

   /* Exit */
   if *in03;
      exit = *on;
      leave;
   endif;

   /* Read item */
   chain ITEMNO ITEMMASTER;

   if %found(ITEMMASTER);

      /* Update request */
      if *in05;
         update ITEMMASTER;
      endif;

   else;
      /* Item not found - clear display fields */
      clear ITEMDESC;
      clear GRPCODE;
      clear PRICE;
      clear UOM;
      clear ACTIVE;
      clear COST;
      clear REORDERLVL;
   endif;

enddo;

*inlr = *on;
return;
