INCLUDE "header.asm"

NewsRootScreen: ; $0006
	screenconfig
	db MUSIC_PROF_ELM ; music

	db $00 ; number of custom palettes
;	dw $0000 ; custom palette color 1
;	dw $0000 ; custom palette color 2
;	dw $0000 ; custom palette color 3
;	dw $0000 ; custom palette color 4
	
	db $02 ; number of boxes to draw
	db $00 ; x ; first box
	db $03 ; y
	db $14 ; width
	db $0A ; height
	db $01 ; border type
	db $03 ; palette
	db $00 ; x ; second box
	db $0C ; y
	db $14 ; width
	db $06 ; height
	db $02 ; border type
	db $04 ; palette
	
	db $01 ; number of strings to draw
	dw $0029 ; offset into screen buffer
	db "NOTIZIE PKMN Nº1@" ; string
	
	db $02, $05 ; menu x, y
	db $01, $04 ; number of columns, rows
	db $00, $02 ; column width, row height
	db $12, $04, $07, $04, $02, $04 ; ?
	
	relativepointer .aButton ; script pointer a button
	relativepointer .bButton ; script pointer b button
	dw $FFFF ; script pointer select button
	dw $FFFF ; script pointer start button
	dw $FFFF ; script pointer left button
	dw $FFFF ; script pointer right button
	relativepointer .upButton ; script pointer up button
	relativepointer .downButton ; script pointer down button
	
	db $04 ; number of menu items
	dw $0119 ; screen buffer offset to print menu descriptions
	db $12, $04 ; width, height of blanked area
	
	db $00 ; load rankings table flag (table number should be specfied in 0:CD62)
	
	relativepointer .menuItemNewsGuideText ; pointers to text for each menu item
	relativepointer .menuItemTrainerRankingsText
	relativepointer .menuItemPokemonQuizText
	relativepointer .menuItemQuitText
	
	relativepointer .menuItemNewsGuideScript ; pointers to script for each menu item
	relativepointer .menuItemTrainerRankingsScript
	relativepointer .menuItemPokemonQuizScript
	relativepointer .menuItemQuitScript
	
	relativepointer .menuItemNewsGuideDescription ; pointers to description text for each menu item
	relativepointer .menuItemTrainerRankingsDescription
	relativepointer .menuItemPokemonQuizDescription
	relativepointer .menuItemQuitDescription

.aButton
	playsound SFX_READ_TEXT
	menuscript
	end

.bButton
	playsound SFX_MENU
	exit
	end

.upButton
	menuup
	end

.downButton
	menudown
	end

.menuItemNewsGuideText
	db "GUIDA NOTIZIE@"

.menuItemTrainerRankingsText
	db "CLASSIFICA ALLEN.@"

.menuItemPokemonQuizText
	db "QUIZ #FANATICO@"

.menuItemQuitText
	db "ESCI@"

.menuItemNewsGuideScript
	cleartext $0105, $12, $04
	printtext $0119, .newsGuideText
	menureturn
	end

.menuItemTrainerRankingsScript
	loadscreen TrainerRankingsScreen
	end

.menuItemPokemonQuizScript
	setval wQuizQuestionNo, $00
	setval wQuizScore, $00
	loadscreen PokemonQuizScreen
	end

.menuItemQuitScript
	exit
	end

.newsGuideText
	text "Ci auguriamo che"
	line "la CLASSIFICA"
	para "ALLENATORI e il"
	line "QUIZ #MANIA"
	para "nella prima"
	line "edizione ti"
	cont "piacciano."

	para "Puoi aggiornare"
	line "la classifica"
	cont "quando vuoi."

	para "Se lavori sodo,"
	line "raggiungerai la"
	cont "vetta!"
	done

.menuItemNewsGuideDescription
	db   "Leggi la spiegazi-"
	line "one delle NOTIZIE.@"

.menuItemTrainerRankingsDescription
	db   "Classifiche allen-"
	line "atore a tema.@"

.menuItemPokemonQuizDescription
	db   "Quiz dei ricordi"
	line "sull'avventura!@"

.menuItemQuitDescription
	db   "Stop lettura"
	line "NOTIZIE.@"


PokemonQuizScreen: ; $0172
	screenconfig
	db MUSIC_GAME_CORNER ; music

	db $00 ; number of custom palettes

	db $01 ; number of boxes to draw
	db $00 ; x
	db $0E ; y
	db $14 ; width
	db $04 ; height
	db $02 ; border type
	db $04 ; palette
	
	db $01 ; number of strings to draw
	dw $0029 ; offset into screen buffer
	news_text_start
	news_text_switch 10, wQuizQuestionNo, \
		.question1Text, \
		.question2Text, \
		.question3Text, \
		.question4Text, \
		.question5Text, \
		.question6Text, \
		.question7Text, \
		.question8Text, \
		.question9Text, \
		.question10Text
	db "@"
	
	db $02, $10 ; menu x, y
	db $04, $01 ; number of columns, rows
	db $04, $02 ; column width, row height
	db $01, $00, $00, $00, $00, $04 ; ?
	
	relativepointer .aButton ; script pointer a button
	relativepointer .bButton ; script pointer b button
	dw $FFFF ; script pointer select button
	relativepointer .bButton ; script pointer start button
	relativepointer .leftButton ; script pointer left button
	relativepointer .rightButton ; script pointer right button
	dw $FFFF ; script pointer up button
	dw $FFFF ; script pointer down button
	
	db $04 ; number of menu items
	dw $0119 ; screen buffer offset to print menu descriptions
	db $12, $04 ; width, height of blanked area
	
	db $00 ; load rankings table flag (table number should be specfied in 0:CD62)
	
	relativepointer .menuItemAnswer1Text ; pointers to text for each menu item
	relativepointer .menuItemAnswer2Text
	relativepointer .menuItemAnswer3Text
	relativepointer .menuItemQuitText
	
	relativepointer .menuItemAnswer1Script ; pointers to script for each menu item
	relativepointer .menuItemAnswer2Script
	relativepointer .menuItemAnswer3Script
	relativepointer .menuItemQuitScript
	
	relativepointer .dummyDescription ; pointers to description text for each menu item
	relativepointer .dummyDescription
	relativepointer .dummyDescription
	relativepointer .dummyDescription

