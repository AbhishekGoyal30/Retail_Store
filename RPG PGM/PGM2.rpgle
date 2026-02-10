**FREE
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt:*nodebugio);

/* File Declaration */
dcl-f ITEMMASTER usage(*input) keyed;

/* Variables */
dcl-s itemNo     char(15);
dcl-s groupCode  char(5);

/* Example: Read ALL items */
read ITEMMASTER;
dow not %eof(ITEMMASTER);

   itemNo    = ITEMNO;
   groupCode = GRPCODE;

   select;
      when groupCode = 'ELEC';
         // Electronics items
         exsr ElecGroup;

      when groupCode = 'FURN';
         // Furniture items
         exsr FurnGroup;

      when groupCode = 'CLOT';
         // Clothing items
         exsr ClotGroup;

      other;
         // Other categories
         exsr OtherGroup;
   endsl;

   read ITEMMASTER;
enddo;

*inlr = *on;

/* ========================= */
/* Subroutines               */
/* ========================= */

begsr ElecGroup;
   dsply ('Electronics Item: ' + %trim(itemNo));
endsr;

begsr FurnGroup;
   dsply ('Furniture Item: ' + %trim(itemNo));
endsr;

begsr ClotGroup;
   dsply ('Clothing Item: ' + %trim(itemNo));
endsr;

begsr OtherGroup;
   dsply ('Other Item: ' + %trim(itemNo));
endsr;
