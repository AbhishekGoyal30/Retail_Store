**FREE
ctl-opt dftactgrp(*no) actgrp(*new);

/* Files */
dcl-f SALESHIST usage(*input) keyed;
dcl-f SALESPRT  printer;

/* Print report header */
write HEADER;

/* Read first record */
read SALESHIST;

dow not %eof(SALESHIST);

   /* Write detail line */
   write DETAIL;

   /* Read next record */
   read SALESHIST;

enddo;

/* Print footer */
write FOOTER;

*inlr = *on;
return;
