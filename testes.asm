; *********************************************************************************
; * IST-UL | UAlg
; * Modulo:    Projeto Final - Vitrine de Ano Novo 
; * Alunos: Eline Snijder (84785), Helena Corassa (86834), Mariana Fidelis (86831)
; *********************************************************************************

; *********************************************************************************
; * Constantes
; *********************************************************************************
TEC_LIN EQU 0C000H ; linhas do teclado (periférico POUT-2)
TEC_COL EQU 0E000H ; colunas do teclado (periférico PIN)
LINHA1_TECLADO EQU 1 ; linha 0001b (primeira)
LINHA4_TECLADO EQU 8 ; linha 1000b (quarta linha)
MASCARA EQU 0FH ; isolar 4 bits de menor peso (na leitura da coluna)
TECLA_ESQ EQU 1  ; tecla na primeira coluna do teclado (tecla C)
TECLA_DIR EQU 2  ; tecla na segunda coluna do teclado (tecla D)

COMANDOS EQU 6000H ; endereço de base dos comandos do MediaCenter

MIN_COLUNA		EQU  0		; número da coluna mais à esquerda que o objeto pode ocupar
MAX_COLUNA		EQU  63     ; número da coluna mais à direita que o objeto pode ocupar
ATRASO			EQU	15H		; atraso para limitar a velocidade de movimento do objeto

; *********************************************************************************
; * Endereço dos Comandos do MediaCenter
; *********************************************************************************

DEFINE_LINHA EQU COMANDOS + 0AH ; endereço do comando para definir a linha
DEFINE_COLUNA EQU COMANDOS + 0CH ; endereço do comando para definir a coluna
DEFINE_PIXEL EQU COMANDOS + 12H ; endereço do comando para escrever um pixel
APAGA_AVISO EQU COMANDOS + 40H ; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRÃ EQU COMANDOS + 02H ; endereço do comando para apagar todos os pixels já desenhados
SELECIONA_CENARIO_FUNDO EQU COMANDOS + 42H ; endereço do comando para selecionar uma imagem de fundo
SELECIONA_ECRA EQU COMANDOS + 04H ; endereço do comando para selecionar o ecrã
MOSTRA_ECRÃ EQU COMANDOS + 06H ; endereço do comando para mostrar o ecrã
ESCONDE_ECRÃ EQU COMANDOS + 08H ; endereço do comando para esconder o ecrã
TOCA_SOM EQU COMANDOS + 5AH ; endereço do comando para tocar um som
PAUSA_SOM EQU COMANDOS + 5EH ; endereço do comando para pausar um som

; *********************************************************************************
; * Dados 
; *********************************************************************************
	PLACE       1000H
pilha:
	STACK 100H			; espaço reservado para a pilha 
						; (200H bytes, pois são 100H words)
SP_inicial:				; este é o endereço (1200H) com que o SP deve ser 
						; inicializado. O 1.º end. de retorno será 
						; armazenado em 11FEH (1200H-2)
							
; *********************************************************************************
; * Posição dos Objetos
; *********************************************************************************
; Papai Noel/Pai Natal
LINHA_PAPAI_NOEL EQU 5 ; escolher posição inicial do Papai Noel
COLUNA_PAPAI_NOEL EQU 1 ; escolher posição inicial do Papai Noel

; Feliz Natal
LINHA_FELIZ_NATAL EQU 10 ; meio do ecrã
COLUNA_FELIZ_NATAL EQU 9 ; meio do ecrã

; Bolas
LINHA_BOLAS EQU 8 ; escolher posição inicial das Bolas
COLUNA_BOLAS EQU 17 ;escolher posição inicial das Bolas

; Candy
LINHA_CANDY EQU 0 ; escolher posição inicial do candy
COLUNA_CANDY EQU 32 ;escolher posição inicial do candy

; Boneco de neve 1
LINHA_BONECO1 EQU 5 ; escolher posição inicial do Boneco de Neve
COLUNA_BONECO1 EQU 1 ; escolher posição inicial do Boneco de Neve