.aButton
	playsound SFX_READ_TEXT
	menuscript
	end

.leftButton
	menuleft
	end

.rightButton
	menuright
	end

.bButton
	playsound SFX_MENU
	loadscreen NewsRootScreen
	end

.menuItemAnswer1Text
	db "1. @"

.menuItemAnswer2Text
	db "2. @"

.menuItemAnswer3Text
	db "3. @"

.menuItemQuitText
	db "ESCI@"

.menuItemAnswer1Script
	incval wQuizQuestionNo, $01
	cmpval wQuizQuestionNo, .answer1notquestion1, .answer1question1, .answer1notquestion1, $01, $01

.answer1question1
	incval wQuizScore, $01
	loadscreen PokemonQuizScreen
	end

.answer1notquestion1
	cmpval wQuizQuestionNo, .answer1notquestion2, .answer1question2, .answer1notquestion2, $01, $02

.answer1question2
	loadscreen PokemonQuizScreen
	end

.answer1notquestion2
	cmpval wQuizQuestionNo, .answer1notquestion3, .answer1question3, .answer1notquestion3, $01, $03

.answer1question3
	incval wQuizScore, $03
	loadscreen PokemonQuizScreen
	end

.answer1notquestion3
	cmpval wQuizQuestionNo, .answer1notquestion4, .answer1question4, .answer1notquestion4, $01, $04

.answer1question4
	incval wQuizScore, $01
	loadscreen PokemonQuizScreen
	end

.answer1notquestion4
	cmpval wQuizQuestionNo, .answer1notquestion5, .answer1question5, .answer1notquestion5, $01, $05

.answer1question5
	loadscreen PokemonQuizScreen
	end

.answer1notquestion5
	cmpval wQuizQuestionNo, .answer1notquestion6, .answer1question6, .answer1notquestion6, $01, $06

.answer1question6
	loadscreen PokemonQuizScreen
	end

.answer1notquestion6
	cmpval wQuizQuestionNo, .answer1notquestion7, .answer1question7, .answer1notquestion7, $01, $07

.answer1question7
	loadscreen PokemonQuizScreen
	end

.answer1notquestion7
	cmpval wQuizQuestionNo, .answer1notquestion8, .answer1question8, .answer1notquestion8, $01, $08

.answer1question8
	incval wQuizScore, $03
	loadscreen PokemonQuizScreen
	end

.answer1notquestion8
	cmpval wQuizQuestionNo, .answer1notquestion9, .answer1question9, .answer1notquestion9, $01, $09

.answer1question9
	loadscreen PokemonQuizScreen
	end

.answer1notquestion9
	cmpval wQuizQuestionNo, .answer1notquestion10, .answer1question10, .answer1notquestion10, $01, $0A

.answer1question10
	loadscreen QuizScoreEvaluationScreen
	end

.answer1notquestion10
	end


.menuItemAnswer2Script
	incval wQuizQuestionNo, $01
	cmpval wQuizQuestionNo, .answer2notquestion1, .answer2question1, .answer2notquestion1, $01, $01
	
.answer2question1
	loadscreen PokemonQuizScreen
	end
	
.answer2notquestion1
	cmpval wQuizQuestionNo, .answer2notquestion2, .answer2question2, .answer2notquestion2, $01, $02
	
.answer2question2
	loadscreen PokemonQuizScreen
	end
	
.answer2notquestion2
	cmpval wQuizQuestionNo, .answer2notquestion3, .answer2question3, .answer2notquestion3, $01, $03

.answer2question3
	loadscreen PokemonQuizScreen
	end

.answer2notquestion3
	cmpval wQuizQuestionNo, .answer2notquestion4, .answer2question4, .answer2notquestion4, $01, $04
	
.answer2question4
	loadscreen PokemonQuizScreen
	end

.answer2notquestion4
	cmpval wQuizQuestionNo, .answer2notquestion5, .answer2question5, .answer2notquestion5, $01, $05
	
.answer2question5
	loadscreen PokemonQuizScreen
	end

.answer2notquestion5
	cmpval wQuizQuestionNo, .answer2notquestion6, .answer2question6, .answer2notquestion6, $01, $06
	
.answer2question6
	incval wQuizScore, $01
	loadscreen PokemonQuizScreen
	end

.answer2notquestion6
	cmpval wQuizQuestionNo, .answer2notquestion7, .answer2question7, .answer2notquestion7, $01, $07
	
