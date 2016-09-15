	.inesprg 1
	.ineschr 1
	.inesmap 0
	.inesmir 1

	.bank 0
	.org $C000
RESET:
	sei
	cld
	ldx #$40
	stx $4017
	ldx #$FF
	txs
	inx
	stx $2000
	stx $2001
	stx $4010
vblankwait1:
	bit $2002
	bpl vblankwait1
clrmem:
	lda #$00
	sta $0000, x
	sta $0100, x
	sta $0200, x
	sta $0400, x
	sta $0500, x
	sta $0600, x
	sta $0700, x
	lda #$FE
	sta $0300, x
	inx
	bne clrmem
vblankwait2:
	bit $2002
	bpl vblankwait2

	lda $2002
	lda #$3F
	sta $2006
	lda #$00
	sta $2006
	ldx #$00
LoadPalettesLoop:
	lda PaletteData, x
	sta $2007
	inx
	cpx #$20
	bne LoadPalettesLoop




LoadSprites:
	ldx #$00
LoadSpritesLoop:
	lda sprites, x
	sta $0200, x
	inx
	cpx #$10
	bne LoadSpritesLoop

LoadBackgrounds:
	lda $2002
	lda #$20
	sta $2006
	lda #$00
	sta $2006
	ldx #$00
LoadBackground1:
	lda background1, x
	sta $2007
	inx
	cpx #$00
	bne LoadBackground1
LoadBackground2:
	lda background2, x
	sta $2007
	inx
	cpx #$00
	bne LoadBackground2
LoadBackground3:
	lda background3, x
	sta $2007
	inx
	cpx #$00
	bne LoadBackground3
LoadBackground4:
	lda background4, x
	sta $2007
	inx
	cpx #$00
	bne LoadBackground4
LoadAttribute:
	lda $2002
	lda #$23
	sta $2006
	lda #$C0
	sta $2006
	ldx #$00
LoadAttributeLoop:
	lda attribute, x
	sta $2007
	inx
	cpx #$40
	bne LoadAttributeLoop


	lda #%10010000
	sta $2000
	lda #%00011110
	sta $2001
	lda #$00
	sta $2005
	sta $2005

NMI:

	lda #$00
	sta $2003
	lda #$02
	sta $4014

	lda #$01
	sta $4016
	lda #$00
	sta $4016
ReadA:
	lda $4016
	and #%00000001
	beq ReadADone
ReadADone:
ReadB:
	lda $4016
	and #%00000001
	beq ReadBDone
ReadBDone:
ReadSel:
	lda $4016
	and #%00000001
	beq ReadSelDone
ReadSelDone:
ReadStart:
	lda $4016
	and #%00000001
	beq ReadStartDone
ReadStartDone:
ReadUp:
	lda $4016
	and #%00000001
	beq ReadUpDone
	lda $0200
	sec
	sbc #$01
	sta $0200
	lda $0204
	sec
	sbc #$01
	sta $0204
	lda $0208
	sec
	sbc #$01
	sta $0208
	lda $020C
	sec
	sbc #$01
	sta $020C
ReadUpDone:
ReadDown:
	lda $4016
	and #%00000001
	beq ReadDownDone
	lda $0200
	clc
	adc #$01
	sta $0200
	lda $0204
	clc
	adc #$01
	sta $0204
	lda $0208
	clc
	adc #$01
	sta $0208
	lda $020C
	clc
	adc #$01
	sta $020C
ReadDownDone:
ReadLeft:
	lda $4016
	and #%00000001
	beq ReadLeftDone
	lda $0203
	sec
	sbc #$01
	sta $0203
	lda $0207
	sec
	sbc #$01
	sta $0207
	lda $020B
	sec
	sbc #$01
	sta $020B
	lda $020F
	sec
	sbc #$01
	sta $020F
ReadLeftDone:
ReadRight:
	lda $4016
	and #%00000001
	beq ReadRightDone
	lda $0203
	clc
	adc #$01
	sta $0203
	lda $0207
	clc
	adc #$01
	sta $0207
	lda $020B
	clc
	adc #$01
	sta $020B
	lda $020F
	clc
	adc #$01
	sta $020F
ReadRightDone:
	lda #%10010000
	sta $2000
	lda #%00011110
	sta $2001
	lda #$00
	sta $2005
	sta $2005


	rti
	.bank 1
	.org $E000

PaletteData:
	.db $3B,$15,$25,$27,$3B,$19,$29,$39,$3B,$11,$21,$31,$3B,$17,$27,$37
	.db $3B,$15,$25,$27,$3B,$19,$29,$39,$3B,$11,$21,$31,$3B,$17,$27,$37





