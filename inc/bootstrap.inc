DEF CGB = (CGB_FLAG & $80 == $80) && (CGB_FLAG & $0c == 0)

SECTION "Header", ROM0[$100]
	nop
	jp EntryPoint

	ds $143 - @, 0
	db CGB_FLAG
	ds $150 - @, 0

SECTION "Home", ROM0[$150]


