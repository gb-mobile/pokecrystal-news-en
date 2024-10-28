INCLUDE "header.asm"

; defined here for easy extraction
DEF NEWS_TITLE EQUS "\"NACHRICHTEN Nr. 1@\""

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
	db NEWS_TITLE ; string
	
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
	db "NACHRICHTEN-INFO@"

.menuItemTrainerRankingsText
	db "BESTENLISTE@"

.menuItemPokemonQuizText
	db "#MANIAC-QUIZ@"

.menuItemQuitText
	db "ZURÜCK@"

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
	text "Wir hoffen, dir"
	line "gefallen die"
	
	para "TRAINER-BESTEN-"
	line "LISTE und das"
	
	para "#MANIAC-QUIZ"
	line "in Ausgabe Nr. 1!"

	para "Du kannst deinen"
	line "Rang jederzeit"
	cont "aktualisieren."

	para "Gib dein Bestes,"
	line "um einen hohen"
	cont "Rang zu erreichen!"
	done

.menuItemNewsGuideDescription
	db   "Eine Erklärung zu"
	line "den NACHRICHTEN.@"

.menuItemTrainerRankingsDescription
	db   "Dreifache Trainer-"
	line "Bestenliste!@"

.menuItemPokemonQuizDescription
	db   "Erinnerst du dich"
	line "an dein Abenteuer?@"

.menuItemQuitDescription
	db   "Lesen der NACH-"
	line "RICHTEN beenden.@"


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
	db "ZUR.@"

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
	db   "Wer befand sich im"
    next "mittleren #BALL"
    next "in LINDs LABOR?"
    next "1. KARNIMANI"
    next "2. FEURIGEL"
    next "3. ENDIVIE"
    next "@"
    
.question2Text
    db   "Was befindet sich"
    next "im Mülleimer neben"
    next "PROF. LIND?"
    next "1. ÜBERRESTE"
    next "2. SAFTFLASCHE"
    next "3. SNACK-FOLIE"
    next "@"
    
.question3Text
    db   "Wie viele TRÄNKE"
    next "besaß der KUMPEL,"
    next "der dir das Fan-"
    next "gen von #MON"
    next "beigebracht hat?"
    next "1. 1  2. 2  3. 3"
    next "@"
    
.question4Text
    db   "Mamas Spezialität"
    next "heißt wie genau?"
    next "ZINNOBER-VULKAN-…"
    next "1. BURGER"
    next "2. CURRY"
    next "3. NUDELN"
    next "@"
    
.question5Text
    db   "Wie oft hatte"
    next "sich EARL gedreht,"
    next "bevor er in die"
    next "#MON-AKADEMIE"
    next "ging?"
    next "1. 5  2. 6  3. 7"
    next "@"
    
.question6Text
    db   "Welches Item"
    next "gibt es nicht im"
    next "EINHEITSTUNNEL?"
    next "1. X-ANGRIFF"
    next "2. PARAHEILER"
    next "3. TRANK"
    next "@"
	
.question7Text
	db   "Wie oft muss man"
	next "PORENTA mindestens"
	next "ansprechen, bevor"
	next "man es fangen"
	next "kann?"
	next "1. 3  2. 4  3. 5"
	next "@"
	
.question8Text
	db   "Wie viele FLEGMON"
	next "befanden sich im"
	next "FLEGMON-BRUNNEN"
	next "als du sie ge-"
	next "rettet hast?"
	next "1. 2  2. 3  3. 4"
	next "@"
	
.question9Text
	db   "Das Meer war der"
	next "wievielte Halt des"
	next "FREMDENFÜHRERS von"
	next "ROSALIA CITY?"
	next ""
	next "1. 3. 2. 4. 3. 5."
	next "@"
	
