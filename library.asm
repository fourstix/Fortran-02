; *******************************************************************
; *** This software is copyright 2021 by Michael H Riley          ***
; *** You have permission to use, modify, copy, and distribute    ***
; *** this software so long as this copyright notice is retained. ***
; *** This software may not be used in commercial applications    ***
; *** without express written permission from the author.         ***
; *******************************************************************

epush:      sex     r7
            lda     r6
            stxd
            lda     r6
            stxd
            lda     r6
            stxd
            lda     r6
            stxd
            sex     r2
            sep     sret

vpush32:    lda     r6
            phi     rf
            lda     r6
            plo     rf
            sex     r7
            lda     rf
            stxd
            lda     rf
            stxd
            lda     rf
            stxd
            lda     rf
            stxd
            sex     r2
            sep     sret
            
#ifdef USEEF
sampleef:   ldi     0
            bn1     ef1
            ori     1
ef1:        bn2     ef2
            ori     2
ef2:        bn3     ef3
            ori     4
ef3:        bn4     ef4
            ori     8
ef4:        sep     sret
#endif

/* *********************************************************************** */
/* *********************************************************************** */
/* *****                    Terminal Library                         ***** */
/* *********************************************************************** */
/* *********************************************************************** */
#ifdef SELFTERM
            sep     r3
delay:      ghi     re
            shr
            plo     re
            sex     r2
delay1:     dec     re
            glo     re
            bz      delay-1
            br      delay1

f_type:     plo     re
            ghi     rf
            stxd
            glo     rf
            stxd
            ghi     rd
            stxd
            glo     rd
            stxd
            glo     re
            phi     rf
            ldi     9
            plo     rf
            ldi     delay.1
            phi     rd
            ldi     delay.0
            plo     rd
            adi     0
sendlp:     bdf     sendnb              ; jump if no bit
#ifdef INVQ
            req
#else
            seq
#endif
            br      sendct
#ifdef INVQ
sendnb:     seq
#else
sendnb:     req
#endif
            br      sendct
sendct:     sep     rd                  ; perform bit delay
            sex r2
            sex r2
            ghi     rf
            shrc
            phi     rf
            dec     rf
            glo     rf
            bnz     sendlp
#ifdef INVQ
            seq
#else
            req
#endif
            sep     rd
            sep     rd
            irx
            ldxa
            plo     rd
            ldxa
            phi     rd
            ldxa
            plo     rf
            ldx
            phi     rf
            sep     sret

f_read:     ghi     rf
            stxd
            glo     rf
            stxd
            ghi     rd
            stxd
            glo     rd
            stxd
            ldi     9
            plo     rf
            ldi     delay.1
            phi     rd
            ldi     delay.0
            plo     rd
            ghi     re
            phi     rf
            shr
            shr
            phi     re

#ifdef SEREF1
            b1      $
#endif
#ifdef SEREF2
            b2      $
#endif
#ifdef SEREF3
            b3      $
#endif
#ifdef SEREF4
            b4      $
#endif
#ifdef SEREF1I
            bn1     $
#endif
#ifdef SEREF2I
            bn2     $
#endif
#ifdef SEREF3I
            bn3     $
#endif
#ifdef SERPBN4I
            bn4     $
#endif
            sep     rd
            ghi     rf
            phi     re
            ghi     rf
            shr
            bdf     recvlpe
recvlp:     ghi     rf
            shr

#ifdef SEREF1
            bn1     recvlp0
#endif
#ifdef SEREF2
            bn2     recvlp0
#endif
#ifdef SEREF3
            bn3     recvlp0
#endif
#ifdef SEREF4
            bn4     recvlp0
#endif
#ifdef SEREF1I
            b1      recvlp0
#endif
#ifdef SEREF2I
            b2      recvlp0
#endif
#ifdef SEREF3I
            b3      recvlp0
#endif
#ifdef SERPBN4I
            b4      recvlp0
#endif
            ori     128
recvlp1:    phi     rf
            sep     rd
            dec     rf
            nop
            nop
            glo     rf
            bnz     recvlp
#ifdef INVQ
recvdone:   seq
#else
recvdone:   req
#endif
            ghi     rf
            plo     re
            irx
            ldxa
            plo     rd
            ldxa
            phi     rd
            ldxa 
            plo     rf
            ldx
            phi     rf
            glo     re
            sep     sret
recvlp0:    br      recvlp1
recvlpe:    ghi     rf
            shr

#ifdef SEREF1
            bn1     recvlpe0
#endif
#ifdef SEREF2
            bn2     recvlpe0
#endif
#ifdef SEREF3
            bn3     recvlpe0
#endif
#ifdef SEREF4
            bn4     recvlpe0
#endif
#ifdef SEREF1I
            b1      recvlpe0
#endif
#ifdef SEREF2I
            b2      recvlpe0
#endif
#ifdef SEREF3I
            b3      recvlpe0
#endif
#ifdef SERPBN4I
            b4      recvlpe0
#endif
            ori     128
#ifdef INVQ
            seq
#else
            req
#endif
recvlpe1:   phi     rf
            sep     rd
            dec     rf
            sex     r2
            sex     r2
            glo     rf
            bnz     recvlpe
            br      recvdone
#ifdef INVQ
recvlpe0:   req
#else
recvlpe0:   seq
#endif
            br      recvlpe1

#ifdef INVQ
f_setbd:    seq
#else
f_setbd:    req
#endif
            ldi     0
            phi     rc
            plo     rc
            phi     rb
            plo     rb

#ifdef SEREF1
timalc_o:   b1      $
#endif
#ifdef SEREF2
timalc_o:   b2      $
#endif
#ifdef SEREF3
timalc_o:   b3      $
#endif
#ifdef SEREF4
timalc_o:   b4      $
#endif
#ifdef SEREF1I
timalc_o:   bn1     $
#endif
#ifdef SEREF2I
timalc_o:   bn2     $
#endif
#ifdef SEREF3I
timalc_o:   bn3     $
#endif
#ifdef SERPBN4I
timalc_o:   bn4     $
#endif
#ifdef SEREF1
end_sb:     bn1     $
#endif
#ifdef SEREF2
end_sb:     bn2     $
#endif
#ifdef SEREF3
end_sb:     bn3     $
#endif
#ifdef SEREF4
end_sb:     bn4     $
#endif
#ifdef SEREF1I
end_sb:     b1      $
#endif
#ifdef SEREF2I
end_sb:     b2      $
#endif
#ifdef SEREF3I
end_sb:     b3      $
#endif
#ifdef SERPBN4I
end_sb:     b4      $
#endif
#ifdef SEREF1
            b1      $
#endif
#ifdef SEREF2
            b2      $
#endif
#ifdef SEREF3
            b3      $
#endif
#ifdef SEREF4
            b4      $
#endif
#ifdef SEREF1I
            bn1     $
#endif
#ifdef SEREF2I
            bn2     $
#endif
#ifdef SEREF3I
            bn3     $
#endif
#ifdef SERPBN4I
            bn4     $
#endif
setbd1:     inc     rc
            sex     r2
            sex     r2

#ifdef SEREF1
            bn1     setbd1
#endif
#ifdef SEREF2
            bn2     setbd1
#endif
#ifdef SEREF3
            bn3     setbd1
#endif
#ifdef SEREF4
            bn4     setbd1
#endif
#ifdef SEREF1I
            b1      setbd1
#endif
#ifdef SEREF2I
            b2      setbd1
#endif
#ifdef SEREF3I
            b3      setbd1
#endif
#ifdef SERPBN4I
            b4      setbd1
#endif
setbd2:     inc     rb
            sex     r2
            sex     r2

#ifdef SEREF1
            b1      setbd2
#endif
#ifdef SEREF2
            b2      setbd2
#endif
#ifdef SEREF3
            b3      setbd2
#endif
#ifdef SEREF4
            b4      setbd2
#endif
#ifdef SEREF1I
            bn1     setbd2
#endif
#ifdef SEREF2I
            bn2     setbd2
#endif
#ifdef SEREF3I
            bn3     setbd2
#endif
#ifdef SERPBN4I
            bn4     setbd2
#endif
setbd4:     glo     rb
            shr
            shr
            str     r2
            glo     rc
            shr
            shr
            sm
            lbz     setbd3
            ldi     1
            lskp
setbd3:     ldi     0
            phi     rb
            glo     rc
            smi     4
            phi     re
            ghi     rb
            shr
            ghi     re
            shlc
            phi     re
timalc_rt:  sep     sret

f_tty:      lbr     f_type

f_inmsg:    lda     r6
            lbz     return
            sep     scall
            dw      f_type
            lbr     f_inmsg

f_msg:      lda     rf
            lbz     return
            sep     scall
            dw      f_type
            lbr     f_msg

f_input:    ldi     0
            plo     ra
inplp:      sep     scall
            dw      f_read
            plo     re
            smi     3
            lbnz    inpgo
inpterm:    smi     0
            ldi     0
            lbr     inpdone2
inpdone:    ldi     0
            shr
inpdone2:   str     rf
            sep     sret
inpgo:      smi     5
            lbz     isbs
            smi     5
            lbz     inpdone
            glo     rc
            lbnz    inpcnt
            ghi     rc
            lbnz    inpcnt
            ldi     8
            sep     scall
            dw      f_tty
            lbr     bs2
inpcnt:     glo     re
            str     rf
            inc     rf
            smi     08
            lbnz    nobs
isbs:       glo     ra
            lbz     inplp
            dec     ra
            dec     rf
            inc     rc
bs2:        ldi     32
            sep     scall
            dw      f_tty
            ldi     8
            sep     scall
            dw      f_tty
            lbr     inplp
nobs:       inc     ra
            dec     rc
            lbr     inplp
#endif

; ***********************
; ***** FORTRAN I/O *****
; ***********************
#ifdef FFWRITE
#redefine ITOA32
#redefine FTOA
#redefine USEFP
#redefine DIVFP
#redefine MULFP
ffwrite:    ldi     iobuffer.1         ; setup output buffer
            phi     rd
            ldi     iobuffer.0
            plo     rd
ffwrite_lp: lda     r9                 ; get next variable type
            lbz     ffwrite_dn         ; jump if no more
            plo     re                 ; set aside for a moment
            smi     34                 ; check for quoted text
            lbz     ffwrite_qt         ; jump if quoted value
            lda     r9                 ; get variable address
            phi     rf
            lda     r9
            plo     rf
            glo     re                 ; recover variable type
            smi     'B'                ; check for byte
            lbz     ffwrite_b          ; jump if so
            glo     re                 ; recover variable type
            smi     'L'                ; check for logical
            lbz     ffwrite_l          ; jump if so
            glo     re                 ; recover variable type
            smi     'S'                ; check for short
            lbz     ffwrite_s          ; jump if so
            glo     re                 ; recover variable type
            smi     'I'                ; check for integer
            lbz     ffwrite_i          ; jump if so
            glo     re                 ; recover variable type
            smi     'R'                ; check for real
            lbz     ffwrite_r          ; jump if so
            lbr     ffwrite_dn         ; anything else terminates write
ffwrite_qt: lda     r9                 ; get byte from list
            lbz     ffwrite_lp         ; jump if end found
            str     rd                 ; store into output
            inc     rd
            lbr     ffwrite_qt
ffwrite_l:  ldn     rf                 ; get variable vlue
            lbnz    ffwrite_lt         ; jump if true
            ldi     'F'                ; need to output false
            lskp
ffwrite_lt: ldi     'T'                ; need to output true
            str     rd                 ; store into output
            inc     rd
ffwrite_sp: ldi     ' '                ; followed by a space
            str     rd
            inc     rd
            lbr     ffwrite_lp         ; loop back for next variable
ffwrite_i:  ldi     (scratch2_+3).1    ; need to reverse the bytes
            phi     rb
            ldi     (scratch2_+3).0
            plo     rb
            lda     rf
            str     rb
            dec     rb
            lda     rf
            str     rb
            dec     rb
            lda     rf
            str     rb
            dec     rb
            lda     rf
            str     rb
            ldi     scratch2_.1        ; point to data
            phi     rf
            ldi     scratch2_.0
            plo     rf
            ghi     r7                 ; save consumed variables
            stxd
            glo     r7
            stxd
            ghi     r9
            stxd
            glo     r9
            stxd
            sep     scall              ; convert integer value
            dw      itoa32
ffwrite_r2: irx                        ; recover consumed registers
            ldxa
            plo     r9
            ldxa
            phi     r9
            ldxa
            plo     r7
            ldx
            phi     r7
            lbr     ffwrite_sp         ; add space, then next variable
ffwrite_s:  ldi     scratch1_.1        ; need to convert to 32 bits
            phi     rb
            ldi     scratch1_.0
            plo     rb
            ldi     0                  ; need two zeroes
            str     rb
            inc     rb
            str     rb
            inc     rb
            lda     rf                 ; then the two bytes from the variable
            str     rb
            inc     rb
            lda     rf
            str     rb
            ldi     scratch1_.1        ; now point rf to 32-bit value
            phi     rf
            ldi     scratch1_.0
            plo     rf
            lbr     ffwrite_i          ; now process as an integer
ffwrite_b:  ldi     scratch1_.1        ; need to convert to 32 bits
            phi     rb
            ldi     scratch1_.0
            plo     rb
            ldi     0                  ; need three zeroes
            str     rb
            inc     rb
            str     rb
            inc     rb
            str     rb
            inc     rb
            lda     rf                 ; then tthi byte from the variable
            str     rb
            ldi     scratch1_.1        ; now point rf to 32-bit value
            phi     rf
            ldi     scratch1_.0
            plo     rf
            lbr     ffwrite_i          ; now process as an integer
ffwrite_r:  ldi     (scratch2_+3).1    ; need to reverse the bytes
            phi     rb
            ldi     (scratch2_+3).0
            plo     rb
            lda     rf
            str     rb
            dec     rb
            lda     rf
            str     rb
            dec     rb
            lda     rf
            str     rb
            dec     rb
            lda     rf
            str     rb
            ldi     scratch2_.1        ; point to data
            phi     rf
            ldi     scratch2_.0
            plo     rf
            ghi     r7                 ; save consumed variables
            stxd
            glo     r7
            stxd
            ghi     r9
            stxd
            glo     r9
            stxd
            sep     scall              ; convert real value
            dw      ftoa
            lbr     ffwrite_r2         ; and finish up 
ffwrite_dn: ldi     0                  ; write a terminator
            str     rd
            ldi     iobuffer.1         ; setup buffer for output
            phi     rf
            ldi     iobuffer.0
            plo     rf
            sep     scall              ; display it
            dw      f_msg
            sep     scall              ; display cr/lf
            dw      f_inmsg
            db      10,13,0
            sep     sret               ; then return to caller
#endif

#ifdef FFREAD
#redefine ATOI32
#redefine ATOF
ffread:     ldi     iobuffer.1         ; setup buffer
            phi     rb
            ldi     iobuffer.0
            plo     rb
            ldi     0                  ; clear count
            str     rb
ffread_lp:  ldn     r9                 ; get next variable type
            lbnz    ffread_1           ; jump if not at end
            sep     sret               ; otherwise return to caller
ffread_1:   ldn     rb                 ; need to see if we have some input
            lbnz    ffread_2           ; jump if we do
ffread_1a:  ldi     '?'                ; show input prompt
            sep     scall
            dw      f_type
            ldi     iobuffer.1         ; setup buffer
            phi     rf
            ldi     iobuffer.0
            plo     rf
            sep     scall              ; get input from user
            dw      f_input
            sep     scall              ; output cr/lf
            dw      f_inmsg
            db      10,13,0
            ldi     iobuffer.1         ; point to input
            phi     rb
            ldi     iobuffer.0
            plo     rb
ffread_2:   lda     rb                 ; move past any spaces
            lbz     ffread_1a          ; jump if ran out of input
            smi     ' '                ; is character a space
            lbz     ffread_2           ; loop until no more spaces
            dec     rb                 ; move back to non-space
            ldi     scratch1_.1        ; point to scratch buffer
            phi     rf
            ldi     scratch1_.0
            plo     rf
ffread_3:   lda     rb                 ; read byte from input
            str     rf                 ; write to scratch buffer
            inc     rf
            lbz     ffread_40          ; jump if terminator written
            smi     ' '                ; check for space
            lbnz    ffread_3           ; loop until space or terminator
            dec     rf                 ; change space to terminator
            str     rf
            skp
ffread_40:  dec     rb                 ; move back to terminator
ffread_4:   ldi     scratch1_.1        ; setup buffers for conversion
            phi     rf
            ldi     scratch1_.0
            plo     rf
            ldi     scratch2_.1
            phi     rd
            ldi     scratch2_.0
            plo     rd
            ldn     r9                 ; get variable type
            smi     'L'                ; check for logical
            lbz     ffread_l           ; jump if so
            ghi     r7                 ; save important registers
            stxd
            glo     r7
            stxd
            ghi     r9
            stxd
            glo     r9
            stxd
            ghi     rb
            stxd
            glo     rb
            stxd
            ldn     r9                 ; get variable type
            smi     'R'                ; is it a real
            lbz     ffread_r           ; jump if so
            sep     scall              ; otherwise convert integer
            dw      atoi32
            lbr     ffread_5           ; then move past real conversion
ffread_r:   sep     scall              ; convert real
            dw      atof
ffread_5:   irx                        ; recover consumed registers
            ldxa
            plo     rb
            ldxa
            phi     rb
            ldxa
            plo     r9
            ldxa
            phi     r9
            ldxa
            plo     r7
            ldx
            phi     r7
            lda     r9                 ; get variable type
            plo     re                 ; set aside for a moment
            lda     r9                 ; get variable address
            phi     rd
            lda     r9
            plo     rd
            ldi     scratch2_.1        ; point to converted data
            phi     rf
            ldi     scratch2_.0
            plo     rf
            glo     re                 ; recover type
            smi     'B'                ; is it a byte
            lbz     ffread_b           ; jump if so
            glo     re                 ; recover type
            smi     'S'                ; is it a short
            lbz     ffread_s           ; jump if so
            ldi     4                  ; need to copy 4 bytes
            plo     rc
ffread_cp:  lda     rf                 ; read byte from conversion
            str     rd                 ; write to variable
            inc     rd
            dec     rc                 ; decrement count
            glo     rc
            lbnz    ffread_cp          ; loop back if not done
            lbr     ffread_lp          ; loop back for next variable
ffread_s:   inc     rf                 ; point to lower two bytes
            inc     rf
            lda     rf                 ; copy low 2 bytes to variable
            str     rd
            inc     rd
            lda     rf
            str     rd
            lbr     ffread_lp          ; loop back for next variable
ffread_b:   inc     rf                 ; move to LSB
            inc     rf
            inc     rf
            ldn     rf                 ; retrieve it
            str     rd                 ; and store to variable
            lbr     ffread_lp          ; loop back for next variable
ffread_l:   inc     r9                 ; get variable address
            lda     r9
            phi     rd
            lda     r9
            plo     rd
            ldi     0                  ; set it initially to false
            str     rd
ffread_la:  lda     rf                 ; read byte from input
            lbz     ffread_lp          ; loop to next variable if done
            smi     'T'                ; check for T
            lbz     ffread_t           ; jump if so
            smi     32                 ; check for t
            lbnz    ffread_la          ; jump if not
ffread_t:   ldi     0ffh               ; set variable to true
            str     rd
            lbr     ffread_lp          ; then to next variable
#endif

#ifdef UWRITE
#redefine FWRITE
uwrite:     ldi     iobuffer.1         ; setup output buffer
            phi     rb
            ldi     iobuffer.0
            plo     rb
            ldi     0                  ; clear count
            plo     rc
            phi     rc
uwrite_lp:  lda     r9                 ; get next variable type
            lbz     uwrite_dn          ; jump if done with variables
            plo     re                 ; keep type
            lda     r9                 ; get variable address
            phi     rf
            lda     r9
            plo     rf
            glo     re
            smi     'B'                ; check for byte
            lbz     uwrite_1           ; jump if so
            glo     re
            smi     'L'                ; check for logical
            lbz     uwrite_1           ; jump if so
            glo     re
            smi     'S'                ; check for short
            lbz     uwrite_2           ; jump if so
            ldi     4                  ; four bytes to transfer
            lbr     uwrite_go
uwrite_1:   ldi     1                  ; 1 byte to transfer
            lskp
uwrite_2:   ldi     2                  ; 2 bytes to transfer
uwrite_go:  plo     rd                 ; will count them here
uwrite_c1:  lda     rf                 ; get byte from variable
            str     rb                 ; put into output buffer
            inc     rb
            inc     rc                 ; increment byte count
            dec     rd                 ; decrement variable bytes
            glo     rd                 ; see if all copied
            lbnz    uwrite_c1          ; jump if not
            lbr     uwrite_lp          ; loop back for more variables
uwrite_dn:  ghi     ra
            sep     scall              ; get file record for file
            dw      fildes
            lbdf    uwrite_rt          ; return if invalid file
            lda     rd                 ; get file open flag
            lbz     uwrite_rt          ; error if file is not open
            inc     rd                 ; move to Elf/OS FILDES
            inc     rd
            inc     rd
            inc     rd
            inc     rd
            ldi     iobuffer.1         ; setup output buffer
            phi     rf
            ldi     iobuffer.0
            plo     rf
            sep     scall              ; call Elf/OS to write
            dw      030ch
            dec     rd                 ; move to status field
            dec     rd
            dec     rd
            lbdf    uwrite_er          ; jump if error occured
            glo     rc                 ; otherwise get count written
            str     rd
            dec     rd
            ldi     0
            str     rd
            glo     rc
            sep     sret
uwrite_er:  str     rd                 ; write D to status
            dec     rd                 ; point to flag field
            ldi     0
            shlc                       ; move DF to D
            str     rd                 ; and write to flag
            shr                        ; restore DF
            sep     sret               ; and return to caller
uwrite_rt:  smi     0                  ; make sure DF is set for error
            sep     sret               ; and return to caller
#endif

#ifdef UREAD
uread:      ghi     ra                 ; get lun
            sep     scall              ; get file record for file
            dw      fildes
            lbdf    uread_rt           ; return if invalid file
            ldn     rd                 ; get file open flag
            lbz     ferr_no            ; error if the file is not open
            inc     rd                 ; move to Elf/OS FILDES
            inc     rd
            inc     rd
            inc     rd
            inc     rd
            inc     rd
            ghi     r9                 ; save variable list
            stxd
            glo     r9
            stxd
            ldi     iobuffer.1         ; setup output buffer
            phi     rf
            ldi     iobuffer.0
            plo     rf
            sep     scall              ; call Elf/OS to read file
            dw      0309h
            plo     re                 ; save returned status
            irx                        ; recover variable list
            ldxa
            plo     r9
            ldx
            phi     r9
            glo     re                 ; recover status
            lbdf    uread_er           ; jump on read error
            glo     rc                 ; get bytes read
            str     rd                 ; write to status
            dec     rd                 ; point to io flag
            ldi     0                  ; indicate success
            str     rd
            ldi     iobuffer.1         ; point to i/o buffer
            phi     rf
            ldi     iobuffer.0
            plo     rf
uread_lp:   lda     r9                 ; get next variable type
            lbz     uread_dn           ; jump if done
            plo     re                 ; keep a copy
            lda     r9                 ; get address
            phi     rd
            lda     r9
            plo     rd
            glo     re                 ; recover var type
            smi     'B'                ; is it a byte
            lbz     uread_1            ; jump if so
            glo     re                 ; check for logical
            smi     'L'
            lbz     uread_1            ; jump if so
            glo     re                 ; check for short
            smi     'S'
            lbz     uread_2            ; jump if so
            ldi     4
            lskp
uread_1:    ldi     1
            lskp
uread_2:    ldi     2
            plo     ra                 ; set count
uread_l2:   lda     rf                 ; get byte from io buffer
            str     rd                 ; write to variable
            inc     rd
            dec     ra                 ; decrement count
            glo     ra                 ; see if done
            lbnz    uread_l2           ; loop until done
            lbr     uread_lp           ; on to next variable
uread_dn:   adi     0                  ; signal no error
            glo     rc                 ; get byte count
            sep     sret               ; and return
uread_er:   str     rd                 ; store status
            dec     rd                 ; point to ioflag
            ldi     0
            shlc                       ; mv DF to D
            str     rd                 ; store status
            shr                        ; restore DF
            sep     sret               ; and return to caller
uread_rt:   smi     0                  ; indicate error
            sep     sret               ; and return to caller

#endif

#ifdef FMTREAD
#redefine FREAD
#redefine ATOI32
#redefine ISNUMERAL
#redefine ATOF
fmtread:    ghi     ra                 ; get lun
            lbz     fmtread_0          ; jump if from terminal
            ldi     iobuffer.1
            phi     rf
            ldi     iobuffer.0
            plo     rf
            sep     scall              ; othereise read from disk
            dw      fread
            lbdf    fmtread_er         ; jump on file error
            lbnz    fmtread_st         ; jump if bytes read
fmtread_er: sep     sret               ; return to caller
fmtread_0:  sep     scall              ; display prompt
            dw      f_inmsg
            db      '? ',0
            ldi     iobuffer.1         ; point to io buffer
            phi     rf
            ldi     iobuffer.0
            plo     rf
            sep     scall              ; read line from terminal
            dw      f_input
            sep     scall              ; output a cr/lf
            dw      f_inmsg
            db      10,13,0
fmtread_st: ldi     iobuffer.1         ; point to io buffer
            phi     rb
            ldi     iobuffer.0
            plo     rb
fmtread_lp: lda     r8                 ; get count for next format item
            lbz     fmtrd_dn           ; jump if no more items
            plo     ra
            ldn     r8                 ; get format type
            smi     'X'                ; check for X
            lbz     fmtrd_x            ; jump if so
fmtr_loop:  inc     r8                 ; get size of field
            ldn     r8
            plo     rc                 ; place into count
            phi     rc                 ; keep a copy
            dec     r8
            ldi     scratch1_.1        ; where to copy
            phi     rf
            ldi     scratch1_.0
            plo     rf
fmtrd_c_1:  lda     rb                 ; copy bytes from input
            str     rf
            inc     rf
            dec     rc
            glo     rc
            lbnz    fmtrd_c_1
            ldi     0                  ; terminate
            str     rf
            ghi     rc                 ; reset size
            plo     rc
            ldi     scratch1_.1        ; Point RF back to here
            phi     rf
            ldi     scratch1_.0
            plo     rf
            ldn     r8                 ; recover type
            smi     'I'                ; check for integer
            lbz     fmtrd_i            ; jump if so
            ldn     r8                 ; recover type
            smi     'L'                ; check for logical
            lbz     fmtrd_l            ; jump if so
            ldn     r8                 ; recover type
            smi     'F'                ; check for real
            lbz     fmtrd_r            ; jump if so
            ldi     0x22               ; error code
            smi     0                  ; invalid type, so error
            sep     sret               ; return to caller
fmtrd_x:    glo     ra                 ; get item count
            str     r2                 ; store for add
            glo     rb                 ; add to buffer position
            add
            plo     rb
            ghi     rb
            adci    0
            phi     rb
            inc     r8                 ; move to next format item
            inc     r8
            inc     r8
            lbr     fmtread_lp         ; loop for next item

fmtrd_l:    ldi     0                  ; set field initially to false
            phi     rc
fmtrd_l_1:  lda     rf                 ; get byte from input
            smi     'T'                ; check for true
            lbz     fmtrd_l_t          ; jump if so
            smi     32                 ; lowercase t
            lbz     fmtrd_l_t          ; jump if so
fmtrd_l_2:  dec     rc                 ; decrement width count
            glo     rc                 ; see if done
            lbnz    fmtrd_l_1          ; loop back if not
            lda     r9                 ; get next variable type
            lbz     fmtrd_dn           ; jump if no more variables
            plo     re                 ; save variable type
            lda     r9                 ; retrieve address
            phi     rd
            lda     r9
            plo     rd
            glo     re                 ; get variable type
            smi     'B'                ; check for byte
            lbz     fmtrd_l_b          ; jump if so
            glo     re                 ; get variable type
            smi     'L'                ; check for logical
            lbz     fmtrd_l_b          ; jump if so
            glo     re                 ; get variable type
            smi     'S'                ; check for short
            lbz     fmtrd_l_s          ; jump if so
            ldi     4                  ; 4 bytes to set
            lskp
fmtrd_l_s:  ldi     2
            lskp
fmtrd_l_b:  ldi     1
            plo     rf                 ; set counter
fmtrd_l_3:  ghi     rc                 ; get read value
            str     rd                 ; write into variable
            inc     rd
            dec     rf                 ; decrement count
            glo     rf                 ; see if done
            lbnz    fmtrd_l_3          ; loop back if not
            lbr     fmtrd_nx           ; otherwise on to the next
fmtrd_l_t:  ldi     0ffh               ; mark as true
            phi     rc
            lbr     fmtrd_l_2          ; finish checking field

fmtrd_i:    lda     rf                 ; get byte from input
            sep     scall              ; is it a numeral
            dw      isnumeral
            lbdf    fmtrd_i_1          ; jump if so
            dec     rf                 ; replace with '0'
            ldi     '0'
            str     rf
            inc     rf
fmtrd_i_1:  dec     rc                 ; decrement width
            glo     rc                 ; see if done
            lbnz    fmtrd_i            ; loop back if not
            ldi     scratch1_.1        ; back to field data
            phi     rf
            ldi     scratch1_.0
            plo     rf
fmtrd_i_2:  lda     rf                 ; move past any spaces
            lbz     fmtrd_i_3          ; jump if terminator hit
            smi     ' '                ; check for space
            lbz     fmtrd_i_2          ; loop until no more spaces
            dec     rf                 ; back to nonspace