; Boneco de neve 2
LINHA_BONECO2 EQU 19 ; escolher posição inicial do Boneco de Neve 2
COLUNA_BONECO2 EQU 43 ; escolher posição inicial do Boneco de Neve 2 

; Flocos de Neve
LINHA_FLOCOS EQU 0 ; escolher posição inicial dos Flocos de Neve
COLUNA_FLOCOS EQU 0 ; escolher posição inicial dos Flocos de Neve

; Feliz Ano Novo
LINHA_FELIZ_ANO_NOVO EQU 0 ; escolher posição inicial do Feliz Natal
COLUNA_FELIZ_ANO_NOVO EQU 0 ; escolher posição inicial do Feliz Natal

; Fogos
LINHA_FOGOS EQU 0 ; escolher posição inicial dos Fogos
COLUNA_FOGOS EQU 0 ; escolher posição inicial dos Fogos

; Lua
LINHA_LUA EQU 0 ; escolher posição inicial 
COLUNA_LUA EQU 0 ; escolher posição inicial 

; *********************************************************************************
; * Tabelas dos Objetos
; *********************************************************************************
; CENA 0:
PAPAI_NOEL:
	WORD 20, 26
	WORD  0, 0, 0, 0, 0, 0, 0, 0,0F000H,0F000H,0F000H,0F000H, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0,0F000H,0FE12H,0FE12H,0FE12H,0FE12H,0F000H, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0F000H, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0,0F000H,0F000H,0F000H,0F000H,0F000H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0F000H, 0, 0, 0, 0, 0
	WORD  0, 0, 0,0F000H,0FFFFH,0FFFFH,0F000H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0,0F000H,0FFFFH,0FFFFH,0F000H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0,0F000H,0FFFFH,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H, 0, 0, 0
	WORD  0, 0, 0, 0,0F000H,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0
	WORD  0, 0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0FEA7H,0FEA7H,0FEA7H,0FEA7H,0FEA7H,0FEA7H,0FFFFH,0F000H, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0FEA7H,0F000H,0FEA7H,0FEA7H,0F000H,0FEA7H,0FFFFH,0F000H, 0, 0, 0
	WORD  0, 0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FEA7H,0FEA7H,0FE12H,0FEA7H,0FE12H,0FFFFH,0FFFFH,0F000H, 0, 0
	WORD  0, 0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0
	WORD  0, 0, 0, 0,0F000H,0F000H,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0, 0
	WORD  0, 0, 0,0F000H,0F152H,0F152H,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH, 0FFFFH,0F000H, 0, 0, 0
	WORD  0, 0,0F000H,0F152H,0F152H,0F000H,0FE12H,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H,0FE12H,0F000H, 0, 0
	WORD 0, 0F000H,0F152H,0F152H,0F000H,0FE12H,0F000H,0FE12H,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H,0FE12H,0F000H,0FE12H,0F000H, 0
	WORD 0, 0F000H,0F152H,0F152H,0F000H,0FE12H,0F000H,0FE12H,0FE12H,0F000H,0FFFFH,0FFFFH,0FFFFH,0F000H,0FE12H,0FE12H,0F000H,0FE12H,0F000H, 0
	WORD 0, 0F000H,0F152H,0F152H,0F000H,0FE12H,0F000H,0FE12H,0FE12H,0FE12H,0F000H,0F000H,0F000H,0FE12H,0FE12H,0FE12H,0F000H,0FE12H,0F000H, 0
	WORD 0, 0F000H,0F152H,0F152H,0F000H,0FFFFH,0F000H,0F000H,0F000H,0F000H,0FFF0H,0FFF0H,0FFF0H,0F000H,0F000H,0F000H,0F000H,0FFFFH,0F000H, 0
	WORD 0, 0F000H,0F152H,0F152H,0F000H,0FFFFH,0FFFFH,0F000H,0F000H,0F000H,0FFF0H,0FFF0H,0FFF0H,0F000H,0F000H,0F000H,0FFFFH,0FFFFH,0F000H, 0
	WORD 0, 0F000H,0F000H,0F152H,0F152H,0F000H,0F000H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0F000H,0F000H, 0, 0
	WORD  0, 0, 0,0F000H,0F000H,0F000H,0F000H,0FE12H,0FE12H,0FE12H,0F000H,0F000H,0F000H,0FE12H,0FE12H,0FE12H,0F000H, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0FE12H,0FE12H,0FE12H,0F000H, 0,0F000H,0FE12H,0FE12H,0FE12H,0F000H, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0F000H,0F000H,0F000H,0F000H, 0,0F000H,0F000H,0F000H,0F000H,0F000H, 0, 0, 0