.question10Text
	db   "Was findet man"
	next "nicht im HAUS von"
	next "MR. #MON?"
	next "1. MÜNZE"
	next "2. BRIEFMARKE"
	next "3. HEFT"
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
	
	db $02, $0A ; menu x, y ; $04, $0A ; Needs to be updated with PROF.OAK's REPORT
	db $01, $01 ; number of columns, rows
	db $00, $00 ; column width, row height
	db $01, $00, $00, $00, $02, $01 ; $03, $00, $00, $00, $02, $01 PROF OAK's REPORT location
	
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
	db "EICHs BERICHT@"
	
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
	db   "Die Bewertung"
	line "deiner Antworten!@"

.textScoreLow
	text "Es genügt nicht,"
	line "Dinge bloß aus-"
	cont "wendig zu lernen."
	
	para "#MANIACs können"
	line "sich Dinge merken,"
	cont "ohne dafür lernen"
	cont "zu müssen!"
	done

.textScoreAverage
	text "Du hast noch eine"
	line "Menge Arbeit vor"
	cont "dir."
	
	para "Echte #MANIACs"
	line "sind da noch mehr"
	cont "bei der Sache!"
	
	para "Sieh dich genau"
	line "in allen Ecken"
	cont "und Winkeln um!"
	done

.textScoreGood
	text "Du gibst dir Mühe."
	line ""
	para "Du bist fast"
	line "schon sowas wie"
	cont "ein #MANIAC!"
	
	para "Tauschst du dich"
	line "auch mit deinen"
	cont "Freunden aus?"
	
	para "Zusammen ist man"
	line "immer stärker!"
	done

.textScoreGreat
	text "Exzellent! Du"
	line "beobachtest wirk-"
	
	para "lich alles ganz"
	line "genau, nicht wahr?"
	done

.textScoreBest
	text "Wow! Du bist ein"
	line "wahrer #MANIAC,"
	
	para "von dem man sonst"
	line "nur träumen kann!"
	
	para "Perfekt! Herzli-"
	line "chen Glückwunsch!"
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
	db "BESTENLISTE@" ; string
	
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
	db "BETRACHTEN@"

.menuItemUpdateRankingsText
	db "ÜBERTRAGEN@"

.menuItemRankingsDescriptionText
	db "BESTENL.-INFO@"
	
.menuItemReturnText
	db "ZURÜCK@"

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
	text "Bestenlisten wur-"
	line "den übertragen!"
	done

.rankingsUpdateCancelledText
	text "Die Übertragung"
	line "wurde abgebrochen."
	done

.rankingsUpdateFailedText
	text "Die Übertragung"
	line "schlug fehl…"

	para "Die NACHRICHTEN"
	line "bitte neu laden."
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
	text "DUELLTURM"
	line ""
	
	para "Die Anzahl der"
	line "gewonnenen"
	cont "#MON-Kämpfe"
	cont "gegen andere"
	cont "<TRAINER> beim"
	cont "DUELLTURM auf"
	cont "ROUTE 40."

	para "GRÖSSTES KARPADOR"
	line ""
	
	para "Das größte"
	line "KARPADOR, das"
	cont "vom PROFI-ANGLER"
	cont "am SEE DES ZORNS"
	cont "gemessen wurde."

	para "KÄFER-TURNIER"
	line ""
	
	para "Die höchste Punkt-"
	line "zahl beim KÄFER-"
	cont "TURNIER im"
	cont "NATIONALPARK."
	done

.noRankingsDataText
	text "Keine Daten zur"
	line "Bestenliste vor-"
	cont "handen."
	
	para "Aktualisiere die"
	line "die Daten, um die"
	
	para "Bestenliste zu"
	line "betrachten."
	
	para ""
	done

.menuItemViewRankingsDescription
	db   "Betrachte versch."
	line "Bestenlisten.@"

.menuItemUpdateRankingsDescription
	db   "Übertrage und em-"
	line "pfange Daten.@"

.menuItemRankingsDescriptionDescription
	db   "Eine Erklärung zu"
	line "einzelnen Listen.@"

