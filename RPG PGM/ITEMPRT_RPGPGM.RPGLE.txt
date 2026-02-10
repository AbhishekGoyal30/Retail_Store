**FREE
ctl-opt dftactgrp(*no) actgrp(*new);

/* Files */
dcl-f ITEMMASTER usage(*input) keyed;
dcl-f ITEMPRT printer;

/* Indicators */
dcl-s eof ind inz(*off);

/* Print header once */
write HDR;

/* Read item master */
read ITEMMASTER;
dow not %eof(ITEMMAS);

   /* Optional filter: only active items */
   // if ACTIVE = 'Y';

      write DETAIL;

   // endif;

   read ITEMMASTER;
enddo;

/* Print footer */
write FOOT;

*inlr = *on;
return;
