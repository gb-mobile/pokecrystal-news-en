; MobileAPI calls (see lib/mobile/main.asm:_MobileAPI)
	const_def 0, 2
	const MOBILEAPI_00
	const MOBILEAPI_01
	const MOBILEAPI_02
	const MOBILEAPI_03
	const MOBILEAPI_04
	const MOBILEAPI_05
	const MOBILEAPI_06
	const MOBILEAPI_07
	const MOBILEAPI_08
	const MOBILEAPI_09
	const MOBILEAPI_0A
	const MOBILEAPI_0B
	const MOBILEAPI_0C
	const MOBILEAPI_0D
	const MOBILEAPI_0E
	const MOBILEAPI_0F
	const MOBILEAPI_10
	const MOBILEAPI_11
	const MOBILEAPI_12
	const MOBILEAPI_13
	const MOBILEAPI_14
	const MOBILEAPI_15
	const MOBILEAPI_16
	const MOBILEAPI_17
	const MOBILEAPI_SETTIMER
	const MOBILEAPI_TELEPHONESTATUS
	const MOBILEAPI_1A
	const MOBILEAPI_1B
	const MOBILEAPI_1C
	const MOBILEAPI_1D
	const MOBILEAPI_1E
	const MOBILEAPI_1F
	const MOBILEAPI_20
	const MOBILEAPI_21

; MobileEZChatCategoryPointers indexes (see mobile/fixed_words.asm)
	const_def
	const EZCHAT_POKEMON
	const EZCHAT_TYPES
	const EZCHAT_GREETINGS
	const EZCHAT_PEOPLE
	const EZCHAT_BATTLE
	const EZCHAT_EXCLAMATIONS
	const EZCHAT_CONVERSATION
	const EZCHAT_FEELINGS
	const EZCHAT_CONDITIONS
	const EZCHAT_LIFE
	const EZCHAT_HOBBIES
	const EZCHAT_ACTIONS
	const EZCHAT_TIME
	const EZCHAT_FAREWELLS
	const EZCHAT_THISANDTHAT

DEF NUM_KANA EQU 45 ; length of SortedPokemon table (see mobile/fixed_words.asm)

DEF MOBILE_LOGIN_PASSWORD_LENGTH EQU 17
DEF MOBILE_PHONE_NUMBER_LENGTH EQU 20

; Maximum amount of time allowed for mobile battles each day
DEF MOBILE_BATTLE_ALLOWED_SECONDS EQU 0
DEF MOBILE_BATTLE_ALLOWED_MINUTES EQU 10

; Trade corner request size
; DION addr $1e + request $8 + Name $5
; + party struct $30 + OT $5 + NICK $5
; + JP Mail struct $2a
DEF MOBILE_EMAIL_LENGTH EQU $1e
DEF TRADE_CORNER_TRADE_INFO_LENGTH EQU 8
DEF TRADE_CORNER_CANCEL_REQUEST_LENGTH EQU MOBILE_EMAIL_LENGTH + TRADE_CORNER_TRADE_INFO_LENGTH
DEF TRADE_CORNER_RECEIVE_TRADE_LENGTH EQU PLAYER_NAME_LENGTH - 1 + PARTYMON_STRUCT_LENGTH + PLAYER_NAME_LENGTH - 1 + MON_NAME_LENGTH - 1 + MAIL_STRUCT_LENGTH
DEF TRADE_CORNER_TRADE_REQUEST_LENGTH EQU TRADE_CORNER_CANCEL_REQUEST_LENGTH + TRADE_CORNER_RECEIVE_TRADE_LENGTH

DEF EASY_CHAT_MESSAGE_WORD_COUNT EQU 4
DEF EASY_CHAT_MESSAGE_LENGTH EQU EASY_CHAT_MESSAGE_WORD_COUNT * 2 ; every word uses 2 bytes
DEF PHONE_NUMBER_LENGTH EQU 8
DEF PHONE_NUMBER_DIGITS_QUANTITY EQU PHONE_NUMBER_LENGTH * 2 ; Two digits are saved per byte (1x 0-10 digit per nybble).
DEF PHONE_NUMBER_DIGITS_MIN_REQUIRED_QUANTITY EQU 6
DEF NUM_CARD_FOLDER_ENTRIES EQU 40
DEF CARD_FOLDER_ENTRY_LENGTH EQU 41

IF DEF(_CRYSTAL_AU)
DEF ZIPCODE_LENGTH EQU 4
DEF NUM_REGION_CODES EQU 25
DEF REGION_CODE_STRING_LENGTH EQU 7
ELIF DEF(_CRYSTAL_EU)
DEF ZIPCODE_LENGTH EQU 7
DEF NUM_REGION_CODES EQU 40
DEF REGION_CODE_STRING_LENGTH EQU 6
ELIF DEF(_CRYSTAL_ES)
DEF ZIPCODE_LENGTH EQU 5
DEF NUM_REGION_CODES EQU 40
DEF REGION_CODE_STRING_LENGTH EQU 6
ELIF DEF(_CRYSTAL_FR)
DEF ZIPCODE_LENGTH EQU 5
DEF NUM_REGION_CODES EQU 40
DEF REGION_CODE_STRING_LENGTH EQU 6
ELIF DEF(_CRYSTAL_IT)
DEF ZIPCODE_LENGTH EQU 5
DEF NUM_REGION_CODES EQU 40
DEF REGION_CODE_STRING_LENGTH EQU 6
ELIF DEF(_CRYSTAL_DE)
DEF ZIPCODE_LENGTH EQU 5
DEF NUM_REGION_CODES EQU 40
DEF REGION_CODE_STRING_LENGTH EQU 6
ELSE ; US
DEF ZIPCODE_LENGTH EQU 6
DEF NUM_REGION_CODES EQU 64
DEF REGION_CODE_STRING_LENGTH EQU 6
ENDC

DEF ZIPCODE_MAX_LENGTH EQU 7
DEF ZIPCODE_FRAME_RIGHT_MARGIN EQU 1
DEF REGION_NAME_MAX_LENGTH EQU 7