.menuItemReturnDescription
	db   "Zurück zur ersten"
	line "Seite.@"


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
	db "BESTENLISTE@" ; string
	
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
	db "DUELLTURM@"
	
.menuItemBugCatchingContestHighScoreText
	db "KÄFER-TURNIER@"
	
.menuItemLargestMagikarpText
	db "GRÖSSTES KARPADOR@"
	
.menuItemReturnText
	db "ZURÜCK@"

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
	db   "Wähle eine"
	line "Bestenliste.@"


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
	db "LANDESLISTE@"

.menuItemPrefecturalRankingText
	news_text_start
	news_text_own_region_backup 0
	news_text_end
	db "-LISTE@"

.menuItemZipCodeRankingText
	news_text_start
	news_text_own_zip_backup 3
	news_text_end
	db "-LISTE@"

.menuItemReturnText
	db "ZURÜCK@"

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
	db   "Für welche Region"
	line "anzeigen?@"

.battleTowerWinsText
	db "DUELLTURM@"

.bugCatchingContestHighScoreText
	db "KÄFER-TURNIER@"

.largestMagikarpText
	db "GRÖSSTES KARPADOR@"


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
	news_text_start
	news_text_own_name 0
	news_text_end
	db "s RANG: @"

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
	db   "Hier gibt es"
	next "keinen Eintrag."
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
	text "Wer so einen hohen"
	next "Rang erreicht,"

	para "verdient ein"
	line "tolles Geschenk."
	cont "Bitte schön!"
	done

.rankedPlayerInfoText
	news_text_start
	news_text_ranking_gender 11, 7
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
	news_text_start
	news_text_own_name 0
	news_text_end
	db "s RANG ist…"
	
	para ""
	news_text_start
	news_text_number wOwnRank, 4, 4, 4, 0, 0
	news_text_end
	db   "!"
	line "Glückwunsch!"
	para "@"

.playerNotRankedText
	news_text_start
	news_text_switch 3, wRankingsCategory, .ownBattleTowerWinsText, .ownBugCatchingContestHighScoreText, .ownLargestMagikarpText
	news_text_start
	news_text_own_name 0
	news_text_end
	db "s RANG ist…"
	
	para "leider außerhalb"
	line "der Bestenliste."
	para "@"
	
.ownBattleTowerWinsText
	news_text_start
	news_text_own_name 0
	news_text_end
	db "s PUNKTZAHL:"
	line ""
	news_text_start
	news_text_number sNumBattleTowerWins, 2, 5, 5, 0, 0
	news_text_end
	db " Punkte"
	para "@"

.ownBugCatchingContestHighScoreText
	news_text_start
	news_text_own_name 0
	news_text_end
	db "s PUNKTZAHL:"
	line ""
	news_text_start
	news_text_number sBugContestHighscore, 2, 5, 5, 0, 0
	news_text_end
	db " Punkte"
	para "@"

.ownLargestMagikarpText
	news_text_start
	news_text_own_name 0
	news_text_end
	db "s REKORD:"
	line ""
	news_text_start
	news_text_number sLargestMagikarp, 2 | PRINTNUM_LEADINGZEROS, 4, 5, 4, "<DOT>"
	news_text_end
	db " cm"
	para "@"
	

.menuItemDescription
	db   "Profil des"
	line "TRAINERs anzeigen.@"

.headerText1
	db "DUELLTURM@"

.headerText2
	db "KÄFER-TURNIER@"

.headerText3
	db "GRÖSSTES KARPADOR@"

.headerText4
	db "LANDES-TOP-10!@"

.headerText5
	news_text_start
	news_text_own_region_backup 0
	news_text_end
	db " TOP-10!@"

.headerText6
	news_text_start
	news_text_own_zip_backup 3
	news_text_end
	db " TOP-10!@"
	
	db $04 ; whatever this is supposed to be