fmtrd_i_3:  ldi     scratch2_.1        ; where to put conversion
            phi     rd
            ldi     scratch2_.0
            plo     rd
            ghi     r7                 ; save important registers
            stxd
            glo     r7
            stxd
            ghi     r8
            stxd
            glo     r8
            stxd
            ghi     r9
            stxd
            glo     r9
            stxd
            ghi     ra
            stxd
            glo     ra
            stxd
            ghi     rb
            stxd
            glo     rb
            stxd
            sep     scall              ; convert ascii to integer
            dw      atoi32
            irx                        ; recover important registers
            ldxa
            plo     rb
            ldxa
            phi     rb
            ldxa
            plo     ra
            ldxa
            phi     ra
            ldxa
            plo     r9
            ldxa
            phi     r9
            ldxa
            plo     r8
            ldxa
            phi     r8
            ldxa
            plo     r7
            ldx
            phi     r7
            lda     r9                 ; get next variable type
            plo     re                 ; set aside
            lda     r9                 ; get data address
            phi     rd
            lda     r9
            plo     rd
            ldi     scratch2_.1        ; where to number
            phi     rf
            ldi     scratch2_.0
            plo     rf
            glo     re                 ; recover variable type
            smi     'B'                ; is it a byte
            lbz     fmtrd_i_b          ; jump if so
            glo     re                 ; recover variable type
            smi     'L'                ; is it a logical
            lbz     fmtrd_i_b          ; jump if so
            glo     re                 ; recover variable type
            smi     'S'                ; is it a short
            lbz     fmtrd_i_s          ; jump if so
            lda     rf                 ; copy converted number
            str     rd
            inc     rd
            lda     rf
            str     rd
            inc     rd
fmtrd_i_c2: lda     rf
            str     rd
            inc     rd
fmtrd_i_c1: lda     rf
            str     rd
            lbr     fmtrd_nx           ; process end of entry
fmtrd_i_s:  inc     rf                 ; skip high 2 bytes
            inc     rf
            lbr     fmtrd_i_c2         ; and copy 2 bytes
fmtrd_i_b:  inc     rf                 ; skip high 3 bytes
            inc     rf
            inc     rf
            lda     rf                 ; and copy final byte
            str     rd


fmtrd_r:    ldi     0                  ; indicate no period found
            phi     rc
fmtrd_ra:   lda     rf                 ; get byte from input
            lbz     fmtrd_r0           ; jump if terminator found
            sep     scall              ; is it a numeral
            dw      isnumeral
            plo     re                 ; save character
            lbdf    fmtrd_r_1          ; jump if so
            smi     '-'                ; check for minus sign
            lbz     fmtrd_r_1          ; jump if minus
            glo     re                 ; test for +
            smi     '+'
            lbz     fmtrd_r_1
            glo     re                 ; test for E
            smi     'E'
            lbz     fmtrd_r_1
            smi     32                 ; test for e
            lbz     fmtrd_r_1
            smi     '.'                ; check for period
            lbnz    fmtrd_r_1          ; jump if not
            ldi     0xff               ; indicate period found
            phi     rc
            dec     rf                 ; replace with '0'
            ldi     '0'
            skp
            str     rf
            inc     rf
fmtrd_r_1:  dec     rc                 ; decrement width
            glo     rc                 ; see if done
            lbnz    fmtrd_ra           ; loop back if not
fmtrd_r_0b: ldi     scratch1_.1        ; back to field data
            phi     rf
            ldi     scratch1_.0
            plo     rf
            ghi     rc                 ; was a decimal encountered
            lbnz    fmtrd_r_2          ; jump if so
fmtrd_r_x1: lda     rf                 ; find terminator
            lbnz    fmtrd_r_x1
            inc     r8                 ; get decimal size
            inc     r8
            ldn     r8
            plo     rc
            dec     r8
            dec     r8
            ldi     0                  ; write new terminator
            str     rf
fmtrd_r_x2: dec     rf                 ; move to prior character
            glo     rc                 ; done moving characters?
            lbz     fmtrd_r_x3         ; jump if so
            dec     rf                 ; move prior character
            lda     rf
            str     rf
            dec     rc                 ; decrement count
            lbr     fmtrd_r_x2         ; loop until done
fmtrd_r_x3: ldi     '.'                ; put in decimal point
            str     rf
            ldi     scratch1_.1        ; back to field data
            phi     rf
            ldi     scratch1_.0
            plo     rf
fmtrd_r_2:  lda     rf                 ; move past any spaces
            lbz     fmtrd_r_3          ; jump if terminator hit
            smi     ' '                ; check for space
            lbz     fmtrd_r_2          ; loop until no more spaces
            dec     rf                 ; back to nonspace
fmtrd_r_3:  ldi     scratch2_.1        ; where to put conversion
            phi     rd
            ldi     scratch2_.0
            plo     rd
            ghi     r7                 ; save important registers
            stxd
            glo     r7
            stxd
            ghi     r8
            stxd
            glo     r8
            stxd
            ghi     r9
            stxd
            glo     r9
            stxd
            ghi     ra
            stxd
            glo     ra
            stxd
            ghi     rb
            stxd
            glo     rb
            stxd
            sep     scall              ; convert ascii to integer
            dw      atof
            irx                        ; recover important registers
            ldxa
            plo     rb
            ldxa
            phi     rb
            ldxa
            plo     ra
            ldxa
            phi     ra
            ldxa
            plo     r9
            ldxa
            phi     r9
            ldxa
            plo     r8
            ldxa
            phi     r8
            ldxa
            plo     r7
            ldx
            phi     r7
            lda     r9                 ; get next variable type
            lbz     fmtrd_dn
            plo     re                 ; set aside
            lda     r9                 ; get data address
            phi     rd
            lda     r9
            plo     rd
            ldi     scratch2_.1        ; where to number
            phi     rf
            ldi     scratch2_.0
            plo     rf
            glo     re                 ; recover variable type
            smi     'B'                ; is it a byte
            lbz     fmtrd_r_b          ; jump if so
            glo     re                 ; recover variable type
            smi     'L'                ; is it a logical
            lbz     fmtrd_r_b          ; jump if so
            glo     re                 ; recover variable type
            smi     'S'                ; is it a short
            lbz     fmtrd_r_s          ; jump if so
            lda     rf                 ; copy converted number
            str     rd
            inc     rd
            lda     rf
            str     rd
            inc     rd
fmtrd_r_c2: lda     rf
            str     rd
            inc     rd
fmtrd_r_c1: lda     rf
            str     rd
            lbr     fmtrd_nx           ; process end of entry
fmtrd_r_s:  inc     rf                 ; skip high 2 bytes
            inc     rf
            lbr     fmtrd_r_c2         ; and copy 2 bytes
fmtrd_r_b:  inc     rf                 ; skip high 3 bytes
            inc     rf
            inc     rf
            lda     rf                 ; and copy final byte
            str     rd
fmtrd_r0:   dec     rf                 ; move back to terminator
fmtrd_r0c:  glo     rc                 ; see if done with field
            lbz     fmtrd_r_0a         ; jump if so
            ldi     '0'                ; write a zero
            str     rf
            inc     rf
            dec     rc
            lbr     fmtrd_r0c          ; loop until full field set
fmtrd_r_0a: ldi     0                  ; write terminator
            str     rf
            lbr     fmtrd_r_0b



fmtrd_nx:   dec     ra                 ; see if done with specifier
            glo     ra
            lbnz    fmtr_loop          ; jump if not, process next var
            inc     r8                 ; move to next specifier
            inc     r8
            inc     r8
            lbr     fmtread_lp         ; and process it

fmtrd_dn:   ldi     1                  ; signal not eof
            adi     0                  ; clear DF, no errors
            sep     sret               ; return to caller
#endif

#ifdef FMTWRITE
#redefine ITOA32
#redefine FTOA
#redefine STRLEN
#redefine USEFP
#redefine DIVFP
#redefine MULFP
#redefine FROMSCI
#redefine FWRITE
; ****************************************
; ***** Formatted write              *****
; ***** R8 - Pointer to format list  *****
; ***** R9 - Pointer to data list    *****
; ***** RA.1 LUN                     *****
; ***** data list format:            *****
; *****      1-byte data type        *****
; *****      2-bytes address of data *****
; ***** format list format:          *****
; *****      1-byte count            *****
; *****      1-byte format type      *****
; *****      1-byte size 1           *****
; *****      1-byte size 2           *****
; ***** Both lists end with a 0 in   *****
; ***** first byte for entry         *****
; ***** Uses: RA.0 - remaining items *****
; *****       RB   - output buffer   *****
; ****************************************
fmtwrite:   ldi     iobuffer.1         ; setup output buffer
            phi     rb
            ldi     iobuffer.0
            plo     rb

fmtloop:    lda     r8                 ; Get count for current format item
            plo     ra
            lbz     fmtwrt_dn          ; end if run out of format items
; need to add support for hollerith data here
            ldn     r8                 ; get format type
            smi     'X'                ; check for X
            lbz     fmtwrt_x           ; jump if so
            ldn     r8                 ; get format type
            smi     'H'                ; check for hollerith data
            lbz     fmtwrt_h1          ; jump if so
            lbr     fmtwrt_lp          ; on to process next variable
fmtwrt_h1:  inc     r8                 ; move past H
fmtwrt_h:   lda     r8                 ; get byte from format data
            str     rb                 ; write to output
            inc     rb
            dec     ra                 ; decrement character count
            glo     ra                 ; get count
            lbnz    fmtwrt_h           ; loop back if not done
            lbr     fmtloop            ; otherwise to next specifier
fmtwrt_x:   ldi     ' '                ; write a blank to output
            str     rb
            inc     rb
            dec     ra                 ; decrement count
            glo     ra                 ; see if done
            lbnz    fmtwrt_x           ; loop back if not done
            inc     r8                 ; move to next specifier
            inc     r8
            inc     r8
            lbr     fmtloop            ; otherwise check next specifier

fmtwrt_lp:  ldn     r8                 ; get current conversion
            smi     'I'                ; is it integer
            lbz     fmtwrt_i           ; jump if so
            ldn     r8                 ; get current conversion
            smi     'F'                ; check for F conversion
            lbz     fmtwrt_f           ; jump if so
            ldn     r8                 ; get current conversion
            smi     'A'                ; check for A conversion
            lbz     fmtwrt_a           ; jump if so
            ldn     r8                 ; get current conversion
            smi     'L'                ; check for L conversion
            lbz     fmtwrt_l           ; jump if so
            lbr     fmtwrt_dn          ; done if not valid conversion

            /* ************************ */
            /* ***** F Conversion ***** */
            /* ************************ */
fmtwrt_f:   lda     r9                 ; get next variable type
            plo     re                 ; save for now
            lbz     fmtwrt_dn          ; done if no more variables
            lda     r9                 ; retrieve address of variable
            phi     rf
            lda     r9
            plo     rf
            glo     re                 ; now check variable type
            smi     'B'                ; check for byte
            lbz     fmtwrt_f1          ; jump if so
            glo     re
            smi     'L'                ; check for logical
            lbz     fmtwrt_f1          ; jump if so
            glo     re
            smi     'S'                ; check for short
            lbz     fmtwrt_f2          ; jump if so
            glo     re
            smi     'I'                ; check for integer
            lbz     fmtwrt_f4          ; jump if so
            glo     re
            smi     'R'                ; check for real
            lbz     fmtwrt_fr          ; jump if so
            lbr     fmtwrt_dn          ; done if not valid conversion
fmtwrt_f1:  ldi     0                  ; push byte variable to expr stack
            sex     r7
            stxd
            stxd
            stxd
            lbr     fmtwrt_f1a         ; then retrieve variable
fmtwrt_f2:  ldi     0                  ; push byte variable to expr stack
            sex     r7
            stxd
            stxd
            lbr     fmtwrt_f2a         ; then retrieve variable
fmtwrt_f4:  sex     r7                 ; point x to expr stack
            lda     rf                 ; copy variable contents to expr stack
            stxd
            lda     rf
            stxd
fmtwrt_f2a: lda     rf
            stxd
fmtwrt_f1a: lda     rf
            stxd
            sex     r2                 ; point x back to stack
            ldi     scratch1_.1        ; where to put conversion
            phi     rd
            ldi     scratch1_.0
            plo     rd
            ghi     r8                 ; save consumed registers
            stxd
            glo     r8
            stxd
            ghi     r9
            stxd
            glo     r9
            stxd
            ghi     ra
            stxd
            glo     ra
            stxd
            ghi     rb
            stxd
            glo     rb
            stxd
            ghi     r7                 ; point to data item
            phi     rf
            glo     r7
            plo     rf
            inc     rf
            sep     scall              ; convert integer to ascii
            dw      itoa32
            irx                        ; recover consumed registers
            ldxa
            plo     rb
            ldxa
            phi     rb
            ldxa
            plo     ra
            ldxa
            phi     ra
            ldxa
            plo     r9
            ldxa
            phi     r9
            ldxa
            plo     r8
            ldx
            phi     r8
            inc     r7                 ; remove item from expr stack
            inc     r7
            inc     r7
            inc     r7
            ldi     '.'                ; need a decimal point
            str     rd                 ; write to number buffer
            inc     rd
            inc     r8                 ; get number of decimal points
            inc     r8
            ldn     r8
            plo     rc
            dec     r8
            dec     r8
fmtwrt_fa:  glo     rc                 ; see if done
            lbz     fmtwrt_fb          ; jump if so
            ldi     '0'                ; write zero to output
            str     rd
            inc     rd
            dec     rc                 ; decrement count
            lbr     fmtwrt_fa          ; loop back for more
fmtwrt_fb:  ldi     0                  ; terminate string
            str     rd
            lbr     fmtwrt_fi          ; then send to output

fmtwrt_fr:  sex     r7                 ; point x to expr stack
            lda     rf                 ; copy variable contents to expr stack
            stxd
            lda     rf
            stxd
            lda     rf
            stxd
            lda     rf
            stxd
            sex     r2                 ; point x back to stack
            ldi     scratch2_.1        ; where to put conversion
            phi     rd
            ldi     scratch2_.0
            plo     rd
            ghi     r8                 ; save consumed registers
            stxd
            glo     r8
            stxd
            ghi     r9
            stxd
            glo     r9
            stxd
            ghi     ra
            stxd
            glo     ra
            stxd
            ghi     rb
            stxd
            glo     rb
            stxd
            ghi     r7                 ; point to data item
            phi     rf
            glo     r7
            plo     rf
            inc     rf
            sep     scall              ; convert integer to ascii
            dw      ftoa
            irx                        ; recover consumed registers
            ldxa
            plo     rb
            ldxa
            phi     rb
            ldxa
            plo     ra
            ldxa
            phi     ra
            ldxa
            plo     r9
            ldxa
            phi     r9
            ldxa
            plo     r8
            ldx
            phi     r8
            inc     r7                 ; remove item from expr stack
            inc     r7
            inc     r7
            inc     r7
            inc     r8                 ; get number of decimal points
            inc     r8
            ldn     r8
            plo     rc
            dec     r8
            dec     r8
            ldi     scratch2_.1        ; where to put conversion
            phi     rf
            ldi     scratch2_.0
            plo     rf
            ldi     scratch1_.1        ; where to put conversion
            phi     rd
            ldi     scratch1_.0
            plo     rd
            sep     scall              ; convert from scientific, if needed
            dw      fromsci
            inc     r8                 ; get decimal count
            inc     r8
            ldn     r8
            plo     rc
            dec     r8
            dec     r8
            shl                        ; check for unspecified digits
            lbdf    fmtwrt_fi          ; jump straitght to output if so
            ldi     scratch1_.1        ; point to converted number
            phi     rf
            ldi     scratch1_.0
            plo     rf
fmtwrt_fr1: lda     rf                 ; get byte from number
            lbz     fmtwrt_fr4         ; jump if end found
            smi     '.'                ; looking for a decimal point
            lbnz    fmtwrt_fr1         ; loop until decimal or end found
fmtwrt_fr2: glo     rc                 ; see if enough digits have been output
            lbz     fmtwrt_fr5
            lda     rf                 ; get byte from 
            lbz     fmtwrt_fr3         ; jump if end found
            dec     rc                 ; decrement count
            lbr     fmtwrt_fr2         ; jump if not
fmtwrt_fr5: ldi     0                  ; terminate the number
            str     rf
            lbr     fmtwrt_fi          ; then send to output
fmtwrt_fr4: dec     rf                 ; move back to zero byte
            ldi     '.'                ; write a decimal point
            str     rf
            inc     rf
            skp
fmtwrt_fr3: dec     rf                 ; move back to terminator
fmtwrt_fr6: ldi     '0'                ; write a zero to output
            str     rf
            inc     rf
            dec     rc                 ; decrement count
            glo     rc                 ; get count
            lbnz    fmtwrt_fr6         ; loop until done
            ldi     0                  ; terminate the number
            str     rf
            lbr     fmtwrt_fi          ; then send to output

            /* ************************ */
            /* ***** A Conversion ***** */
            /* ************************ */
fmtwrt_a:   lda     r9                 ; get next variable type
            plo     re                 ; save for now
            lbz     fmtwrt_dn          ; done if no more variables
            lda     r9                 ; retrieve address of variable
            phi     rf
            lda     r9
            plo     rf
            inc     r8                 ; get field width
            ldn     r8
            plo     rc
            dec     r8
            glo     re                 ; now check variable type
            smi     'B'                ; check for byte
            lbz     fmtwrt_a1          ; jump if so
            glo     re                 ; now check variable type
            smi     'L'                ; check for logical
            lbz     fmtwrt_a1          ; jump if so
            glo     re                 ; now check variable type
            smi     'S'                ; check for short
            lbz     fmtwrt_a2          ; jump if so
            glo     re                 ; now check variable type
            smi     'I'                ; check for integer
            lbz     fmtwrt_a4          ; jump if so
            glo     re                 ; now check variable type
            smi     'R'                ; check for real
            lbz     fmtwrt_a4          ; jump if so
            lbr     fmtwrt_dn          ; invalid type ends write
fmtwrt_a1:  ldi     1                  ; 1 character
            lbr     fmtwrt_aa
fmtwrt_a2:  ldi     2                  ; 2 characters
            lbr     fmtwrt_aa
fmtwrt_a4:  ldi     4                  ; 4 characters
fmtwrt_aa:  phi     rc                 ; store count
fmtwrt_ab:  lda     rf                 ; get byte from variable
            lbz     fmtwrt_an          ; jump if not ascii data
            str     rb                 ; write to output buffer
            inc     rb
            dec     rc                 ; decrement field width
            glo     rc                 ; see if field width reached
            lbz     fmtwrt_e1          ; end of entry if so
fmtwrt_an:  ghi     rc                 ; get source count
            smi     1                  ; subtract 1
            phi     rc                 ; and put it back
            lbnz    fmtwrt_ab          ; continue copying if not done
fmtwrt_ac:  ldi     ' '                ; write a space to the output
            str     rb
            inc     rb
            dec     rc                 ; decrement field width
            glo     rc                 ; see if done
            lbnz    fmtwrt_ac          ; loop back if not
            lbr     fmtwrt_e1          ; otherwise done with item

            /* ************************ */
            /* ***** L Conversion ***** */
            /* ************************ */
fmtwrt_l:   lda     r9                 ; get next variable type
            plo     re                 ; save for now
            lbz     fmtwrt_dn          ; done if no more variables
            lda     r9                 ; retrieve address of variable
            phi     rf
            lda     r9
            plo     rf
            inc     r8                 ; get field width
            ldn     r8
            plo     rc
            dec     r8
            glo     re                 ; now check variable type
            smi     'B'                ; check for byte
            lbz     fmtwrt_l1          ; jump if so
            glo     re                 ; now check variable type
            smi     'L'                ; check for logical
            lbz     fmtwrt_l1          ; jump if so
            glo     re                 ; now check variable type
            smi     'S'                ; check for short
            lbz     fmtwrt_l2          ; jump if so
            glo     re                 ; now check variable type
            smi     'I'                ; check for integer
            lbz     fmtwrt_l4          ; jump if so
            glo     re                 ; now check variable type
            smi     'R'                ; check for real
            lbz     fmtwrt_l4          ; jump if so
            lbr     fmtwrt_dn          ; invalid type ends write
fmtwrt_l1:  ldi     1                  ; 1 character
            lbr     fmtwrt_la
fmtwrt_l2:  ldi     2                  ; 2 characters
            lbr     fmtwrt_la
fmtwrt_l4:  ldi     4                  ; 4 characters
fmtwrt_la:  phi     rc                 ; store count
fmtwrt_lb:  ldi     ' '                ; write a space to the output
            str     rb
            inc     rb
            dec     rc                 ; decrement field width
            glo     rc                 ; see if done
            lbnz    fmtwrt_lb          ; loop back if not
            dec     rb                 ; need to write into final byte of field
            ghi     rc                 ; move var size to low rc
            plo     rc
            ldi     0                  ; set initial value
            str     r2
fmtwrt_ld:  lda     rf                 ; get first byte of variable
            or                         ; combine with prior value
            str     r2                 ; put on stack
fmtwrt_lc:  dec     rc                 ; decrement size count
            glo     rc                 ; see if done
            lbnz    fmtwrt_ld          ; jump if not
            ldn     r2                 ; retrieve value
            lbz     fmtwrt_lf          ; jump if false
            ldi     'T'                ; write T to output
fmtwrt_le:  str     rb
            inc     rb
            lbr     fmtwrt_e1          ; done with item
fmtwrt_lf:  ldi     'F'                ; need to output F
            lbr     fmtwrt_le          ; output it

            /* ************************ */
            /* ***** I Conversion ***** */
            /* ************************ */
fmtwrt_i:   lda     r9                 ; get next variable type
            lbz     fmtwrt_dn          ; done if no more variables
            plo     re                 ; save type for a moment
            lda     r9                 ; retrieve address of data
            phi     rf
            lda     r9
            plo     rf
            glo     re                 ; get conversion
            sex     r7                 ; point to expr stack
            smi     'I'                ; is it an integer
            lbz     fmtwrt_i4          ; jump if so
            glo     re                 ; recover conversion
            smi     'S'                ; is it a short
            lbz     fmtwrt_i2          ; jump if so
            glo     re                 ; recover conversion
            smi     'B'                ; is it a byte
            lbz     fmtwrt_i1          ; jump if so
            glo     re                 ; recover conversion
            smi     'L'                ; is it a logical
            lbz     fmtwrt_i1          ; jump if so
            glo     re                 ; recover conversion
            smi     'R'                ; is it a Real
            lbz     fmtwrt_ir          ; jump if so
            sex     r2                 ; point x back to stack
            lbr     fmtwrt_dn          ; unknown type ends
fmtwrt_ir:  lda     rf                 ; place variable value on expr stack
            stxd
            lda     rf
            stxd
            lda     rf
            stxd
            lda     rf
            stxd
            sex     r2                 ; point x back to stack
            ghi     r8                 ; save consumed registers
            stxd
            glo     r8
            stxd
            ghi     r9
            stxd
            glo     r9
            stxd
            ghi     ra
            stxd
            glo     ra
            stxd
            ghi     rb
            stxd
            glo     rb
            stxd
            sep     scall              ; convert floating point to integer
            dw      ftoi
            irx                        ; recover consumed registers
            ldxa
            plo     rb
            ldxa
            phi     rb
            ldxa
            plo     ra
            ldxa
            phi     ra
            ldxa
            plo     r9
            ldxa
            phi     r9
            ldxa
            plo     r8
            ldx
            phi     r8
            lbr     fmtwrt_ia          ; then process as an integer
fmtwrt_i1:  ldi     0                  ; first 3 bytes are zero
            stxd                       ; push to expr stack
            stxd
            stxd
            lda     rf                 ; get byte from variable
            stxd                       ; push to expr stack
            lbr     fmtwrt_ia          ; then continue
fmtwrt_i2:  ldi     0                  ; first 2 bytes are zero
            stxd                       ; push to expr stack
            stxd
            lda     rf                 ; get byte from variable
            stxd                       ; push to expr stack
            lda     rf                 ; get byte from variable
            stxd                       ; push to expr stack
            lbr     fmtwrt_ia          ; then continue
fmtwrt_i4:  lda     rf                 ; place variable value on expr stack
            stxd
            lda     rf
            stxd
            lda     rf
            stxd
            lda     rf
            stxd
fmtwrt_ia:  sex     r2                 ; point x back to stack
            ldi     scratch1_.1        ; where to put conversion
            phi     rd
            ldi     scratch1_.0
            plo     rd
            ghi     r8                 ; save consumed registers
            stxd
            glo     r8
            stxd
            ghi     r9
            stxd
            glo     r9
            stxd
            ghi     ra
            stxd
            glo     ra
            stxd
            ghi     rb
            stxd
            glo     rb
            stxd
            ghi     r7                 ; point to data item
            phi     rf
            glo     r7
            plo     rf
            inc     rf
            sep     scall              ; convert integer to ascii
            dw      itoa32
            irx                        ; recover consumed registers
            ldxa
            plo     rb
            ldxa
            phi     rb
            ldxa
            plo     ra
            ldxa
            phi     ra
            ldxa
            plo     r9
            ldxa
            phi     r9
            ldxa
            plo     r8
            ldx
            phi     r8
            inc     r7                 ; remove item from expr stack
            inc     r7
            inc     r7
            inc     r7

fmtwrt_fi:  ldi     scratch1_.1        ; point to ascii value
            phi     rf
            ldi     scratch1_.0
            plo     rf
            sep     scall              ; get length
            dw      strlen
            ldi     scratch1_.1        ; point to ascii value
            phi     rf
            ldi     scratch1_.0
            plo     rf
            glo     rc                 ; save for subtract
            str     r2
            inc     r8                 ; get field width
            ldn     r8
            dec     r8
            sm                         ; subtract data size
            lbdf    fmtwrt_fi2         ; jump if no overflow
            plo     re
            ldi     '*'                ; signal overflow in output
            str     rb
            inc     rb
            inc     rf
            glo     re
fmtwrt_fi2: lbz     fmtwrt_c1          ; jump if data matches field size
            plo     rc                 ; put back into counter
            lbnf    fmtwrt_fi1         ; jump if data was wider
            ldi     ' '                ; need to output a space
            str     rb                 ; write into output
            inc     rb
            dec     rc                 ; decrement count
            glo     rc                 ; recover count
            lbr     fmtwrt_fi2         ; loop until done
fmtwrt_fi1: inc     rf                 ; left trim data
            inc     rc                 ; increment count
            glo     rc                 ; retrieve count
            lbr     fmtwrt_fi2         ; loop until data matches field width

; Now copy to output
fmtwrt_cpy: ldi     scratch1_.1        ; point to formatted number
            phi     rf
            ldi     scratch1_.0
            plo     rf
fmtwrt_c1:  lda     rf                 ; get byte from number
            lbz     fmtwrt_e1          ; next variable if end found
            str     rb                 ; write to output buffer
            inc     rb
            lbr     fmtwrt_c1          ; copy remaining characters
fmtwrt_e1:  dec     ra                 ; decrement repeat count
            glo     ra                 ; see if done with specifier
            lbz     fmtwrt_e2          ; jump if so
            lbr     fmtwrt_lp          ; loop back for next variable
fmtwrt_e2:  inc     r8                 ; move to next specifier
            inc     r8
            inc     r8
            lbr     fmtloop            ; then loop back

fmtwrt_dn:  ldi     0                  ; terminate record
            str     rb
            ldi     iobuffer.1         ; point to record
            phi     rf
            ldi     iobuffer.0
            plo     rf
            ghi     ra                 ; need to get LUN
            lbnz    fmtwrt_dsk         ; jump if a disk file
            sep     scall              ; display it
            dw      f_msg
            sep     scall              ; display cr/lf
            dw      f_inmsg
            db      10,13,0
            sep     sret               ; then return to caller
fmtwrt_dsk: sep     scall              ; call disk write
            dw      fwrite
            sep     sret               ; and then return
#endif

#ifdef FROMSCI
#redefine ROUND45
; ********************************************
; ***** Convert from scientific notation *****
; ***** RF - Pointer to ASCII number     *****
; ***** RD - Where to put result         *****
; ***** Uses: RC.0-exponent              *****
; *****       RC.1-decimal count         *****
; ********************************************
fromsci:    ghi     rf                 ; safe RF for now
            stxd
            glo     rf
            stxd
            sep     scall
            dw      round45
fromsci_1:  lda     rf                 ; get byte from input
            lbz     fromsci_no         ; jump if end reached
            smi     'E'                ; check for E character
            lbz     fromsci_y          ; jump if in scientific notation
            smi     32                 ; check for e character
            lbz     fromsci_y          ; jump if in scientific notation
            lbr     fromsci_1          ; loop until either E or end
fromsci_no: irx                        ; recover source
            ldxa
            plo     rf
            ldx
            phi     rf
fromsci_x1: lda     rf                 ; copy input to output
            str     rd
            inc     rd
            lbnz    fromsci_x1         ; loop until terminator copied
            sep     sret               ; return to caller
fromsci_y:  ldn     rf                 ; get byte following E
            smi     '+'                ; is it plus
            lbz     fromsci_p          ; jump if so
            ldn     rf                 ; recover byte
            smi     '-'                ; check for minus
            lbz     fromsci_n
            dec     rf                 ; compensate for later increment
fromsci_p:  ldi     0                  ; signal negative exponent
            lskp
fromsci_n:  ldi     1                  ; signal positive exponent
            phi     rc
            inc     rf                 ; point to exponent field
            ldi     0                  ; start exponent at zero
            plo     rc
fromsci_l1: lda     rf                 ; get byte from exponent field
            smi     '0'                ; check if below numbers
            plo     re                 ; keep a copy
            lbnf    fromsci_2          ; jump if done reading exponent
            smi     10                 ; check if above numbers
            lbdf    fromsci_2          ; jump if done reading exponent
            glo     rc                 ; multiply rc.0 by 10
            shl
            str     r2
            shl
            shl
            add
            str     r2                 ; now add in new digit
            glo     re
            add
            plo     rc                 ; put result back
            lbr     fromsci_l1         ; loop until done
