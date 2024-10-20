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
	db "#MON NEWS No.1@" ; string
	
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
	db "NEWS GUIDE@"

.menuItemTrainerRankingsText
	db "TRAINER RANKINGS@"

.menuItemPokemonQuizText
	db "#MANIA QUIZ@"

.menuItemQuitText
	db "CANCEL@"

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
	text "We hope you enjoy"
	line "the TRAINER RANK-"
	cont "INGS and #MANIA"
	cont "QUIZ in issue No.1"

	para "You can update"
	line "your ranking at"
	cont "any time."

	para "If you work hard"
	line "you can reach the"
	cont "top!"
	done

.menuItemNewsGuideDescription
	db   "Read an explan-"
	line "ation of the NEWS@"

.menuItemTrainerRankingsDescription
	db   "Triple-theme"
	line "trainer ranking!@"

.menuItemPokemonQuizDescription
	db   "Test your memory"
	line "of your adventure!@"

.menuItemQuitDescription
	db   "Stop reading the"
	line "NEWS.@"


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
	db "QUIT@"

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
	db   "Who was in the"
    next "middle # BALL"
    next "at PROF.ELM's LAB?"
    next "1. TOTODILE"
    next "2. CYNDAQUIL"
    next "3. CHIKORITA"
    next "@"
    
.question2Text
    db   "What is inside"
    next "the trash can" 
    next "next to PROF.ELM?"
    next "1. LEFTOVERS"
    next "2. JUICE BOTTLE"
    next "3. SNACK WRAPPER"
    next "@"
    
.question3Text
    db   "How many POTIONs"
    next "did the DUDE who"
    next "taught you to "
    next "catch #MON have"
    next "in his pack?"
    next "1. 1  2. 2  3. 3"
    next "@"
    
.question4Text
    db   "MOM's specialty"
    next "dish is the"
    next "CINNABAR VOLCANO ?"
    next "1. BURGER"
    next "2. CURRY"
    next "3. NOODLES"
    next "@"
    
.question5Text
    db   "How many times"
    next "does EARL spin"
    next "from talking to"
    next "him until he goes"
    next "into the ACADEMY?"
    next "1. 5  2. 6  3. 7"
    next "@"
    
.question6Text
    db   "Which of these"
    next "items is not found"
    next "in UNION CAVE?"
    next "1. X ATTACK"
    next "2. PARLYZ HEAL"
    next "3. POTION"
    next "@"
	
.question7Text
	db   "What is the least"
	next "amount of times"
	next "you need to talk"
	next "to FARFETCH'D to"
	next "capture it?"
	next "1. 3  2. 4  3. 5"
	next "@"
	
.question8Text
	db   "How many SLOWPOKE"
	next "were in the cave"
	next "when you rescued"
	next "them at SLOWPOKE"
	next "WELL?"
	next "1. 2  2. 3  3. 4"
	next "@"
	
.question9Text
	db   "Which stop is the"
	next "sea on the GUIDE"
	next "GENT's tour around"
	next "CHERRYGROVE CITY?"
	next "1. 3rd  2. 4th "
	next "3. 5th"
	next "@"
	
.question10Text
	db   "Which of these"
	next "foreign items is"
	next "not found in MR."
	next "#MON's HOUSE?"
	next "1. COIN  2. STAMP"
	next "3. MAGAZINE"
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
	db "PROF.OAK's REPORT@"
	
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
	db   "Take the quiz to"
	line "receive a rating!@"

.textScoreLow
	text "It's not enough to"
	line "memorize things."

	para "#MANIACs can"
	line "memorize things"
	cont "they don't even"
	cont "need to remember!"
	done

.textScoreAverage
	text "You still have"
	line "lots to do."

	cont "#MANIACs have a"
	cont "lot more passion!"

	para "Be sure to look in"
	line "every nook and"
	cont "cranny!"
	done

.textScoreGood
	text "You're trying--I"
	line "can see that."
	
	para "You're really"
	line "starting to earn"	
	cont "the title of" 
	cont "#MANIAC!"

	para "Are you talking"
	line  "with your friends?"
	
	para "It's tough to" 
	line "do this alone!"
	done

.textScoreGreat
	text "Excellent! You"
	line "really like to"
	
	para "poke around in"
	line "those nooks and"
	cont "crannies, don't"
	cont "you?"
	done

.textScoreBest
	text "Whoa! A perfect"
	line "#MANIAC! I've"

	para "dreamt about this!"
	line "Congratulations!"
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
	db "TRAINER RANKINGS@" ; string
	
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
	db "VIEW RANKINGS@"

.menuItemUpdateRankingsText
	db "UPDATE RANKINGS@"

.menuItemRankingsDescriptionText
	db "RANKING INFO@"
	
