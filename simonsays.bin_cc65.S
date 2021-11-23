; Target assembler: cc65 v2.18.0 [--target none -C simonsays.bin_cc65.cfg]
;***************************************
;* MatchThis-for-KIM-1                 *
;*                                     *
;*     by Gino F. Silvestri            *
;*     Engeneering Division            *
;*     Loral Electronic Systems        *
;*     999 Central Park Avenue         *
;*     Yonkers, NY 10704               *
;***************************************
         .setcpu "6502"
PA0write =       $1700
PA0open  =       $1701
Timer1   =       $1704
TIMstart =       $1706
Timer    =       $1707
CHAR     =       $1740
DDR      =       $1741
C_POSITION =     $1742
KIMSCANDS =      $1f1f
KEYDOW_KIM =     $1f40
GETKEY   =       $1f6a

         .org    $0200
START:   cld
         ldx     #$07
MOVE:    lda     initdata,x
         sta     $d5,x
         dex
         bpl     MOVE
         lda     Timer1
         and     #$03
         sta     $00
         jsr     DELAY
PLAY1:   jsr     SOUNDIS
PLAY2:   lda     $dc
         bne     TEST2
         lda     $d6
         cmp     $d7
         beq     TEST1
         inc     $d6
         lda     #$00
         sta     $dc
         jsr     DELAY
         sec
         bcs     PLAY1

TEST1:   lda     #$00
         sta     $d6
TEST2:   lda     #$01
         sta     $d6
KEYIN:   lda     #$00
         sta     DDR
         lda     Timer1
         and     #$03
         sta     $dd
         jsr     GETKEY
         cmp     #$15
         beq     KEYIN
         cmp     #$13
         beq     START
         ldx     $d6
         cmp     $00,x
         beq     INCREMENT
         clc
         adc     #$fc
         bcs     KEYIN
ERROR:   lda     #$00
         sta     $de
         lda     #$f9
         sta     CHAR
         lda     #$09
         sta     C_POSITION
         ldy     #$04
         jsr     TONE
SHOWLOSS:
         jsr     SCORDIS
         lda     $de
         bne     ERREND
         dec     $d5
         beq     LOSE
         inc     $de
         bne     SHOWLOSS
ERREND:  jsr     DELAY
         lda     #$00
         sta     $d6
         sta     $dc
         jmp     PLAY1

INCREMENT:
         jsr     SOUNDIS
KEYDOWN: jsr     KEYDOW_KIM
         bne     KEYDOWN
         lda     $d7
         cmp     $d6
         beq     INCEND
         inc     $d6
         jmp     PLAY2

INCEND:  inc     $d7
         lda     #$00
         sta     $de
         jsr     SCORDIS
         lda     $de
         bne     ONWARDS
         sed
         clc
         lda     #$01
         adc     $d8
         sta     $d8
         cld
         lda     #$01
         sta     $de
         jsr     SCORDIS
ONWARDS: ldx     #$02
BONUCHEK:
         lda     $d9,x
         cmp     $d8
         beq     BONUMET
         dex
         bpl     BONUCHEK
         bmi     EXITINC

BONUMET: lda     #$ff
         sta     $d9,x
         inc     $d5
EXITINC: ldx     $d7
         lda     $dd
         sta     $00,x
         lda     #$00
         sta     $dc
         sta     $d6
         jmp     PLAY1

LOSE:    lda     #$b8
         sta     CHAR
         lda     #$0f
         sta     C_POSITION
         ldy     #$05
         jsr     TONE
         jsr     SCORDIS
         jsr     GETKEY
         cmp     #$13
         bne     LOSE
         jmp     START

SCORDIS: lda     $d5
         ora     #$b0
         sta     $fb
         lda     #$c0
         sta     $fa
         lda     $d8
         sta     $f9
         lda     #$ff
         sta     $d3
SCANDS:  jsr     KIMSCANDS
         dec     $d3
         bne     SCANDS
         rts

SOUNDIS: ldx     $d6
         ldy     $00,x
         lda     $1fe7,y
         sta     CHAR
         lda     POSDATA,y
         sta     C_POSITION
TONE:    ldx     TIMEDATA,y
         stx     $d4
         lda     #$7f
         sta     DDR
         lda     #$01
         sta     PA0open
REPEAT:  sta     PA0write
         ldx     TONEDATA,y
         stx     TIMstart
BIT1:    bit     Timer
         bpl     BIT1
         eor     #$01
         dec     $d4
         bne     REPEAT
         lda     #$00
         sta     PA0open
         sta     CHAR
         rts

DELAY:   lda     #$ff
         sta     Timer
BIT2:    bit     Timer
         bpl     BIT2
         rts

initdata:
         .byte   $06
         .byte   $00
         .byte   $00
         .byte   $00
         .byte   $06
         .byte   $15
         .byte   $25
         .byte   $00
POSDATA: .byte   $09
         .byte   $0b
         .byte   $0d
         .byte   $0f
TONEDATA:
         .byte   $88
         .byte   $35
         .byte   $18
         .byte   $11
         .byte   $b0
         .byte   $c0
TIMEDATA:
         .byte   $20
         .byte   $50
         .byte   $b0
         .byte   $ff
         .byte   $80
         .byte   $55
         .byte   $00