fromsci_2:  irx                        ; recover source
            ldxa
            plo     rf
            ldx
            phi     rf
            ldn     rf                 ; get first byte of source
            smi     '-'                ; check for negative sign
            lbnz    fromsci_3          ; jump if not
            ldi     '-'                ; write negative sign to output
            str     rd
            inc     rd
            inc     rf                 ; move past negative sign
; Need to look for negative exponents here
fromsci_3:  ghi     rc                 ; check for negative exponent
            shr
            lbnf    fromsci_4          ; jump if not
            ghi     rf                 ; save source
            stxd
            glo     rf
            stxd
            ldi     0                  ; clear count
            phi     rc
fromsci_n1: lda     rf                 ; get byte from input
            plo     re                 ; keep a copy
            smi     '.'                ; check for period
            lbz     fromsci_n2         ; jump if decimal found
            ghi     re                 ; recover character
            smi     'E'                ; check for E
            lbz     fromsci_n2         ; jump if E
            smi     32                 ; check for e
            lbz     fromsci_n2         ; jump if so
            ghi     rc                 ; increment count
            adi     1
            phi     rc
            lbr     fromsci_n1         ; loop until . or E found
fromsci_n2: irx                        ; recover source address
            ldxa
            plo     rf
            ldx
            phi     rf
            glo     rc                 ; subtract exponent from count
            str     r2
            ghi     rc
            sm
            phi     rc
            lbnf    fromsci_n3         ; jump if negative result
            lbz     fromsci_n3         ; or zero
fromsci_n7: lda     rf                 ; read from source
            str     rd                 ; write to destination
            inc     rd
            ghi     rc                 ; get count
            smi     1                  ; and decrement
            phi     rc                 ; put it back
            lbnz    fromsci_n7         ; loop until correct number copied
            lbr     fromsci_n8         ; add a dot and remaining chars
fromsci_n3: ldi     '0'                ; need to write a zero
            str     rd                 ; write to output
            inc     rd
fromsci_n8: ldi     '.'                ; next a period
fromsci_n6: str     rd                 ; write to output
            inc     rd
fromsci_n4: ghi     rc                 ; see if done with leading zeros
            lbz     fromsci_n5         ; jump if so
            adi     1                  ; increment count
            phi     rc                 ; put it back
            ldi     '0'                ; write a 0 to the output
            lbr     fromsci_n6
fromsci_n5: lda     rf                 ; get byte from input
            lbz     fromsci_4d         ; jump if end found
            plo     re                 ; save a copy
            smi     '.'                ; check for period
            lbz     fromsci_n5         ; ignore it
            glo     re                 ; check for E
            smi     'E'
            lbz     fromsci_4d         ; done if E
            smi     32                 ; check for e
            lbz     fromsci_4d         ; done if so
            glo     re                 ; recover character
            str     rd                 ; otherwise write to output
            inc     rd
            lbr     fromsci_n5         ; loop until done
; code following is for positive exponents
; first part, copy until decimal point is found
fromsci_4:  lda     rf                 ; get byte from input
            plo     re                 ; keep a copy
            smi     '.'                ; is it decimal point
            lbz     fromsci_4a         ; jump if so
            glo     re                 ; get character
            smi     'E'                ; check for E
            lbz     fromsci_4b 
            smi     32                 ; check for e
            lbz     fromsci_4b 
            glo     re                 ; recover character
            str     rd                 ; and output it
            inc     rd
            lbr     fromsci_4          ; loop back for more
; now after decimal point through E
fromsci_4a: lda     rf                 ; get next digit
            plo     re                 ; keep a copy
            smi     'E'                ; check for end
            lbz     fromsci_4b 
            smi     32
            lbz     fromsci_4b 
            glo     re                 ; copy character to output
            str     rd
            inc     rd
            dec     rc                 ; increment count
            glo     rc                 ; get current count
            lbnz    fromsci_4a         ; jump if not zero
            ldi     '.'                ; output a decimal point
            str     rd
            inc     rd
            lbr     fromsci_4a         ; loop until done
fromsci_4b: glo     rc                 ; get count remaining
            lbz     fromsci_4d         ; jump if no more decimals
            shl                        ; see if negative
            lbdf    fromsci_4d         ; jump if done
fromsci_4c: ldi     '0'                ; write zero to output
            str     rd
            inc     rd
            dec     rc                 ; decrement count
            glo     rc                 ; see if done
            lbnz    fromsci_4c         ; loop back if not
            ldi     '.'                ; output a decimal point
            str     rd
            inc     rd
fromsci_4d: ldi     0                  ; terminate result
            str     rd
            sep     sret               ; and return to caller
            
#endif

#ifdef ROUND45
round45:    ghi     rf                 ; save rf
            stxd
            glo     rf
            stxd
            ldi     0                  ; set character count
            plo     rc
            phi     rc                 ; also flag no decimal point
            ldn     rf                 ; get character from input
            smi     '-'                ; check for minus sign
            lbnz    round45_1          ; jump if not
            inc     rf                 ; otherwise move past it
round45_1:  lda     rf                 ; get next character
            plo     re                 ; keep a copy
            lbz     round45_2          ; jump if end of number reached
            smi     'E'                ; check for E
            lbz     round45_2          ; jump if end of number
            smi     32                 ; check for e
            lbz     round45_2          ; jump if so
            inc     rc                 ; otherwise increment count
            glo     re                 ; recover character
            smi     '.'                ; check for decimal point
            lbnz    round45_1          ; loop back if not
            ldi     1                  ; indicate decimal point found
            phi     rc
            lbr     round45_1          ; and keep looking
round45_2:  ghi     rc                 ; was a decimal encountered
            lbnz    round45_3          ; jump if so
round45_rt: irx                        ; recover rf
            ldxa
            plo     rf
            ldx
            phi     rf
            sep     sret               ; otherwise return to caller
round45_3:  glo     rc                 ; check digit count
            smi     6                  ; need at least 6 to do rouding
            lbnf    round45_rt         ; return if no rounding
            dec     rf                 ; move back last digit
            dec     rf
            ldn     rf                 ; retrieve it
            smi     '.'                ; see if it was the decimal
            lbz     round45_rt         ; nothing to do if so
            ldn     rf                 ; recover last character
            adi     5                  ; round it
            smi     '9'+1              ; is it still a number
            lbnf    round45_rt         ; nothing to do if so
            ldi     '0'                ; replace with a zero
round45_lp: str     rf
round45_l1: dec     rf                 ; point to prior character
            dec     rc                 ; decrement count
            glo     rc                 ; get count
            lbz     round45_e          ; done if zero
            ldn     rf                 ; get next digit
            smi     '.'                ; is it the decimal
            lbz     round45_l1         ; jump if so
            ldn     rf                 ; recover character
            adi     1                  ; add 1 to it
            str     rf                 ; and put it back
            smi     '9'+1              ; is result still a numeral
            lbnf    round45_rt         ; done if so
            ldn     rf                 ; recover character
            smi     10                 ; subtract 10
            lbr     round45_lp         ; and loop back
round45_e:  inc     rf                 ; move back to first byte
            ldn     rf                 ; get current byte
            str     r2                 ; set aside
            ldi     '1'                ; need a 1
            str     rf                 ; write it
round45_e1: inc     rf
            ldn     rf                 ; get next byte
            plo     re                 ; set aside
            ldx                        ; get last byte
            str     rf                 ; store it
            lbz     round45_rt         ; done if stored a null
            glo     re                 ; otherwise get current character
            str     r2                 ; and save it
            lbr     round45_e1         ; loop for next character
#endif


/* *********************************************************************** */
/* *********************************************************************** */
/* *****                       File Library                          ***** */
/* *********************************************************************** */
/* *********************************************************************** */
#ifdef FWRITE
#redefine FILDES
#redefine FSTATUS
#redefine FCLOSE
fwrite:       sep      scall           ; get file record for file
              dw       fildes
              lbdf     fclose_rt       ; return if invalid file
              ldn      rd              ; get file open flag
              lbz      ferr_no         ; jump if file not open
              inc      rd              ; point to record size
              lda      rd
              plo      rc              ; put into count
              ldi      0
              phi      rc
              inc      rd              ; move to Elf/OS FILDES
              inc      rd
              inc      rd
              inc      rd
              sep      scall           ; call Elf/OS to write the record
              dw       030ch
              dec      rd              ; move back to IOSTATUS field
              dec      rd
              dec      rd
              str      rd              ; store status into record
              dec      rd              ; point to IORESULT
              ldi      0               ; get restult flag
              shlc
              str      rd              ; and store it
              lbz      fwrite_gd       ; jumpt if good read
              sep      sret            ; return to caller
fwrite_gd:    inc      rd              ; back to status field
              glo      rc              ; get bytes written
              str      rd
              sep      sret
#endif

#ifdef FREAD
#redefine FILDES
#redefine FSTATUS
#redefine FCLOSE
fread:        ghi      ra
              sep      scall           ; get file record for file
              dw       fildes
              lbdf     fclose_rt       ; return if invalid file
              ldn      rd              ; get file open flag
              lbz      ferr_no         ; jump if file not open
              inc      rd              ; point to record size
              lda      rd
              plo      rc              ; put into count
              ldi      0
              phi      rc
              inc      rd              ; move to Elf/OS FILDES
              inc      rd
              inc      rd
              inc      rd
              sep      scall           ; call Elf/OS to read the record
              dw       0309h
              dec      rd              ; move back to IOSTATUS field
              dec      rd
              dec      rd
              str      rd              ; store status into record
              dec      rd              ; point to IORESULT
              ldi      0               ; get restult flag
              shlc
              str      rd              ; and store it
              lbz      fread_gd        ; jump if good read
              sep      sret            ; return to caller
fread_gd:     inc      rd              ; back to status field
              glo      rc              ; get bytes read
              str      rd
              sep      sret
#endif

#ifdef FOPEN
#redefine FILDES
#redefine FSTATUS
#redefine FCLOSE
fopen:        sep      scall           ; get file record for file
              dw       fildes
              lbdf     fopen_rt        ; return if invalid file
              ldn      rd              ; get file open flag
              lbnz     ferr_ao         ; jump if already open
              inc      rd              ; move to record length
              glo      rc              ; store record length
              str      rd
              inc      rd              ; then move to Elf/OS FILDES
              inc      rd
              inc      rd
              inc      rd
              inc      rd
              ghi      r7              ; preserver R7
              stxd
              glo      r7
              stxd
              ldi      1               ; create file if it does not exist
              plo      r7
              ldi      0
              phi      r7
              sep      scall           ; call Elf/OS to open the file
              dw       0306h
              dec      rd              ; move back to IOSTATUS field
              dec      rd
              dec      rd
              str      rd              ; store status into record
              dec      rd              ; point to IORESULT
              ldi      0               ; get restult flag
              shlc
              str      rd              ; and store it
              shr                      ; put success back into DF
              irx                      ; recover R7
              ldxa
              plo      r7
              ldx
              phi      r7
              lbdf     fopen_rt        ; return on error
              dec      rd              ; move back to open flag
              dec      rd
              ldi      1               ; signal file is open
              str      rd
fopen_rt:     sep      sret            ; return to caller
#endif

#ifdef FCLOSE
#redefine FILDES
#redefine FSTATUS
; *****************************************
; ***** Close a file                  *****
; ***** D - File number (starts at 1) *****
; *****************************************
fclose:       sep      scall           ; get file record for file
              dw       fildes
              lbdf     fclose_rt       ; return if invalid file
              ldn      rd              ; get file open flag
              lbz      ferr_no         ; jump if file not open
              ldi      0               ; mark file as closed
              str      rd
              inc      rd              ; now move to Elf/OS FILDES
              inc      rd
              inc      rd
              inc      rd
              inc      rd
              inc      rd
              sep      scall           ; call Elf/OS to close the file
              dw       0312h
              dec      rd              ; move back to IOSTATUS field
              dec      rd
              dec      rd
              str      rd              ; store status into record
              dec      rd              ; point to IORESULT
              ldi      0               ; get restult flag
              shlc
              str      rd              ; and store it
fclose_rt:    sep      sret            ; return to caller
#endif

#ifdef FREWIND
#redefine FILDES
#redefine FSTATUS
; *****************************************
; ***** Rewind a file                 *****
; ***** D - File number (starts at 1) *****
; *****************************************
frewind:      sep      scall           ; get file record for file
              dw       fildes
              lbdf     frewind_rt      ; return if invalid file
              ldn      rd              ; get file open flag
              lbz      ferr_no         ; jump if file not open
              inc      rd              ; now move to Elf/OS FILDES
              inc      rd
              inc      rd
              inc      rd
              inc      rd
              inc      rd
              ghi      r7              ; preserver R7
              stxd
              glo      r7
              stxd
              ldi      0               ; set seek position to zero
              plo      r7
              phi      r7
              plo      r8
              phi      r8
              plo      rc              ; seek from beginning
              phi      rc
              sep      scall           ; call Elf/OS to rewind the file
              dw       030fh
              dec      rd              ; move back to IOSTATUS field
              dec      rd
              dec      rd
              str      rd              ; store status into record
              dec      rd              ; point to IORESULT
              ldi      0               ; get restult flag
              shlc
              str      rd              ; and store it
              irx                      ; recover R7
              ldxa
              plo      r7
              ldx
              phi      r7
frewind_rt:   sep      sret            ; return to caller
#endif

#ifdef FSTATUS
ferr_no:      inc      rd              ; move to IOFLAG
              inc      rd
              ldi      1               ; signal error
              str      rd
              inc      rd
              ldi      020h            ; signal file not open
              str      rd              ; store into IORESULT
              smi      0               ; Set DF to signal error
              sep      sret            ; and return to caller
ferr_ao:      inc      rd              ; move to IOFLAG
              inc      rd
              ldi      1               ; signal error
              str      rd
              inc      rd
              ldi      021h            ; signal file already open
              str      rd              ; store into IORESULT
              smi      0               ; Set DF to signal error
              sep      sret            ; and return to caller
#endif

#ifdef IOFLAG
#redefine FILDES
ioflag:       inc      r7              ; get LUN from stack
              lda      r7
              inc      r7              ; remove remainder of number
              inc      r7
              plo      re              ; set number aside
              ldi      0               ; high 3 bytes of result are zero
              str      r7
              dec      r7
              str      r7
              dec      r7
              str      r7
              dec      r7
              glo      re              ; recover file number
              sep      scall           ; get file record for file
              dw       fildes
              lbdf     ioflag_er       ; jump if bad file number
              inc      rd              ; point to ioflag field
              inc      rd
              lda      rd              ; and retrieve it
              str      r7              ; place on expr stack
              dec      r7
              sep      sret            ; and return
ioflag_er:    ldi      0xff            ; indicate bad file number
              str      r7              ; place on expr stack
              dec      r7
              sep      sret            ; and return
#endif

#ifdef IOSTATUS
#redefine FILDES
iostatus:     inc      r7              ; get LUN from stack
              lda      r7
              inc      r7              ; remove remainder of number
              inc      r7
              plo      re              ; set number aside
              ldi      0               ; high 3 bytes of result are zero
              str      r7
              dec      r7
              str      r7
              dec      r7
              str      r7
              dec      r7
              glo      re              ; recover file number
              sep      scall           ; get file record for file
              dw       fildes
              lbdf     iostatus_er     ; jump if bad file number
              inc      rd              ; point to iostatus field
              inc      rd
              inc      rd
              lda      rd              ; and retrieve it
              str      r7              ; place on expr stack
              dec      r7
              sep      sret            ; and return
iostatus_er:  ldi      0xff            ; indicate bad file number
              str      r7              ; place on expr stack
              dec      r7
              sep      sret            ; and return
#endif

#ifdef FILDES
; **********************************************
; ***** Find file record for a file number *****
; ***** D - File number (starts at 1)      *****
; ***** Returns: DF=0 - file good          *****
; *****          DF=1 - Invalid number     *****
; *****          RD   - File record        *****
; **********************************************
fildes:       smi      1               ; File numbers start at 1
              lbz      fildes1         ; jump if file 1
              smi      1               ; check for file 2
              lbz      fildes2
              smi      1               ; check for file 3
              lbz      fildes3
              smi      1               ; check for file 4
              lbz      fildes4
              smi      0               ; set DF to indicate invalid
              sep      sret            ; and return to caller
fildes1:      ldi      file1_.1        ; point file 1 record
              phi      rd
              ldi      file1_.0
              plo      rd
              adi      0               ; signal good
              sep      sret            ; and return
fildes2:      ldi      file2_.1        ; point file 1 record
              phi      rd
              ldi      file2_.0
              plo      rd
              adi      0               ; signal good
              sep      sret            ; and return
fildes3:      ldi      file3_.1        ; point file 1 record
              phi      rd
              ldi      file3_.0
              plo      rd
              adi      0               ; signal good
              sep      sret            ; and return
fildes4:      ldi      file4_.1        ; point file 1 record
              phi      rd
              ldi      file4_.0
              plo      rd
              adi      0               ; signal good
              sep      sret            ; and return
#endif

; ***********************************************************************
; ***********************************************************************
; *****                 16-bit Integer Library                      *****
; ***********************************************************************
; ***********************************************************************
#ifdef MULDIV16
mdnorm:     ghi     rc
            str     r2
            ghi     rd
            xor
            shl
            ldi     0
            shlc
            plo     re
            ghi     rc
            shl
            lbnf    mdnorm2
            ghi     rc
            xri     0ffh
            phi     rc
            glo     rc
            xri     0ffh
            plo     rc
            inc     rc
mdnorm2:    ghi     rd
            shl
            lbnf    mdnorm3
            ghi     rd
            xri     0ffh
            phi     rd
            glo     rd
            xri     0ffh
            plo     rd
            inc     rd
mdnorm3:    glo     re
            sep     sret
#endif

#ifdef MUL16
mul16:      sex     r7
            irx
            ldxa
            plo     rd
            ldxa
            phi     rd
            ldxa
            plo     rc
            ldx
            phi     rc
            sex     r2
            sep     scall
            dw      mdnorm
            plo     re
            ldi     0
            phi     rf
            plo     rf
mulloop:    glo     rd
            lbnz    mulcont
            ghi     rd
            lbnz    mulcont
            glo     re
            shr
            lbnf    mulexit
            glo     rf
            xri     0ffh
            plo     rf
            ghi     rf
            xri     0ffh
            phi     rf
            inc     rf
mulexit:    sex     r7
            ghi     rf
            stxd
            glo     rf
            stxd
            sex     r2
            sep     sret
mulcont:    ghi     rd
            shr
            phi     rd
            glo     rd
            shrc
            plo     rd
            lbnf    mulcont2
            glo     rc
            str     r2
            glo     rf
            add
            plo     rf
            ghi     rc
            str     r2
            ghi     rf
            adc
            phi     rf
mulcont2:   glo     rc
            shl
            plo     rc
            ghi     rc
            shlc
            phi     rc
            lbr     mulloop
#endif

#ifdef DIV16
div16:      sex     r7
            irx
            ldxa
            plo     rd
            ldxa
            phi     rd
            ldxa
            plo     rc
            ldx
            phi     rc
            sex     r2
            sep     scall
            dw      mdnorm
            plo     re
            glo     rd
            lbnz    div16_1
            ghi     rd
            lbnz    div16_1
            sex     r7
            ldi     0
            stxd
            stxd
            sex     r2
            sep     sret
div16_1:    ldi     0
            phi     rf
            plo     rf
            phi     r8
            plo     r8
            inc     r8
d16lp1:     ghi     rd
            ani     128
            lbnz    divst
            glo     rd
            shl
            plo     rd
            ghi     rd
            shlc
            phi     rd
            glo     r8
            shl
            plo     r8
            ghi     r8
            shlc
            phi     r8
            lbr     d16lp1
divst:      glo     rd
            lbnz    divgo
            ghi     rd
            lbnz    divgo
divret:     glo     re
            shr
            lbnf    divrt
            ghi     rf
            xri     0ffh
            phi     rf
            glo     rf
            xri     0ffh
            plo     rf
            inc     rf
divrt:      sex     r7
            ghi     rf
            stxd
            glo     rf
            stxd
            sex     r2
            sep     sret
divgo:      glo     rc
            plo     r9
            ghi     rc
            phi     r9
            glo     rd
            str     r2
            glo     rc
            sm
            plo     rc
            ghi     rd
            str     r2
            ghi     rc
            smb
            phi     rc
            lbdf    divyes
            glo     r9
            plo     rc
            ghi     r9
            phi     rc
            lbr     divno
divyes:     glo     r8
            str     r2
            glo     rf
            add
            plo     rf
            ghi     r8
            str     r2
            ghi     rf
            adc
            phi     rf
divno:      ghi     rd
            shr
            phi     rd
            glo     rd
            shrc
            plo     rd
            ghi     r8
            shr
            phi     r8
            glo     r8
            shrc
            plo     r8
            lbdf    divret
            lbr     divst
#endif

#ifdef MOD16
mod16:      sep     scall
            dw      div16
            inc     r7
            inc     r7
            ghi     rc
            str     r7
            dec     r7
            glo     rc
            str     r7
            dec     r7
            sep     sret
#endif

#ifdef ADD16
add16:      sex     r7
            irx
            ldxa
            irx
            add
            stxd
            ldxa
            irx           
            adc
            stxd
            dec     r7
            sex     r2
            sep     sret
#endif

#ifdef SUB16
sub16:      sex     r7
            irx
            ldxa
            irx
            sd
            stxd
            ldxa
            irx           
            sdb
            stxd
            dec     r7
            sex     r2
            sep     sret
#endif

#ifdef AND16
and16:      sex     r7
            irx
            ldxa
            irx
            and
            stxd
            ldxa
            irx
            and
            stxd
            dec     r7
            sex     r2
            sep     sret
#endif

#ifdef OR16
or16:       sex     r7
            irx
            ldxa
            irx
            or
            stxd
            ldxa
            irx
            or
            stxd
            dec     r7
            sex     r2
            sep     sret
#endif

#ifdef XOR16
xor16:      sex     r7
            irx
            ldxa
            irx
            xor
            stxd
            ldxa
            irx
            xor
            stxd
            dec     r7
            sex     r2
            sep     sret
#endif

#ifdef CMP16
true:       ldi     0ffh
            sex     r7
            stxd
            stxd
            sex     r2
            sep     sret

false:      ldi     000h
            sex     r7
            stxd
            stxd
            sex     r2
            sep     sret
#endif

#ifdef EQ16
eq16:       sep     scall
            dw      sub16
            sex     r7
            irx
            ldxa
            or
            sex     r2
            lbz     true
            lbr     false
#endif

#ifdef NE16
ne16:       sep     scall
            dw      sub16
            sex     r7
            irx
            ldxa
            or
            sex     r2
            lbnz    true
            lbr     false
#endif

#ifdef GT16
gt16:       sep     scall
            dw      sub16
            sex     r7
            irx
            ldxa
            or
            sex     r2
            lbz     false
            ldn     r7
            shl
            lbnf    true
            lbr     false
#endif

#ifdef LT16
lt16:       sep     scall
            dw      sub16
            sex     r7
            irx
            ldxa
            or
            sex     r2
            lbz     false
            ldn     r7
            shl
            lbdf    true
            lbr     false
#endif

#ifdef GTE16
gte16:      sep     scall
            dw      sub16
            sex     r7
            irx
            ldxa
            or
            sex     r2
            lbz     true
            ldn     r7
            shl
            lbnf    true
            lbr     false
#endif

#ifdef LTE16
lte16:      sep     scall
            dw      sub16
            sex     r7
            irx
            ldxa
            or
            sex     r2
            lbz     true
            ldn     r7
            shl
            lbdf    true
            lbr     false
#endif

#ifdef ABS16
abs16:      inc     r7
            inc     r7
            ldn     r7
            shl
            lbnf    absrt
            dec     r7
            ldn     r7
            xri     0ffh
            adi     1
            str     r7
            inc     r7
            ldn     r7
            xri     0ffh
            adci    0
            str     r7
absrt:      dec     r7
            dec     r7
            sep     sret
#endif

#ifdef SGN16
sgn16:      inc     r7
            lda     r7
            str     r2
            ldn     r7
            shl
            lbdf    sgnm
            ldn     r7
            or
            lbz     sgn0
            ldi     0
            str     r7
            dec     r7
            ldi     1
            str     r7
            dec     r7
            sep     sret
sgnm:       ldi     0ffh
            str     r7
            dec     r7
            str     r7
            dec     r7
            sep     sret
sgn0:       dec     r7
            dec     r7
            sep     sret
#endif

#ifdef RND16
rnd16:      ldi     16
            plo     rc
            sep     scall         ; Shift the register
            dw      lfsr_lp
            ldi     LFSR_.1
            phi     r9
            ldi     LFSR_.0
            plo     r9
            lda     r9
            plo     rf
            ldn     r9
            phi     rf
            inc     r7
            lda     r7
            plo     r9
            ldn     r7
            phi     r9
            ghi     rf
            ani     07fh
            str     r7
            dec     r7
            glo     rf
            str     r7
            dec     r7
            ghi     r9
            str     r7
            dec     r7
            glo     r9
            str     r7
            dec     r7
            lbr     mod16
#endif

#ifdef NEXT16
nextvar:    irx          ; move to varAddr
            ldxa
            plo     rd
            ldxa
            phi     rd
            irx
            irx
            glo     rc   ; check for correct address
            sm           ; against stack
            lbnz    nv1  ; jump if not
            irx          ; move to msb
            ghi     rc
            sm           ; compare
            lbnz    nv2  ; jump if not
            dec     r2   ; entry found, move back
            dec     r2
            dec     r2
            dec     r2
            dec     r2
            dec     r2
            lbr     next
nv1:        irx          ; move past bad entry
nv2:        irx          ; move past bad entry
            irx       
            irx       
            irx       
            ghi     rd
            stxd
            glo     rd
            stxd
            lbr     nextvar
next:       glo     r2
            plo     ra
            ghi     r2
            phi     ra
            sex     ra
            irx          ; return address lsb
            irx          ; return address msb
            irx          ; exec address lsb
            ldxa         ; retrieve exec address
            plo     r9
            ldxa
            phi     r9
            ldxa         ; get it
            plo     rf   ; set rf to address
            ldxa         ; get msb
            phi     rf
            inc     rf   ; point to variable lsb
            ldn     rf   ; retrieve it
            add          ; add in step
            str     rf
            dec     rf   ; point to msb
            irx          ; point to msb of step
            ldn     rf   ; get msb of var value
            adc          ; add in step
            str     rf   ; store back into variable
            irx          ; point to loop count lsb
            ldi     1    ; need to decrement count
            sd           ; decrement it
            str     ra   ; and put it back
            irx          ; point to loop count msb
            ldi     0    ; propagate carry
            sdb
            str     ra   ; and put it back
            sex     r2   ; point X back to R2
            lbdf    stay ; Jump if loop not done
            inc     r2
            dec     ra
            ldxa
            str     ra
            inc     ra
            ldx
            str     ra
            dec     ra
            dec     ra
            glo     ra
            plo     r2
            ghi     ra
            phi     r2
            sep     sret ; nothing to do so return
stay:       glo     r9   ; set return address to exec address
            plo     r6
            ghi     r9
            phi     r6
            sep     sret ; and then return
#endif

#ifdef ATOI16
; **************************************** 
; ***** Convert ASCII to integer     ***** 
; ***** RF - Pointer to ASCII number ***** 
; ***** Returns: RC - 16-bit integer ***** 
; **************************************** 
atoi:       ldi     0
            plo     rc
            phi     rc
            plo     r9
            ldn     rf
            smi     '-'
            lbnz    atoi_0_1
            inc     rf
            inc     r9
atoi_0_1:   lda     rf
            plo     re
            smi     '0'
            lbnf    atoi_no
            smi     10
            lbnf    atoi_0_2
atoi_no:    glo     r9
            shr
            lbnf    atoi_rt
            glo     rc
            xri     0ffh
            adi     1
            plo     rc
            ghi     rc
            xri     0ffh
            adci    0
            phi     rc
atoi_rt:    sep     sret
atoi_0_2:   glo     re
            smi     '0'
            plo     re
            glo     rc
            shl
            plo     rc
            plo     r8
            ghi     rc
            shlc
            phi     rc
            phi     r8
            glo     r8
            shl
            plo     r8
            ghi     r8
            shlc
            phi     r8
            glo     r8
            shl
            plo     r8
            ghi     r8
            shlc
            phi     r8
            glo     r8
            str     r2
            glo     rc
            add
            plo     rc
            ghi     r8
            str     r2
            ghi     rc
            adc
            phi     rc
            glo     re
            str     r2
            glo     rc
            add
            plo     rc
            ghi     rc
            adci    0
            phi     rc
            lbr     atoi_0_1
#endif

#ifdef ITOA16
; ************************************** 
; ***** Convert RC to bcd in M[RF] ***** 
; ************************************** 
tobcd:      ghi     rf
            stxd
            glo     rf
            stxd
            ldi     5
            plo     re
tobcdlp1:   ldi     0
            str     rf
            inc     rf
            dec     re
            glo     re
            lbnz    tobcdlp1
            irx
            ldxa
            plo     rf
            ldx
            phi     rf
            ldi     16
            plo     r9
tobcdlp2:   ldi     5
            plo     re
            ghi     rf
            stxd
            glo     rf
            stxd
tobcdlp3:   ldn     rf
            smi     5
            lbnf    tobcdlp3a
            adi     8
            str     rf
tobcdlp3a:  inc     rf
            dec     re
            glo     re
            lbnz    tobcdlp3
            glo     rc
            shl
            plo     rc
            ghi     rc
            shlc
            phi     rc
            shlc
            shl
            shl
            shl
            str     rf
            irx
            ldxa
            plo     rf
            ldx
            phi     rf
            ghi     rf
            stxd
            glo     rf
            stxd
            ldi     5
            plo     re