BOLAS:
	WORD 15, 21
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0,0F903H, 0,0F903H, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0,0FD6DH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0,0FD6DH, 0,0FD6DH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0,0FD6DH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F115H, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F115H, 0,0F115H, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F115H, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0FF70H, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0,0FF70H, 0,0FF70H, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0FF70H, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FELIZ_NATAL:
	WORD 44, 9
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H, 0
	WORD  0,0FE12H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFFFH,0FE12H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FE12H,0FE12H,0FFFFH,0FE12H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFC0H,0FE12H, 0
	WORD  0,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFFFH,0FE12H,0FFFFH,0FE12H,0FE12H,0FFFFH,0FE12H,0FFFFH,0FE12H,0FFFFH,0FE12H,0FE12H,0FFFFH,0FE12H,0FE12H,0FFFFH,0FE12H,0FFFFH,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFC0H,0FE12H, 0
	WORD  0,0FE12H,0FFFFH,0FFFFH,0FE12H,0FE12H,0FFFFH,0FFFFH,0FE12H,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFFFH,0FE12H,0FE12H,0FFFFH,0FE12H,0FE12H,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FE12H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FE12H,0FFFFH,0FE12H,0FE12H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFC0H,0FE12H, 0
	WORD  0,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFFFH,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFFFH,0FE12H,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FE12H,0FFFFH,0FE12H,0FE12H,0FFFFH,0FE12H,0FE12H,0FFFFH,0FE12H,0FFFFH,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H, 0
	WORD  0,0FE12H,0FFFFH,0FE12H,0FE12H,0FE12H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FE12H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FE12H,0FE12H,0FFFFH,0FE12H,0FFFFH,0FE12H,0FFFFH,0FE12H,0FE12H,0FFFFH,0FE12H,0FE12H,0FFFFH,0FE12H,0FFFFH,0FE12H,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FFC0H,0FE12H, 0
	WORD  0,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
CANDY:
	WORD 10, 17
	WORD  0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0
	WORD  0, 0, 0, 0, 0,0F903H,0F903H,0F903H, 0, 0
	WORD  0, 0, 0, 0,0F903H, 0,0F000H, 0,0F903H, 0
	WORD  0, 0, 0, 0, 0,0F000H,0FE12H,0F000H, 0, 0
	WORD  0, 0, 0, 0, 0,0F000H,0FFFFH,0F000H, 0, 0
	WORD  0, 0, 0, 0, 0,0F000H,0FE12H,0F000H, 0, 0
	WORD  0, 0, 0, 0, 0,0F000H,0FFFFH,0F000H, 0, 0
	WORD  0, 0, 0, 0, 0,0F000H,0FE12H,0F000H, 0, 0
	WORD  0, 0,0F000H, 0, 0,0F000H,0FFFFH,0F000H, 0, 0
	WORD  0,0F000H,0FE12H,0F000H, 0,0F000H,0FE12H,0F000H, 0, 0
	WORD  0,0F000H,0FFFFH,0FE12H,0F000H,0FE12H,0FFFFH,0F000H, 0, 0
	WORD  0, 0,0F000H,0FFFFH,0FE12H,0FFFFH,0F000H, 0, 0, 0
	WORD  0, 0, 0,0F000H,0F000H,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
