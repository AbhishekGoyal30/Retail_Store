**FREE
ctl-opt dftactgrp(*no) actgrp(*new);

/* Files */
dcl-f ITEMMASTER usage(*update) keyed;
dcl-f PRICEHDR   usage(*update) keyed;
dcl-f WHSTOCK    usage(*update) keyed;
dcl-f ITEMMULTI  workstn;

/* Variables */
dcl-s exit ind inz(*off);

/* Main loop */
dow not exit;

   exfmt ITEMUPD;

   /* Exit */
   if *in03;
      exit = *on;
      leave;
   endif;

   /* Fetch ITEMMASTER */
   chain ITEMNO ITEMMASTER;

   if not %found(ITEMMASTER);
      clear ITEMDESC;
      clear UOM;
      clear COST;
      clear PRICE;
      clear TAXPCT;
      clear QTYONHAND;
      iter;
   endif;

   /* Fetch PRICEHDR */
   chain ITEMNO PRICEHDR;

   /* Fetch WHSTOCK */
   chain (ITEMNO: WHCODE) WHSTOCK;

   /* Update request */
   if *in05;

      /* Update ITEMMASTER */
      update ITEMMASTER;

      /* Update PRICEHDR if exists */
      if %found(PRICEHDR);
         update PRICEHDR;
      endif;

      /* Update WHSTOCK if exists */
      if %found(WHSTOCK);
         update WHSTOCK;
      endif;

   endif;

enddo;

*inlr = *on;
return;