.answer2question7
	incval wQuizScore, $02
	loadscreen PokemonQuizScreen
	end

.answer2notquestion7
	cmpval wQuizQuestionNo, .answer2notquestion8, .answer2question8, .answer2notquestion8, $01, $08

.answer2question8
	loadscreen PokemonQuizScreen
	end

.answer2notquestion8
	cmpval wQuizQuestionNo, .answer2notquestion9, .answer2question9, .answer2notquestion9, $01, $09

.answer2question9
	incval wQuizScore, $02
	loadscreen PokemonQuizScreen
	end

.answer2notquestion9
	cmpval wQuizQuestionNo, .answer2notquestion10, .answer2question10, .answer2notquestion10, $01, $0A

.answer2question10
	incval wQuizScore, $02
	loadscreen QuizScoreEvaluationScreen
	end

.answer2notquestion10
	end


.menuItemAnswer3Script
	incval wQuizQuestionNo, $01
	cmpval wQuizQuestionNo, .answer3notquestion1, .answer3question1, .answer3notquestion1, $01, $01
	
.answer3question1
	loadscreen PokemonQuizScreen
	end
	
.answer3notquestion1
	cmpval wQuizQuestionNo, .answer3notquestion2, .answer3question2, .answer3notquestion2, $01, $02
	
.answer3question2
	incval wQuizScore, $02
	loadscreen PokemonQuizScreen
	end
	
.answer3notquestion2
	cmpval wQuizQuestionNo, .answer3notquestion3, .answer3question3, .answer3notquestion3, $01, $03

.answer3question3
	loadscreen PokemonQuizScreen
	end

.answer3notquestion3
	cmpval wQuizQuestionNo, .answer3notquestion4, .answer3question4, .answer3notquestion4, $01, $04
	
.answer3question4
	loadscreen PokemonQuizScreen
	end

.answer3notquestion4
	cmpval wQuizQuestionNo, .answer3notquestion5, .answer3question5, .answer3notquestion5, $01, $05
	
.answer3question5
	incval wQuizScore, $03
	loadscreen PokemonQuizScreen
	end

.answer3notquestion5
	cmpval wQuizQuestionNo, .answer3notquestion6, .answer3question6, .answer3notquestion6, $01, $06
	
.answer3question6
	loadscreen PokemonQuizScreen
	end

.answer3notquestion6
	cmpval wQuizQuestionNo, .answer3notquestion7, .answer3question7, .answer3notquestion7, $01, $07
	
.answer3question7
	loadscreen PokemonQuizScreen
	end

.answer3notquestion7
	cmpval wQuizQuestionNo, .answer3notquestion8, .answer3question8, .answer3notquestion8, $01, $08

.answer3question8
	loadscreen PokemonQuizScreen
	end

.answer3notquestion8
	cmpval wQuizQuestionNo, .answer3notquestion9, .answer3question9, .answer3notquestion9, $01, $09

.answer3question9
	loadscreen PokemonQuizScreen
	end

.answer3notquestion9
	cmpval wQuizQuestionNo, .answer3notquestion10, .answer3question10, .answer3notquestion10, $01, $0A

.answer3question10
	loadscreen QuizScoreEvaluationScreen
	end

.answer3notquestion10
	end


.menuItemQuitScript
	playsound SFX_MENU
	loadscreen NewsRootScreen
	end
	
.dummyDescription
	db "@"
	
.question1Text
	db   "Chi c'era nella"
    next "#BALL centrale"
    next "dal PROF.ELM?"
    next "1. TOTODILE"
    next "2. CYNDAQUIL"
    next "3. CHIKORITA"
    next "@"
    
.question2Text
    db   "Cosa c'è nel"
    next "cestino vicino" 
    next "al PROF. ELM?"
    next "1. AVANZI"
    next "2. BOTTIGLIA VUOTA"
    next "3. CARTA SNACK"
    next "@"
    
.question3Text
    db   "Quante POZIONI"
    next "aveva nello ZAINO"
    next "l'AMICO che ti ha"
    next "ha insegnato a"
    next "catturare #MON?"
    next "1. 1  2. 2  3. 3"
    next "@"
    
.question4Text
    db   "La specialità di"
    next "MAMMA è … DELL'"
    next "ISOLA CANNELLA?"
    next "1. MINESTRONE"
    next "2. CURRY"
    next "3. NOODLE"
    next "@"
    
.question5Text
    db   "Quante volte gira"
    next "PRIMO da quando"
    next "gli parli a quando"
    next "va nell'ACCADEMIA?"
    next "1. 5  2. 6  3. 7"
    next "@"
    
.question6Text
    db   "Quale oggetto"
    next "non è nella"
    next "GROTTA DI MEZZO?"
    next "1. X ATTACCO"
    next "2. ANTIPARALISI"
    next "3. POZIONE"
    next "@"
	
.question7Text
	db   "Qual è il numero"
	next "minimo di volte in"
	next "cui devi parlare"
	next "a FARFETCH'D per"
	next "acchiapparlo?"
	next "1. 3  2. 4  3. 5"
	next "@"
	
.question8Text
	db   "Quanti SLOWPOKE"
	next "c'erano nella"
	next "grotta al POZZO"
	next "SLOWPOKE quando"
	next "li hai salvati?"
	next "1. 2  2. 3  3. 4"
	next "@"
	