tobcdlp4:   lda     rf
            str     r2
            ldn     rf
            shr
            shr
            shr
            shr
            ldn     r2
            shlc
            ani     0fh
            dec     rf
            str     rf
            inc     rf
            dec     re
            glo     re
            lbnz    tobcdlp4
            irx
            ldxa
            plo     rf
            ldx
            phi     rf
            dec     r9
            glo     r9
            lbnz    tobcdlp2
            sep     sret

; *************************************************** 
; ***** Output 16-bit integer                   ***** 
; ***** RC - 16-bit integer                     ***** 
; ***** RD - Buffer for output                  ***** 
; *************************************************** 
itoa:       glo     r2
            smi     6
            plo     r2
            ghi     r2
            smbi    0
            phi     r2
            glo     r2
            plo     rf
            ghi     r2
            phi     rf
            inc     rf
            ghi     rc
            shl
            lbnf    itoa1
            ldi     '-'
            str     rd
            inc     rd
            glo     rc
            xri     0ffh
            plo     rc
            ghi     rc
            xri     0ffh
            phi     rc
            inc     rc
itoa1:      sep     scall
            dw      tobcd
            glo     r2
            plo     rf
            ghi     r2
            phi     rf
            inc     rf
            ldi     5
            plo     r8
            ldi     4
            phi     r8
itoalp1:    lda     rf
            lbz     itoaz
            str     r2
            ldi     0
            phi     r8
            ldn     r2
itoa2:      adi     030h
            str     rd
            inc     rd
itoa3:      dec     r8
            glo     r8
            lbnz    itoalp1
            glo     r2
            adi     6
            plo     r2
            ghi     r2
            adci    0
            phi     r2
            ldi     0
            str     rd
            sep     sret
itoaz:      ghi     r8
            lbz     itoa2
            smi     1
            phi     r8
            lbr     itoa3
#endif


/* *********************************************************************** */
/* *********************************************************************** */
/* *****                     Heap manager                            ***** */
/* *********************************************************************** */
/* *********************************************************************** */

#ifdef HEAP
; ******************************************* 
; ***** Allocate memory                 ***** 
; ***** RC - requested size             ***** 
; ***** Returns: RF - Address of memory ***** 
; ******************************************* 
alloc:      ldi     HEAP_.0           ; get heap address
            plo     r9
            ldi     HEAP_.1
            phi     r9
            lda     r9
            phi     rd
            ldn     r9
            plo     rd
            dec     r9                  ; leave pointer at heap address
alloc_1:    lda     rd                  ; get flags byte
            lbz     alloc_new           ; need new if end of table
            plo     re                  ; save flags
            lda     rd                  ; get block size
            phi     rf
            lda     rd
            plo     rf
            glo     re                  ; is block allocated?
            smi     2
            lbz     alloc_nxt           ; jump if so
            glo     rc                  ; subtract size from block size
            str     r2
            glo     rf
            sm
            plo     rf
            ghi     rc
            str     r2
            ghi     rf
            smb
            phi     rf                  ; RF now has difference
            lbnf    alloc_nxt           ; jumpt if block is too small
            ghi     rf                  ; see if need to split block
            lbnz    alloc_sp            ; jump if so
            glo     rf                  ; get low byte of difference
            ani     0f8h                ; want to see if at least 8 extra bytes
            lbnz    alloc_sp            ; jump if so
alloc_2:    glo     rd                  ; set address for return
            plo     rf
            ghi     rd
            phi     rf
            dec     rd                  ; move back to flags byte
            dec     rd
            dec     rd
            ldi     2                   ; mark block as used
            str     rd
            sep     sret                ; and return to caller
alloc_sp:   ghi     rd                  ; save this address
            stxd
            glo     rd
            stxd
            dec     rd                  ; move to lsb of block size
            glo     rc                  ; write requested size
            str     rd
            dec     rd
            ghi     rc                  ; write msb of size
            str     rd
            inc     rd                  ; move back to data
            inc     rd
            glo     rc                  ; now add size
            str     r2
            glo     rd
            add
            plo     rd
            ghi     rd
            str     r2
            ghi     rc
            adc
            phi     rd                  ; rd now points to new block
            ldi     1                   ; mark as a free block
            str     rd
            inc     rd
            dec     rf                  ; remove 3 bytes from block size
            dec     rf
            dec     rf
            ghi     rf                  ; and write into block header
            str     rd
            inc     rd
            glo     rf
            str     rd
            irx                         ; recover address
            ldxa
            plo     rd
            ldx
            phi     rd
            lbr     alloc_2             ; finish allocating
alloc_nxt:  glo     rf                  ; add block size to address
            str     r2
            glo     rd
            add
            plo     rd
            ghi     rf
            str     r2
            ghi     rd
            adc
            phi     rd
            lbr     alloc_1             ; check next cell
alloc_new:  lda     r9                  ; retrieve start of heap
            phi     rd
            ldn     r9
            plo     rd
            glo     rc                  ; subtract req. size from pointer
            str     r2
            glo     rd
            sm
            plo     rd
            ghi     rc
            str     r2
            ghi     rd
            smb
            phi     rd
            dec     rd                  ; point to lsb of block size
            glo     rc                  ; write size
            str     rd
            dec     rd
            ghi     rc
            str     rd
            dec     rd
            ldi     2                   ; mark as allocated block
            str     rd
            glo     rd                  ; set address
            plo     rf
            ghi     rd
            phi     rf
            inc     rf                  ; point to actual data space
            inc     rf
            inc     rf
            glo     rd                  ; write new heap address
            str     r9
            dec     r9
            ghi     rd
            str     r9
            sep     scall               ; check for out of memory
            dw      checkeom
            sep     sret                ; return to caller

; ************************************** 
; ***** Deallocate memory          ***** 
; ***** RF - address to deallocate ***** 
; ************************************** 
dealloc:    dec     rf                  ; move to flags byte
            dec     rf
            dec     rf
            ldi     1                   ; mark block as free
            str     rf
heapgc:     ghi     rc                  ; save consumed registers
            stxd
            glo     rc
            stxd
            ghi     rd
            stxd
            glo     rd
            stxd
            ldi     HEAP_.0           ; need start of heap
            plo     r9
            ldi     HEAP_.1
            phi     r9
            lda     r9                  ; retrieve heap start address
            phi     rd
            ldn     r9
            plo     rd
heapgc_s:   dec     r9
            ldn     rd                  ; see if first block was freed
            lbz     heapgc_dn           ; jump if end of heap encountered
            smi     1
            lbnz    heapgc_1            ; jump on first allocated block
            inc     rd                  ; retrieve block size
            lda     rd
            plo     re
            lda     rd
            str     r2                  ; and add to block
            glo     rd
            add
            plo     rd
            glo     re
            str     r2
            ghi     rd
            adc
            phi     rd
            str     r9                  ; write new heap start
            inc     r9
            glo     rd
            str     r9
            lbr     heapgc_s            ; loop back to check for more leading empty blocks
heapgc_1:   lda     rd                  ; retrieve flags byte
            lbz     heapgc_dn           ; return if end of heap found
            plo     re                  ; save copy of flags
            lda     rd                  ; retrieve block size
            phi     rc
            lda     rd
            plo     rc
            glo     rd                  ; RF=RD+RC, point to next block
            str     r2
            glo     rc
            add
            plo     rf
            ghi     rd
            str     r2
            ghi     rc
            adc
            phi     rf
            lda     rf                  ; retrieve flags for next block
            lbz     heapgc_dn           ; return if on last block
            smi     2                   ; is block allocated?
            lbz     heapgc_a            ; jump if so
            glo     re                  ; check flags of current block
            smi     2                   ; is it allocated
            lbz     heapgc_a            ; jump if so
            lda     rf                  ; retrieve next block size into RF
            plo     re
            lda     rf
            plo     rf
            glo     re
            phi     rf
            inc     rf                  ; add 3 bytes for header
            inc     rf
            inc     rf
            glo     rf                  ; RC += RF, combine sizes
            str     r2
            glo     rc
            add
            plo     rc
            ghi     rf
            str     r2
            ghi     rc
            adc
            phi     rc
            dec     rd                  ; write size of combined blocks
            glo     rc
            str     rd
            dec     rd
            ghi     rc
            str     rd
            dec     rd                  ; move back to flags byte
            lbr     heapgc_1            ; keep checking for merges
heapgc_a:   glo     rf                  ; move pointer to next block
            plo     rd
            ghi     rf
            phi     rd
            dec     rd                  ; move back to flags byte
            lbr     heapgc_1            ; and check next block
heapgc_dn:  irx                         ; recover consumed registers
            ldxa
            plo     rd
            ldxa
            phi     rd
            ldxa
            plo     rc
            ldx
            phi     rc
            sep     sret                ; return to caller

; ********************************************* 
; ***** Return amount of free heap memory ***** 
; ***** Returns: RC - free heap memory    ***** 
; ********************************************* 
hfree:      ldi     0                   ; clear count
            plo     rc
            phi     rc
            ldi     HEAP_.0             ; setup heap pointer
            plo     r9
            ldi     HEAP_.1
            phi     r9
            lda     r9                  ; retrieve start of heap
            phi     rf
            ldn     r9
            plo     rf
hfree_lp:   lda     rf                  ; get heap allocation status byte
            lbz     hfree_dn            ; jump if end of heap
            plo     re                  ; save this for a moment
            lda     rf                  ; retrieve block size
            phi     rd
            lda     rf
            plo     rd
            str     r2                  ; add size to block address
            glo     rf
            add
            plo     rf
            ghi     rd
            str     r2
            ghi     rf
            adc
            phi     rf
            glo     re                  ; recover status byte
            smi     1                   ; is it a free block
            lbnz    hfree_lp            ; jump if not
            glo     rd                  ; add block size to count
            str     r2
            glo     rc
            add
            plo     rc
            ghi     rd
            str     r2
            ghi     rc
            adc
            phi     rc
            lbr     hfree_lp            ; check next block
hfree_dn:   sep     sret                ; and return

; *********************************** 
; ***** Check for out of memory ***** 
; *********************************** 
checkeom:   ghi     rc                  ; save consumed register
            stxd
            glo     rc
            stxd
            ldi     FREE_.0             ; get end of variable table
            plo     r9
            ldi     FREE_.1
            phi     r9
            lda     r9                  ; retrieve variable table end
            phi     rc
            lda     r9
            plo     rc
            ldi     HEAP_.0             ; point to heap start
            plo     r9
            ldi     HEAP_.1
            phi     r9
            inc     r9                  ; point to lsb
            ldn     r9                  ; get heap
            str     r2
            glo     rc                  ; subtract from variable table end
            sm
            dec     r9                  ; point to msb
            ldn     r9                  ; retrieve it
            str     r2
            ghi     rc                  ; subtract from variable table end
            smb
            lbdf    oom                 ; jump of out of memory
            irx                         ; recover consumed register
            ldxa
            plo     rc
            ldx
            phi     rc
            sep     sret                ; and return to caller
oom:        sep     scall               ; display out of memory error
            dw      f_inmsg
            db      'Out of memory: ',0
            lbr     $                   ; show line of error and exit
#endif



/* *********************************************************************** */
/* *********************************************************************** */
/* *****                      Trig Library                           ***** */
/* *********************************************************************** */
/* *********************************************************************** */


#ifdef TANFP
#redefine USETRIG
#redefine SINFP
#redefine COSFP
; ****************************************************** 
; ***** tan                                        ***** 
; ***** RF - Pointer to floating point number      ***** 
; ***** RD - Pointer to floating point destination ***** 
; ***** internal:                                  ***** 
; *****       R2+1     - s                         ***** 
; *****       R2+5     - c                         ***** 
; ****************************************************** 
fptan:      ghi      r7           ; save expr stack
            stxd
            glo      r7
            stxd
            ghi      r7           ; source is expr stack
            phi      rf
            glo      r7
            plo      rf
            inc      rf
            ghi      rf           ; s = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
            ghi      rf           ; c = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
            glo      r2           ; setup for computing sin
            plo      r7
            ghi      r2
            phi      r7
            sep      scall        ; compute sin
            dw       fpsin
            glo      r2           ; setup to compute cos
            adi      4
            plo      r7
            ghi      r2
            adci     0
            phi      r7
            sep      scall        ; compute cos
            dw       fpcos
            sep      scall        ; get arguments for division
            dw       getargs
            db       1,5
            sep      scall        ; s = s / c
            dw       divfpi
            irx                   ; recover answer
            ldxa
            plo      r8
            ldxa
            phi      r8
            ldxa
            plo      ra
            ldxa
            phi      ra
            irx                   ; move past c
            irx
            irx
            irx                   ; recover expr stack
            ldxa
            plo      r7
            ldx
            phi      r7
            inc      r7
            glo      r8           ; store answer
            str      r7
            inc      r7
            ghi      r8
            str      r7
            inc      r7
            glo      ra
            str      r7
            inc      r7
            ghi      ra
            str      r7
            dec      r7
            dec      r7
            dec      r7
            dec      r7
            sep      sret         ; and return to caller
#endif

#ifdef COSFP
#redefine USETRIG
#redefine USEFP
#redefine SINFP
; ****************************************************** 
; ***** cos                                        ***** 
; ***** RF - Pointer to floating point number      ***** 
; ***** RD - Pointer to floating point destination ***** 
; ***** internal:                                  ***** 
; *****       R2+1  R7 - sum                       ***** 
; *****       R2+5  R8 - pwr                       ***** 
; *****       R2+9  R9 - last                      ***** 
; *****       R2+13 RA - fctPos                    ***** 
; *****       R2+17 RB - fct                       ***** 
; *****       R2+21 RC - tmp                       ***** 
; *****       R2+25 RD - sgn                       ***** 
; *****       R2+29    - angle                     ***** 
; ****************************************************** 
fpcos:      ghi      r7           ; save expr stack
            stxd
            glo      r7
            stxd
            ghi      r7           ; source is expr stack
            phi      rf
            glo      r7
            plo      rf
            inc      rf
            ghi      rf           ; angle = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
            ldi      0            ; sign starts out positive
            stxd                  ; make space for sgn
            stxd
            stxd
            stxd
            stxd                  ; make space for tmp
            stxd
            stxd
            stxd
            stxd                  ; make space for fct
            stxd
            stxd
            stxd
            stxd                  ; make space for fctPos
            stxd
            ldi      (fact+8).1   ; position of 2!
            stxd
            ldi      (fact+8).0
            stxd
            ldi      0
            stxd                  ; make space for last
            stxd
            stxd
            stxd
            ldi      fp_1.1       ; pwr = 1.0
            phi      rd
            ldi      fp_1.0
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
            ldi      fp_1.1       ; pwr = 1.0
            phi      rd
            ldi      fp_1.0
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
            lbr      sincos       ; now compute
#endif

#ifdef SINFP
#redefine MULFP
#redefine DIVFP
#redefine ADDFP
#redefine USETRIG
; ****************************************************** 
; ***** sin                                        ***** 
; ***** RF - Pointer to floating point number      ***** 
; ***** RD - Pointer to floating point destination ***** 
; ***** internal:                                  ***** 
; *****       R2+1  R7 - sum                       ***** 
; *****       R2+5  R8 - pwr                       ***** 
; *****       R2+9  R9 - last                      ***** 
; *****       R2+13 RA - fctPos                    ***** 
; *****       R2+17 RB - fct                       ***** 
; *****       R2+21 RC - tmp                       ***** 
; *****       R2+25 RD - sgn                       ***** 
; *****       R2+29    - angle                     ***** 
; ****************************************************** 
fpsin:      ghi      r7           ; save expr stack
            stxd
            glo      r7
            stxd
            ghi      r7           ; source is expr stack
            phi      rf
            glo      r7
            plo      rf
            inc      rf
            ghi      rf           ; angle = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
            ldi      0            ; sign starts out positive
            stxd                  ; make space for sgn
            stxd
            stxd
            stxd
            stxd                  ; make space for tmp
            stxd
            stxd
            stxd
            stxd                  ; make space for fct
            stxd
            stxd
            stxd
            stxd                  ; make space for fctPos
            stxd
            ldi      (fact+12).1  ; position of 3!
            stxd
            ldi      (fact+12).0
            stxd
            ldi      0
            stxd                  ; make space for last
            stxd
            stxd
            stxd
            ghi      rf           ; pwr = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
            ghi      rf           ; sum = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
sincos:     sep      scall        ; angle = angle * angle
            dw       getargs
            db       29,29
            sep      scall        ; angle = angle * angle
            dw       mulfpi
sincos_l:   sep      scall        ; need to see if sum == last
            dw       getargs
            db       9,1
            ldi      4            ; 4 bytes to check
            plo      rc
            ldi      0            ; clear comparison flag
            plo      re
sincos_1:   ldn      rd           ; get byte from sum
            str      r2           ; save for comparison
            ldn      rf           ; get point from last
            sm                    ; compare them
            str      r2           ; store to combine with comparison flag
            glo      re           ; get comparison flag
            or                    ; combine
            plo      re           ; put back into comparison
            ldn      rd           ; get byte from sum
            str      rf           ; store into last
            inc      rd           ; increment pointers
            inc      rf
            dec      rc           ; decrement count
            glo      rc           ; see if done
            lbnz     sincos_1     ; jump if not
            glo      re           ; get comparison flag
            lbz      sincos_d     ; jump if done
            sep      scall        ; pwr = pwr * angle
            dw       getargs
            db       5,29
            sep      scall
            dw       mulfpi
            sep      scall        ; fct = facts[fctPos]
            dw       getargs
            db       17,13
            ldn      rd           ; get address of facts[fctPos]
            plo      r7
            adi      8            ; and then point two constants up
            str      rd
            inc      rd
            ldn      rd           ; get high byte of address
            phi      r7
            adci     0
            str      rd           ; fctPos now points at next one needed
            lda      r7           ; read factorial into destination
            str      rf
            inc      rf
            lda      r7
            str      rf
            inc      rf
            lda      r7
            str      rf
            inc      rf
            glo      r2           ; point to sgn
            adi      25
            plo      rd
            ghi      r2
            adci     0
            phi      rd
            ldn      rd           ; get sign
            xri      080h         ; flip it
            str      rd           ; and put it back
            str      r2           ; store to combine with fct
            lda      r7
            or                    ; set sign
            str      rf
            sep      scall        ; tmp = pwr
            dw       getargs
            db       21,5
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            sep      scall        ; tmp = tmp / fct
            dw       getargs
            db       21,17
            sep      scall
            dw       divfpi
            sep      scall        ; sum = sum + tmp
            dw       getargs
            db       1,21
            sep      scall
            dw       addfpi
            lbr      sincos_l     ; loop until done
sincos_d:   irx                   ; recover answer
            ldxa
            plo      r8
            ldxa
            phi      r8
            ldxa
            plo      ra
            ldx
            phi      ra
            glo      r2           ; clean workspace off stack
            adi      28
            plo      r2
            ghi      r2
            adci     0
            phi      r2
            irx                   ; recover expr stack
            ldxa
            plo      r7
            ldx
            phi      r7
            inc      r7
            glo      r8           ; store answer
            str      r7
            inc      r7
            ghi      r8
            str      r7
            inc      r7
            glo      ra
            str      r7
            inc      r7
            ghi      ra
            str      r7
            dec      r7
            dec      r7
            dec      r7
            dec      r7
            sep      sret         ; and return to caller
#endif

#ifdef LNFP
#redefine USETRIG
#redefine ADDFP
#redefine DIVFP
#redefine MULFP
#redefine SUBFP
; ****************************************************** 
; ***** Natural logarithm                          ***** 
; ***** RF - Pointer to floating point number      ***** 
; ***** RD - Pointer to floating point destination ***** 
; ***** internal:                                  ***** 
; *****       R2+1     - sum                       ***** 
; *****       R2+5     - last                      ***** 
; *****       R2+9     - k                         ***** 
; *****       R2+13    - pwr                       ***** 
; *****       R2+17    - tmp                       ***** 
; *****       R2+21    - n                         ***** 
; ****************************************************** 
fpln:       ghi      r7           ; save expr stack
            stxd
            glo      r7
            stxd
            ghi      r7           ; source is expr stack
            phi      rf
            glo      r7
            plo      rf
            inc      rf
            ghi      rf           ; n = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall
            dw       addtows
            ghi      rf           ; tmp = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall
            dw       addtows
            stxd                  ; reserve space for pwr
            stxd
            stxd
            stxd
            ldi      fp_1.1       ; k = 1.0
            phi      rd
            ldi      fp_1.0
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
            ldi      fp_1.1       ; last = 1.0
            phi      rd
            ldi      fp_1.0
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
            ldi      0            ; sum = 0
            stxd
            stxd
            stxd
            stxd
            glo      r2           ; point to tmp
            adi      17
            plo      rf
            ghi      r2
            adci     0
            phi      rf
            ldi      fp_1.1       ; point to 1.0
            phi      rd
            ldi      fp_1.0
            plo      rd
            sep      scall        ; compute n+1
            dw       addfpi
            glo      r2           ; point to n
            adi      21
            plo      rf
            ghi      r2
            adci     0
            phi      rf
            ldi      fp_1.1       ; point to 1.0
            phi      rd
            ldi      fp_1.0
            plo      rd
            sep      scall        ; compute n-1
            dw       subfpi
            sep      scall        ; compute (n-1)/(n+1)
            dw       getargs
            db       21,17
            sep      scall
            dw       divfpi
            sep      scall        ; pwr = n
            dw       getargs
            db       13,21
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            sep      scall        ; n = n * n
            dw       getargs
            db       21,21
            sep      scall
            dw       mulfpi
fplog_l:    sep      scall        ; need to see if sum == last
            dw       getargs
            db       5,1
            ldi      4            ; 4 bytes to check
            plo      rc
            ldi      0            ; clear comparison flag
            plo      re
fplog_1:    ldn      rd           ; get byte from sum
            str      r2           ; save for comparison
            ldn      rf           ; get point from last
            sm                    ; compare them
            str      r2           ; store to combine with comparison flag
            glo      re           ; get comparison flag
            or                    ; combine
            plo      re           ; put back into comparison
            ldn      rd           ; get byte from sum
            str      rf           ; store into last
            inc      rd           ; increment pointers
            inc      rf
            dec      rc           ; decrement count
            glo      rc           ; see if done
            lbnz     fplog_1      ; jump if not
            glo      re           ; get comparison flag
            lbz      fplog_d      ; jump if done
            sep      scall        ; tmp = pwr
            dw       getargs
            db       17,13
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            sep      scall        ; tmp = tmp / k
            dw       getargs
            db       17,9
            sep      scall
            dw       divfpi
            sep      scall        ; sum = sum + tmp
            dw       getargs
            db       1,17
            sep      scall
            dw       addfpi
            sep      scall        ; pwr = pwr * n
            dw       getargs
            db       13,21
            sep      scall
            dw       mulfpi
            glo      r2           ; k = k + 2
            adi      9
            plo      rf
            ghi      r2
            adci     0
            phi      rf
            ldi      fp_2.1       ; point to 2.0
            phi      rd
            ldi      fp_2.0
            plo      rd
            sep      scall
            dw       addfpi
            lbr      fplog_l      ; loop until done
fplog_d:    sep      scall        ; sum = sum + sum
            dw       getargs
            db       1,1
            sep      scall
            dw       addfpi
            irx                   ; recover answer
            ldxa    
            plo      r8
            ldxa
            phi      r8
            ldxa
            plo      ra
            ldx
            phi      ra
            glo      r2           ; clean up the stack
            adi      20
            plo      r2
            ghi      r2
            adci     0
            phi      r2
            irx                   ; recover expr stack
            ldxa
            plo      r7
            ldx
            phi      r7
            inc      r7
            glo      r8           ; store answer
            str      r7
            inc      r7
            ghi      r8
            str      r7
            inc      r7
            glo      ra
            str      r7
            inc      r7
            ghi      ra
            str      r7
            dec      r7
            dec      r7
            dec      r7
            dec      r7
            sep      sret         ; and return to caller
#endif

#ifdef EXPFP
#redefine USETRIG
#redefine ADDFP
#redefine DIVFP
#redefine MULFP
; ****************************************************** 
; ***** Natural exp                                ***** 
; ***** RF - Pointer to floating point number      ***** 
; ***** RD - Pointer to floating point destination ***** 
; ***** internal:                                  ***** 
; *****       R2+1     - sum                       ***** 
; *****       R2+5     - last                      ***** 
; *****       R2+9     - fct                       ***** 
; *****       R2+13    - fctCount                  ***** 
; *****       R2+17    - pwr                       ***** 
; *****       R2+21    - tmp                       ***** 
; *****       R2+25    - n                         ***** 
; ****************************************************** 
fpexp:      ghi      r7           ; save expr stack
            stxd
            glo      r7
            stxd
            ghi      r7           ; source is expr stack
            phi      rf
            glo      r7
            plo      rf
            inc      rf
            ghi      rf           ; n = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall
            dw       addtows
            stxd                  ; space for tmp
            stxd
            stxd
            stxd
            ghi      rf           ; pwr = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall
            dw       addtows
            ldi      fp_2.1       ; fctCount = 2.0
            phi      rd
            ldi      fp_2.0
            plo      rd
            sep      scall
            dw       addtows
            ldi      fp_1.1       ; fct = 1.0
            phi      rd
            ldi      fp_1.0
            plo      rd
            sep      scall
            dw       addtows
            ldi      fp_0.1       ; last = 0
            phi      rd
            ldi      fp_0.0
            plo      rd
            sep      scall
            dw       addtows
            ghi      rf           ; sum = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall
            dw       addtows
            ghi      r2           ; sum = sum + 1
            phi      rf
            glo      r2
            plo      rf
            inc      rf
            ldi      fp_1.1
            phi      rd
            ldi      fp_1.0
            plo      rd
            sep      scall
            dw       addfpi
fpexp_l:    sep      scall        ; need to see if sum == last
            dw       getargs
            db       5,1
            ldi      4            ; 4 bytes to check
            plo      rc
            ldi      0            ; clear comparison flag
            plo      re
fpexp_1:    ldn      rd           ; get byte from sum
            str      r2           ; save for comparison
            ldn      rf           ; get point from last
            sm                    ; compare them
            str      r2           ; store to combine with comparison flag
            glo      re           ; get comparison flag
            or                    ; combine
            plo      re           ; put back into comparison
            ldn      rd           ; get byte from sum
            str      rf           ; store into last
            inc      rd           ; increment pointers
            inc      rf
            dec      rc           ; decrement count
            glo      rc           ; see if done
            lbnz     fpexp_1      ; jump if not
            glo      re           ; get comparison flag
            lbz      fpexp_d      ; jump if done
            sep      scall        ; pwr = pwr * n
            dw       getargs
            db       17,25
            sep      scall
            dw       mulfpi
            sep      scall        ; fct = fct * fctCount
            dw       getargs
            db       9,13
            sep      scall
            dw       mulfpi
            glo      r2           ; fctCount = fctCount + 1
            adi      13
            plo      rf
            ghi      r2
            adci     0
            phi      rf
            ldi      fp_1.1
            phi      rd
            ldi      fp_1.0
            plo      rd
            sep      scall
            dw       addfpi
            sep      scall        ; tmp = pwr
            dw       getargs
            db       21,17
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            sep      scall        ; tmp = tmp / fct
            dw       getargs
            db       21,9
            sep      scall
            dw       divfpi
            sep      scall        ; sum = sum + tmp
            dw       getargs
            db       1,21
            sep      scall
            dw       addfpi
            lbr      fpexp_l      ; loop until done
fpexp_d:    irx                   ; recover answer
            ldxa
            plo      r8
            ldxa
            phi      r8
            ldxa
            plo      ra
            ldx
            phi      ra
            glo      r2           ; clean workspace off stack
            adi      24
            plo      r2
            ghi      r2
            adci     0
            phi      r2
            irx                   ; recover expr stack
            ldxa
            plo      r7
            ldx
            phi      r7
            inc      r7
            glo      r8           ; store answer
            str      r7
            inc      r7
            ghi      r8
            str      r7
            inc      r7
            glo      ra
            str      r7
            inc      r7
            ghi      ra
            str      r7
            dec      r7
            dec      r7
            dec      r7
            dec      r7
            sep      sret         ; and return to caller
#endif

#ifdef POWFP
; ****************************************************** 
; ***** Power x^y                                  ***** 
; ***** RF - Pointer to floating point number x    ***** 
; ***** RC - Pointer to floating point number y    ***** 
; ***** RD - Pointer to floating point destination ***** 
; ***** internal:                                  ***** 
; *****       R2+1     - x                         ***** 
; *****       R2+5     - y                         ***** 
; ****************************************************** 
fppow:      inc      r7           ; x = log(x)
            inc      r7
            inc      r7
            inc      r7
            sep      scall
            dw       fpln
            dec      r7           ; now x = x * y
            dec      r7
            dec      r7
            dec      r7
            sep      scall
            dw       mulfp
            sep      scall        ; x = exp(x)
            dw       fpexp
            sep      sret         ; and return to caller
#endif

#ifdef ASINFP
#redefine MULFP
#redefine DIVFP
#redefine SUBFP
#redefine SQRTFP
#redefine ATANFP
#redefine USETRIG
; ****************************************************** 
; ***** Compute arcsin                             ***** 
; ****************************************************** 
fpasin:     inc     r7           ; retrieve x
            lda     r7
            plo     r8
            lda     r7
            phi     r8
            lda     r7
            plo     r9
            ldn     r7
            phi     r9
            dec     r7           ; keep x on the expr stack
            dec     r7
            dec     r7
            dec     r7
            sex     r7           ; now place 2 1.0s
            ldi     03fh
            stxd
            ldi     080h
            stxd
            ldi     000h
            stxd
            stxd
            ldi     03fh
            stxd
            ldi     080h
            stxd
            ldi     000h
            stxd
            stxd
            ghi     r9           ; Put x back on the stack twice
            stxd
            glo     r9
            stxd
            ghi     r8
            stxd
            glo     r8
            stxd
            ghi     r9
            stxd
            glo     r9
            stxd
            ghi     r8
            stxd
            glo     r8
            stxd
            sex     r2
            sep     scall        ; x * x
            dw      mulfp
            sep     scall        ; subtract from 1.0
            dw      subfp
            sep     scall        ; take square root
            dw      fpsqrt
            sep     scall        ; add 1.0
            dw      addfp
            sep     scall        ; divide into x
            dw      divfp
            sep     scall        ; and then atan
            dw      fpatan
            sex     r7           ; multiply result by 2.0
            ldi     040h
            stxd
            ldi     000h
            stxd
            stxd
            stxd
            sex     r2
            sep     scall
            dw      mulfp
            sep     sret