; CENA 1
BONECO1:
	WORD 22, 33
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F000H,0F000H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0,0F000H,0FFFFH,0FBBBH,0F000H, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0F000H, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F000H,0F000H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0,0F000H,0FE12H,0FE12H,0F000H, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0,0F000H,0FE12H,0FE12H,0FE12H,0F903H,0F000H, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0,0F000H,0FE12H,0FE12H,0FE12H,0F903H,0F903H,0F903H,0F000H, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0FFFFH,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0FFFFH,0F000H, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0F000H,0FFFFH,0F000H,0FFFFH,0FFFFH,0F000H,0FFFFH,0F000H,0F000H, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FE12H,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0, 0, 0, 0, 0
	WORD  0,0F000H, 0,0F000H, 0, 0,0F000H,0FFFFH,0FFFFH,0F000H,0FFFFH,0FFFFH,0F000H,0FFFFH,0FFFFH,0F000H, 0, 0,0F000H, 0,0F000H, 0
	WORD  0, 0,0F000H, 0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0F000H,0F000H,0FFFFH,0FFFFH,0F000H, 0, 0, 0, 0,0F000H, 0, 0
	WORD  0,0F000H,0F000H, 0, 0, 0,0F000H,0FE12H,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H,0F903H,0F000H, 0, 0, 0,0F000H,0F000H, 0
	WORD  0, 0,0F000H, 0, 0, 0,0F000H,0FE12H,0F903H,0F000H,0F000H,0F000H,0F000H,0F903H,0FE12H,0F000H, 0, 0, 0,0F000H, 0, 0
	WORD  0, 0, 0,0F000H, 0, 0, 0,0F000H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0FE12H,0F000H,0F903H,0F000H, 0,0F000H, 0, 0, 0
	WORD  0, 0, 0,0F000H, 0,0F000H,0F000H,0FDDDH,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0FE12H,0F903H,0F000H, 0,0F000H, 0, 0, 0
	WORD  0, 0, 0, 0,0F000H,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0F000H,0FE12H,0F903H,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0, 0,0F000H,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0F000H,0FE12H,0FE12H,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0,0F000H,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0F000H,0F000H,0F000H,0FBBBH,0F000H, 0, 0, 0
	WORD  0, 0, 0,0F000H,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0F000H,0F000H,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FBBBH,0FBBBH,0F000H, 0, 0, 0
	WORD  0, 0, 0,0F000H,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0F000H,0F000H,0FDDDH,0FDDDH,0FDDDH,0FBBBH,0FBBBH,0FBBBH,0F000H, 0, 0, 0
	WORD  0, 0, 0,0F000H,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0F000H, 0, 0, 0
	WORD  0, 0, 0,0F000H,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0F000H, 0, 0, 0
	WORD  0, 0, 0,0F000H,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0F000H,0F000H,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0F000H, 0, 0, 0
	WORD  0, 0, 0, 0,0F000H,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0F000H,0F000H,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0, 0,0F000H,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FDDDH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0,0F000H,0FDDDH,0FDDDH,0FDDDH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0F000H, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0F000H,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0FBBBH,0F000H,0F000H, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
