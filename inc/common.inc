SECTION "Header", ROM0[$100]
    nop
	jp EntryPoint

	ds $150 - @, 0 ; Make room for the header

SECTION "Home", ROM0[$150]


