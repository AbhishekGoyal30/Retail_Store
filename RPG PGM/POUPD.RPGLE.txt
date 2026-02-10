**FREE
ctl-opt dftactgrp(*no) actgrp(*new);

/* Files */
dcl-f POHDR usage(*update) keyed;
dcl-f POUPD workstn;

/* Variables */
dcl-s exit ind inz(*off);

/* Main processing loop */
dow not exit;

   exfmt POUPD;

   /* Exit key */
   if *in03;
      exit = *on;
      leave;
   endif;

   /* Fetch PO record */
   chain PONO POHDR;

   if %found(POHDR);

      /* Update request */
      if *in05;
         update POHDR;
      endif;

   else;
      /* Record not found – clear fields */
      clear VENDORID;
      clear PODATE;
      clear POAMOUNT;
   endif;

enddo;

*inlr = *on;
return;