BONECO2:
	WORD 21, 25
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0,0F000H,0F000H,0F000H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0,0F000H,0F000H,0F953H,0F953H,0FE12H,0F000H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0,0F000H,0F953H,0F953H,0F953H,0FE12H,0FE12H,0F000H,0F000H,0F000H, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0,0F000H,0F953H,0F953H,0FE12H,0FE12H,0F953H,0F953H,0F953H,0F953H,0F000H, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0F953H,0F953H,0F953H,0F953H,0F953H,0F000H,0F000H, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0,0F000H,0F000H,0F000H,0F953H,0F953H,0F953H,0F953H,0F953H,0F000H,0FFFFH,0F000H, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0,0F000H,0F953H,0F953H,0F953H,0F953H,0F953H,0F953H,0F000H,0F000H,0FFFFH,0FFFFH, 0,0F000H, 0, 0, 0, 0, 0
	WORD  0, 0, 0,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH, 0,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0, 0, 0
	WORD  0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0, 0
	WORD  0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0, 0
	WORD  0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H,0F000H,0FFFFH,0FFFFH,0FFFFH,0F000H,0F000H,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0, 0
	WORD  0, 0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFF0H,0FFF0H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFF0H,0FFF0H,0FFFFH,0FFFFH,0FFFFH, 0,0F000H, 0, 0, 0, 0, 0
	WORD  0, 0,0F000H, 0,0F000H,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH, 0,0F000H,0F000H, 0,0F000H,0F000H, 0, 0
	WORD  0,0F000H,0F953H,0F000H,0F000H,0FE12H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F2B4H,0F000H,0F000H,0F953H,0F953H,0F000H, 0
	WORD  0, 0,0F000H,0F953H,0F953H,0F000H,0F2B4H,0FE12H,0F2B4H,0FE12H,0F2B4H,0F000H,0F2B4H,0F000H,0FE12H,0F000H, 0,0F000H,0F000H, 0, 0
	WORD  0, 0, 0,0F000H,0F000H,0FFFFH,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0FE12H,0F000H,0F000H,0FFFFH,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H,0F2B4H,0F000H,0FFFFH,0FFFFH,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H,0F000H,0F000H,0FFFFH,0FFFFH,0F000H, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0,0F000H,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0F000H, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H,0F000H, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FLOCOS:
	WORD 44, 26
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0,0F9DEH
	WORD  0, 0, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0,0F9DEH, 0,0F9DEH, 0
	WORD 0F9DEH, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0,0F9DEH, 0, 0
	WORD  0,0F9DEH, 0,0F9DEH, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0,0F9DEH, 0,0F9DEH, 0
	WORD  0, 0,0F9DEH, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0,0F9DEH
	WORD  0,0F9DEH, 0,0F9DEH, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0
	WORD 0F9DEH, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0,0F9DEH, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0,0F9DEH, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0,0F9DEH, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0,0F9DEH, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F9DEH, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
; CENA 2:
FELIZ_ANO_NOVO:
	WORD 61, 5
	WORD  0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0,0FFFBH, 0, 0, 0, 0,0FFFBH, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0, 0,0FFFBH, 0
	WORD  0,0FFFBH, 0, 0, 0, 0,0FFFBH, 0, 0, 0, 0,0FFFBH, 0, 0, 0, 0,0FFFBH, 0, 0, 0, 0,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0, 0,0FFFBH, 0
	WORD  0,0FFFBH,0FFFBH,0FFFBH, 0, 0,0FFFBH,0FFFBH,0FFFBH, 0, 0,0FFFBH, 0, 0, 0, 0,0FFFBH, 0, 0,0FFFBH,0FFFBH, 0, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0,0FFFBH,0FFFBH, 0,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH,0FFFBH, 0,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0, 0,0FFFBH, 0
	WORD  0,0FFFBH, 0, 0, 0, 0,0FFFBH, 0, 0, 0, 0,0FFFBH, 0, 0, 0, 0,0FFFBH, 0,0FFFBH, 0, 0, 0, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH, 0,0FFFBH,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH, 0,0FFFBH,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0, 0, 0, 0
	WORD  0,0FFFBH, 0, 0, 0, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0,0FFFBH, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0,0FFFBH, 0, 0,0FFFBH, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0, 0,0FFFBH,0FFFBH, 0, 0,0FFFBH,0FFFBH,0FFFBH,0FFFBH, 0, 0,0FFFBH, 0
FOGOS:
	WORD 35, 19
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0FE12H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0, 0, 0,0FE12H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0,0F903H, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0FE12H, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0FE12H, 0,0F903H, 0,0F903H, 0,0F903H, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0FE12H, 0,0F903H, 0,0FE12H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0,0FE12H, 0, 0, 0,0FE12H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	WORD 0F903H, 0, 0,0F903H, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0FE12H, 0,0F903H, 0, 0
	WORD  0, 0,0F903H, 0,0FE12H, 0,0FE12H, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0
	WORD  0, 0, 0,0F903H, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0, 0, 0,0FE12H
	WORD  0, 0,0FE12H, 0,0F903H, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0,0FE12H, 0,0F903H, 0
	WORD 0FE12H, 0, 0,0F903H, 0,0FE12H, 0, 0,0FE12H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0FE12H, 0, 0, 0, 0, 0,0F903H
	WORD  0, 0, 0, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0
	WORD  0, 0, 0, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0,0FE12H, 0, 0
	WORD  0, 0, 0, 0,0F903H, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0
	WORD  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0F903H, 0, 0, 0