#endif

#ifdef ACOSFP
#redefine ADDFP
#redefine SUBFP
#redefine MULFP
#redefine DIVFP
#redefine SQRTFP
#redefine ATANFP
#redefine USETRIG
; ****************************************************** 
; ***** Compute arcsin                             ***** 
; ****************************************************** 
fpacos:     inc     r7           ; retrieve x
            lda     r7
            plo     r8
            lda     r7
            phi     r8
            lda     r7
            plo     r9
            ldn     r7
            phi     r9
            sex     r7           ; now place 1.0
            ldi     03fh
            stxd
            ldi     080h
            stxd
            ldi     000h
            stxd
            stxd
            ghi     r9           ; Put x back on the stack twice
            stxd
            glo     r9
            stxd
            ghi     r8
            stxd
            glo     r8
            stxd
            ghi     r9
            stxd
            glo     r9
            stxd
            ghi     r8
            stxd
            glo     r8
            stxd
            ldi     03fh         ; now place 1.0
            stxd
            ldi     080h
            stxd
            ldi     000h
            stxd
            stxd
            ghi     r9           ; and 1 more x
            stxd
            glo     r9
            stxd
            ghi     r8
            stxd
            glo     r8
            stxd
            sex     r2
            sep     scall        ; add 1 to x
            dw      addfp
            inc     r7           ; transfer 1+x to stack for safe keeping
            lda     r7
            stxd
            lda     r7
            stxd
            lda     r7
            stxd
            ldn     r7
            stxd
            sep     scall        ; multiply the two xs
            dw      mulfp
            sep     scall        ; subtract from 1.0
            dw      subfp
            sep     scall        ; take the square root
            dw      fpsqrt
            irx                  ; transfer 1+x back to expr stack
            ldxa
            str     r7
            dec     r7
            ldxa
            str     r7
            dec     r7
            ldxa
            str     r7
            dec     r7
            ldx
            str     r7
            dec     r7
            sep     scall        ; now divide
            dw      divfp
            sep     scall        ; and then atan
            dw      fpatan
            sex     r7           ; multiply result by 2.0
            ldi     040h
            stxd
            ldi     000h
            stxd
            stxd
            stxd
            sex     r2
            sep     scall
            dw      mulfp
            sep     sret
#endif

#ifdef ATANFP
#redefine DIVFP
#redefine MULFP
#redefine ADDFP
#redefine SQRTFP
#redefine USETRIG
; ****************************************************** 
; ***** Compute arctangent                         ***** 
; ***** internal:                                  ***** 
; *****       R2+1     - ret                       ***** 
; *****       R2+5     - total                     ***** 
; *****       R2+9     - ydx                       ***** 
; *****       R2+13    - tmp                       ***** 
; ****************************************************** 
atandata:   db      0abh,0aah,0aah,0beh ; -1/3
            db      0cdh,0cch,04ch,03eh ;  1/5
            db      025h,049h,012h,0beh ; -1/7
            db      039h,08eh,0e3h,03dh ;  1/9
            db      08ch,02eh,0bah,0bdh ; -1/11
            db      0d9h,089h,09dh,03dh ;  1/13
            db      089h,088h,088h,0bdh ; -1/15
            db      0f1h,0f0h,070h,03dh ;  1/17
            db      036h,094h,057h,0bdh ; -1/19
            db      031h,00ch,043h,03dh ;  1/21
fpatan:     inc     r7           ; retrieve x
            lda     r7
            plo     r8
            lda     r7
            phi     r8
            lda     r7
            plo     r9
            ldn     r7
            phi     r9
            dec     r7           ; keep x on the expr stack
            dec     r7
            dec     r7
            dec     r7
            sex     r7           ; Put x back on the stack twice
            ghi     r9
            stxd
            glo     r9
            stxd
            ghi     r8
            stxd
            glo     r8
            stxd
            ghi     r9
            stxd
            glo     r9
            stxd
            ghi     r8
            stxd
            glo     r8
            stxd
            sex     r2
            sep     scall        ; x*x
            dw      mulfp
            sex     r7           ; now add 1.0
            ldi     03fh
            stxd
            ldi     080h
            stxd
            ldi     000h
            stxd
            stxd
            sex     r2
            sep     scall
            dw      addfp
            sep     scall        ; now sqrt
            dw      fpsqrt
            sex     r7           ; now add 1.0
            ldi     03fh
            stxd
            ldi     080h
            stxd
            ldi     000h
            stxd
            stxd
            sex     r2
            sep     scall
            dw      addfp
            sep     scall       ; now have x/(1+sqrt(1+x*X))
            dw      divfp
            ghi      r7           ; save expr stack
            stxd
            glo      r7
            stxd
            stxd                  ; space on stack for tmp
            stxd
            stxd
            stxd
            ghi      r7           ; source is expr stack
            phi      rf
            glo      r7
            plo      rf
            inc      rf
            ghi      rf           ; ydx = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
            ghi      rf           ; total = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
            ghi      rf           ; ret = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall        ; add to workspace
            dw       addtows
            sep      scall        ; ydx = ydx * ydx
            dw       getargs
            db       9,9
            sep      scall
            dw       mulfpi
            ldi      atandata.1   ; point to -1/3
            phi      r9
            ldi      atandata.0
            plo      r9
            ldi      10           ; 10 loops
            plo      rc
atanlp:     sep      scall        ; total *= ydx
            dw       getargs
            db       5,9
            glo      rc           ; save needed registers
            stxd
            ghi      r9           ; save needed registers
            stxd
            glo      r9
            stxd
            sep      scall
            dw       mulfpi
            sep      scall        ; tmp = total
            dw       getargs
            db       16,8
            sep      scall
            dw       fpcopy
            irx                   ; tmp = tmp * fractional
            ldxa
            plo      rd
            ldx
            phi      rd
            dec      r2
            glo      r2
            adi      15
            plo      rf
            ghi      r2
            adci     0
            phi      rf
            dec      r2
            sep      scall
            dw       mulfpi
            sep      scall        ; ret = ret + tmp
            dw       getargs
            db       4,16
            sep      scall
            dw       addfpi
            irx                   ; recover registers
            ldxa
            plo      r9
            ldxa
            phi      r9
            ldx
            plo      rc
            inc      r9           ; move to next fractional
            inc      r9
            inc      r9
            inc      r9
            dec      rc           ; decrement loop count
            glo      rc           ; get remaining loops
            lbnz     atanlp       ; jump if more loops
            sep      scall        ; ret = ret + ret
            dw       getargs
            db       1,1
            sep      scall
            dw       addfpi
            irx                   ; recover answer
            ldxa
            plo      r8
            ldxa
            phi      r8
            ldxa
            plo      r9
            ldx
            phi      r9
            glo      r2           ; remove remaining workspace from stack
            adi      12
            plo      r2
            ghi      r2
            adci     0
            phi      r2
            irx                   ; recover expr stack
            ldxa
            plo      r7
            ldx
            phi      r7
            inc      r7
            glo      r8           ; store answer
            str      r7
            inc      r7
            ghi      r8
            str      r7
            inc      r7
            glo      r9
            str      r7
            inc      r7
            ghi      r9
            str      r7
            dec      r7
            dec      r7
            dec      r7
            dec      r7
            sep      sret         ; and return to caller
#endif

#ifdef SQRTFP
#redefine ADDFP
#redefine DIVFP
#redefine MULFP
#redefine USETRIG
; ****************************************************** 
; ***** Square root                                ***** 
; ***** RF - Pointer to floating point number x    ***** 
; *****       R2+1     - x                         ***** 
; *****       R2+5     - s                         ***** 
; *****       R2+9     - p                         ***** 
; *****       R2+13    - arg                       ***** 
; ****************************************************** 
fpsqrt:     ghi      r7           ; argument is on expr stack
            phi      rf
            glo      r7
            plo      rf
            inc      rf
            ghi      rf           ; arg = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall
            dw       addtows
            ghi      rf           ; p = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall
            dw       addtows
            ghi      rf           ; s = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall
            dw       addtows
            ghi      rf           ; x = argument
            phi      rd
            glo      rf
            plo      rd
            sep      scall
            dw       addtows
            ldi      255          ; set max iteration count
            plo      rc
fpsqrtlp:   sep      scall        ; x = arg
            dw       getargs
            db       1,13
            sep      scall
            dw       fpcopy
            glo      rc           ; save iteration count
            stxd
            sep      scall        ; x = x / s
            dw       getargs
            db       2,6
            sep      scall
            dw       divfpi
            sep      scall        ; s = s + x
            dw       getargs
            db       6,2
            sep      scall
            dw       addfpi
            glo      r2           ; s = s * 0.5
            adi      6
            plo      rf
            ghi      r2
            adci     0
            phi      rf
            ldi      fpdot5.1
            phi      rd
            ldi      fpdot5.0
            plo      rd
            sep      scall
            dw       mulfpi
            irx                   ; recover iteration count
            ldx
            plo      rc
            sep      scall        ; check p=s
            dw       getargs
            db       9,5
            lda      rf
            ani      0fch
            str      r2
            lda      rd
            ani      0fch
            sm
            lbnz     fpsqrtn
            lda      rf
            str      r2
            lda      rd
            sm
            lbnz     fpsqrtn
            lda      rf
            str      r2
            lda      rd
            sm
            lbnz     fpsqrtn
            lda      rf
            str      r2
            lda      rd
            sm
            lbz      fpsqrtd
fpsqrtn:    dec      rc           ; decrement iteration count
            glo      rc
            lbz      fpsqrtd      ; jump if reached
            sep      scall        ; p = s
            dw       getargs
            db       9,5
            sep      scall
            dw       fpcopy
            lbr      fpsqrtlp     ; loop until convergence
fpsqrtd:    irx                   ; retrieve answer
            irx
            irx
            irx
            irx
            ldxa
            plo      r8
            ldxa
            phi      r8
            ldxa
            plo      r9
            ldx
            phi      r9
            glo      r2           ; remove remaining workspace
            adi      8
            plo      r2
            ghi      r2
            adci     0
            phi      r2
            inc      r7
            glo      r8           ; store answer
            str      r7
            inc      r7
            ghi      r8
            str      r7
            inc      r7
            glo      r9
            str      r7
            inc      r7
            ghi      r9
            str      r7
            dec      r7
            dec      r7
            dec      r7
            dec      r7
            sep      sret         ; and return to caller
#endif

#ifdef USETRIG
fact:       db       000h, 000h, 000h, 000h
            db       000h, 000h, 080h, 03fh
            db       000h, 000h, 000h, 040h
            db       000h, 000h, 0c0h, 040h
            db       000h, 000h, 0c0h, 041h
            db       000h, 000h, 0f0h, 042h
            db       000h, 000h, 034h, 044h
            db       000h, 080h, 09dh, 045h
            db       000h, 080h, 01dh, 047h
            db       000h, 030h, 0b1h, 048h
            db       000h, 07ch, 05dh, 04ah
            db       040h, 045h, 018h, 04ch
            db       0e0h, 067h, 0e4h, 04dh
            db       066h, 094h, 0b9h, 04fh
            db       0d9h, 061h, 0a2h, 051h
            db       0bbh, 03bh, 098h, 053h
            db       0bbh, 03bh, 098h, 055h
            db       077h, 0bfh, 0a1h, 057h
            db       066h, 0f7h, 0b5h, 059h
            db       0c9h, 015h, 0d8h, 05bh
            db       09eh, 00dh, 007h, 05eh
            db       0dfh, 041h, 031h, 060h
            db       093h, 0bah, 073h, 062h
            db       01ah, 02eh, 0afh, 064h
            db       094h, 062h, 003h, 067h
            db       007h, 04ah, 04dh, 069h
            db       026h, 0cch, 0a6h, 06bh
            db       040h, 0bch, 00ch, 06eh
            db       070h, 049h, 076h, 070h
            db       08eh, 032h, 0dfh, 072h
            db       065h, 03fh, 051h, 075h
            db       06ah, 0b5h, 0cah, 077h
            db       06ah, 0b5h, 04ah, 07ah
            db       015h, 00bh, 0d1h, 07ch
            db       0c6h, 01bh, 05eh, 07fh

addtows:    irx                   ; retrieve return address
            ldxa
            phi      r8
            ldx
            plo      r8
            inc      rd           ; move to msb
            inc      rd
            inc      rd
            ldn      rd           ; retrieve
            stxd                  ; and place on stack
            dec      rd
            ldn      rd           ; retrieve next byte
            stxd                  ; and place on stack
            dec      rd
            ldn      rd           ; retrieve next byte
            stxd                  ; and place on stack
            dec      rd
            ldn      rd           ; retrieve next byte
            stxd                  ; and place on stack
            glo      r8           ; put return address back on stack
            stxd
            ghi      r8
            stxd
            sep      sret         ; return to caller

fpcopy:     lda      rd           ; copy source to destination
            str      rf
            inc      rf
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            inc      rf
            lda      rd
            str      rf
            sep      sret         ; return to caller

getargs:    lda      r6           ; get passed argument
            str      r2           ; store for add
            glo      r2           ; add stack offset
            add
            plo      rf           ; put into first argument
            ghi      r2           ; high of stack
            adci     0            ; propagate carry
            phi      rf           ; rf now has argument address
            inc      rf           ; remove last call offset
            inc      rf
            lda      r6           ; get passed argument
            str      r2           ; store for add
            glo      r2           ; add stack offset
            add
            plo      rd           ; put into second argument
            ghi      r2           ; high of stack
            adci     0            ; propagate carry
            phi      rd           ; rd now has argument address
            inc      rd           ; remove last call offset
            inc      rd
            sep      sret         ; return to caller
#endif


/* *********************************************************************** */
/* *********************************************************************** */
/* *****       Single Preceision Floating Point Library              ***** */
/* *********************************************************************** */
/* *********************************************************************** */


#ifdef MULFP
#redefine USEFP
; ******************************************** 
; ***** Floating point multiplication    ***** 
; ***** RF - pointer to first fp number  ***** 
; ***** RD - pointer to second fp number ***** 
; ***** Uses: R7:R8 - answer       (cc)  ***** 
; *****       RA:RB - second number (bb) ***** 
; *****       R9.0  - exponent           ***** 
; *****       R9.1  - sign               ***** 
; *****       RC:RD - first number (aa)  ***** 
; ******************************************** 
mulfpi:     ghi     r7           ; save expr stack
            stxd
            glo     r7
            stxd
            ghi     rf           ; save destination address
            stxd
            glo     rf
            stxd
            lda      rd           ; retrieve second number
            plo      rb           ; place into bb
            lda      rd
            phi      rb
            lda      rd
            plo      ra
            shl                   ; shift high bit into DF
            lda      rd
            phi      ra
            shlc                  ; now have full 8 bits of exponent
            phi      r9           ; store into r9
            lbz      fpret_0      ; jump if number is zero
            lda      rf           ; retrieve first number
            plo      rd           ; place into aa
            lda      rf
            phi      rd
            lda      rf
            plo      rc
            shl                   ; shift high bit into DF
            lda      rf
            phi      rc
            shlc                  ; now have exponent of first number
            plo      r9           ; save it
            lbz      fpret_0      ; jump if number was zero
            glo      r9           ; get exponent of first number
            smi      0ffh         ; check for infinity
            lbz      fpmul_a      ; jump if so
            ghi      r9           ; get exponent of second number
            smi      0ffh         ; check for infinity
            lbz      fpret_b      ; jump if so
            glo      r9           ; get exponent 1
            smi      127          ; remove bias
            str      r2           ; store for add
            ghi      r9           ; get exponent 2
            smi      127          ; remove bias
            add                   ; add in exponent 1
            adi      127          ; add bias back in
            plo      r9           ; r9 now has exponent of result
            ghi      ra           ; get msb of bb
            str      r2           ; store it
            ghi      rc           ; get msb of aa
            xor                   ; now have sign comparison
            shl                   ; shift sign into DF
            ldi      0            ; clear byte
            shlc                  ; shift in sign
            phi      r9           ; save sign for later
            ldi      0            ; need to clear high bytes
            phi      ra           ; of bb
            phi      rc           ; and aa
            plo      r8           ; also clear answer
            phi      r8
            plo      r7
            phi      r7
            glo      ra           ; get msb of bb mantissa
            ori      080h         ; add in implied 1
            plo      ra           ; and put it back
            glo      rc           ; get msb of aa mantissa
            ori      080h         ; add in implied 1
            plo      rc           ; and put it back
fpmul_lp:   glo      ra           ; need to zero check bb
            str      r2
            ghi      ra
            or
            str      r2
            glo      rb
            or
            str      r2
            ghi      rb
            or
            lbz      fpmul_dn     ; jump of bb==0
            ghi      r7           ; cc >>= 1
            shr
            phi      r7
            glo      r7
            shrc
            plo      r7
            ghi      r8
            shrc
            phi      r8
            glo      r8
            shrc
            plo      r8
            ghi      ra           ; bb >>= 1
            shr
            phi      ra
            glo      ra
            shrc
            plo      ra
            ghi      rb
            shrc
            phi      rb
            glo      rb
            shrc
            plo      rb
            lbnf     fpmul_lp     ; back to loop if no addition needed
            glo      r8           ; cc += aa
            str      r2
            glo      rd
            add
            plo      r8
            ghi      r8
            str      r2
            ghi      rd
            adc
            phi      r8
            glo      r7
            str      r2
            glo      rc
            adc
            plo      r7
            ghi      r7
            str      r2
            ghi      rc
            adc
            phi      r7
            lbr      fpmul_lp     ; back to beginning of loop
fpmul_dn:   sep      scall        ; assemble answer
            dw       fpnorm
            lbr      fpret_a      ; place result into destination
fpmul_a:    irx                   ; recover destination address
            ldxa
            plo      rf
            ldx
            phi      rf
            glo      rd           ; write a to answer
            str      rf
            inc      rf
            ghi      rd
            str      rf
            inc      rf
            glo      rc
            str      rf
            inc      rf
            ghi      rc
            str      rf
            irx                   ; recover expr stack
            ldxa
            plo      r7
            ldx
            phi      r7
            sep      sret         ; and return to caller

mulfp:      glo     r7           ; Setup registers for call
            plo     rf
            plo     rd
            ghi     r7
            phi     rf
            phi     rd
            inc     rd
            inc     rf
            inc     rf
            inc     rf
            inc     rf
            inc     rf
            sep     scall        ; Call addition
            dw      mulfpi
            inc     r7           ; Adjust expr stack
            inc     r7
            inc     r7
            inc     r7
            sep     sret         ; And return
#endif

#ifdef DIVFP
#redefine USEFP
; ******************************************** 
; ***** Floating point division          ***** 
; ***** RF - pointer to first fp number  ***** 
; ***** RD - pointer to second fp number ***** 
; ***** Uses: R7:R8 - answer       (a)   ***** 
; *****       RA:RB - second number (b)  ***** 
; *****       RA    - pointer to (aa)    ***** 
; *****       RB    - pointer to (bb)    ***** 
; *****       R9.0  - exponent           ***** 
; *****       R9.1  - sign               ***** 
; *****       RC:RD - mask               ***** 
; ******************************************** 
divfpi:     ghi     r7           ; save expr stack
            stxd
            glo     r7
            stxd
            ghi     rf           ; save destination address
            stxd
            glo     rf
            stxd
            sep      scall        ; get arguments
            dw       fpargs
            glo      r9           ; check for a==0
            lbz      fpret_0      ; return 0 if so
            ghi      r9           ; check for b==0
            lbz      fpret_0      ; return 0 if so
            glo      r9           ; check for a==infinity
            smi      0ffh
            lbz      fpret_a      ; return a if so
            ghi      r9           ; check for b==infinity
            smi      0ffh
            lbz      fpret_b      ; return b if so
            ghi      r9           ; get exp2
            smi      127          ; remove bias
            str      r2           ; store for subtraction
            glo      r9           ; get exp1
            smi      127          ; remove bias
            sm                    ; subtract exp2
            adi      127          ; add bias back in
            plo      r9           ; now have final exp
            ghi      r7           ; get sign of a
            str      r2           ; store for xor
            ghi      ra           ; get sign of b
            xor                   ; now have sign comparison
            shl                   ; shift it into DF
            ldi      0            ; clear D
            shlc                  ; and shift in sign
            phi      r9           ; store sign
            glo      ra           ; put bb on stack
            ori      080h         ; set implied 1 bit
            stxd
            ghi      rb
            stxd
            glo      rb
            stxd
            ldi      0
            stxd
            stxd
            stxd
            glo      r2           ; point RB to bb
            plo      rb
            ghi      r2
            phi      rb
            inc      rb
            glo      r7           ; put aa on stack
            ori      080h         ; set implied 1 bit
            stxd
            ghi      r8
            stxd
            glo      r8
            stxd
            ldi      0
            stxd
            stxd
            stxd
            glo      r2           ; set RA to point to aa
            plo      ra
            ghi      r2
            phi      ra
            inc      ra
            ldi      0            ; clear a
            plo      r8
            phi      r8
            plo      r7
            phi      r7
            plo      rd           ; setup mask
            phi      rd
            phi      rc
            ldi      080h
            plo      rc
fpdiv_lp:   glo      rd           ; need to check for mask==0
            lbnz     fpdiv_1      ; jump if not 0
            ghi      rd
            lbnz     fpdiv_1
            glo      rc
            lbnz     fpdiv_1
            sep      scall        ; division is done, so call normalize
            dw       fpnorm
            glo      r2           ; clear work space from stack
            adi      12
            plo      r2
            ghi      r2
            adci     0
            phi      r2
            lbr      fpret_a      ; and return the answer
fpdiv_1:    smi      0            ; set DF for first byte
            ldi      6            ; 6 bytes to subtract
            plo      re
            sex      rb           ; point x to bb
fpdiv_1a:   lda      ra           ; get byte from aa
            smb                   ; subtract byte from bb from aa
            inc      rb           ; point to next byte
            dec      re           ; decrement count
            glo      re           ; see if done
            lbnz     fpdiv_1a     ; loop back if not
            ldi      6            ; need to move pointers back
            plo      re
fpdiv_1b:   dec      ra
            dec      rb
            dec      re
            glo      re
            lbnz     fpdiv_1b
            lbnf     fpdiv_2      ; jump if b>a
            ldi      6            ; 6 bytes to subtract bb from aa
            plo      re
            smi      0            ; set DF for first subtract
fpdiv_1c:   ldn      ra           ; get byte from a
            smb                   ; subtract bb
            str      ra           ; put it back
            inc      ra           ; increment pointers
            inc      rb
            dec      re           ; decrement byte count
            glo      re           ; see if done
            lbnz     fpdiv_1c     ; loop back if not
            ldi      6            ; need to move pointers back
            plo      re
fpdiv_1d:   dec      ra
            dec      rb
            dec      re
            glo      re
            lbnz     fpdiv_1d
            sex      r2           ; point x back to stack
            glo      rc           ; add mask to answer
            str      r2
            glo      r7
            or
            plo      r7
            ghi      rd
            str      r2
            ghi      r8
            or
            phi      r8
            glo      rd
            str      r2
            glo      r8
            or
            plo      r8
fpdiv_2:    sex      r2           ; point x back to stack
            glo      rc           ; right shift mask
            shr
            plo      rc
            ghi      rd
            shrc
            phi      rd
            glo      rd
            shrc
            plo      rd
            inc      rb           ; need to start at msb of bb
            inc      rb
            inc      rb
            inc      rb
            inc      rb
            inc      rb
            ldi      6            ; 6 bytes in bb to shift right
            plo      re
            adi      0            ; clear DF for first shift
fpdiv_2a:   dec      rb
            ldn      rb           ; get byte from bb
            shrc                  ; shift it right
            str      rb           ; and put it back
            dec      re           ; decrement count
            glo      re           ; see if done
            lbnz     fpdiv_2a     ; loop back if not
            lbr      fpdiv_lp     ; loop for rest of division

divfp:      glo     r7           ; Setup registers for call
            plo     rf
            plo     rd
            ghi     r7
            phi     rf
            phi     rd
            inc     rd
            inc     rf
            inc     rf
            inc     rf
            inc     rf
            inc     rf
            sep     scall        ; Call addition
            dw      divfpi
            inc     r7           ; Adjust expr stack
            inc     r7
            inc     r7
            inc     r7
            sep     sret         ; And return
#endif

#ifdef ABSFP
absfp:      inc      r7           ; move to MSB
            inc      r7
            inc      r7
            inc      r7
            ldn      r7           ; retrieve it
            ani      07fh         ; force it positive
            str      r7           ; and put it back
            dec      r7           ; move pointer back
            dec      r7
            dec      r7
            dec      r7
            sep      sret
#endif

#ifdef SGNFP
sgnfp:      inc     r7
            lda     r7
            str     r2
            lda     r7
            or
            str     r2
            lda     r7
            or
            str     r2
            ldn     r7
            shl
            lbdf    sgnmfp
            ldn     r7
            or
            lbz     sgn0fp
            ldi     0
            str     r7
            dec     r7
            str     r7
            dec     r7
            str     r7
            dec     r7
            ldi     1
            str     r7
            dec     r7
            sep     sret
sgnmfp:     ldi     0ffh
            str     r7
            dec     r7
            str     r7
            dec     r7
            str     r7
            dec     r7
            str     r7
            dec     r7
            sep     sret
sgn0fp:     dec     r7
            dec     r7
            dec     r7
            dec     r7
            sep     sret
#endif

#ifdef EQFP
#redefine SUBFP
#redefine CMP32
eqfp:       sep     scall
            dw      subfp
            sex     r7
            irx
            ldxa
            or
            ldxa
            or
            ldxa
            or
            ldx
            or
            sex     r2
            lbz     true32
            lbr     false32
#endif

#ifdef NEFP
#redefine SUBFP
#redefine CMP32
nefp:       sep     scall
            dw      subfp
            sex     r7
            irx
            ldxa
            or
            ldxa
            or
            ldxa
            or
            ldx
            or
            sex     r2
            lbnz    true32
            lbr     false32
#endif

#ifdef GTFP
#redefine SUBFP
#redefine CMP32
gtfp:       sep     scall
            dw      subfp
            sex     r7
            irx
            ldxa
            or
            ldxa
            or
            ldxa
            or
            ldx
            or
            sex     r2
            lbz     false32
            ldn     r7
            shl
            lbnf    true32
            lbr     false32
#endif

#ifdef LTFP
#redefine SUBFP
#redefine CMP32
ltfp:       sep     scall
            dw      subfp
            sex     r7
            irx
            ldxa
            or
            ldxa
            or
            ldxa
            or
            ldx
            or
            sex     r2
            lbz     false32
            ldn     r7
            shl
            lbdf    true32
            lbr     false32
#endif

#ifdef GTEFP
#redefine SUBFP
#redefine CMP32
gtefp:      sep     scall
            dw      subfp
            sex     r7
            irx
            ldxa
            or
            ldxa
            or
            ldxa
            or
            ldx
            or
            sex     r2
            lbz     true32
            ldn     r7
            shl
            lbnf    true32
            lbr     false32
#endif

#ifdef LTEFP
#redefine SUBFP
#redefine CMP32
ltefp:      sep     scall
            dw      subfp
            sex     r7
            irx
            ldxa
            or
            ldxa
            or
            ldxa
            or
            ldx
            or
            sex     r2
            lbz     true32
            ldn     r7
            shl
            lbdf    true32
            lbr     false32
#endif

#ifdef SUBFP
#redefine ADDFP
; ******************************************** 
; ***** Floating point subtraction       ***** 
; ***** RF - pointer to first fp number  ***** 
; ***** RD - pointer to second fp number ***** 
; ***** Uses: R7:R8 - first number (aa)  ***** 
; *****       RA:RB - second number (bb) ***** 
; *****       R9.0  - exponent           ***** 
; *****       R9.1  - sign               ***** 
; ******************************************** 
subfpi:     ghi     r7           ; save expr stack
            stxd
            glo     r7
            stxd
            ghi     rf           ; save destination address
            stxd
            glo     rf
            stxd
            sep     scall        ; retrieve arguments
            dw      fpargs
            ghi     ra           ; invert number
            xri     080h
            phi     ra           ; save inverted sign
            ghi     r9
            lbr     fpsub_1      ; now process with add

subfp:      glo     r7           ; Setup registers for call
            plo     rf
            plo     rd
            ghi     r7
            phi     rf
            phi     rd
            inc     rd
            inc     rf
            inc     rf
            inc     rf
            inc     rf
            inc     rf
            sep     scall        ; Call addition
            dw      subfpi
            inc     r7           ; Adjust expr stack
            inc     r7
            inc     r7
            inc     r7
            sep     sret         ; And return
#endif

#ifdef ADDFP
#redefine USEFP
; ******************************************** 
; ***** Floating point addition          ***** 
; ***** RF - pointer to first fp number  ***** 
; ***** RD - pointer to second fp number ***** 
; ***** Uses: R7:R8 - first number (aa)  ***** 
; *****       RA:RB - second number (bb) ***** 
; *****       R9.0  - exponent           ***** 
; *****       R9.1  - sign               ***** 
; ******************************************** 
addfpi:     ghi     r7           ; save expr stack
            stxd
            glo     r7
            stxd
            ghi     rf           ; save destination address
            stxd
            glo     rf
            stxd
            sep     scall        ; retrieve arguments
            dw      fpargs