sprites:
	.db $80, $08, $0, $80
	.db $80, $09, $0, $88
	.db $88, $18, $0, $80
	.db $88, $19, $0, $88



background1:
	.db $04,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $00,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$00
	.db $04,$00,$04,$04,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$00,$00,$00
	.db $04,$00,$04,$00,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$00,$00,$04,$00,$04
	.db $04,$00,$00,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$00,$04,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$04,$00,$04,$00,$00,$00,$04,$04,$00,$04,$04,$00,$04,$04,$04
	.db $00,$00,$00,$04,$00,$04,$00,$00,$00,$04,$04,$04,$04,$04,$04,$04
	.db $04,$04,$00,$04,$04,$04,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$ff,$00,$00,$00,$04,$00,$04,$04,$04,$04,$04,$04,$04
	.db $04,$04,$00,$04,$04,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
background2:
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$05,$06,$07,$08,$09,$0a
	.db $0b,$0c,$0d,$0e,$0f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$04,$04,$04,$00,$00,$14,$15,$16,$17,$18,$19,$1a
	.db $1b,$1c,$1d,$1e,$1f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$24,$25,$26,$27,$28,$29,$2a
	.db $2b,$2c,$2d,$2e,$2f,$00,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$04,$04,$00,$00,$00,$00,$00,$00,$34,$35,$36,$37,$38,$39,$3a
	.db $3b,$3c,$3d,$3e,$3f,$04,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$04,$04,$04,$00,$00,$00,$00,$00,$44,$45,$46,$47,$48,$49,$4a
	.db $4b,$4c,$4d,$4e,$4f,$00,$00,$00,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$04,$00,$00,$00,$00,$00,$00,$00,$54,$55,$56,$57,$58,$59,$5a
	.db $5b,$5c,$5d,$5e,$5f,$00,$00,$00,$00,$04,$04,$04,$04,$04,$04,$04
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$64,$65,$66,$67,$68,$69,$6a
	.db $6b,$6c,$6d,$6e,$6f,$00,$04,$04,$00,$04,$04,$04,$04,$04,$04,$04
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$74,$75,$76,$77,$78,$79,$7a
background3:
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$84,$85,$86,$87,$88,$89,$8a
	.db $8b,$8c,$8d,$8e,$8f,$00,$00,$00,$00,$00,$04,$04,$04,$04,$04,$04
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$94,$95,$96,$97,$98,$99,$9a
	.db $9b,$9c,$9d,$9e,$9f,$00,$00,$00,$00,$00,$00,$04,$04,$04,$04,$04
	.db $04,$04,$00,$04,$00,$04,$00,$00,$00,$a4,$a5,$a6,$a7,$a8,$a9,$aa
	.db $ab,$ac,$ad,$ae,$af,$00,$00,$00,$00,$00,$00,$04,$04,$04,$04,$04
	.db $04,$04,$00,$04,$04,$04,$00,$00,$00,$b4,$b5,$b6,$b7,$b8,$b9,$ba
	.db $bb,$bc,$bd,$be,$bf,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$73,$74
	.db $00,$00,$00,$00,$04,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$82,$83,$84
	.db $00,$00,$00,$00,$00,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$04,$00,$04,$00,$00,$00,$04,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
background4:
	.db $04,$04,$00,$00,$00,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$04
	.db $04,$04,$00,$04,$04,$04,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $04,$04,$00,$04,$04,$04,$04,$04,$04,$04,$00,$04,$04,$04,$04,$04
	.db $00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$04,$00,$04,$04,$04,$04,$04,$04,$00,$04,$04,$04,$04,$04,$04
	.db $00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$04,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.db $04,$04,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$00
	.db $04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
attribute:
	.db %00010011, %00010111, %01010101, %00010001, %00010001, %00010001, %00010001, %01110111
	.db %00010001, %00010001, %01010101, %00010001, %00010001, %00010001, %00010001, %01110111
	.db %00010001, %00010001, %01010101, %00010001, %00010001, %00010001, %00010001, %01110111
	.db %00010001, %00010001, %01010101, %00010001, %00010001, %00010001, %00010001, %01110111
	.db %00010001, %00010001, %01010101, %00010001, %00010001, %00010001, %00010001, %01110111
	.db %00010001, %00010001, %01010101, %00010001, %00010001, %00010001, %00010001, %01110111
	.db %00010001, %00010001, %01010101, %00010001, %00010001, %00010001, %00010001, %01110111
	.db %00010001, %00010001, %01010101, %00010001, %00010001, %00010001, %00010001, %01110111

	.org $FFFA

	.dw NMI
	.dw RESET
	.dw 0

	.bank 2
	.org $0000
	.incbin "./tiles.chr"