LUA:
	WORD 11, 11
	WORD  0, 0, 0,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH, 0, 0, 0
	WORD  0, 0,0FFFFH,0FFFFH,0FFFFH,0FDDDH,0FDDDH,0FFFFH,0FFFFH, 0, 0
	WORD  0,0FFFFH,0FFFFH,0FDDDH,0FFFFH,0FFFFH,0FDDDH,0FDDDH,0FFFFH,0FFFFH, 0
	WORD  0, 0,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FDDDH,0FDDDH,0FFFFH, 0
	WORD  0, 0,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FDDDH,0FDDDH,0FFFFH
	WORD  0, 0, 0,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FDDDH,0FFFFH
	WORD  0, 0, 0,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH
	WORD  0, 0, 0, 0,0FFFFH,0FFFFH,0FFFFH,0FDDDH,0FFFFH,0FFFFH,0FFFFH
	WORD  0, 0, 0, 0,0FFFFH,0FFFFH,0FDDDH,0FFFFH,0FFFFH,0FFFFH, 0
	WORD  0, 0, 0, 0,0FFFFH,0FDDDH,0FDDDH,0FFFFH,0FFFFH, 0, 0
	WORD  0, 0, 0, 0,0FFFFH,0FFFFH,0FFFFH,0FFFFH, 0, 0, 0


;*********************************************************************************
; * Código
; *********************************************************************************
	PLACE 0 

inicio:   
    MOV SP, SP_inicial		; inicializa SP

	MOV [APAGA_AVISO], R1 	; apaga o aviso de "nenhum cenário selecionado"
	MOV [APAGA_ECRÃ], R1	; apaga pixel já desenhados
	MOV R1, 0 				; cenário de fundo número 0 
	; CMP tecla com 0, 1 ou 2 -> se sim JUMP cena 
	MOV [SELECIONA_CENARIO_FUNDO], R1 ; seleciona cenário de fundo    

cena0:
; FELIZ NATAL
	MOV R1, 0 ; seleciona ecrã de fundo para feliz natal e som de número 0
	MOV [TOCA_SOM], R1 ; toca som 
	MOV [SELECIONA_ECRA], R1 ; seleciona ecrã de fundo para feliz natal
	MOV [MOSTRA_ECRÃ], R1 ; mostra ecrã
	MOV R1, LINHA_FELIZ_NATAL
	MOV R2, COLUNA_FELIZ_NATAL
	MOV R4, FELIZ_NATAL
	CALL desenha_objeto
	CALL atraso  ; tempo para ver a mensagem de FELIZ NATAL
	MOV [APAGA_ECRÃ], R1 ; apaga pixel do ecrã
	MOV R1, 0 ; pausa som de número 0
	MOV [PAUSA_SOM], R1


; BOLAS DA ÁRVORE
	MOV R1, 2      ; seleciona o ecrã 2 para o Papai Noel passar por cima sem apagar objeto
	MOV [SELECIONA_ECRA], R1
	MOV R1, LINHA_BOLAS
	MOV R2, COLUNA_BOLAS
	MOV R4, BOLAS
	MOV [MOSTRA_ECRÃ], R1
	CALL desenha_objeto

; CANDY
	MOV R1, LINHA_CANDY
	MOV R2, COLUNA_CANDY
	MOV R4, CANDY
	CALL desenha_objeto
	
; PAPAI NOEL (PAI NATAL)
	MOV R1, 1 
	MOV [TOCA_SOM], R1 ; toca som de PAPAI NOEL
	MOV R1, 1          ; ecrã número 1 - acima do ecrã 2
	MOV [SELECIONA_ECRA], R1
	MOV R1, LINHA_PAPAI_NOEL
	MOV R2, COLUNA_PAPAI_NOEL
	MOV R4, PAPAI_NOEL
	CALL desenha_objeto
	MOV [MOSTRA_ECRÃ], R1
	JMP espera_tecla