fpsub_1:    lbz     fpret_a      ; return a if b==0
            smi     0ffh         ; check for infinity
            lbz     fpret_b      ; return b if b==infinity
            glo     r9           ; get exponent 1
            lbz     fpret_b      ; return b if a==0
            smi     0ffh         ; check for infinity
            lbz     fpret_a      ; return a if a==infinity
            glo     r9           ; get exponent 1
            str     r2           ; store for comparison
            ghi     r9           ; get exponent 2
            sm                   ; compare to exponent 1
            lbnf    fpadd_1      ; jump if b<a
            glo     r8           ; swap a and b
            plo     re
            glo     rb
            plo     r8
            glo     re
            plo     rb
            ghi     r8           ; swap a and b
            plo     re
            ghi     rb
            phi     r8
            glo     re
            phi     rb
            glo     r7           ; swap a and b
            plo     re
            glo     ra
            plo     r7
            glo     re
            plo     ra
            ghi     r7           ; swap a and b
            plo     re
            ghi     ra
            phi     r7
            glo     re
            phi     ra
            glo     r9           ; also swap exponents
            plo     re
            ghi     r9
            plo     r9
            glo     re
            phi     r9
fpadd_1:    ghi     r7           ; compare signs
            str     r2
            ghi     ra
            xor
            plo     rc           ; store operation, 0=+, 1=-
            ghi     r7           ; get sign of largest number
            phi     rc           ; save it for now
            ldi     0            ; clear high bytes of numbers
            phi     ra
            phi     r7
            glo     ra           ; set implied 1 bit
            ori     080h
            plo     ra
            glo     r7           ; in first number too
            ori     080h
            plo     r7
fpadd_2:    glo     r9           ; compare exponents
            str     r2
            ghi     r9
            sm
            lbz     fpadd_3;     ; jump if exponents match
            ghi     r9           ; increment exponent 2
            adi     1
            phi     r9
            ghi     ra           ; shift b right
            shr
            phi     ra
            glo     ra
            shrc
            plo     ra
            ghi     rb
            shrc
            phi     rb
            glo     rb
            shrc
            plo     rb
            lbr     fpadd_2      ; loop until exponents match
fpadd_3:    glo     rc           ; get operation
            shl                  ; shift into DF
            lbdf    fpadd_s      ; jump if subtraction
            glo     r8           ; a += b
            str     r2
            glo     rb
            add
            plo     r8
            ghi     r8
            str     r2
            ghi     rb
            adc
            phi     r8
            glo     r7
            str     r2
            glo     ra
            adc
            plo     r7
            ghi     r7
            str     r2
            ghi     ra
            adc
            phi     r7
            lbr     fpadd_4      ; jump to completion
fpadd_s:    glo     r8           ; a -= b
            str     r2
            glo     rb
            sd
            plo     r8
            ghi     r8
            str     r2
            ghi     rb
            sdb
            phi     r8
            glo     r7
            str     r2
            glo     ra
            sdb
            plo     r7
            ghi     r7
            str     r2
            ghi     ra
            sdb
            phi     r7
            shl                  ; need to check sign of answer
            lbnf    fpadd_4      ; jump if positive
            sep     scall        ; 2s compliment number
            dw      fpcomp2
            ghi     rc           ; compliment sign
            xri     080h
            phi     rc           ; put it back
fpadd_4:    ghi     rc           ; move sign to R9.1
            shl
            ldi     0
            shlc
            phi     r9
            ghi     r7           ; check for zero
            lbnz    fpadd_5
            glo     r7
            lbnz    fpadd_5
            ghi     r8
            lbnz    fpadd_5
            glo     r8
            lbnz    fpadd_5
            lbr     fpret_0      ; otherwise answer is 0
fpadd_5:    sep     scall        ; normalize the answer
            dw      fpnorm
            lbr     fpret_a      ; write answer and return

addfp:      glo     r7           ; Setup registers for call
            plo     rf
            plo     rd
            ghi     r7
            phi     rf
            phi     rd
            inc     rd
            inc     rf
            inc     rf
            inc     rf
            inc     rf
            inc     rf
            sep     scall        ; Call addition
            dw      addfpi
            inc     r7           ; Adjust expr stack
            inc     r7
            inc     r7
            inc     r7
            sep     sret         ; And return
#endif

#ifdef ATOF
; ******************************************** 
; ***** Convert ASCII to floating point  ***** 
; ***** RF - Pointer to ASCII string     ***** 
; ***** RD - Desintation FP              ***** 
; ***** Uses:                            ***** 
; *****       R7:R8 - mantissa           ***** 
; *****       R9.0  - exponent           ***** 
; *****       R9.1  - sign               ***** 
; *****       RA:RB - mask               ***** 
; *****       RC    - fractional pointer ***** 
; ******************************************** 
; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
; +++++ First convert integer portion to floating point +++++ 
; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
atof:       ghi      r7           ; save expr stack
            stxd
            glo      r7
            stxd
            ldi      0            ; set sign to positive
            phi      r9
            ldn      rf           ; get first byte from buffer
            smi      '-'          ; is it minus
            lbnz     atof_1       ; jump if not
            ldi      1            ; indicate negative number
            phi      r9
            inc      rf           ; and move past minus
atof_1:     ghi      rd           ; save destination
            stxd
            glo      rd
            stxd
            ghi      r9           ; save sign
            stxd
            sep      scall        ; convert integer portion of number
            dw       atoi32
            irx
            ldxa                  ; recover sign
            phi      r9
            ldxa                  ; recover destination
            plo      rd
            ldx
            phi      rd
            dec      r2           ; and keep on stack
            dec      r2
            lda      rd           ; retrieve integer number
            phi      r7
            str      r2           ; store for zero check
            lda      rd
            plo      r7
            or                    ; combine with zero check
            str      r2
            lda      rd
            phi      r8
            or                    ; combine with zero check
            str      r2
            lda      rd
            plo      r8
            or                    ; combine with zero check
            lbz      atof_z       ; jump if integer is zero
            ldi      150          ; initial exponent starts at 150
            plo      r9
            ldi      1            ; initial mask is 1
            plo      rb
            ldi      0
            phi      rb
            plo      ra
            phi      ra
            ghi      r7           ; check if high byte has anything
            lbz      atof_b       ; jump if not
atof_a1:    ghi      r7           ; get high byte
            lbz      atof_a2      ; jump if done shifting
            shr                   ; shift mantissa right
            phi      r7
            glo      r7
            shrc
            plo      r7
            ghi      r8
            shrc
            phi      r8
            glo      r8
            shrc
            plo      r8
            glo      r9           ; get exponent
            adi      1            ; increment it
            plo      r9           ; put it back
            lbr      atof_a1      ; loop until high byte cleared
atof_a2:    ldi      0            ; clear mask
            phi      ra
            plo      ra
            phi      rb
            plo      rb
            lbr      atof_2       ; and then jump to next section
atof_b:     glo      r7           ; get first byte of mantissa
            shl                   ; shift high bit into DF
            lbdf     atof_2       ; if set, no more shifts needed
            glo      r8           ; shift mantissa left
            shl
            plo      r8
            ghi      r8
            shlc
            phi      r8
            glo      r7
            shlc
            plo      r7
            glo      rb           ; shift mask left
            shl
            plo      rb
            ghi      rb
            shlc
            phi      rb
            glo      ra
            shlc
            plo      ra
            glo      r9           ; get exponent
            smi      1            ; decrement it
            plo      r9           ; and put it back
            lbr      atof_b       ; loop until high bit of mantissa set
atof_z:     ldi      080h         ; set initial mask
            plo      ra
            ldi      0
            phi      ra
            phi      rb
            plo      rb
            ldi      127          ; initial exponent
            plo      r9
; ++++++++++++++++++++++++++++++++++++++++++++++++++ 
; +++++ Now convert number after decimal point +++++ 
; ++++++++++++++++++++++++++++++++++++++++++++++++++ 
atof_2:     ldn      rf           ; get next byte from input
            smi      '.'          ; is it a decimal
            lbnz     atof_e       ; jump if not
            inc      rf           ; move past decimal
            ldi      99           ; need marker on stack
            stxd
atof_2a:    lda      rf           ; get next byte from input
            plo      re           ; keep a copy
            smi      '0'          ; see if below digits
            lbnf     atof_2b      ; jump if not valid digit
            smi      10           ; check for high of range
            lbdf     atof_2b      ; jump if not valid digit
            glo      re           ; recover number
            smi      '0'          ; convert to binary
            stxd                  ; and store on stack
            lbr      atof_2a      ; loop until all numerals copied
atof_2b:    dec      rf           ; move pointer back to non-numeral character
; ------------------------------------ 
; ----- Main loop for fractional ----- 
; ------------------------------------ 
atof_2c:    glo      rb           ; check mask for zero
            lbnz     atof_2d
            ghi      rb
            lbnz     atof_2d
            glo      ra
            lbnz     atof_2d
            lbr      atof_2z      ; done with fractional
atof_2d:    glo      r7           ; check mantissa for zero
            lbnz     atof_2e
            ghi      r8
            lbnz     atof_2e
            glo      r8
            lbnz     atof_2e
            glo      r9           ; zero result
            smi      1            ; so subtract 1 from exponent
            plo      r9           ; put it back
            lbr      atof_2f
atof_2e:    glo      ra           ; if result nonzero, shift mask right
            shr
            plo      ra
            ghi      rb
            shrc
            phi      rb
            glo      rb
            shrc
            plo      rb
atof_2f:    ldi      0            ; set carry to 0
            plo      re
            glo      r2           ; point to fractional data
            plo      rc
            ghi      r2
            phi      rc
            inc      rc
atof_2g:    ldn      rc           ; get next byte from fractional
            smi      99           ; check for end
            lbz      atof_2j      ; jump if end found
            glo      re           ; get carry
            shr                   ; shift into DF
            ldn      rc           ; get next fractional digit
            shlc                  ; add to itself plus carry
            str      rc           ; put it back
            smi      10           ; see if exceeded 10
            lbnf     atof_2h      ; jump if not
            str      rc           ; store corrected number
            ldi      1            ; set carry
atof_2i:    plo      re
            inc      rc           ; point to next character
            lbr      atof_2g      ; and loop back for more
atof_2h:    ldi      0            ; clear carry
            lbr      atof_2i
atof_2j:    glo      re           ; get carry
            shr                   ; shift into DF
            lbnf     atof_2c      ; loop until mask==0
            glo      rb           ; check mask for zero
            lbnz     atof_2k      ; jump if not zero
            ghi      rb
            lbnz     atof_2k      ; jump if not zero
            glo      ra
            lbnz     atof_2k      ; jump if not zero
            glo      r8           ; mask==0, add 1
            adi      1
            plo      r8
            ghi      r8
            adci     0
            phi      r8
            glo      r7
            adci     0
            plo      r7
            lbr      atof_2z      ; done with fractional
atof_2k:    glo      rb           ; combine mask with result
            str      r2
            glo      r8
            or
            plo      r8
            ghi      rb
            str      r2
            ghi      r8
            or
            phi      r8
            glo      ra
            str      r2
            glo      r7
            or
            plo      r7
            lbr      atof_2c      ; loop until mask == 0
atof_2z:    irx                   ; clean temp data from stack
atof_2z2:   ldxa                  ; get next byte
            smi      99           ; look for end marker
            lbnz     atof_2z2     ; loop until marker found
            dec      r2           ; move stack pointer back
atof_e:     sep      scall        ; normalize number
            dw       fpnorm
            ldn      rf           ; get next character
            smi      'E'          ; check for exponent
            lbz      atof_ex      ; jump if so
            smi      32           ; check lowercase e as well
            lbz      atof_ex      ; jump if exponent
atof_dn:    irx                   ; recover destination
            ldxa
            plo      rd
            ldx
            phi      rd
            ghi      r7           ; store answer in destination
            str      rd
            inc      rd
            glo      r7
            str      rd
            inc      rd
            ghi      r8
            str      rd
            inc      rd
            glo      r8
            str      rd
            dec      rd           ; restore destination pointer
            dec      rd
            dec      rd
            irx                   ; recover expr stack
            ldxa
            plo      r7
            ldx
            phi      r7
            sep      sret         ; return to caller
; ++++++++++++++++++++++++++++ 
; +++++ Process exponent +++++ 
; ++++++++++++++++++++++++++++ 
atof_ex:    ldi      0            ; signal positive exponent
            phi      r9           ; put it here
            inc      rf           ; move past E
            ldn      rf           ; need to check for sign
            smi      '+'          ; check for positive
            lbz      atof_exp     ; jump if so
            smi      2            ; check for negative
            lbnz     atof_ex1     ; jump if not
            ldi      1            ; signal negative number
            phi      r9
atof_exp:   inc      rf           ; move past sign
atof_ex1:   ldi      0            ; set exponent count to zero
            plo      rc
atof_ex2:   ldn      rf           ; get byte from input
            smi      '0'          ; see if below digits
            lbnf     atof_ex3     ; jump if not valid digit
            smi      10           ; check for high of range
            lbdf     atof_ex3     ; jump if not valid digit
            glo      rc           ; get count
            shl                   ; multiply by 2
            str      r2           ; save for add
            shl                   ; multiply by 4
            shl                   ; by 8
            add                   ; by 10
            str      r2           ; store for add
            lda      rf           ; get input byte
            smi      '0'          ; convert to binary
            add                   ; add in prior total
            plo      rc           ; put it back
            lbr      atof_ex2     ; loop until no more digits
atof_ex3:   ghi      r7           ; put result on stack
            stxd
            glo      r7
            stxd
            ghi      r8
            stxd
            glo      r8
            stxd
            ghi      r9           ; check sign of exponent
            shr
            lbdf     atof_exn     ; jump if negative
atof_ex4:   glo      rc           ; see if done
            lbz      atof_exd     ; jump if done
            glo      r2           ; point to result
            plo      rf
            ghi      r2
            phi      rf
            inc      rf
            ldi      fp_10.1      ; point to 10.0
            phi      rd
            ldi      fp_10.0
            plo      rd
            glo      rc           ; save count
            stxd
            sep      scall        ; multiply result by 10.0
            dw       mulfpi
            irx                   ; recover count
            ldx
            plo      rc           ; put back into count
            dec      rc           ; decrement count
            lbr      atof_ex4     ; loop until done
atof_exn:   glo      rc           ; see if done
            lbz      atof_exd     ; jump if done
            glo      r2           ; point to result
            plo      rf
            ghi      r2
            phi      rf
            inc      rf
            ldi      fp_10.1      ; point to 10.0
            phi      rd
            ldi      fp_10.0
            plo      rd
            glo      rc           ; save count
            stxd
            sep      scall        ; divide result by 10.0
            dw       divfpi
            irx                   ; recover count
            ldx
            plo      rc           ; put back into count
            dec      rc           ; decrement count
            lbr      atof_exn     ; loop until done
atof_exd:   irx                   ; recover answer
            ldxa
            plo      r8
            ldxa
            phi      r8
            ldxa
            plo      r7
            ldx
            phi      r7
            lbr      atof_dn      ; and return result
#endif

#ifdef FTOA
; ************************************************* 
; ***** Convert floating point to ASCII       ***** 
; ***** RF - pointer to floating point number ***** 
; ***** RD - destination buffer               ***** 
; ***** Uses:                                 ***** 
; *****       R9.0  - exponent                ***** 
; *****       R9.1  - E                       ***** 
; *****       R7:R8 - number                  ***** 
; *****       RA:RB - fractional              ***** 
; *****       RC.0  - digit count             ***** 
; ************************************************* 
ftoa:       ghi      r7           ; save expr stack
            stxd
            glo      r7
            stxd
            lda      rf           ; retrieve number into R7:R8
            plo      r8
            lda      rf
            phi      r8
            lda      rf
            plo      r7
            lda      rf
            phi      r7
            shl                   ; shift sign into DF
            lbnf     ftoa_1       ; jump if number is positive
            ldi      '-'          ; place minus sign into output
            str      rd
            inc      rd
ftoa_1:     glo      r7           ; get low bit of exponent
            shl                   ; shift into DF
            ghi      r7           ; get high 7 bits of exponent
            shlc                  ; shift in the low bit
            plo      r9           ; store it
            lbnz     ftoa_2       ; jump if exponent is not zero
            ldi      '0'          ; write 0 digit to output
            str      rd
            inc      rd
ftoa_t:     ldi      0            ; terminate output
            str      rd
            irx                   ; recover expr stack
            ldxa
            plo      r7
            ldx
            phi      r7
            sep      sret         ; and return to caller
ftoa_2:     smi      0ffh         ; check for infinity
            lbnz     ftoa_3       ; jump if not
            ldi      'i'          ; write inf to output
            str      rd
            inc      rd
            ldi      'n'
            str      rd
            inc      rd
            ldi      'f'
            str      rd
            inc      rd
            lbr      ftoa_t       ; terminate string and return
ftoa_3:     ghi      rd           ; save destination pointer
            stxd
            glo      rd
            stxd
            ldi      0            ; clear E
            phi      r9
//            glo      r9           ; check exponent for greater than 150
//            smi      151
            glo      r9           ; check exponent for greater than 129
            smi      129

            lbnf     ftoa_4       ; jump if <= 129
            ghi      r7           ; put number on the stack
            stxd
            glo      r7
            stxd
            ghi      r8
            stxd
            glo      r8
            stxd
ftoa_3a:    glo      r9           ; get exponent
//            smi      131          ; looking for below 131
            smi      130          ; looking for below 131
            lbnf     ftoa_3z      ; jump if done scaling
            glo      r2           ; point to number
            plo      rf
            ghi      r2
            phi      rf
            inc      rf
            ghi      r9           ; get E
            stxd                  ; and save on stack
            ldi      fp_10.1      ; need to divide by 10
            phi      rd
            ldi      fp_10.0
            plo      rd
            sep      scall        ; perform the division
            dw       divfpi
            irx                   ; recover E
            ldx
            adi      1            ; increment E
            phi      r9           ; and put it back
            glo      r2           ; point to new exponent
            adi      3
            plo      rf
            ghi      r2
            adci     0
            phi      rf
            lda      rf           ; get low bit
            shl                   ; shift into DF
            ldn      rf           ; get high 7 bites
            shlc                  ; shift in the low bit
            plo      r9           ; and store it
            lbr      ftoa_3a      ; loop until exponent in correct range
ftoa_3z:    irx                   ; retrieve the number from the stack
            ldxa
            plo      r8
            ldxa
            phi      r8
            ldxa
            plo      r7
            ldx
            phi      r7
; ftoa_4:     glo      r9           ; check exponent for less than 114
;             smi      114
ftoa_4:     glo      r9           ; check exponent for less than 127
            smi      127
            lbdf     ftoa_5       ; jump if > 127
            ghi      r7           ; put number on the stack
            stxd
            glo      r7
            stxd
            ghi      r8
            stxd
            glo      r8
            stxd
ftoa_4a:    glo      r9           ; get exponent
            smi      127          ; looking for below 127
            lbdf     ftoa_4z      ; jump if done scaling
            glo      r2           ; point to number
            plo      rf
            ghi      r2
            phi      rf
            inc      rf
            ghi      r9           ; get E
            stxd                  ; and save on stack
            ldi      fp_10.1      ; need to multiply by 10
            phi      rd
            ldi      fp_10.0
            plo      rd
            sep      scall        ; perform the division
            dw       mulfpi
            irx                   ; recover E
            ldx
            smi      1            ; decrement E
            phi      r9           ; and put it back
            glo      r2           ; point to new exponent
            adi      3
            plo      rf
            ghi      r2
            adci     0
            phi      rf
            lda      rf           ; get low bit
            shl                   ; shift into DF
            ldn      rf           ; get high 7 bites
            shlc                  ; shift in the low bit
            plo      r9           ; and store it
            lbr      ftoa_4a      ; loop until exponent in correct range
ftoa_4z:    irx                   ; retrieve the number from the stack
            ldxa
            plo      r8
            ldxa
            phi      r8
            ldxa
            plo      r7
            ldx
            phi      r7
ftoa_5:     ldi      0            ; clear high byte of number
            phi      r7
            glo      r7           ; set implied 1
            ori      080h
            plo      r7           ; and put it back
            ldi      0            ; clear fractional
            phi      ra
            plo      ra
            phi      rb
            plo      rb
ftoa_6:     glo      r9           ; get exponent
            smi      150          ; check for less than 150
            lbdf     ftoa_7       ; jump if not
            glo      r7           ; shift number right
            shr
            plo      r7
            ghi      r8
            shrc
            phi      r8
            glo      r8
            shrc
            plo      r8
            glo      ra
            shrc
            plo      ra
            ghi      rb
            shrc
            phi      rb
            glo      rb
            shrc
            plo      rb
            glo      r9           ; get exponent
            adi      1            ; increase it
            plo      r9           ; put it back
            lbr      ftoa_6       ; loop back until exponent >= 150
ftoa_7:     glo      r9           ; get exponent
            smi      151          ; check for greater than 150
            lbnf     ftoa_8       ; jump if not
            glo      r8           ; shift number left
            shl
            plo      r8
            ghi      r8
            shlc
            phi      r8
            glo      r7
            shlc
            plo      r7
            ghi      r7
            shlc
            phi      r7
            glo      r9           ; get exponent
            adi      1            ; increment it
            plo      r9           ; and put it back
            lbr      ftoa_7       ; loop until exponent in range
ftoa_8:     irx                   ; recover destination
            ldxa
            plo      rd
            ldx
            phi      rd
            ghi      r7           ; place integer portion on stack
            stxd
            glo      r7
            stxd
            ghi      r8
            stxd
            glo      r8
            stxd
            glo      r2           ; point source to integer number
            plo      rf
            ghi      r2
            phi      rf
            inc      rf
            ghi      ra           ; save registers consumed by itoa
            stxd
            glo      ra
            stxd
            ghi      rb
            stxd
            glo      rb
            stxd
            ghi      r9
            stxd
            glo      r9
            stxd
            sep      scall        ; call itoa to convert integer portion of result
            dw       itoa32
            irx                   ; recover consumed registers
            ldxa
            plo      r9
            ldxa
            phi      r9
            ldxa
            plo      rb
            ldxa
            phi      rb
            ldxa
            plo      ra
            ldx
            phi      ra
            irx                   ; remove number from stack
            irx
            irx
            irx
            glo      ra           ; check for nonzero fractional
            lbnz     ftoa_9       ; jump if not zero
            ghi      rb
            lbnz     ftoa_9
            glo      rb
            lbnz     ftoa_9
            lbr      ftoa_e       ; no fractional digits, jump to E processing
ftoa_9:     ghi      r9           ; check if need E
            lbz      ftoa_9c2     ; jump if not
            dec      rd           ; get 2 characters back
            dec      rd
            lda      rd           ; get it
            smi      '1'          ; see if it was 1
            lbnz     ftoa_9c      ; jump if not
            ldn      rd           ; get 2nd number
            plo      re           ; save it
            ldi      '.'          ; replace it with a dot
            str      rd
            inc      rd
            glo      re           ; recover number
            str      rd           ; and store into destination
            inc      rd
            ghi      r9           ; get E
            adi      1            ; increment it
            phi      r9           ; and put it back
            lbr      ftoa_9d      ; then continue
ftoa_9c:    inc      rd           ; put RD back to original position
ftoa_9c2:   ldi      '.'          ; need decimal point
            str      rd           ; store into destination
            inc      rd
ftoa_9d:    ldi      6            ; set digit count
            plo      rc
ftoa_9a:    glo      ra           ; check if fractional is still non-zero
            lbnz     ftoa_9b      ; jump if not
            ghi      rb
            lbnz     ftoa_9b
            glo      rb
            lbz      ftoa_e       ; on to E processing if no more fractional bits
ftoa_9b:    glo      rb           ; multiply fractional by 2
            shl
            plo      rb
            plo      r8           ; put copy in R7:R8 as well
            ghi      rb
            shlc
            phi      rb
            phi      r8
            glo      ra
            shlc
            plo      ra
            plo      r7
            ghi      ra
            shlc
            phi      ra
            phi      r7
            glo      r8           ; now multiply R7:R8 by 2
            shl
            plo      r8
            ghi      r8
            shlc
            phi      r8
            glo      r7
            shlc
            plo      r7
            ghi      r7
            shlc
            phi      r7
            glo      r8           ; now multiply R7:R8 by 4
            shl
            plo      r8
            ghi      r8
            shlc
            phi      r8
            glo      r7
            shlc
            plo      r7
            ghi      r7
            shlc
            phi      r7
            glo      rb           ; now add R7:R8 to RA:RB
            str      r2
            glo      r8
            add
            plo      rb
            ghi      rb
            str      r2
            ghi      r8
            adc
            phi      rb
            glo      ra
            str      r2
            glo      r7
            adc
            plo      ra
            ghi      ra
            str      r2
            ghi      r7
            adc
            phi      ra           ; D now has decimal byte
            adi      '0'          ; convert to ASCII
            str      rd           ; and write to destination
            inc      rd
            ldi      0            ; clear high byte of fractional
            phi      ra
            dec      rc           ; increment counter
            glo      rc           ; need to see if done
            lbnz     ftoa_9a      ; loop until done
ftoa_e:     ghi      r9           ; need to check for E
            lbz      ftoa_dn      ; jump if no E needed
            ldi      'E'          ; write E to output
            str      rd
            inc      rd
            ghi      r9           ; see if E was negative
            shl
            lbnf     ftoa_ep      ; jump if not
            ldi      '-'          ; write minus sign to output
            str      rd
            inc      rd
            ghi      r9           ; then 2s compliment E
            xri      0ffh
            adi      1
            phi      r9           ; and put it back
            lbr      ftoa_e1      ; then continue
ftoa_ep:    ldi      '+'          ; write plus to output
            str      rd
            inc      rd
ftoa_e1:    ldi      0            ; place E as 32-bits onto stack
            stxd
            stxd
            stxd
            ghi      r9
            stxd
            glo      r2           ; point rf to number
            plo      rf
            ghi      r2
            phi      rf
            inc      rf
            sep      scall        ; call itoa to display E
            dw       itoa32
            irx                   ; remove number from stack
            irx
            irx
            irx
ftoa_dn:    ldi      0            ; terminate string
            str      rd
            irx                   ; recover expr stack
            ldxa
            plo      r7
            ldx
            phi      r7
            sep      sret         ; and return to caller
#endif

#ifdef USEFP
fpdot1:     db      0cdh, 0cch, 0cch, 03dh
fp_0:       db      00,00,00,00
fp_1:       db      00,00,080h,03fh
fp_2:       db      00,00,000h,040h
fp_10:      db      00,00,020h,041h
fp_100:     db      00,00,0c8h,042h
fp_1000:    db      00,00,07ah,044h
fp_e:       db      054h, 0f8h, 02dh, 040h
fp_pi:      db      0dbh, 00fh, 049h, 040h
fp_3:       db      00,00,040h,040h
fpdot5:     db      000h, 000h, 000h, 03fh
fp_halfpi:  db      0dbh, 00fh, 0c9h, 03fh

; ******************************************* 
; ***** Normalize and combine FP result ***** 
; ***** R7:R8 - Mantissa                ***** 
; ***** R9.0  - Exponent                ***** 
; ***** R9.1  - Sign                    ***** 
; ***** Returns: R7:R8 - FP number      ***** 
; ******************************************* 
fpnorm:     glo     r9           ; Get exponent
            lbz     fpnorm0      ; jump if zero
            glo     r8           ; zero check mantissa
            lbnz    fpnormnz     ; jump if not
            ghi     r8
            lbnz    fpnormnz
            glo     r7
            lbnz    fpnormnz
            ghi     r7
            lbnz    fpnormnz
fpnorm0:    ldi     0            ; set result to 0
            plo     r8
            phi     r8
            plo     r7
            phi     r7
            sep     sret         ; and return
fpnormi:    ldi     03fh         ; set infinity
            phi     r7
            ldi     080h
            plo     r7
            ldi     0
            phi     r8
            plo     r8
            sep     sret         ; and return
fpnormnz:   ghi     r7           ; check for need to right shift
            lbz     fpnorm_1     ; jump if no right shifts needed
            shr                  ; shift mantissa right
            phi     r7
            glo     r7
            shrc
            plo     r7
            ghi     r8
            shrc
            phi     r8
            glo     r8
            shrc
            plo     r8
            inc     r9           ; increment exponent
            glo     r9           ; get exponent
            smi     0ffh         ; check for exponent overflow
            lbz     fpnormi      ; jump if exponent overflow, returns 0
            lbr     fpnormnz     ; keep checking for bits too high in mantissa
fpnorm_1:   glo     r7           ; check for need to shift left
            shl                  ; shift high bit into DF
            lbdf    fpnorm_2     ; jump if high bit is set
            glo     r8           ; shift mantissa left
            shl
            plo     r8
            ghi     r8
            shlc
            phi     r8
            glo     r7
            shlc
            plo     r7
            dec     r9           ; decrement exponent
            glo     r9           ; check for exponent underflow
            lbz     fpnorm0      ; jump if underflow occured
            lbr     fpnorm_1     ; loop until high bit set
fpnorm_2:   glo     r7           ; prepare mantissa for merging exponent
            shl
            plo     r7
            ghi     r9           ; get sign
            shr                  ; shift into DF
            glo     r9           ; get exponent
            shrc                 ; shift in sign
            phi     r7           ; place into answer
            glo     r7           ; get high byte of mantissa
            shrc                 ; shift in least bit from exponent
            plo     r7           ; and put back
            sep     sret         ; return to caller