.question9Text
	db   "A che fermata è il"
	next "mare durante il"
	next "tour della GUIDA"
	next "di FIORPESCOPOLI?"
	next "1. 3º  2. 4º "
	next "3. 5º"
	next "@"
	
.question10Text
	db   "Quale oggetto"
	next "non è nella CASA"
	next "di MR. #MON?"
	next "1. GETTONE"
	next "2. FRANCOBOLLO"
	next "3. RIVISTA"
	next "@"


QuizScoreEvaluationScreen: ; $0677
	screenconfig
	db MUSIC_POKEMON_TALK ; music
	
	db $00 ; number of custom palettes
	
	db $01 ; number of boxes to draw
	db $00 ; x
	db $0C ; y
	db $14 ; width
	db $06 ; height
	db $02 ; border type
	db $04 ; palette
	
	db $01 ; number of strings to draw
	db $00, $00 ; offset into screen buffer
	db "@" ; string
	
	db $03, $0A ; menu x, y ; $04, $0A ; Needs to be updated with PROF.OAK's REPORT
	db $01, $01 ; number of columns, rows
	db $00, $00 ; column width, row height
	db $02, $00, $00, $00, $02, $01 ; $03, $00, $00, $00, $02, $01 PROF OAK's REPORT location
	
	relativepointer .aButton ; script pointer a button
	relativepointer .aButton ; script pointer b button
	dw $FFFF ; script pointer select button
	relativepointer .aButton ; script pointer start button
	dw $FFFF ; script pointer left button
	dw $FFFF ; script pointer right button
	dw $FFFF ; script pointer up button
	dw $FFFF ; script pointer down button
	
	db $01 ; number of menu items
	dw $0119 ; screen buffer offset to print menu descriptions
	db $12, $04 ; width, height of blanked area
	
	db $00 ; load rankings table flag (table number should be specfied in 0:CD62)
	
	relativepointer .menuItemText ; pointers to text for each menu item
	
	relativepointer .menuItemScript ; pointers to script for each menu item
	
	relativepointer .menuItemDescription ; pointers to description text for each menu item
	
.aButton
	playsound SFX_READ_TEXT
	cleartext $0105, $12, $04
	trainersprite $002E, POKEMON_PROF, $07
	menuscript
	menureturn
	loadscreen NewsRootScreen
	end
	
.menuItemText
	db "RAPPORTO DI OAK@"
	
.menuItemScript
	cmpval wQuizScore, .scorelow, .scorelow, .greater, $01, $05
	
.scorelow
	printtext $0119, .textScoreLow
	playsound SFX_DEX_FANFARE_LESS_THAN_20
	end
	
.greater
	cmpval wQuizScore, .scoreaverage, .scoreaverage, .greater2, $01, $0A
	
.scoreaverage
	printtext $0119, .textScoreAverage
	playsound SFX_DEX_FANFARE_140_169
	end

.greater2
	cmpval wQuizScore, .scoregood, .scoregood, .greater3, $01, $0F

.scoregood
	printtext $0119, .textScoreGood
	playsound SFX_DEX_FANFARE_170_199
	end

.greater3
	cmpval wQuizScore, .scoregreat, .scoregreat, .greater4, $01, $13

.scoregreat
	printtext $0119, .textScoreGreat
	playsound SFX_DEX_FANFARE_200_229
	end

.greater4
	cmpval wQuizScore, .scorebest, .scorebest, .scoreoutofbounds, $01, $14

.scorebest
	printtext $0119, .textScoreBest
	playsound SFX_DEX_FANFARE_230_PLUS
	end

.scoreoutofbounds
	end

.menuItemDescription
	db   "Fai il quiz per"
	line "una valutazione!@"

.textScoreLow
	text "Imparare a memoria"
	line "non basta."

	para "I #FANATICI"
	line "memorizzano cose"
	para "che non hanno"
	line "nemmeno bisogno"
	cont "di ricordare!"
	done

.textScoreAverage
	text "Hai ancora"
	line "molto da fare."

	para "I #FANATICI"
	line "hanno molta più"
	cont "passione!"

	para "Assicurati di"
	line "guardare in ogni"
	cont "angolo!"
	done

.textScoreGood
	text "Ti impegni, si"
	line "vede."
	
	para "Stai tentando"
	line "di diventare un"
	cont "#FANATICO."

	para "Stai parlando"
	line "coi tuoi amici?"

	para "È dura farcela"
	line "da soli!"
	done

.textScoreGreat
	text "Eccellente! Ti"
	line "piace proprio"
	
	para "ficcare il naso"
	line "dappertutto!"
	done

.textScoreBest
	text "Ma questo è un"
	line "#FANATICO"
	cont "perfetto!"

	para "È sempre stato il"
	line "mio sogno."
	cont "Complimenti!"
	done