;cena1:
; NEVANDO
;	MOV R1, 1 ; seleciona ecrã de fundo de neve 
;	MOV [TOCA_SOM], R1 ; toca som 
;	MOV [SELECIONA_ECRA], R1 ; seleciona ecrã de fundo para feliz natal
;	MOV [MOSTRA_ECRÃ], R1 ; mostra ecrã
;	MOV R1, LINHA_FLOCOS
;	MOV R2, COLUNA_FLOCOS
;	MOV R4, FLOCOS
;	CALL desenha_objeto
;	CALL atraso  ; tempo para ver os flocos 
;	MOV [APAGA_ECRÃ], R1 ; apaga pixel do ecrã
;	MOV R1, 0 ; pausa som 

; BONECO 2
;	MOV R1, 2      ; seleciona o ecrã 2 para o boneco passar por cima sem apagar objeto
;	MOV [SELECIONA_ECRA], R1
;	MOV R1, LINHA_BONECO2
;	MOV R2, COLUNA_BONECO2
;	MOV R4, BONECO2
;	MOV [MOSTRA_ECRÃ], R1
;	CALL desenha_objeto

; BONECO 1
;	MOV R1, 1 
;	MOV R1, 1          ; ecrã número 1 - acima do ecrã 2
;	MOV [SELECIONA_ECRA], R1
;	MOV R1, LINHA_BONECO1
;	MOV R2, COLUNA_BONECO1
;	MOV R4, BONECO1
;	CALL desenha_objeto
;	MOV [MOSTRA_ECRÃ], R1
;	JMP espera_tecla

espera_tecla:				; neste ciclo espera-se até uma tecla ser premida
	MOV R6, LINHA4_TECLADO	; linha a testar no teclado
	CALL teclado			; leitura às teclas
	CMP	R0, 0
	JZ	espera_tecla		; espera, enquanto não houver tecla premida
	CMP	R0, TECLA_ESQ
	JNZ	testa_direita
	SUB R2, 1 				; deslocar para a esquerda
	JMP move_objeto			; se for a esquerda, pula para mover o objeto
testa_direita:
	CMP	R0, TECLA_DIR
	JNZ	espera_tecla		; tecla que não interessa
	ADD R2, 1				; deslocar para a direita
move_objeto:
	MOV R1, LINHA_PAPAI_NOEL
	MOV R4, PAPAI_NOEL
	CALL desenha_objeto
	JMP espera_tecla

fim:
	JMP fim
	
;loop:
;	MOV R9, 3               ; numero de vezes que obj 1 irá piscar
;	MOV R10, 3	            ; numero de vezes que obj 2 irá piscar 
;	CALL desenha_objeto1    ; chamada para rotina objeto 1
;   CALL desenha_objeto2    ; chamada para rotina objeto 2
;	JMP loop

; ******************************************************************************
; desenha_objeto - Desenha um objeto no ecrã a partir da linha e coluna indicadas.
; REGISTROS de ENTRADA
; R1 - linha que inicia o desenho 
; R2 - coluna que inicia o desenho
; R3 - pixel a ser desenhado
; R4 - endereço do objeto a desenhar
; REGISTROS AUXILIARES
; R5 - contador da largura (i.e, máximo de colunas que devem ser desenhadas)
; R6 - backup do contador da largura 
; R7 - backup da coluna inicial
; R8 - contador da altura (i.e, máximo de linhas que devem ser desenhadas)
; *******************************************************************************

desenha_objeto:
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8

	MOV R5, [R4] ; colunas a percorrer (largura)
	MOV R6, R5 ; backup de colunas
	MOV R7, R2 ; guarda a coluna inicial
	ADD R4, 2 ; passa ao próximo valor da tabela
	MOV R8, [R4] ; linhas a percorrer (altura)
	ADD R4, 2 ; passa ao próximo valor da tabela