; ********************************* 
; ***** Retrieve fp arguments ***** 
; ***** M[RF] -> R7:R8 R9.0   ***** 
; ***** M[RD] -> RA:RB R9.1   ***** 
; ********************************* 
fpargs:     lda     rf           ; retrieve first number
            plo     r8
            lda     rf
            phi     r8
            lda     rf
            plo     r7
            shl                  ; shift low bit of exponent
            lda     rf
            phi     r7
            shlc                 ; get full exponent
            plo     r9           ; save exponent 1
            lda     rd           ; retrieve second number
            plo     rb
            lda     rd
            phi     rb
            lda     rd
            plo     ra
            shl                  ; shift low bit of exponent
            lda     rd
            phi     ra
            shlc                 ; get full exponent
            phi     r9           ; save exponent 2
            sep     sret         ; return to caller

fpret_0:    irx                  ; recover destination address
            ldxa
            plo     rf
            ldx
            phi     rf
            ldi     0            ; write 0
            str     rf
            inc     rf
            str     rf
            inc     rf
            str     rf
            inc     rf
            str     rf
            irx
            ldxa
            plo     r7
            ldx
            phi     r7
            sep     sret         ; and return

fpret_a:    irx                  ; recover destination address
            ldxa
            plo     rf
            ldx
            phi     rf
            glo     r8           ; store a as answer
            str     rf
            inc     rf
            ghi     r8
            str     rf
            inc     rf
            glo     r7
            str     rf
            inc     rf
            ghi     r7
            str     rf
            irx
            ldxa
            plo     r7
            ldx
            phi     r7
            sep     sret         ; and return to caller

fpret_b:    irx                  ; recover destination address
            ldxa
            plo     rf
            ldx
            phi     rf
            glo     rb           ; store a as answer
            str     rf
            inc     rf
            ghi     rb
            str     rf
            inc     rf
            glo     ra
            str     rf
            inc     rf
            ghi     ra
            str     rf
            irx
            ldxa
            plo     r7
            ldx
            phi     r7
            sep     sret         ; and return to caller

fpcomp2:    glo     r8           ; perform 2s compliment on input
            xri     0ffh
            adi     1
            plo     r8
            ghi     r8
            xri     0ffh
            adci    0
            phi     r8
            glo     r7
            xri     0ffh
            adci    0
            plo     r7
            ghi     r7
            xri     0ffh
            adci    0
            phi     r7
            sep     sret

; **************************************************** 
; ***** Convert 32-bit integer to floating point ***** 
; ***** numbers are on expr stack                ***** 
; ***** RF - Pointer to 32-bit integer           ***** 
; ***** RD - Destination floating point          ***** 
; **************************************************** 
itof:       inc     r7
            lda     r7           ; retrieve 32-bit integer into ra:rb
            plo     rb
            str     r2           ; store for zero check
            lda     r7
            phi     rb
            or                   ; combine with zero check
            str     r2           ; keep zero check on stack
            lda     r7
            plo     ra
            or
            str     r2
            ldn     r7           ; MSB
            phi     ra
            or
            lbz     itof0        ; jump if input number is zero
            ldi     0            ; set sign flag
            str     r2
            ghi     ra           ; see if number is negative
            shl                  ; shift sign bit into DF
            lbnf    itof_p       ; jump if number is positive
            ldi     1            ; set sign flag
            stxd
            glo     rb           ; 2s compliment input number
            xri     0ffh
            adi     1
            plo     rb
            ghi     rb
            xri     0ffh
            adci    0
            phi     rb
            glo     ra
            xri     0ffh
            adci    0
            plo     ra
            ghi     ra
            xri     0ffh
            adci    0
            phi     ra
            irx                  ; point x back to sign flag
itof_p:     ldi     150          ; exponent starts at 150
            plo     re
itof_1:     ghi     ra           ; see if need right shifts
            lbz     itof_2       ; jump if not
            shr                  ; otherwise shift number right
            phi     ra
            glo     ra
            shrc
            plo     ra
            ghi     rb
            shrc
            phi     rb
            glo     rb
            shrc
            plo     rb
            inc     re           ; increment exponent
            lbr     itof_1       ; and loop to see if more shifts needed
itof_2:     glo     ra           ; see if we need left shifts
            ani     080h
            lbnz    itof_3       ; jump if no shifts needed
            glo     rb           ; shift number left
            shl
            plo     rb
            ghi     rb
            shlc
            phi     rb
            glo     ra
            shlc
            plo     ra
            ghi     ra
            shlc
            phi     ra
            dec     re           ; decrement exponent
            lbr     itof_2       ; and loop to see if more shifts needed
itof_3:     glo     ra           ; prepare to merge in exponent
            shl
            plo     ra
            glo     re           ; get exponent
            phi     ra           ; store into result
            shr                  ; shift it right 1 bit
            glo     ra
            shrc                 ; shift final exponent bit in
            plo     ra
            ldx                  ; recover sign flag
            shr                  ; shift it into DF
            ghi     ra           ; get msb of result
            shrc                 ; shift in sign bit
            phi     ra           ; and put it back
itof0:      ghi     ra           ; store answer into destination
            str     r7
            dec     r7
            glo     ra
            str     r7
            dec     r7
            ghi     rb
            str     r7
            dec     r7
            glo     rb
            str     r7
            dec     r7
            sep     sret         ; and return

; ************************************************* 
; ***** Convert floating point to integer     ***** 
; ***** Numbers are on expr stack             ***** 
; ***** RF - pointer to floating point number ***** 
; ***** RD - destination integer              ***** 
; ***** Returns: DF=1 - overflow              ***** 
; ***** Uses:                                 ***** 
; *****       R9.0  - exponent                ***** 
; *****       R9.1  - sign                    ***** 
; *****       RD:RF - number                  ***** 
; *****       RA:RB - fractional              ***** 
; *****       RC.0  - digit count             ***** 
; ************************************************* 
ftoi:       inc      r7
            lda      r7         ; retrieve number into RD:RF
            plo      rf
            lda      r7
            phi      rf
            lda      r7
            plo      rd
            ldn      r7
            phi      rd
            shl                   ; shift sign into DF
            ldi      0            ; clear D
            shlc                  ; shift sign into D
            phi      r9           ; and store it
ftoi_1:     glo      rd           ; get low bit of exponent
            shl                   ; shift into DF
            ghi      rd           ; get high 7 bits of exponent
            shlc                  ; shift in the low bit
            plo      r9           ; store it
            lbnz     ftoi_2       ; jump if exponent is not zero
            ldi      0            ; result is zero
            str      r7
            dec      r7
            str      r7
            dec      r7
            str      r7
            dec      r7
            str      r7
            dec      r7
            adi      0            ; clear DF
            sep      sret         ; return to caller
ftoi_2:     smi      0ffh         ; check for infinity
            lbnz     ftoi_5       ; jump if not
ftoi_ov:    ldi      0ffh         ; write highest integer
            str      r7
            dec      r7
            str      r7
            dec      r7
            str      r7
            dec      r7
            ldi      07fh         ; positive number
            str      r7
            dec      r7
            smi      0            ; set DF to signal ovelow
            sep      sret         ; and return
ftoi_5:     ldi      0            ; clear high byte of number
            phi      rd
            glo      rd           ; set implied 1
            ori      080h
            plo      rd           ; and put it back
            ldi      0            ; clear fractional
            phi      ra
            plo      ra
            phi      rb
            plo      rb
ftoi_6:     glo      r9           ; get exponent
            smi      150          ; check for less than 150
            lbdf     ftoi_7       ; jump if not
            glo      ra           ; shift fractional right
            shr
            plo      ra
            ghi      rb
            shrc
            phi      rb
            glo      rb
            shrc
            plo      rb
            glo      rf           ; get low bit of number
            shr                   ; shift it into DF
            lbnf     ftoi_6a      ; jump if bit was clear
            glo      ra           ; otherwise set high bit in fractional
            ori      080h
            plo      ra           ; put it back
ftoi_6a:    glo      rd           ; shift number right
            shr
            plo      rd
            ghi      rf
            shrc
            phi      rf
            glo      rf
            shrc
            plo      rf
            glo      r9           ; get exponent
            adi      1            ; increase it
            plo      r9           ; put it back
            lbr      ftoi_6       ; loop back until exponent >= 150
ftoi_7:     glo      r9           ; get exponent
            smi      151          ; check for greater than 150
            lbnf     ftoi_8       ; jump if not
            ghi      rd           ; check for ovelow
            ani      080h
            lbnz     ftoi_ov      ; jump if ovelow
            glo      rf           ; shift number left
            shl
            plo      rf
            ghi      rf
            shlc
            phi      rf
            glo      rd
            shlc
            plo      rd
            ghi      rd
            shlc
            phi      rd
            glo      r9           ; get exponent
            adi      1            ; increment it
            plo      r9           ; and put it back
            lbr      ftoi_7       ; loop until exponent in range
ftoi_8:     ghi      r9           ; was fp number negative
            lbz      ftoi_8a
            glo      rf           ; 2's compliment number
            xri      0ffh
            adi      1
            plo      rf
            ghi      rf
            xri      0ffh
            adci     0
            phi      rf
            glo      rd
            xri      0ffh
            adci     0
            plo      rd
            ghi      rd
            xri      0ffh
            adci     0
            phi      rd
ftoi_8a:    ghi      rd           ; store number into destination
            str      r7
            dec      r7
            glo      rd
            str      r7
            dec      r7
            ghi      rf
            str      r7
            dec      r7
            glo      rf
            str      r7
            dec      r7           ; move destination pointer back
            adi      0            ; signal no ovelow
            sep      sret         ; and return to caller
#endif





/* *********************************************************************** */
/* *********************************************************************** */
/* *****               32-bit Integer Library                        ***** */
/* *********************************************************************** */
/* *********************************************************************** */

#ifdef RND32
#redefine MOD32
#redefine LFSR
rnd32:      ldi     32
            plo     rc
            sep     scall         ; Shift the register
            dw      lfsr_lp
            ldi     LFSR_.1
            phi     r9
            ldi     LFSR_.0
            plo     r9

            inc     r7            ; Retrieve range
            lda     r7
            plo     rb
            lda     r7
            phi     rb
            lda     r7
            plo     ra
            ldn     r7
            phi     ra

            lda     r9            ; Transfer random number
            ani     07fh          ; no negative numbers
            str     r7
            dec     r7
            lda     r9
            str     r7
            dec     r7
            lda     r9
            str     r7
            dec     r7
            lda     r9
            str     r7
            dec     r7

            ghi     ra            ; Put range on expr stack
            str     r7
            dec     r7
            glo     ra
            str     r7
            dec     r7
            ghi     rb
            str     r7
            dec     r7
            glo     rb
            str     r7
            dec     r7
            lbr     mod32          ; and perform modulo
#endif

#ifdef MUL32
#redefine SHL32
#redefine SHR32
#redefine ZERO32
#redefine ADD32
; ************************************************ 
; ***** 32-bit multiply. M[RF]=M[RF]*M[RD]   ***** 
; ***** Numbers in memory stored LSB first   ***** 
; ***** In routine:                          ***** 
; *****    R9 - points to first number       ***** 
; *****    RD - points to second number      ***** 
; *****    RF - points to answer             ***** 
; ************************************************ 
mul32i:     ldi      0                 ; need to zero answer
            stxd
            stxd
            stxd
            stxd
            glo      rf                ; r9 will point to first number
            plo      r9
            ghi      rf
            phi      r9
            glo      r2                ; rf will point to where the answer is
            plo      rf
            ghi      r2
            phi      rf
            inc      rf                ; point to LSB of answer
scmul2:     glo      rd                ; need second number
            plo      ra
            ghi      rd
            phi      ra
            sep      scall             ; check for zero
            dw       zero32
            lbnf     scmul4            ; jump if number was not zero
            inc      r2                ; now pointing at lsb of answer
            lda      r2                ; get number from stack
            str      r9                ; store into destination
            inc      r9                ; point to 2nd byte
            lda      r2                ; get number from stack
            str      r9                ; store into destination
            inc      r9                ; point to 3rd byte
            lda      r2                ; get number from stack
            str      r9                ; store into destination
            inc      r9                ; point to msb
            ldn      r2                ; get number from stack
            str      r9                ; store into destination
            sep      sret              ; return to caller
scmul4:     ldn      rd                ; get lsb of second number
            shr                        ; shift low bit into df
            lbnf     scmulno           ; no add needed
            ghi      rd                ; save position of second number
            stxd
            glo      rd
            stxd
            glo      r9                ; rd needs to be first number
            plo      rd
            ghi      r9
            phi      rd
            sep      scall             ; call add routine
            dw       add32i
            irx                        ; recover rd
            ldxa
            plo      rd
            ldx
            phi      rd
scmulno:    glo      r9                ; point to first number
            plo      ra
            ghi      r9
            phi      ra
            sep      scall             ; shift left
            dw       shl32
            glo      rd                ; now need pointer to second number
            plo      ra
            ghi      rd
            phi      ra
            sep      scall             ; shift right
            dw       shr32
            lbr      scmul2            ; loop until done

mul32:      glo      r7                ; setup pointers
            plo      rd
            plo      rf
            ghi      r7                ; setup pointers
            phi      rd
            phi      rf
            inc      rd
            inc      rf
            inc      rf
            inc      rf
            inc      rf
            inc      rf
            sep      scall             ; Perform multiply
            dw       mul32i
            inc      r7                ; Remove 2nd number from stack
            inc      r7
            inc      r7
            inc      r7
            sep      sret              ; Return to caller
#endif

#ifdef ADD32
; ************************************************ 
; ***** 32-bit Add.    M[RF]=M[RF]+M[RD]     ***** 
; ***** Numbers in memory stored LSB first   ***** 
; ************************************************ 
add32i:     sex      rd                ; point x to second number
            ldn      rf                ; get lsb
            add                        ; add second lsb of second number
            str      rf                ; store it
            inc      rf                ; point to 2nd byte
            inc      rd
            ldn      rf                ; get second byte
            adc                        ; add second byte of second number
            str      rf                ; store it
            inc      rf                ; point to 3rd byte
            inc      rd
            ldn      rf                ; get third byte
            adc                        ; add third byte of second number
            str      rf                ; store it
            inc      rf                ; point to msb
            inc      rd
            ldn      rf                ; get msb byte
            adc                        ; add msb byte of second number
            str      rf                ; store it
            sex      r2                ; restore stack
            dec      rf                ; restore registers to original values
            dec      rf
            dec      rf
            dec      rd
            dec      rd
            dec      rd
            sep      sret              ; return to caller

add32:      glo      r7                ; setup pointers
            plo      rd
            plo      rf
            ghi      r7                ; setup pointers
            phi      rd
            phi      rf
            inc      rd
            inc      rf
            inc      rf
            inc      rf
            inc      rf
            inc      rf
            sep      scall             ; Perform addition
            dw       add32i
            inc      r7                ; Remove 2nd number from stack
            inc      r7
            inc      r7
            inc      r7
            sep      sret              ; Return to caller
#endif

#ifdef DEC32
dec32:      inc      r7                ; move to lsb
            ldn      r7                ; retrieve it
            smi      1                 ; add 1
            str      r7                ; and put it back
            inc      r7                ; point to next byte
            ldn      r7                ; retrieve it
            smbi     0                 ; propagate carry
            str      r7                ; and put it back
            inc      r7                ; point to next byte
            ldn      r7                ; retrieve it
            smbi     0                 ; propagate carry
            str      r7                ; and put it back
            inc      r7                ; point to next byte
            ldn      r7                ; retrieve it
            smbi     0                 ; propagate carry
            str      r7                ; and put it back
            dec      r7                ; move expr pointer back
            dec      r7
            dec      r7
            dec      r7
            sep      sret              ; and return to caller
#endif

#ifdef MOD32
#redefine DIV32
mod32:      sep     scall
            dw      div32
            inc     r7
            inc     r7
            inc     r7
            inc     r7
            ghi     ra
            str     r7
            dec     r7
            glo     ra
            str     r7
            dec     r7
            ghi     rb
            str     r7
            dec     r7
            glo     rb
            str     r7
            dec     r7
            sep     sret
#endif

#ifdef DIV32
#redefine NEG32
#redefine COMP32
#redefine ICOMP32
#redefine SHL32
#redefine SHR32
#redefine ZERO32
#redefine SUB32
; ************************************************ 
; ***** 32-bit division. M[RF]=M[RF]/M[RD]   ***** 
; ***** Numbers in memory stored LSB first   ***** 
; ***** In routine:                          ***** 
; *****    RF=a                              ***** 
; *****    RD=b                              ***** 
; *****    RC=result                         ***** 
; *****    RB=shift                          ***** 
; ************************************************ 
div32i:     ldi      0                 ; set sign flag as positive
            str      r2                ; place on the stack
            inc      rf                ; point to msb of first number
            inc      rf
            inc      rf
            ldn      rf                ; retrieve it
            dec      rf                ; restore position
            dec      rf
            dec      rf
            ani      080h              ; is number negative
            lbz      div32_1           ; jump if not
            ldi      1                 ; set sign flag
            xor
            stxd                       ; save flag
            glo      rf                ; 2s compliment number
            plo      ra
            ghi      rf
            phi      ra
            sep      scall
            dw       neg32
            irx                        ; point back to sign flag
div32_1:    inc      rd                ; point to msb of second number
            inc      rd
            inc      rd
            ldn      rd                ; retrieve it
            dec      rd                ; restore position
            dec      rd
            dec      rd
            ani      080h              ; is number negative
            lbz      div32_2           ; jump if not
            ldi      1                 ; adjust sign flag
            xor
            stxd                       ; save sign flag
            glo      rd                ; 2s compliment second number
            plo      ra
            ghi      rd
            phi      ra
            sep      scall
            dw       neg32
            irx
div32_2:    dec      r2                ; preserve sign flag
            ldi      0                 ; zero answer on stack
            stxd
            stxd
            stxd
            stxd
            glo      r2                ; set RC here
            plo      rc
            ghi      r2
            phi      rc
            inc      rc                ; point rc to lsb of answer
            ldi      1                 ; set shift to 1
            plo      rb
scdiv1:     sep      scall             ; compare a to b
            dw       icomp32
            lbnf     scdiv4            ; jump if b>=a
            glo      rd                ; need to shift b
            plo      ra
            ghi      rd
            phi      ra
            sep      scall
            dw       shl32
            inc      rb                ; increment shift
            lbr      scdiv1            ; loop until b>=a
scdiv4:     glo      rf                ; point to a
            plo      ra
            ghi      rf
            phi      ra
            sep      scall             ; is a zero
            dw       zero32
            lbdf     scdivd1           ; jump if it was zero
            glo      rd                ; point to b
            plo      ra
            ghi      rd
            phi      ra
            sep      scall             ; is b zero
            dw       zero32
            lbdf     scdivd1           ; jump if so
            glo      rc                ; point to result
            plo      ra
            ghi      rc
            phi      ra
            sep      scall             ; need to shift result left
            dw       shl32
            sep      scall             ; compare a to b
            dw       comp32
            lbdf     scdiv6            ; jump if a < b
            ldn      rc                ; get LSB of result
            ori      1                 ; set low bit
            str      rc                ; and but it back
            sep      scall             ; subtrcct a from b
            dw       sub32i
scdiv6:     ldn      rd                ; get lsb of b
            shr                        ; see if low bit is set
            lbnf     scdiv5            ; jump if not
            dec      rb                ; mark final shift
            lbr      scdivd1           ; and then done
scdiv5:     glo      rd                ; point to b
            plo      ra
            ghi      rd
            phi      ra
            sep      scall             ; need to shift b right
            dw       shr32
            dec      rb                ; decrement shift
            glo      rb                ; see if run out of shifts
            lbz      scdivd1           ; done if so
            lbr      scdiv4            ; loop back until done
scdivd1:    glo      rb                ; get shift
            shl                        ; shift sign into df
            lbdf     scdivd2           ; jump if so
scdivd3:    glo      rb                ; get shift
            lbz      scdivdn           ; jump if zero
            glo      rc                ; point to result
            plo      ra
            ghi      rc
            phi      ra
            sep      scall             ; shift it left
            dw       shl32
            dec      rb                ; decrement shift
            lbr      scdivd3           ; loop back
scdivd2:    glo      rb                ; get shift
            lbz      scdivdn           ; jump if zero
            glo      rc                ; point to result
            plo      ra
            ghi      rc
            phi      ra
            sep      scall             ; shift it right
            dw       shr32
            inc      rb                ; increment shift
            lbr      scdivd2
scdivdn:    lda      rf                ; recover remainder
            plo      rb
            lda      rf
            phi      rb
            lda      rf                ; recover remainder
            plo      ra
            ldn      rf
            phi      ra
            dec      rf
            dec      rf
            dec      rf
            ldi      4                 ; 4 bytes to trcnsfer
            plo      r9
scdivd5:    lda      rc                ; get result byte
            str      rf                ; store into answer
            inc      rf
            dec      r9                ; decrement count
            glo      r9                ; see if done
            lbnz     scdivd5           ; jump if not
            dec      rf                ; recover answer
            dec      rf
            dec      rf
            dec      rf
            glo      rc                ; need to clean up the stack
            plo      r2
            ghi      rc
            phi      r2
            ldn      r2                ; retrieve sign
            shr                        ; shift into df
            lbnf     scdivrt           ; jump if signs were the same
            glo      rf                ; otherwise negate number
            plo      ra
            ghi      rf
            phi      ra
            sep      scall
            dw       neg32
scdivrt:    sep      sret              ; return to caller

div32:      glo      r7                ; setup pointers
            plo      rd
            plo      rf
            ghi      r7                ; setup pointers
            phi      rd
            phi      rf
            inc      rd
            inc      rf
            inc      rf
            inc      rf
            inc      rf
            inc      rf
            sep      scall             ; Perform division
            dw       div32i
            inc      r7                ; Remove 2nd number from stack
            inc      r7
            inc      r7
            inc      r7
            sep      sret              ; Return to caller
#endif

#ifdef SUB32
; ************************************************ 
; ***** 32-bit subtract.  M[RF]=M[RF]-M[RD]  ***** 
; ***** Numbers in memory stored LSB first   ***** 
; ************************************************ 
sub32i:     sex      rd                ; point x to second number
            ldn      rf                ; get lsb
            sm                         ; subtract second lsb of second number
            str      rf                ; store it
            inc      rf                ; point to 2nd byte
            inc      rd
            ldn      rf                ; get second byte
            smb                        ; subtract second byte of second number
            str      rf                ; store it
            inc      rf                ; point to 3rd byte
            inc      rd
            ldn      rf                ; get third byte
            smb                        ; subtract third byte of second number
            str      rf                ; store it
            inc      rf                ; point to msb
            inc      rd
            ldn      rf                ; get msb byte
            smb                        ; subtract msb byte of second number
            str      rf                ; store it
            sex      r2                ; restore stack
            dec      rf                ; restore registers to original values
            dec      rf
            dec      rf
            dec      rd
            dec      rd
            dec      rd
            sep      sret              ; return to caller

sub32:      glo      r7                ; setup pointers
            plo      rd
            plo      rf
            ghi      r7                ; setup pointers
            phi      rd
            phi      rf
            inc      rd
            inc      rf
            inc      rf
            inc      rf
            inc      rf
            inc      rf
            sep      scall             ; Perform subtraction
            dw       sub32i
            inc      r7                ; Remove 2nd number from stack
            inc      r7
            inc      r7
            inc      r7
            sep      sret              ; Return to caller
#endif

#ifdef NEG32
; ********************************************* 
; ***** 2s compliment the number in M[RA] ***** 
; ********************************************* 
neg32:      ldn      ra                ; get lsb
            xri      0ffh              ; invert it
            adi      1                 ; +1
            str      ra
            inc      ra                ; point to 2nd byte
            ldn      ra                ; retrieve it
            xri      0ffh              ; invert it
            adci     0                 ; propagate carry
            str      ra                ; and put back
            inc      ra                ; point to 3rd byte
            ldn      ra                ; retrieve it
            xri      0ffh              ; invert it
            adci     0                 ; propagate carry
            str      ra                ; and put back
            inc      ra                ; point to msb
            ldn      ra                ; retrieve it
            xri      0ffh              ; invert it
            adci     0                 ; propagate carry
            str      ra                ; and put back
            dec      ra                ; restore rf
            dec      ra
            dec      ra
            sep      sret              ; return
#endif

#ifdef ICOMP32
; ************************************************ 
; ***** 32-bit cmp.  M[RD]-M[RF]             ***** 
; ***** Numbers in memory stored LSB first   ***** 
; ***** Returns: D=0 if M[RD]=M[RF]          ***** 
; *****          DF=1 if M[RD]<M[RF]         ***** 
; ************************************************ 
icomp32:    lda      rd                ; get lsb from second number
            str      r2                ; store for subtract
            lda      rf                ; get lsb from first number
            sd                         ; subtract
            plo      re                ; save as zero test
            lda      rd                ; get 2nd byte of second number
            str      r2                ; store for subtract
            lda      rf                ; get 2nd byte of first number
            sdb                        ; perform subtraction
            str      r2                ; store for combining with zero test
            glo      re                ; get zero test
            or                         ; or last result
            plo      re                ; and put back
            lda      rd                ; get 3rd byte of second number
            str      r2                ; store for subtract
            lda      rf                ; get 3rd byte of first number
            sdb                        ; perform subtraction
            str      r2                ; store for combining with zero test
            glo      re                ; get zero test
            or                         ; or last result
            plo      re                ; and put back
            ldn      rd                ; get msb of second number
            str      r2                ; store for subtract
            ldn      rf                ; get msb of first number
            sdb                        ; perform subtraction
            str      r2                ; store for combining with zero test
            shl                        ; shift sign bit into df
            glo      re                ; get zero test
            or                         ; or last result
            dec      rf                ; restore registers
            dec      rf
            dec      rf
            dec      rd
            dec      rd
            dec      rd
            sep      sret              ; return to caller
#endif

#ifdef SHL32
; ************************************************ 
; ***** 32-bit shift left.  M[RA]=M[RA]<<1   ***** 
; ***** Numbers in memory stored LSB first   ***** 
; ************************************************ 
shl32:      ldn      ra                ; get lsb
            shl                        ; shift it
            str      ra                ; put it back
            inc      ra                ; point to second byte
            ldn      ra                ; get it
            shlc                       ; shift it
            str      ra
            inc      ra                ; point to third byte
            ldn      ra                ; get it
            shlc                       ; shift it
            str      ra
            inc      ra                ; point to msb
            ldn      ra                ; get it
            shlc                       ; shift it
            str      ra
            dec      ra                ; restore rf
            dec      ra
            dec      ra
            sep      sret              ; and return
#endif

#ifdef ZERO32
; *************************************** 
; ***** is zero check               ***** 
; ***** returnss: DF=1 if M[RA]=0   ***** 
; *************************************** 
zero32:     sex      ra                ; point X to number
            ldxa                       ; get byte 0
            or                         ; combine with byte 1
            irx                        ; point to byte 2
            or                         ; combine
            irx                        ; point to byte 3
            or                         ; combine
            dec      ra                ; restore rf
            dec      ra
            dec      ra
            sex      r2                ; X back to 2
            lbnz     notzero           ; jump if not zero
            smi      0                 ; set df
            sep      sret              ; and return
notzero:    adi      0                 ; clear df
            sep      sret              ; and return
#endif
#ifdef LFSR
lfsr_lp:    ldi     LFSR_.1
            phi     r9
            ldi     LFSR_.0
            plo     r9
            inc     r9
            inc     r9
            inc     r9
            ldn     r9
            plo     re
            shr
            str     r2
            glo     re
            xor
            plo     re
            ldn     r2
            shr
            str     r2
            glo     re
            xor
            plo     re
            ldn     r2
            shr
            shr
            str     r2
            glo     re
            xor
            plo     re
            ldn     r2
            shr
            shr
            str     r2
            glo     re
            xor
            plo     re
            dec     r9
            dec     r9
            dec     r9
            ldn     r9
            shl
            shlc
            str     r2
            glo     re
            xor
            xri     1
            shr
            ldn     r9
            shrc
            str     r9
            inc     r9
            ldn     r9
            shrc
            str     r9
            inc     r9
            ldn     r9
            shrc
            str     r9
            inc     r9
            ldn     r9
            shrc
            str     r9
            dec     rc
            glo     rc
            lbnz    lfsr_lp
            sep     sret
#endif

#ifdef NULL32
; *************************************** 
; ***** M[RA] = 0                   ***** 
; *************************************** 
null32:     ldi      0                 ; need to zero
            str      ra                ; store to lsb
            inc      ra                ; point to second byte
            str      ra                ; store to second byte
            inc      ra                ; point to third byte
            str      ra                ; store to third byte
            inc      ra                ; point to msb
            str      ra                ; store to msb
            dec      ra                ; restore rf
            dec      ra
            dec      ra
            sep      sret              ; return to caller
#endif
#ifdef SHR32
; ************************************************ 
; ***** 32-bit shift right. M[RA]=M[RA]>>1   ***** 
; ***** Numbers in memory stored LSB first   ***** 
; ************************************************ 
shr32:      inc      ra                ; point to msb
            inc      ra
            inc      ra
            ldn      ra                ; get msb
            shr                        ; shift it right
            str      ra                ; put it back
            dec      ra                ; point to third byte
            ldn      ra                ; get third byte
            shrc                       ; shift it
            str      ra                ; put it back
            dec      ra                ; point to second byte
            ldn      ra                ; get second byte
            shrc                       ; shift it
            str      ra                ; put it back
            dec      ra                ; point to lsb
            ldn      ra                ; get lsb
            shrc                       ; shift it
            str      ra                ; put it back
            sep      sret              ; return to caller
#endif


#ifdef AND32
; ************************************************ 
; ***** 32-bit And expr stack                ***** 
; ***** Numbers in memory stored LSB first   ***** 
; ************************************************ 
and32:      inc      r7                ; point to second number
            glo      r7                ; copy address to rf
            plo      rf
            ghi      r7
            phi      rf
            inc      rf                ; point rf to first number
            inc      rf
            inc      rf
            inc      rf
            sex      rf                ; point X to destination
            lda      r7                ; get byte 1
            and                        ; and with first number
            str      rf                ; store
            inc      rf                ; point to byte 2
            lda      r7                ; get byte 2
            and                        ; and with first number
            str      rf                ; store
            inc      rf                ; point to byte 3
            lda      r7                ; get byte 3
            and                        ; and with first number
            str      rf                ; store
            inc      rf                ; point to byte 4
            ldn      r7                ; get byte 7
            and                        ; and with first number
            str      rf                ; store
            sex      r2                ; Set x back to R2
            sep      sret              ; return to caller
