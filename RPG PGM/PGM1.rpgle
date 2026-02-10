**FREE
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*srcstmt:*nodebugio);

/* ================================================= */
/* File Declarations                                 */
/* ================================================= */

dcl-f ITEMMASTER  usage(*input);
dcl-f ELECITEM  usage(*output);
dcl-f FURNITEM  usage(*output);
dcl-f CLOTITEM  usage(*output);
dcl-f OTHERITEM usage(*output);

/* ================================================= */
/* Main Processing                                   */
/* ================================================= */

read ITEMMAST;
dow not %eof(ITEMMAST);

   select;

      when GRPCODE = 'ELEC';
         write ELECR;

      when GRPCODE = 'FURN';
         write FURNR;

      when GRPCODE = 'CLOT';
         write CLOTR;

      other;
         write OTHERR;

   endsl;

   read ITEMMAST;

enddo;

/* ================================================= */
/* End Program                                       */
/* ================================================= */

*inlr = *on;