desenha_pixels:
	MOV R3, [R4] ; obtém a cor do próximo pixel do objeto
	CALL escreve_pixel ; escreve cada pixel do objeto
	ADD R4, 2 ; passa ao próximo pixel
	ADD R2, 1 ; passa à coluna seguinte
	SUB R6, 1 ; decrementa o contador de coluna
	JNZ desenha_pixels ; continua até percorrer toda a largura do objeto
	MOV R6, R5 ; atualiza o valor das colunas para recomeçar
	MOV R2, R7; atualiza o valor da coluna de início para recomeçar
	ADD R1, 1 ; passa à linha seguinte
	SUB R8, 1 ; decrementa a linha
	JNZ desenha_pixels ; continua até percorrer toda a altura do objeto
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	RET
	

	RET


; **********************************************************************
; apaga_objeto - Apaga um objeto na linha e coluna indicadas
;			  com a forma definida na tabela indicada.
; REGISTROS de ENTRADA
; R1 - linha que inicia para apagar o desenho
; R2 - coluna que para apagar o desenho
; R3 - pixel a ser apagado
; R4 - endereço do objeto a desenhar
; REGISTROS AUXILIARES
; R5 - contador da largura (i.e, máximo de colunas que devem ser apagadas)
; R6 - backup do contador da largura 
; R7 - backup da coluna inicial
; R8 - contador da altura (i.e, máximo de linhas que devem ser apagadas)
; **********************************************************************
apaga_objeto:
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8

	MOV R5, [R4] ; colunas a percorrer (largura)
	MOV R6, R5 ; backup de colunas
	MOV R7, R2 ; guarda a coluna inicial
	ADD R4, 2 ; passa ao próximo valor da tabela
	MOV R8, [R4] ; linhas a percorrer (altura)
	ADD R4, 2 ; passa ao próximo valor da tabela

apaga_pixels:
	MOV R3, 0 ; apaga próximo pixel do objeto
	CALL escreve_pixel ; escreve cada pixel do objeto
	ADD R4, 2 ; passa ao próximo pixel
	ADD R2, 1 ; passa à coluna seguinte
	SUB R6, 1 ; decrementa o contador de coluna
	JNZ apaga_pixels ; continua até percorrer toda a largura do objeto
	MOV R6, R5 ; atualiza o valor das colunas para recomeçar
	MOV R2, R7; atualiza o valor da coluna de início para recomeçar
	ADD R1, 1 ; passa à linha seguinte
	SUB R8, 1 ; decrementa a linha
	JNZ apaga_pixels ; continua até percorrer toda a altura do objeto
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2

	RET

; **********************************************************************
; escreve_pixel - Escreve um pixel na linha e coluna indicadas.
; R1 - linha
; R2 - coluna
; R3 - cor do pixel atual (em formato ARGB de 16 bits)
; **********************************************************************

escreve_pixel:
	MOV [DEFINE_LINHA], R1		; seleciona a linha
	MOV [DEFINE_COLUNA], R2		; seleciona a coluna
	MOV [DEFINE_PIXEL], R3		; altera a cor do pixel na linha e coluna já selecionadas
	RET


; **********************************************************************
; ATRASO - Executa um ciclo para implementar um atraso.
; R10 - valor que define o atraso
; **********************************************************************

atraso:
	PUSH R10
ciclo_atraso:
	SUB	R10, 1
	JNZ	ciclo_atraso
	POP	R10
	RET


; **********************************************************************
; TECLADO - Lê as teclas de uma linha do teclado e retorna o valor lido
; REGISTROS DE ENTRADA
;	R6: linha a testar (em formato 1, 2, 4 ou 8)
; REGISTROS DE SAÍDA
; 	R0: valor lido das colunas do teclado (0, 1, 2, 4, ou 8)	
; **********************************************************************
teclado:
	PUSH R2
	PUSH R3
	PUSH R5
	MOV R2, TEC_LIN   ; endereço do periférico das linhas
	MOV R3, TEC_COL   ; endereço do periférico das colunas
	MOV R5, MASCARA   ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
	MOVB [R2], R6     ; escrever no periférico de saída (linhas)
	MOVB R0, [R3]     ; ler do periférico de entrada (colunas)
	AND R0, R5        ; elimina bits para além dos bits 0-3
	POP	R5
	POP	R3
	POP	R2
	RET