TrainerRankingsScreen: ; $0857
	screenconfig
	db MUSIC_PROF_ELM ; music
	
	db $00 ; number of custom palettes
	
	db $02 ; number of boxes to draw
	db $00 ; x ; first box
	db $03 ; y
	db $14 ; width
	db $0A ; height
	db $01 ; border type
	db $03 ; palette
	db $00 ; x ; second box
	db $0C ; y
	db $14 ; width
	db $06 ; height
	db $02 ; border type
	db $04 ; palette
	
	db $01 ; number of strings to draw
	dw $0029 ; offset into screen buffer
	db "CLASSIFICA ALLEN.@" ; string
	
	db $02, $05 ; menu x, y
	db $01, $04 ; number of columns, rows
	db $00, $02 ; column width, row height
	db $12, $04, $07, $04, $02, $04 ; ?
	
	relativepointer .aButton ; script pointer a button
	relativepointer .bButton ; script pointer b button
	dw $FFFF ; script pointer select button
	dw $FFFF ; script pointer start button
	dw $FFFF ; script pointer left button
	dw $FFFF ; script pointer right button
	relativepointer .upButton ; script pointer up button
	relativepointer .downButton ; script pointer down button
	
	db $04 ; number of menu items
	dw $0119 ; screen buffer offset to print menu descriptions
	db $12, $04 ; width, height of blanked area
	
	db $00 ; load rankings table flag (table number should be specfied in 0:CD62)
	
	relativepointer .menuItemViewRankingsText ; pointers to text for each menu item
	relativepointer .menuItemUpdateRankingsText
	relativepointer .menuItemRankingsDescriptionText
	relativepointer .menuItemReturnText
	
	relativepointer .menuItemViewRankingsScript ; pointers to script for each menu item
	relativepointer .menuItemUpdateRankingsScript
	relativepointer .menuItemRankingsDescriptionScript
	relativepointer .menuItemReturnScript
	
	relativepointer .menuItemViewRankingsDescription ; pointers to description text for each menu item
	relativepointer .menuItemUpdateRankingsDescription
	relativepointer .menuItemRankingsDescriptionDescription
	relativepointer .menuItemReturnDescription

.aButton
	playsound SFX_READ_TEXT
	menuscript
	end

.bButton
	playsound SFX_MENU
	loadscreen NewsRootScreen
	end

.upButton
	menuup
	end

.downButton
	menudown
	end

.menuItemViewRankingsText
	db "VEDI CLASSIFICHE@"

.menuItemUpdateRankingsText
	db "AGG. CLASSIFICHE@"

.menuItemRankingsDescriptionText
	db "INFO CLASSIFICA@"
	
.menuItemReturnText
	db "ESCI@"

.menuItemViewRankingsScript
	cmpvalram sNewsId, $0C, sNewsIdBackup, .noRankingsData, .continueToCategoriesScreen, .noRankingsData

.continueToCategoriesScreen
	loadscreen TrainerRankingsCategoriesScreen
	end

.noRankingsData
	cleartext $0105, $12, $04
	printtext $0119, .noRankingsDataText
	end

.menuItemUpdateRankingsScript
	updaterankings
	cmpval wRankingsUpdateResult, .rankingsUpdated, .rankingsUpdateCancelled, .rankingsUpdateFailed, $01, $01

.rankingsUpdated
	cleartext $0105, $12, $04
	printtext $0119, .rankingsUpdatedText
	menureturn
	end

.rankingsUpdateCancelled
	cleartext $0105, $12, $04
	printtext $0119, .rankingsUpdateCancelledText
	menureturn
	end

.rankingsUpdateFailed
	cleartext $0105, $12, $04
	printtext $0119, .rankingsUpdateFailedText
	menureturn
	end

.rankingsUpdatedText
	text "Classifiche"
	line "aggiornate!"
	done

.rankingsUpdateCancelledText
	text "Aggiornam. classi-"
	line "fiche interrotto."
	done

.rankingsUpdateFailedText
	text "Aggiornamento"
	line "classifiche…"
	cont "fallito…"

	para "Riscarica le"
	line "NOTIZIE."
	done

.menuItemRankingsDescriptionScript
	cleartext $0105, $12, $04
	printtext $0119, .rankingsDescriptionText
	menureturn
	end

.menuItemReturnScript
	loadscreen NewsRootScreen
	end

.rankingsDescriptionText
	text "TORRE LOTTA"
	line ""
	
	para "Il numero di lotte"
	line "#MON vinte"
	cont "contro gli"
	cont "ALLENATORI alla"
	cont "TORRE LOTTA sul"
	cont "PERCORSO 40."

	para "IL MAGIKARP PIÙ"
	line "GROSSO"
	
	para "Le dimensioni del"
	line "MAGIKARP più"
	cont "grosso GURU"
	cont "PESCATORE al"
	cont "LAGO D'IRA."

	para "GARA PIGLIAMOSCHE"
	line ""
	
	para "il punteggio più"
	line "alto ottenuto alla"
	cont "GARA PIGLIAMOSCHE"
	cont "tenuta nel PARCO"
	cont "NAZIONALE."
	done

.noRankingsDataText
	text "Dati classifiche"
	line "assenti."
	
	para "Collegati per" 
	line "ottenere i dati."
	
	para ""
	line ""	
	done

.menuItemViewRankingsDescription
	db   "Guarda le varie"
	line "classifiche.@"

.menuItemUpdateRankingsDescription
	db   "Ricarica classi-"
	line "fiche e punteggi.@"

.menuItemRankingsDescriptionDescription
	db   "Spiegazione temi"
	line "classifiche.@"

.menuItemReturnDescription
	db   "Torna alla"
	line "prima pagina.@"