.menuItemReturnText
	db "CANCEL@"

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
	text "Rankings update"
	line "was successful!"
	done

.rankingsUpdateCancelledText
	text "Rankings update"
	line "was stopped."
	done

.rankingsUpdateFailedText
	text "Rankings update"
	line "has failed…"

	para "Please download"
	line "the latest NEWS."
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
	text "BATTLE TOWER"
	line ""
	
	para "The number of"
	line "#MON battles"
	cont "won against other"
	cont "<TRAINER>S at the"
	cont "BATTLE TOWER on"
	cont "ROUTE 40."

	para "LARGEST MAGIKARP"
	line ""
	
	para "The size of the"
	line "largest MAGIKARP"
	cont "measured by the"
	cont "FISHING GURU at"
	cont "the LAKE OF RAGE."

	para "BUG-CATCHING"
	line ""
	
	para "The highest score"
	line "obtained at the"
	cont "BUG-CATCHING Con-"
	cont "test held in the"
	cont "NATIONAL PARK."
	done

.noRankingsDataText
	text "There is no"
	line "ranking data."
	
	para "Link to obtain" 
	line "ranking data."
	
	para ""
	line ""	
	done

.menuItemViewRankingsDescription
	db   "View the various"
	line "rankings@"

.menuItemUpdateRankingsDescription
	db   "Reload rankings to"
	line "update your scores@"

.menuItemRankingsDescriptionDescription
	db   "An explanation of"
	line "the ranking themes@"

.menuItemReturnDescription
	db   "Return to the"
	line "first page@"


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
	db "TRAINER RANKINGS@" ; string
	
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
	db "BATTLE TOWER@"
	
.menuItemBugCatchingContestHighScoreText
	db "BUG-CATCHING@"
	
.menuItemLargestMagikarpText
	db "LARGEST MAGIKARP@"
	
.menuItemReturnText
	db "CANCEL@"

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
	db   "Please choose a"
	line "ranking to view@"


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
	db "NATIONAL RANKINGS@"

.menuItemPrefecturalRankingText
	news_text_start
	news_text_own_region_backup 0
	news_text_end
	db " RANKINGS@"

.menuItemZipCodeRankingText
	news_text_start
	news_text_own_zip_backup 3
	news_text_end
	db " RANKINGS@"

.menuItemReturnText
	db "CANCEL@"

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
	db   "Choose an area to"
	line "view the rankings@"

.battleTowerWinsText
	db "BATTLE TOWER@"

.bugCatchingContestHighScoreText
	db "BUG-CATCHING@"

.largestMagikarpText
	db "LARGEST MAGIKARP@"


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
	db "'s RANK: @"

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
	db   "No one is"
	next "ranked here."
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
	text "For receiving a"
	next "such a high rank,"

	para "we have a nice"
	line "gift for you."
	cont "Enjoy!"
	done

.rankedPlayerInfoText
	news_text_start
	news_text_ranking_gender 11, 4
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
	db "'s RANK is…"
	para ""
	news_text_start
	news_text_number wOwnRank, 4, 4, 4, 0, 0
	news_text_end
	db   "!"
	line "Congratulations!"
	para "@"

.playerNotRankedText
	news_text_start
	news_text_switch 3, wRankingsCategory, .ownBattleTowerWinsText, .ownBugCatchingContestHighScoreText, .ownLargestMagikarpText
	news_text_start
	news_text_own_name 0
	news_text_end
	db "'s RANK is…"
	para "Not currently in"
	line "the rankings."
	para "@"
	
.ownBattleTowerWinsText
	news_text_start
	news_text_own_name 0
	news_text_end
	db "'s SCORE:"
	line ""
	news_text_start
	news_text_number sNumBattleTowerWins, 2, 5, 5, 0, 0
	news_text_end
	db " points"
	para "@"

.ownBugCatchingContestHighScoreText
	news_text_start
	news_text_own_name 0
	news_text_end
	db "'s SCORE:"
	line ""
	news_text_start
	news_text_number sBugContestHighscore, 2, 5, 5, 0, 0
	news_text_end
	db " points"
	para "@"

.ownLargestMagikarpText
	news_text_start
	news_text_own_name 0
	news_text_end
	db "'s SCORE:"
	line ""
	news_text_start
	news_text_number sLargestMagikarp, 2 | PRINTNUM_LEADINGZEROS, 4, 5, 4, "<DOT>"
	news_text_end
	db " cm"
	para "@"
	

.menuItemDescription
	db   "View the profile"
	line "of this TRAINER.@"

.headerText1
	db "BATTLE TOWER@"

.headerText2
	db "BUG-CATCHING@"

.headerText3
	db "LARGEST MAGIKARP@"

.headerText4
	db "NATIONAL TOP 10!@"

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