#endif

#ifdef OR32
; ************************************************ 
; ***** 32-bit Or.  expr stack               ***** 
; ***** Numbers in memory stored LSB first   ***** 
; ************************************************ 
or32:       inc      r7                ; point to second number
            glo      r7                ; copy address to rf
            plo      rf
            ghi      r7
            phi      rf
            inc      rf                ; point rf to first number
            inc      rf
            inc      rf
            inc      rf
            sex      rf                ; point X to destination
            lda      r7                ; get byte 1
            or                         ; and with first number
            str      rf                ; store
            inc      rf                ; point to byte 2
            lda      r7                ; get byte 2
            or                         ; and with first number
            str      rf                ; store
            inc      rf                ; point to byte 3
            lda      r7                ; get byte 3
            or                         ; and with first number
            str      rf                ; store
            inc      rf                ; point to byte 4
            ldn      r7                ; get byte 7
            or                         ; and with first number
            str      rf                ; store
            sex      r2                ; Set x back to R2
            sep      sret              ; return to caller
#endif

#ifdef XOR32
; ************************************************ 
; ***** 32-bit Xor. expr stack               ***** 
; ***** Numbers in memory stored LSB first   ***** 
; ************************************************ 
xor32:      inc      r7                ; point to second number
            glo      r7                ; copy address to rf
            plo      rf
            ghi      r7
            phi      rf
            inc      rf                ; point rf to first number
            inc      rf
            inc      rf
            inc      rf
            sex      rf                ; point X to destination
            lda      r7                ; get byte 1
            xor                        ; and with first number
            str      rf                ; store
            inc      rf                ; point to byte 2
            lda      r7                ; get byte 2
            xor                        ; and with first number
            str      rf                ; store
            inc      rf                ; point to byte 3
            lda      r7                ; get byte 3
            xor                        ; and with first number
            str      rf                ; store
            inc      rf                ; point to byte 4
            ldn      r7                ; get byte 7
            xor                        ; and with first number
            str      rf                ; store
            sex      r2                ; Set x back to R2
            sep      sret              ; return to caller
#endif

#ifdef EQ32
#redefine CMP32
eq32:       sep      scall             ; compare numbers
            dw       cmp32
            lbnz     false32           ; fails if numbers were unequal
            lbr      true32            ; true if A=B
#endif

#ifdef NE32
#redefine CMP32
ne32:       sep      scall             ; compare numbers
            dw       cmp32
            lbz      false32           ; fails if numbers were equal
            lbr      true32            ; true if A<>B
#endif

#ifdef LT32
#redefine CMP32
lt32:       sep      scall             ; compare numbers
            dw       cmp32
            lbz      false32           ; fails if numbers were equal
            lbdf     true32            ; true if A<B
            lbr      false32           ; otherwise false
#endif

#ifdef GT32
#redefine CMP32
gt32:       sep      scall             ; compare numbers
            dw       cmp32
            lbz      false32           ; fails if numbers were equal
            lbnf     true32            ; true if A>B
            lbr      false32           ; otherwise false
#endif

#ifdef LTE32
#redefine CMP32
lte32:      sep      scall             ; compare numbers
            dw       cmp32
            lbz      true32            ; true if numbers were equal
            lbdf     true32            ; true if A<B
            lbr      false32           ; otherwise false
#endif

#ifdef GTE32
#redefine CMP32
gte32:      sep      scall             ; compare numbers
            dw       cmp32
            lbz      true32            ; true if numbers were equal
            lbnf     true32            ; true if A>B
            lbr      false32           ; otherwise false
#endif


#ifdef CMP32
#redefine COMP32
true32:     ldi     0ffh
            sex     r7
            stxd
            stxd
            stxd
            stxd
            sex     r2
            sep     sret

false32:    ldi     000h
            sex     r7
            stxd
            stxd
            stxd
            stxd
            sex     r2
            sep     sret

cmp32:      glo      r7                ; copy expr stack to rd
            plo      rd
            plo      rf
            ghi      r7
            phi      rd
            phi      rf
            inc      rd                ; point to lsb of second number
            inc      rf                ; point to lsb of first number
            inc      rf                ; point to lsb of first number
            inc      rf                ; point to lsb of first number
            inc      rf                ; point to lsb of first number
            inc      rf                ; point to lsb of first number
            sep      scall             ; compare numbers
            dw       comp32
            inc      r7                ; Remove numbers from stack
            inc      r7
            inc      r7
            inc      r7
            inc      r7
            inc      r7
            inc      r7
            inc      r7
            sep      sret              ; Return to caller
#endif

#ifdef COMP32
; ************************************************ 
; ***** 32-bit cmp.  M[RF]-M[RD]             ***** 
; ***** Numbers in memory stored LSB first   ***** 
; ***** Returns: D=0 if M[RF]=M[RD]          ***** 
; *****          DF=1 if M[RF]<M[RD]         ***** 
; ************************************************ 
comp32:     lda      rd                ; get lsb from second number
            str      r2                ; store for subtract
            lda      rf                ; get lsb from first number
            sm                         ; subtract
            plo      re                ; save as zero test
            lda      rd                ; get 2nd byte of second number
            str      r2                ; store for subtract
            lda      rf                ; get 2nd byte of first number
            smb                        ; perform subtraction
            str      r2                ; store for combining with zero test
            glo      re                ; get zero test
            or                         ; or last result
            plo      re                ; and put back
            lda      rd                ; get 3rd byte of second number
            str      r2                ; store for subtract
            lda      rf                ; get 3rd byte of first number
            smb                        ; perform subtraction
            str      r2                ; store for combining with zero test
            glo      re                ; get zero test
            or                         ; or last result
            plo      re                ; and put back
            ldn      rd                ; get msb of second number
            str      r2                ; store for subtract
            ldn      rf                ; get msb of first number
            smb                        ; perform subtraction
            str      r2                ; store for combining with zero test
            shl                        ; shift sign bit into df
            glo      re                ; get zero test
            or                         ; or last result
            dec      rf                ; restore registers
            dec      rf
            dec      rf
            dec      rd
            dec      rd
            dec      rd
            sep      sret              ; return to caller
#endif

#ifdef ABS32
abs32:      inc     r7
            inc     r7
            inc     r7
            inc     r7
            ldn     r7
            shl
            lbnf    absrt32
            dec     r7
            dec     r7
            dec     r7
            ldn     r7
            xri     0ffh
            adi     1
            str     r7
            inc     r7
            ldn     r7
            xri     0ffh
            adci    0
            str     r7
            inc     r7
            ldn     r7
            xri     0ffh
            adci    0
            str     r7
            inc     r7
            ldn     r7
            xri     0ffh
            adci    0
            str     r7
absrt32:    dec     r7
            dec     r7
            dec     r7
            dec     r7
            sep     sret
#endif

#ifdef SGN32
sgn32:      inc     r7
            lda     r7
            str     r2
            lda     r7
            or
            str     r2
            lda     r7
            or
            str     r2
            ldn     r7
            shl
            lbdf    sgnm32
            ldn     r7
            or
            lbz     sgn032
            ldi     0
            str     r7
            dec     r7
            str     r7
            dec     r7
            str     r7
            dec     r7
            ldi     1
            str     r7
            dec     r7
            sep     sret
sgnm32:     ldi     0ffh
            str     r7
            dec     r7
            str     r7
            dec     r7
            str     r7
            dec     r7
            str     r7
            dec     r7
            sep     sret
sgn032:     dec     r7
            dec     r7
            dec     r7
            dec     r7
            sep     sret
#endif

#ifdef ITOA32
; ***************************************** 
; ***** Convert RA:RB to bcd in M[RF] ***** 
; ***************************************** 
tobcd32:    glo     rf           ; transfer address to rc
            plo     rc
            ghi     rf
            phi     rc
            ldi     10           ; 10 bytes to clear
            plo     re
tobcd32lp1: ldi     0
            str     rc           ; store into answer
            inc     rc
            dec     re           ; decrement count
            glo     re           ; get count
            lbnz    tobcd32lp1   ; loop until done
            glo     rf           ; recover address
            plo     rc
            ghi     rf
            phi     rc
            ldi     32           ; 32 bits to process
            plo     r9
tobcd32lp2: ldi     10           ; need to process 5 cells
            plo     re           ; put into count
tobcd32lp3: ldn     rc           ; get byte
            smi     5            ; need to see if 5 or greater
            lbnf    tobcd32l3a   ; jump if not
            adi     8            ; add 3 to original number
            str     rc           ; and put it back
tobcd32l3a: inc     rc           ; point to next cell
            dec     re           ; decrement cell count
            glo     re           ; retrieve count
            lbnz    tobcd32lp3   ; loop back if not done
            glo     rb           ; start by shifting number to convert
            shl
            plo     rb
            ghi     rb
            shlc
            phi     rb
            glo     ra
            shlc
            plo     ra
            ghi     ra
            shlc
            phi     ra
            shlc                 ; now shift result to bit 3
            shl
            shl
            shl
            str     rc
            glo     rf           ; recover address
            plo     rc
            ghi     rf
            phi     rc
            ldi     10           ; 10 cells to process
            plo     re
tobcd32lp4: lda     rc           ; get current cell
            str     r2           ; save it
            ldn     rc           ; get next cell
            shr                  ; shift bit 3 into df
            shr
            shr
            shr
            ldn     r2           ; recover value for current cell
            shlc                 ; shift with new bit
            ani     0fh          ; keep only bottom 4 bits
            dec     rc           ; point back
            str     rc           ; store value
            inc     rc           ; and move to next cell
            dec     re           ; decrement count
            glo     re           ; see if done
            lbnz    tobcd32lp4   ; jump if not
            glo     rf           ; recover address
            plo     rc
            ghi     rf
            phi     rc
            dec     r9           ; decrement bit count
            glo     r9           ; see if done
            lbnz    tobcd32lp2   ; loop until done
            sep     sret         ; return to caller

; *************************************************** 
; ***** Convert 32-bit binary to ASCII          ***** 
; ***** RF - Pointer to 32-bit integer          ***** 
; ***** RD - destination buffer                 ***** 
; *************************************************** 
itoa32:     lda     rf           ; retrieve number into R7:R8
            plo     rb
            lda     rf
            phi     rb
            lda     rf
            plo     ra
            lda     rf
            phi     ra
            glo     r2           ; make room on stack for buffer
            smi     11
            plo     r2
            ghi     r2
            smbi    0
            phi     r2
            glo     r2           ; RF is output buffer
            plo     rf
            ghi     r2
            phi     rf
            inc     rf
            ghi     ra           ; get high byte
            shl                  ; shift bit to DF
            lbdf    itoa32n      ; negative number
itoa321:    sep     scall        ; convert to bcd
            dw      tobcd32
            glo     r2
            plo     rf
            ghi     r2
            phi     rf
            inc     rf
            ldi     10
            plo     rb
            ldi     9            ; max 9 leading zeros
            phi     rb
loop1:      lda     rf
            lbz     itoa32z      ; check leading zeros
            str     r2           ; save for a moment
            ldi     0            ; signal no more leading zeros
            phi     rb
            ldn     r2           ; recover character
itoa322:    adi     030h
            str     rd           ; store into output buffer
            inc     rd
itoa323:    dec     rb
            glo     rb
            lbnz    loop1
            glo     r2           ; pop work buffer off stack
            adi     11
            plo     r2
            ghi     r2
            adci    0
            phi     r2
            ldi     0            ; place terminator in destination
            str     rd
            sep     sret         ; return to caller
itoa32z:    ghi     rb           ; see if leading have been used up
            lbz     itoa322      ; jump if so
            smi     1            ; decrement count
            phi     rb
            lbr     itoa323      ; and loop for next character
itoa32n:    ldi     '-'          ; show negative
            str     rd           ; write to destination buffer
            inc     rd
            glo     rb           ; 2s compliment
            xri     0ffh
            adi     1
            plo     rb
            ghi     rb
            xri     0ffh
            adci    0
            phi     rb
            glo     ra
            xri     0ffh
            adci    0
            plo     ra
            ghi     ra
            xri     0ffh
            adci    0
            phi     ra
            lbr     itoa321        ; now convert/show number
#endif

#ifdef ATOI32
; **************************************************** 
; ***** Convert ascii to int32                   ***** 
; ***** RF - buffer to ascii                     ***** 
; ***** RD - destinatin int32                    ***** 
; ***** Returns R8:R9 result                     ***** 
; *****         RF - First non-numeric character ***** 
; **************************************************** 
atoi32:     ldi     0            ; zero result
            phi     r8
            plo     r8
            phi     r9
            plo     r9
            stxd                 ; store sign on stack
            ldn     rf           ; get byte from input
            smi     '-'          ; check for negative number
            lbnz    atoi32_lp    ; jump if not a negative number
            ldi     1            ; replace sign
            irx
            stxd
            inc     rf           ; move past sign
atoi32_lp:  ldn     rf           ; get byte from input
            smi     '0'          ; see if below digits
            lbnf    atoi32_dn    ; jump if not valid digit
            smi     10           ; check for high of range
            lbdf    atoi32_dn    ; jump if not valid digit
            glo     r9           ; multiply answer by 2
            shl
            plo     r9
            plo     rb           ; put a copy in RA:RB as well
            ghi     r9
            shlc
            phi     r9
            phi     rb
            glo     r8
            shlc
            plo     r8
            plo     ra
            ghi     r8
            shlc
            phi     r8
            phi     ra
            ldi     2            ; want to shift RA:RB twice
            plo     re
atoi32_1:   glo     rb           ; now shift RA:RB
            shl
            plo     rb
            ghi     rb
            shlc
            phi     rb
            glo     ra
            shlc
            plo     ra
            ghi     ra
            shlc
            phi     ra
            dec     re           ; decrement shift count
            glo     re           ; see if done
            lbnz    atoi32_1     ; shift again if not
            glo     rb           ; now add RA:RB to R8:R9
            str     r2
            glo     r9
            add
            plo     r9
            ghi     rb
            str     r2
            ghi     r9
            adc
            phi     r9
            glo     ra
            str     r2
            glo     r8
            adc
            plo     r8
            ghi     ra
            str     r2
            ghi     ra
            str     r2
            ghi     r8
            adc
            phi     r8
            lda     rf           ; get byte from input
            smi     '0'          ; conver to binary
            str     r2           ; and add it to R8:R9
            glo     r9
            add
            plo     r9
            ghi     r9
            adci    0
            phi     r9
            glo     r8
            adci    0
            plo     r8
            ghi     r8
            adci    0
            phi     r8
            lbr     atoi32_lp    ; loop back for more characters
atoi32_dn:  irx                  ; recover sign
            ldx
            shr                  ; shift into DF
            lbnf    atoi32_dn2   ; jump if not negative
            glo     r9           ; negate the number
            xri     0ffh
            adi     1
            plo     r9
            ghi     r9
            xri     0ffh
            adci    0
            phi     r9
            glo     r8
            xri     0ffh
            adci    0
            plo     r8
            ghi     r8
            xri     0ffh
            adci    0
            phi     r8
atoi32_dn2: ghi     r8           ; store result into destination
            str     rd
            inc     rd
            glo     r8
            str     rd
            inc     rd
            ghi     r9
            str     rd
            inc     rd
            glo     r9
            str     rd
            dec     rd           ; restore RD
            dec     rd
            dec     rd
            sep     sret         ; and return to caller
#endif

#ifdef NEXT32
nextvar32:  irx            ; move to varAddr
            ldxa           ; keep scall return address
            plo     rd
            ldxa
            phi     rd
            irx
            irx
            glo     rc     ; check for correct address
            sm             ; against stack
            lbnz    nv132  ; jump if not
            irx            ; move to msb
            ghi     rc
            sm             ; compare
            lbnz    nv232  ; jump if not
            dec     r2     ; entry found, move back
            dec     r2
            dec     r2
            dec     r2
            dec     r2
            dec     r2
            lbr     next32
nv132:      irx            ; move past bad entry
nv232:      irx            ; move past bad entry
            irx       
            irx       
            irx       
            irx       
            irx       
            irx       
            irx       
            ghi     rd
            stxd
            glo     rd
            stxd
            lbr     nextvar32

next32:     glo     r2
            plo     ra
            ghi     r2
            phi     ra
            sex     ra
            irx            ; return address lsb
            irx            ; return address msb
            irx            ; exec address lsb
            ldxa           ; retrieve exec address
            plo     r9
            ldxa
            phi     r9
            ldxa           ; get it
            plo     rf     ; set rf to address
            ldxa           ; get msb
            phi     rf
            inc     rf     ; point to variable lsb
            inc     rf     ; point to variable lsb
            inc     rf     ; point to variable lsb
            ldn     rf     ; retrieve it
            add            ; add in step
            str     rf
            dec     rf     ; point to byte2
            irx            ; point to byte2 of step
            ldn     rf     ; get byte2 of var value
            adc            ; add in step
            str     rf     ; store back into variable
            dec     rf     ; point to byte3
            irx            ; point to byte3 of step
            ldn     rf     ; get byte3 of var value
            adc            ; add in step
            dec     rf     ; point to byte4
            irx            ; point to byte4 of step
            ldn     rf     ; get byte3 of var value
            adc            ; add in step
            irx            ; point to loop count lsb
            ldi     1      ; need to decrement count
            sd             ; decrement it
            str     ra     ; and put it back
            irx            ; point to loop count byte2
            ldi     0      ; propagate carry
            sdb
            str     ra     ; and put it back
            irx            ; point to loop count byte3
            ldi     0      ; propagate carry
            sdb
            str     ra     ; and put it back
            irx            ; point to loop count byte4
            ldi     0      ; propagate carry
            sdb
            str     ra     ; and put it back
            sex     r2     ; point X back to R2
            lbdf    stay32 ; Jump if loop not done
            inc     r2
            dec     ra
            ldxa
            str     ra
            inc     ra
            ldx
            str     ra
            dec     ra
            dec     ra
            glo     ra
            plo     r2
            ghi     ra
            phi     r2
            sep     sret   ; nothing to do so return
stay32:     glo     r9     ; set return address to exec address
            plo     r6
            ghi     r9
            phi     r6
            sep     sret   ; and then return
#endif



/* *********************************************************************** */
/* *********************************************************************** */
/* *****                     String Library                          ***** */
/* *********************************************************************** */
/* *********************************************************************** */

#ifdef STRCPY
; *********************************** 
; ***** Copy string             ***** 
; ***** RD - destination string ***** 
; ***** RF - source string      ***** 
; *********************************** 
strcpy:     lda     rf           ; get byte from source string
            str     rd           ; store into destination
            inc     rd
            lbnz    strcpy       ; loop back until terminator copied
            sep     sret         ; return to caller
#endif

; ***********************************
; ***** Copy inline string      *****
; ***** RD - destination string ***** 
; ***** RF - source string      ***** 
; *********************************** 
#ifdef STRCPYIN
strcpyin:   lda     r6           ; get byte from source string
            str     rd           ; store into destination
            inc     rd
            lbnz    strcpyin     ; loop back until terminator copied
            sep     sret         ; return to caller
#endif

#ifdef STRCAT
; *********************************** 
; ***** Concatenate string      ***** 
; ***** RD - destination string ***** 
; ***** RF - source string      ***** 
; *********************************** 
strcat:     lda     rd           ; look for terminator
            lbnz    strcat       ; loop back until terminator found
            dec     rd           ; move back to terminator
            lbr     strcpy       ; and then copy source string to end
#endif

#ifdef STRLEN
; ********************************** 
; ***** String length          ***** 
; ***** RF - pointer to string ***** 
; ***** Returns: RC - length   ***** 
; ********************************** 
strlen:     ldi     0            ; set count to zero
            plo     rc
            phi     rc
strlen_1:   lda     rf           ; get byte from string
            lbz     strlen_2     ; jump if terminator found
            inc     rc           ; otherwise increment count
            lbr     strlen_1     ; and keep looking
strlen_2:   sep     sret         ; return to caller
#endif

#ifdef LEFT
; ***************************************** 
; ***** Left portion of string        ***** 
; ***** RF - pointer to source string ***** 
; ***** RD - pointer to destination   ***** 
; ***** RC - Count of characters      ***** 
; ***************************************** 
left:       glo     rc           ; see if characters left
            str     r2
            ghi     rc
            or
            lbz     left_dn      ; jump if not
            dec     rc           ; decrement count
            lda     rf           ; get byte from source
            str     rd           ; write into destination
            inc     rd
            lbnz    left_1       ; jump if terminator not found
left_rt:    sep     sret         ; otherwise return to caller
left_dn:    ldi     0            ; write terminator to destination
            str     rd
            lbr     left_rt      ; then return
#endif

#ifdef MID
; ***************************************** 
; ***** Middle portion of string      ***** 
; ***** RF - pointer to source string ***** 
; ***** RD - pointer to destination   ***** 
; ***** RB - Starting point           ***** 
; ***** RC - Count of characters      ***** 
; ***************************************** 
mid:        glo     rb           ; see if starting position found
            str     r2
            ghi     rc
            or
            lbz     mid_2        ; use left to copy characters
            dec     rb           ; decrement count
            lda     rf           ; get byte from source string
            lbz     mid_dn       ; jump if terminator found, will be empty destination
            lbr     mid_1        ; keep looping until start point
mid_dn:     ldi     0            ; write terminator to destination
            str     rd
            sep     sret         ; and return
mid_2:      sep     scall        ; call left to copy characters
            dw      left
            sep     sret         ; and return to caller
#endif

#ifdef RIGHT
; ***************************************** 
; ***** Right portion of string       ***** 
; ***** RF - pointer to source string ***** 
; ***** RD - pointer to destination   ***** 
; ***** RC - Count of characters      ***** 
; ***************************************** 
right:      ldi     0            ; zero counter
            plo     rb
            phi     rb
right_1:    lda     rf           ; get byte from source
            lbz     right_2      ; jump if terminator found
            inc     rb           ; increment length
            lbr     right_1      ; keep looking for terminator
right_2:    dec     rf           ; point back to previous character
            glo     rb           ; check RB counter
            str     r2
            ghi     rb
            or
            lbz     right_dn     ; start found, so now just copy
            glo     rc           ; check rc counter
            str     r2
            ghi     rc
            or
            lbz     right_dn     ; start found, so now just copy
            dec     rb           ; decrement counters
            dec     rc
            lbr     right_2      ; keep looking for start point
right_dn:   sep     scall        ; call strcpy to copy the string
            dw      strcpy
            sep     sret         ; and return
#endif

#ifdef LOWER
; *************************************** 
; ***** Convert string to lowercase ***** 
; ***** RF - Pointer to string      ***** 
; *************************************** 
lower:      ldn     rf           ; get byte from buffer
            lbz     return       ; jump if terminator found
            smi     'A'          ; Check for lower range
            lbnf    lowernxt     ; jump if below range
            smi     26           ; check for above range
            lbdf    lowernxt     ; jump if above range
            ldn     rf           ; get character
            adi     32           ; convert to lowercvase
            str     rf           ; and put it back
lowernxt:   inc     rf           ; point to next character
            lbr     lower        ; process rest of string
#endif

#ifdef UPPER
; *************************************** 
; ***** Convert string to uppercase ***** 
; ***** RF - Pointer to string      ***** 
; *************************************** 
upper:      ldn     rf           ; get byte from buffer
            lbz     return       ; jump if terminator found
            smi     'a'          ; Check for lower range
            lbnf    uppernxt     ; jump if below range
            smi     26           ; check for above range
            lbdf    uppernxt     ; jump if above range
            ldn     rf           ; get character
            smi     32           ; convert to lowercvase
            str     rf           ; and put it back
uppernxt:   inc     rf           ; point to next character
            lbr     upper_1      ; process rest of string
#endif

#ifdef STRCMP
; ********************************************* 
; ***** String compare                    ***** 
; ***** RF - string1                      ***** 
; ***** RD - string2                      ***** 
; ***** Returns: DF=0 - strings unequal   ***** 
; *****          DF=1 - strings equal     ***** 
; *****          D=1  - string1 > string2 ***** 
; *****          D=0  - string1 < string2 ***** 
; ********************************************* 
strcmp:     lda     rf           ; get byte from string1
            str     r2
            lbnz    strcmp_1     ; jump if terminator not found
            lda     rd           ; get byte from second string
            lbz     strcmp_eq    ; jump if strings are equal
            lbr     strcmp_lt    ; jump if string1 is smaller
strcmp_1:   lda     rd           ; get byte from second string
            lbz     strcmp_gt    ; jump if string2 is lower
            sd                   ; subtract from first string
            lbz     strcmp_2     ; loop to check remaining bytes
            lbdf    strcmp_gt    ; jump if
strcmp_lt:  ldi     0            ; signal string 1 is lower
            lbr     strcmp_rt
strcmp_eq:  ldi     1            ; signal strings equal
            lbr     strcmp_rt
strcmp_gt:  ldi     2            ; signal string 2 is lower
strcmp_rt:  shr
            sep     sret
#endif

#ifdef FILES

; ************************************
; ***** Check if at EOF for file *****
; ***** D - handle number        *****
; ***** Returns: D=0 - Not EOF   *****
; *****          D=0ff = at EOF  *****
; ************************************
eof:        smi     1            ; handle number minus 1
            shl                  ; handles are two bytes
            adi     file1_.0     ; add to file handle storage
            plo     rf
            ldi     file1_.1     ; propagate carry
            adci    0
            phi     rf
            lda     rf           ; retrieve FILDES address
            phi     rd
            ldn     rf
            adi     8            ; point to flags byte
            plo     rd
            ghi     rd           ; propage carry
            adci    0
            phi     rd           ; RD now points at flags
            ldn     rd           ; get flags
            ani     004h         ; check if in last lump
            lbz     eof_no       ; jump if not
            dec     rd           ; move to lsb of EOF
            ldn     rd           ; retrieve it
            plo     rf           ; put into rf
            dec     rd           ; point to msb of EOF
            ldn     rd           ; retrieve it
            ani     0fh          ; keep only low 4 bits
            phi     rf           ; RF now has EOF in lump
            dec     rd           ; move to LSB of offset
            dec     rd
            dec     rd
            ldn     rd           ; retrieve it
            str     r2           ; store for compare
            glo     rf           ; compare against EOF
            sm
            lbnz    eof_no       ; jump if no match
            dec     rd           ; move to next higher byte
            ldn     rd           ; and retrieve it
            ani     0fh          ; keep only bottom 4 bits
            str     r2           ; store for compare
            ghi     rf           ; get high byte of EOF
            sm                   ; and cmpare
            lbnz    eof_no       ; jump if not match
            ldi     0ffh         ; signal at EOF
            sep     sret         ; return to caller
eof_no:     ldi     0            ; signal not in eof
            sep     sret         ; and return

ioresults:  plo    re              ; save return code
            ldi    v_ioresult.1    ; point to ioresult variable
            phi    rf
            ldi    v_ioresult.0
            plo    rf
            ldi    0               ; set msb to zero
#ifdef use32bits
            str    rf              ; clear high word if 32 bits
            inc    rf
            str    rf
            inc    rf
#endif
            str    rf
            inc    rf
            glo    re              ; then set lsb to result code
            str    rf
            ldi    v_ioflag.1      ; point to ioflag variable
            phi    rf
            ldi    v_ioflag.0
            plo    rf
            ldi    0               ; clear msb of ioflag
#ifdef use32bits
            str    rf              ; clear high word if 32 bits
            inc    rf
            str    rf
            inc    rf
#endif
            str    rf
            inc    rf
            shlc                   ; set D to DF
            str    rf              ; and store into ioflag
            sep    sret            ; return to caller


#endif

#ifdef ISNUMERAL
isnumeral:  plo    re              ; keep a copy
            smi    '0'             ; check for below digits
            lbnf   isnum_no        ; jump if not a numeral
            smi    10              ; check high of range
            lbdf   isnum_no        ; jump if too high
            smi    0               ; set DF to indicate numeral
            glo    re              ; recover original
            sep    sret            ; and return
isnum_no:   adi    0               ; clear DF to indicate not numeral
            glo    re              ; recover original character
            sep    sret            ; and return to caller
#endif

#ifdef PUSHALL
pushall:    irx                    ; get top 2 values
            ldxa
            phi    rf
            ldx
            plo    rf
            ghi    r7              ; now push everything
            stxd
            glo    r7
            stxd
            ghi    r8
            stxd
            glo    r8
            stxd
            ghi    r9
            stxd
            glo    r9
            stxd
            ghi    ra
            stxd
            glo    ra
            stxd
            ghi    rb
            stxd
            glo    rb
            stxd
            ghi    rc
            stxd
            glo    rc
            stxd
            ghi    rd
            stxd
            glo    rd
            stxd
            glo    rf               ; put top 2 bytes back
            stxd
            ghi    rf
            stxd
            sep    sret             ; and return to caller
#endif

#ifdef POPALL
popall:     irx                     ; recover top 2 values
            ldxa
            phi    rf
            ldxa
            plo    rf
            ldxa                    ; recover everything else
            plo    rd
            ldxa
            phi    rd
            ldxa
            plo    rc
            ldxa
            phi    rc
            ldxa
            plo    rb
            ldxa
            phi    rb
            ldxa
            plo    ra
            ldxa
            phi    ra
            ldxa
            plo    r9
            ldxa
            phi    r9
            ldxa
            plo    r8
            ldxa
            phi    r8
            ldxa
            plo    r7
            ldx
            phi    r7
            glo    rf                ; put top 2 bytes back
            stxd
            ghi    rf
            stxd
            sep    sret              ; and return
#endif