TrainerRankingsCategoriesScreen: ; $0AF2
	screenconfig
	db MUSIC_PROF_ELM ; music
	
	db $00 ; number of custom palettes
	
	db $02 ; number of boxes to draw
	db $00 ; x ; first box
	db $03 ; y
	db $14 ; width
	db $0A ; height
	db $01 ; border type
	db $03 ; palette
	db $00 ; x ; second box
	db $0C ; y
	db $14 ; width
	db $06 ; height
	db $02 ; border type
	db $04 ; palette
	
	db $01 ; number of strings to draw
	dw $0029 ; offset into screen buffer
	db "CLASSIFICA ALLEN.@" ; string
	
	db $02, $05 ; menu x, y
	db $01, $04 ; number of columns, rows
	db $00, $02 ; column width, row height
	db $12, $04, $07, $04, $02, $04 ; ?
	
	relativepointer .aButton ; script pointer a button
	relativepointer .bButton ; script pointer b button
	dw $FFFF ; script pointer select button
	relativepointer .bButton ; script pointer start button
	dw $FFFF ; script pointer left button
	dw $FFFF ; script pointer right button
	relativepointer .upButton ; script pointer up button
	relativepointer .downButton ; script pointer down button
	
	db $04 ; number of menu items
	dw $0119 ; screen buffer offset to print menu descriptions
	db $12, $04 ; width, height of blanked area
	
	db $00 ; load rankings table flag (table number should be specfied in 0:CD62)
	
	relativepointer .menuItemBattleTowerWinsText ; pointers to text for each menu item
	relativepointer .menuItemBugCatchingContestHighScoreText
	relativepointer .menuItemLargestMagikarpText
	relativepointer .menuItemReturnText
	
	relativepointer .menuItemBattleTowerWinsScript ; pointers to script for each menu item
	relativepointer .menuItemBugCatchingContestHighScoreScript
	relativepointer .menuItemLargestMagikarpScript
	relativepointer .menuItemReturnScript
	
	relativepointer .menuItemDescription ; pointers to description text for each menu item
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription



.aButton
	playsound SFX_READ_TEXT
	menuscript
	end
	
.upButton
	menuup
	end
	
.downButton
	menudown
	end

.bButton
	playsound SFX_MENU

.menuItemReturnScript
	loadscreen TrainerRankingsScreen
	end
	
.menuItemBattleTowerWinsText
	db "TORRE LOTTA@"
	
.menuItemBugCatchingContestHighScoreText
	db "GARA PIGLIAMOSCHE@"
	
.menuItemLargestMagikarpText
	db "MAGIKARP PIÙ GR.@"
	
.menuItemReturnText
	db "ESCI@"

.menuItemBattleTowerWinsScript
	setval wRankingsTable, $00
	setval wRankingsCategory, $00
	loadscreen TrainerRankingsTypeScreen
	end

.menuItemBugCatchingContestHighScoreScript
	setval wRankingsTable, $03
	setval wRankingsCategory, $01
	loadscreen TrainerRankingsTypeScreen
	end

.menuItemLargestMagikarpScript
	setval wRankingsTable, $06
	setval wRankingsCategory, $02
	loadscreen TrainerRankingsTypeScreen
	end

.menuItemDescription
	db   "Scegli quale"
	line "classifica vedere.@"


TrainerRankingsTypeScreen: ; $0BC4
	screenconfig
	db MUSIC_PROF_ELM ; music
	
	db $00 ; number of custom palettes
	
	db $02 ; number of boxes to draw
	db $00 ; x ; first box
	db $03 ; y
	db $14 ; width
	db $0A ; height
	db $01 ; border type
	db $03 ; palette
	db $00 ; x ; second box
	db $0C ; y
	db $14 ; width
	db $06 ; height
	db $02 ; border type
	db $04 ; palette
	
	db $01 ; number of strings to draw
	dw $0029 ; offset into screen buffer
	news_text_start
	news_text_switch 3, wRankingsCategory, .battleTowerWinsText, .bugCatchingContestHighScoreText, .largestMagikarpText
	db "@"
	
	db $02, $05 ; menu x, y
	db $01, $04 ; number of columns, rows
	db $00, $02 ; column width, row height
	db $12, $04, $07, $04, $02, $04 ; ?
	
	relativepointer .aButton ; script pointer a button
	relativepointer .bButton ; script pointer b button
	dw $FFFF ; script pointer select button
	relativepointer .startButton ; script pointer start button
	dw $FFFF ; script pointer left button
	dw $FFFF ; script pointer right button
	relativepointer .upButton ; script pointer up button
	relativepointer .downButton ; script pointer down button
	
	db $04 ; number of menu items
	dw $0119 ; screen buffer offset to print menu descriptions
	db $12, $04 ; width, height of blanked area
	
	db $00 ; load rankings table flag (table number should be specfied in 0:CD62)
	
	relativepointer .menuItemNationalRankingText ; pointers to text for each menu item
	relativepointer .menuItemPrefecturalRankingText
	relativepointer .menuItemZipCodeRankingText
	relativepointer .menuItemReturnText
	
	relativepointer .menuItemNationalRankingScript ; pointers to script for each menu item
	relativepointer .menuItemPrefecturalRankingScript
	relativepointer .menuItemZipCodeRankingScript
	relativepointer .menuItemReturnScript
	
	relativepointer .menuItemDescription ; pointers to description text for each menu item
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription



.aButton
	playsound SFX_READ_TEXT
	menuscript
	end
	
.upButton
	menuup
	end
	
.downButton
	menudown
	end

.startButton
	playsound SFX_MENU
	loadscreen TrainerRankingsScreen
	end

.menuItemNationalRankingText
	db "CLASSIFICA NAZ.@"

.menuItemPrefecturalRankingText
	news_text_start
	news_text_own_region_backup 0
	news_text_end
	db " CLASSIFICA@"

.menuItemZipCodeRankingText
	news_text_start
	news_text_own_zip_backup 3
	news_text_end
	db " CLASSIFICA@"

.menuItemReturnText
	db "ESCI@"

.menuItemNationalRankingScript
	setval wRankingsType, $00
	loadscreen TrainerRankingsRankingsScreen
	end

.menuItemPrefecturalRankingScript
	incval wRankingsTable, $01
	setval wRankingsType, $01
	loadscreen TrainerRankingsRankingsScreen
	end

.menuItemZipCodeRankingScript
	incval wRankingsTable, $02
	setval wRankingsType, $02
	loadscreen TrainerRankingsRankingsScreen
	end

.bButton
	playsound SFX_MENU

.menuItemReturnScript
	loadscreen TrainerRankingsCategoriesScreen
	end

.menuItemDescription
	db   "Scegli dove ved-"
	line "ere la classifica.@"

.battleTowerWinsText
	db "TORRE LOTTA@"

.bugCatchingContestHighScoreText
	db "GARA PIGLIAMOSCHE@"

.largestMagikarpText
	db "MAGIKARP PIÙ GR.@"


TrainerRankingsRankingsScreen: ; $0CBD
	screenconfig
	db MUSIC_PROF_ELM ; music
	
	db $00 ; number of custom palettes
	
	db $02 ; number of boxes to draw
	db $00 ; x ; first box
	db $03 ; y
	db $14 ; width
	db $0A ; height
	db $01 ; border type
	db $03 ; palette
	db $00 ; x ; second box
	db $0C ; y
	db $14 ; width
	db $06 ; height
	db $02 ; border type
	db $04 ; palette
	
	db $02 ; number of strings to draw
	dw $0029 ; offset into screen buffer
	news_text_start
	news_text_switch 3, wRankingsCategory, .headerText1, .headerText2, .headerText3
	db "@"
	dw $0066 ; offset into screen buffer
	news_text_start
	news_text_switch 3, wRankingsType, .headerText4, .headerText5, .headerText6
	db "@"
	
	db $02, $07 ; menu x, y
	db $01, $03 ; number of columns, rows
	db $00, $02 ; column width, row height
	db $12, $04, $07, $03, $02, $03 ; ?
	
	relativepointer .aButton ; script pointer a button
	relativepointer .bButton ; script pointer b button
	dw $FFFF ; script pointer select button
	relativepointer .startButton ; script pointer start button
	dw $FFFF ; script pointer left button
	dw $FFFF ; script pointer right button
	relativepointer .upButton ; script pointer up button
	relativepointer .downButton ; script pointer down button
	
	db $0B ; number of menu items
	dw $0119 ; screen buffer offset to print menu descriptions
	db $12, $04 ; width, height of blanked area
	
	db $01 ; load rankings table flag (table number should be specfied in 0:CD62)
	
	relativepointer .rankingsEntryText ; pointers to text for each menu item
	relativepointer .rankingsEntryText
	relativepointer .rankingsEntryText
	relativepointer .rankingsEntryText
	relativepointer .rankingsEntryText
	relativepointer .rankingsEntryText
	relativepointer .rankingsEntryText
	relativepointer .rankingsEntryText
	relativepointer .rankingsEntryText
	relativepointer .rankingsEntryText
	relativepointer .ownRankText
	
	relativepointer .rankingsEntryScript ; pointers to script for each menu item
	relativepointer .rankingsEntryScript
	relativepointer .rankingsEntryScript
	relativepointer .rankingsEntryScript
	relativepointer .rankingsEntryScript
	relativepointer .rankingsEntryScript
	relativepointer .rankingsEntryScript
	relativepointer .rankingsEntryScript
	relativepointer .rankingsEntryScript
	relativepointer .rankingsEntryScript
	relativepointer .ownRankScript
	
	relativepointer .menuItemDescription ; pointers to description text for each menu item
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription
	relativepointer .menuItemDescription



.aButton
	playsound SFX_READ_TEXT
	menuscript
	end

.bButton
	playsound SFX_MENU
	decvalram wRankingsTable, wRankingsType
	loadscreen TrainerRankingsTypeScreen
	end
	
.upButton
	menuup
	end
	
.downButton
	menudown
	end

.startButton
	playsound SFX_MENU
	loadscreen TrainerRankingsScreen
	end

.rankingsEntryText
	news_text_start
	news_text_switch 3, wRankingsCategory, .rankingsEntryBattleTowerWinsText, .rankingsEntryBugCatchingContestHighScoreText, .rankingsEntryLargestMagikarpText
	news_text_end

.rankingsEntryBattleTowerWinsText
	news_text_start
	news_text_ranking_indicator 3
	news_text_ranking_text 0, 7, 8
	news_text_ranking_number 20, 2, 5, 5, 0, 0
	news_text_end
	db "@"

.rankingsEntryBugCatchingContestHighScoreText
	news_text_start
	news_text_ranking_indicator 3
	news_text_ranking_text 0, 7, 8
	news_text_ranking_number 20, 2, 5, 5, 0, 0
	news_text_end
	db "@"

.rankingsEntryLargestMagikarpText
	news_text_start
	news_text_ranking_indicator 3
	news_text_ranking_text 0, 7, 8
	news_text_ranking_number 20, 2 | PRINTNUM_LEADINGZEROS, 4, 5, 4, "<DOT>"
	news_text_end
	db "@"

.ownRankText
	db "GRADO di: "
	news_text_start
	news_text_own_name 0
	news_text_end
	line "@"

.rankingsEntryScript
	cmpvalram wcd22, $01, wcd5c, .somebodyRankedHere, .nobodyRankedHere, .nobodyRankedHere
	
.somebodyRankedHere
	cleartext $0105, $12, $04
	specialtext $0119, .rankedPlayerInfoText
	cleartext $0105, $12, $04
	specialtext $0119, .rankedPlayerMessage
	end

.nobodyRankedHere
	cleartext $0105, $12, $04
	specialtext $0119, .nobodyRankedHereText
	end

.nobodyRankedHereText
	db   "Nessun classi-"
	next "ficato qui."
	para "@"

.ownRankScript
	cmpvalram wOwnRank, $04, wNumRankedPlayers, .playerRanked, .playerRanked, .playerNotRanked

.playerRanked
	cleartext $0105, $12, $04
	specialtext $0119, .playerRankedText
	cmpval wOwnRank, .doNothing, .checkGSBallEnabled, .doNothing, $04, $00, $00, $00, $01

.checkGSBallEnabled
	cmpval sMobileEventIndex, .doNothing, .enableGSBall, .doNothing, $01, $00

.enableGSBall
	setval wcd6a, $01
	cpyvalram wcd6a, sMobileEventIndex, $0001
	cleartext $0105, $12, $04
	printtext $0119, .giftText
	menureturn

.doNothing
	end

.playerNotRanked
	cleartext $0105, $12, $04
	specialtext $0119, .playerNotRankedText
	end

.giftText
	text "Per aver ricevuto"
	next "un grado così"
	cont "alto,"

	para "ecco un regalo"
	line "per te."
	cont "Buon divertimento!"
	done

.rankedPlayerInfoText
	news_text_start
	news_text_ranking_gender 11, 8
	news_text_ranking_number 10, 1, 3, 4, 0, 0
	news_text_end
	db ""
	news_text_start
	news_text_ranking_region 7, 7
	news_text_end
	para "@"

.rankedPlayerMessage
	news_text_start
	news_text_ranking_message 12
	news_text_end
	para "@"

.playerRankedText
	news_text_start
	news_text_switch 3, wRankingsCategory, .ownBattleTowerWinsText, .ownBugCatchingContestHighScoreText, .ownLargestMagikarpText
	db "GRADO di "
	news_text_start
	news_text_own_name 0
	news_text_end	
	line "è…"
	para " "
	news_text_start
	news_text_number wOwnRank, 4, 4, 4, 0, 0
	news_text_end
	db   "!"
	line "Complimenti!"
	para "@"

.playerNotRankedText
	news_text_start
	news_text_switch 3, wRankingsCategory, .ownBattleTowerWinsText, .ownBugCatchingContestHighScoreText, .ownLargestMagikarpText
	db "GRADO di "
	news_text_start
	news_text_own_name 0
	news_text_end	
	line "è…"
	
	para "Attualmente non"
	line "in classifica."
	para "@"
	
.ownBattleTowerWinsText
	db "PUNTEG. di "
	news_text_start
	news_text_own_name 0
	news_text_end
	db ":"
	line ""
	news_text_start
	news_text_number sNumBattleTowerWins, 2, 5, 5, 0, 0
	news_text_end
	db " punti"
	para "@"

.ownBugCatchingContestHighScoreText
	db "PUNTEG. di "
	news_text_start
	news_text_own_name 0
	news_text_end
	db ":"
	line ""
	news_text_start
	news_text_number sBugContestHighscore, 2, 5, 5, 0, 0
	news_text_end
	db " punti"
	para "@"

.ownLargestMagikarpText
	db "PUNTEG. di "
	news_text_start
	news_text_own_name 0
	news_text_end
	db ":"
	line ""
	news_text_start
	news_text_number sLargestMagikarp, 2 | PRINTNUM_LEADINGZEROS, 4, 5, 4, "<DOT>"
	news_text_end
	db " cm"
	para "@"
	

.menuItemDescription
	db   "Guarda il profilo"
	line "di questo ALLEN.@"

.headerText1
	db "TORRE LOTTA@"

.headerText2
	db "GARA PIGLIAMOSCHE@"

.headerText3
	db "MAGIKARP PIÙ GR.@"

.headerText4
	db "TOP 10 NAZIONALE@"

.headerText5
	news_text_start
	news_text_own_region_backup 0
	news_text_end
	db " TOP 10!@"

.headerText6
	news_text_start
	news_text_own_zip_backup 3
	news_text_end
	db " TOP 10!@"
	
	db $04 ; whatever this is supposed to be
