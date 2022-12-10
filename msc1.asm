;Código feito por: Mateus Souza Coelho - 2018205790
;Turma 6.2 - Sistemas Embarcados 1
;Engenharia elétrica - UFES


segment code
..start:
;Inicia os registros de segmento DS e SS e o ponteiro de pilha SP
    mov 	ax,data
    mov		ds,ax
    mov 	ax,stack
    mov 	ss,ax
    mov 	sp,stacktop

;Salvar modo corrente de video(vendo como está o modo de video da maquina)
    mov		ah,0Fh
    int  	10h
   	mov  	[modo_anterior],al   
;Alterar modo de video para gráfico 640x480 16 cores
    mov     al,12h
   	mov     ah,0
    int     10h

;_____________________________________________________________________________
;_____________________________________________________________________________
;Funções criadas por mim

;Desenha o retangulo da tela e escreve a mensagem na tela
desenha_retangulo_esc_men:

	mov		byte[cor],branco_intenso	;Barra esquerda
	mov		ax,0
	push	ax
	mov		ax,0
	push	ax
	mov		ax,0
	push	ax
	mov		ax,479
	push	ax
	call	line
		
	mov		byte[cor],branco_intenso	;Barra superior	
	mov		ax,0
	push	ax
	mov		ax,479
	push	ax
	mov		ax,639
	push	ax
	mov		ax,479
	push	ax
	call	line

	mov		byte[cor],branco_intenso	;Barra direita
	mov		ax,639
	push	ax
	mov		ax,0
	push	ax
	mov		ax,639
	push	ax
	mov		ax,479
	push	ax
	call	line

	mov		byte[cor],branco_intenso	;Barra inferior
	mov		ax,0
	push	ax
	mov		ax,0
	push	ax
	mov		ax,639
	push	ax
	mov		ax,0
	push	ax
	call	line

	mov		byte[cor],branco_intenso	;Barra texto
	mov		ax,0
	push	ax
	mov		ax,431
	push	ax
	mov		ax,639
	push	ax
	mov		ax,431
	push	ax
	call	line

;Escreve o texto_1
	mov     cx,57   ;número de caracteres
    mov     bx,0
    mov     dh,1    ;linha 0-29
   	mov		dl,12    ;coluna 0-79
	mov		byte[cor],branco_intenso

loop_msg1:

	call	cursor
    mov     al,[bx+texto_1]    
	call	caracter
    inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
    loop    loop_msg1

;Escreve o nome
	mov     cx,19   ;número de caracteres
    mov     bx,0
    mov     dh,2    ;linha 0-29
   	mov		dl,19   ;coluna 0-79
	mov		byte[cor],branco_intenso

loop_msg2:

	call	cursor
    mov     al,[bx+nome]    
	call	caracter
    inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
    loop    loop_msg2

;Escreve o meu placar
	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,39   ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+meu_placar_3]    
	call	caracter

	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,40   ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+meu_placar_2]    
	call	caracter

	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,41   ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+meu_placar_1]    
	call	caracter

;Escreve o x
	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,43   ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+msg_x]    
	call	caracter

;Escreve o placar do computador
	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,45  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+placar_pc_3]    
	call	caracter

	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,46  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+placar_pc_2]    
	call	caracter

	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,47  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+placar_pc_1]    
	call	caracter

;Escreve computador
	mov     cx,10   ;número de caracteres
    mov     bx,0
    mov     dh,2    ;linha 0-29
   	mov		dl,49   ;coluna 0-79
	mov		byte[cor],branco_intenso

loop_msg3:

	call	cursor
    mov     al,[bx+adversario]    
	call	caracter
    inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
    loop    loop_msg3


    jmp bolas_barras    ;Desenha as bolas e as barras


;_____________________________________________________________________________
;Desenha as bolas e as barras
bolas_barras:
	
	;Bola Vermelha
	mov		byte[cor],vermelho	
	mov		ax,word[x_bola]
	push	ax
	mov		ax,word[y_bola]
	push	ax
	mov		ax,word[raio_bola]
	push	ax
	call	full_circle

	;Bola Preta	
	mov		byte[cor],preto	
	mov		ax,word[x_bola]
	push	ax
	mov		ax,word[y_bola]
	push	ax
	mov		ax,word[raio_bola]
	push	ax
	call	full_circle

	;Barra preta
	mov		byte[cor],preto	
	mov		ax,word[x_barras]
	push	ax
	mov		ax,word[y1_barra_preta]
	push	ax
	mov		ax,word[x_barras]
	push	ax
	mov		ax,word[y2_barra_preta]
	push	ax
	call	line

	;Barra branca
	mov		byte[cor],branco_intenso	
	mov		ax,word[x_barras]
	push	ax
	mov		ax,word[y1_barra]
	push	ax
	mov		ax,word[x_barras]
	push	ax
	mov		ax,word[y2_barra]
	push	ax
	call	line

	jmp verifica_tecla    ;Verifica caso o usuário digite algo


;_____________________________________________________________________________
;Verifica se o usuário apertou alguma tecla
verifica_tecla:        
    mov     ah, 0bh
    int     21h

;Se nenhuma tecla foi pressionada, repete o programa    
    cmp     al, 0
	je		inter_movimento_direita
    mov 	ah, 08
	int 	21h

;Se tecla s foi pressionada, sai do programa
	cmp		al, 's'
    je      inter_termina

;Se tecla u foi pressionada, a barra sobe
	cmp		al, 'u'
    je      sobe_barras 

;Se tecla d foi pressionada, a barra desde 
	cmp		al, 'd'
    je      desce_barras

;Se nenhuma das teclas específicas foram precionadas o programa mantem execução 
    jmp		verifica_tecla 


;_____________________________________________________________________________
;Intermediario bolas_barras
inter_bolas_barras:
	jmp bolas_barras


;_____________________________________________________________________________
;Sobe as barras
sobe_barras:

	;Faz uma comparação para que a barra preta não extrapole o limite do retangulo
	cmp    word[y2_barra_preta], 430

	;Se y2_barra_preta = 430, o código pula para o desenho das mesmas 
	je     inter_bolas_barras

	;Se não as barras sobem
	add    word[y1_barra],10
    add    word[y2_barra],10
    add    word[y1_barra_preta],10
    add    word[y2_barra_preta],10

    jmp    bolas_barras	;Desenha as barras e bolas com a nova posição


;_____________________________________________________________________________
;Desce a barra preta 
desce_barras:

	;Faz uma comparação para que a barra preta não extrapole o limite do retangulo
	cmp    word[y1_barra_preta],0

	;Se y2_barra_preta = 0, o código pula para o desenho das mesmas 
	je     inter_bolas_barras    
  
	;Se não as barras descem
	sub    word[y1_barra],10
    sub    word[y2_barra],10
    sub    word[y1_barra_preta],10
    sub    word[y2_barra_preta],10

    jmp    bolas_barras	;Desenha as barras e bolas com a nova posição


;_____________________________________________________________________________
;Intermediario movimento_direita
inter_movimento_direita:
	jmp movimento_direita


;_____________________________________________________________________________
;Intermediario termina
inter_termina:
	jmp termina


;_____________________________________________________________________________
;Intermediario inc_placar_pc_1
inter_inc_placar_pc_1:
	jmp inc_placar_pc_1


;_____________________________________________________________________________
;Incrementa meu placar
inc_meu_placar_1:
	
	;Compara se o ascii do primeiro valor é igual a 9
	cmp		word[meu_placar_1],57;ascii para 9
		;Se igual a 9 incrementa o segundo valor
		je  inc_meu_placar_2

	;Se menor que 9 incrementa o primeiro valor
	inc     word[meu_placar_1]

	;Atualiza o texto no placar
	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,41  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+meu_placar_1]    
	call	caracter

	jmp     inverte_X

inc_meu_placar_2:

	;Zera o primeiro valor
	mov     word[meu_placar_1],48;ascii para 0
	cmp		word[meu_placar_2],57;ascii para 9
		je  inc_meu_placar_3

	inc     word[meu_placar_2]

	;Atualiza o texto no placar
	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,41  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+meu_placar_1]    
	call	caracter

	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,40  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+meu_placar_2]    
	call	caracter

	jmp     inverte_X

inc_meu_placar_3:

	;Zera o primeiro e o segundo valor
	mov     word[meu_placar_1],48;ascii para 0
	mov     word[meu_placar_2],48;ascii para 0

	inc     word[meu_placar_3]

	;Atualiza o texto no placar
	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,39  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+meu_placar_3]    
	call	caracter

	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,40  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+meu_placar_2]    
	call	caracter

	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,41  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+meu_placar_1]    
	call	caracter

	;Inverte o sentido de movimento do eixo X da bola
	jmp     inverte_X


;_____________________________________________________________________________
;Incrementa o placar do computador
inc_placar_pc_1:
	
	;Compara se o ascii do primeiro valor é igual a 9
	cmp		word[placar_pc_1],57;ascii para 9
		;Se igual a 9 incrementa o segundo valor
		je  inc_placar_pc_2

	;Se menor que 9 incrementa o primeiro valor
	inc     word[placar_pc_1]

	;Atualiza o texto no placar
	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,47  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+placar_pc_1]    
	call	caracter

	;Inverte o sentido de movimento do eixo X da bola
	jmp     inverte_X

inc_placar_pc_2:
	
	;Zera o primeiro valor
	mov     word[placar_pc_1],48;ascii para 0
	cmp		word[placar_pc_2],57;ascii para 9
		je  inc_placar_pc_3

	inc     word[placar_pc_2]

	;Atualiza o texto no placar
	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,47  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+placar_pc_1]    
	call	caracter

	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,46  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+placar_pc_2]    
	call	caracter

	;Inverte o sentido de movimento do eixo X da bola
	jmp     inverte_X

inc_placar_pc_3:

	;Zera o primeiro e o segundo valor
	mov     word[placar_pc_1],48;ascii para 0
	mov     word[placar_pc_2],48;ascii para 0

	inc     word[placar_pc_3]

	;Atualiza o texto no placar
	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,47  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+placar_pc_1]    
	call	caracter

	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,46  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+placar_pc_2]    
	call	caracter

	mov     bx,0
    mov     dh,2   ;linha 0-29
   	mov		dl,45  ;coluna 0-79
	mov		byte[cor],branco_intenso
	call	cursor
    mov     al,[bx+placar_pc_3]    
	call	caracter

	;Inverte o sentido de movimento do eixo X da bola
	jmp     inverte_X


;_____________________________________________________________________________
;Termina o programa e voltar para o sistema operacional
termina:

	mov  	ah,0;set video mode
	mov  	al,[modo_anterior];modo anterior
	int  	10h
	mov     ax,4c00h
	int     21h


;_____________________________________________________________________________
;Intermediario inc_placar_pc_1_2
inter_inc_placar_pc_1_2:
	jmp inc_placar_pc_1


;_____________________________________________________________________________
;Intermediario inc_meu_placar
inter_inc_meu_placar_1:
jmp inc_meu_placar_1


;_____________________________________________________________________________
;Varias condições que nega determinado bit
inverte_Y_00:
;Inverte o eixo Y da sequencia 00
	mov 	word[eixos_xy],01b
	;Move as bolas com o novo sentido
	jmp     move_bolas
inverte_Y_01:
;Inverte o eixo Y da sequencia 01
	mov 	word[eixos_xy],00b
	;Move as bolas com o novo sentido
	jmp     move_bolas
inverte_Y_10:
;Inverte o eixo Y da sequencia 10
	mov 	word[eixos_xy],11b
	;Move as bolas com o novo sentido
	jmp     move_bolas
inverte_Y_11:
;Inverte o eixo Y da sequencia 11
	mov 	word[eixos_xy],10b
	;Move as bolas com o novo sentido
	jmp     move_bolas


;_____________________________________________________________________________
;Informa para o programa qual deve ser o sentido da bola
inverte_Y:

	;Inverte o bit do eixo Y
	cmp		word[eixos_xy], 00b
    	je  inverte_Y_00
    cmp 	word[eixos_xy], 01b
    	je 	inverte_Y_01
    cmp 	word[eixos_xy], 10b
    	je  inverte_Y_10
    cmp 	word[eixos_xy], 11b
    	je  inverte_Y_11

	jmp move_bolas


;_____________________________________________________________________________
;Intermediario inc_placar_pc_1_3
inter_inc_placar_pc_1_3:
	jmp inter_inc_placar_pc_1_2


;_____________________________________________________________________________
;Intermediario inc_meu_placar_1
inter_inc_meu_placar_1_2:
jmp inter_inc_meu_placar_1


;_____________________________________________________________________________
;Verifica onde vai ser a colisão depois da bola ter passado por baixo da barra
passou_barra_por_baixo:

	;Compara se houve uma colisão com a barra de baixo
	cmp    word[y_bola],11;Y da barra de texto menos raio
		;Inverte o sentido de movimento do eixo Y da bola
		je inverte_Y

	;Compara se houve uma colisão com a barra da direita
	cmp    word[x_bola],629;X da barra de texto menos raio 
		je inter_inc_placar_pc_1_3

	jmp move_bolas


;_____________________________________________________________________________
;Verica se bateu na barra ou se passou dela
bateu_barra_ou_direita:
	
	;Se a bola estiver indo para a esquerda deve continuar se movimentando sem colisão
	cmp     word[eixos_xy],10b
		je inter_movimento_esquerda
	cmp     word[eixos_xy],11b
		je inter_movimento_esquerda

	;Se a bola estiver indo para direita, deve-ser verificar se ela vai ou não bater na barra
	mov      ax,word[y_bola]
	cmp      ax,word[y1_barra]
		je  inter_inc_meu_placar_1_2;Se igual, bateu na barra
		ja  verifica_bateu_barra;Se maior verifica se de fato bateu na barra

	jmp 	passou_barra_por_baixo;Se menor passou da barra


;_____________________________________________________________________________
;Verifica se bateu na barra
verifica_bateu_barra:

	;Se a bola estiver indo para a esquerda deve continuar se movimentando sem colisão
	cmp     word[eixos_xy],10b
		je inter_movimento_esquerda
	cmp     word[eixos_xy],11b
		je inter_movimento_esquerda

	mov      ax,word[y_bola]
	cmp      ax,word[y2_barra]
		je  inter_inc_meu_placar_1_2;Se igual, bateu na barra
		jb  inter_inc_meu_placar_1_2;Se menor, bateu na barra

	jmp     passou_barra_por_cima;Se maior passou por cima da barra


;_____________________________________________________________________________
;Verifica onde vai ser a colisão depois da bola ter passado por cima da barra
passou_barra_por_cima:

	;Compara se houve uma colisão com a barra de texto
	cmp    word[y_bola],419;Y da barra de texto menos raio
		je inverte_Y

	;Compara se houve uma colisão com a barra da direita
	cmp    word[x_bola],629;X da barra de texto menos raio 
		je inter_inc_placar_pc_1_3

	jmp move_bolas


;_____________________________________________________________________________
;Varias condições que nega determinado bit
inverte_X_00:
;Inverte o eixo X da sequencia 00
	mov 	word[eixos_xy],10b
	;Move as bolas com o novo sentido
	jmp     move_bolas
inverte_X_01:
;Inverte o eixo X da sequencia 01
	mov 	word[eixos_xy],11b
	;Move as bolas com o novo sentido
	jmp     move_bolas
inverte_X_10:
;Inverte o eixo X da sequencia 10
	mov 	word[eixos_xy],00b
	;Move as bolas com o novo sentido
	jmp     move_bolas
inverte_X_11:
;Inverte o eixo X da sequencia 11
	mov 	word[eixos_xy],01b
	;Move as bolas com o novo sentido
	jmp     move_bolas


;_____________________________________________________________________________
;intermediario movimento_esquerda
inter_movimento_esquerda:
	jmp movimento_esquerda


;_____________________________________________________________________________
;intermediario inverte_Y
inter_inverte_Y:
	jmp inverte_Y


;_____________________________________________________________________________
;Intermidario bateu_barra_ou_direita
inter_bateu_barra_ou_direita:
	jmp bateu_barra_ou_direita


;_____________________________________________________________________________
;Intermidario move_bolas
inter_move_bolas:
	jmp move_bolas


;_____________________________________________________________________________
;Informa para o programa qual deve ser o sentido da bola
inverte_X:

	;Inverte o bit do eixo X
	cmp		word[eixos_xy], 00b
    	je  inverte_X_00
    cmp 	word[eixos_xy], 01b
    	je 	inverte_X_01
    cmp 	word[eixos_xy], 10b
    	je  inverte_X_10
    cmp 	word[eixos_xy], 11b
    	je  inverte_X_11

	jmp move_bolas


;_____________________________________________________________________________
;Decide em qual sentido as bolas devem se mover, se movendo para direita
movimento_direita:

	;Se a bola estiver indo para a esquerda deve continuar se movimentando sem colisão com a barra
	cmp    word[eixos_xy],10b
		je movimento_esquerda
	cmp    word[eixos_xy],11b
		je movimento_esquerda

	;Compara se a bola colidiu ou está depois da barra
	cmp    word[x_bola],578;X das barras menos raio
		ja inter_bateu_barra_ou_direita

	;Compara se houve uma colisão com a barra de texto
	cmp    word[y_bola],419;Y da barra de texto menos raio
		je inter_inverte_Y

	;Compara se houve uma colisão com a barra de baixo
	cmp    word[y_bola],11;Y da barra de texto menos raio
		je inter_inverte_Y

	;Compara se houve uma colisão com a barra da esquerda
	cmp    word[x_bola],11;X da barra de texto menos raio
		je inverte_X

	jmp    move_bolas;Desenha as bolas e barras com a nova posição 


;_____________________________________________________________________________
;Decide em qual sentido as bolas devem se mover, se movendo para esquerda
movimento_esquerda:
	
	;Compara se houve uma colisão com a barra de texto
	cmp    word[y_bola],419;Y da barra de texto menos raio
		je inter_inverte_Y

	;Compara se houve uma colisão com a barra de baixo
	cmp    word[y_bola],11;Y da barra de texto menos raio
		je inter_inverte_Y

	;Compara se houve uma colisão com a barra da esquerda
	cmp    word[x_bola],11;X da barra de texto menos raio
		je inverte_X

	jmp    move_bolas;Desenha as bolas e barras com a nova posição 


;_____________________________________________________________________________
;Move as bolas com base no sentido dos eixos x e y
move_bolas

	cmp    word[eixos_xy],00b
		je direita_cima

	cmp    word[eixos_xy],01b
		je direita_baixo

	cmp    word[eixos_xy],10b
		je esquerda_cima

	cmp    word[eixos_xy],11b
		je esquerda_baixo


;_____________________________________________________________________________
;Move as bolas para direita_cima
direita_cima:
	
	add    word[x_bola],2
	add    word[y_bola],2 

	jmp    inter_bolas_barras;Desenha as bolas e barras com a nova posição


;_____________________________________________________________________________
;Move as bolas para direita_baixo
direita_baixo:
	
	add    word[x_bola],2
	add    word[y_bola],-2 

	jmp    inter_bolas_barras;Desenha as bolas e barras com a nova posição


;_____________________________________________________________________________
;Move as bolas para esquerda_cima
esquerda_cima:
	
	add    word[x_bola],-2
	add    word[y_bola],2

	jmp    inter_bolas_barras;Desenha as bolas e barras com a nova posição


;_____________________________________________________________________________
;Move as bolas para esquerda_baixo
esquerda_baixo:
	
	add    word[x_bola],-2
	add    word[y_bola],-2 

	jmp    inter_bolas_barras;Desenha as bolas e barras com a nova posição
;_____________________________________________________________________________
;_____________________________________________________________________________


;_____________________________________________________________________________
;_____________________________________________________________________________
;Funções linec.asm
;_____________________________________________________________________________
;
;   função cursor
;
; dh = linha (0-29) e  dl=coluna  (0-79)
cursor:
		pushf
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
		push		bp
		mov     	ah,2
		mov     	bh,0
		int     	10h
		pop		bp
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		ret
;_____________________________________________________________________________
;
;   função caracter escrito na posição do cursor
;
; al= caracter a ser escrito
; cor definida na variavel cor
caracter:
		pushf
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
		push		bp
    		mov     	ah,9
    		mov     	bh,0
    		mov     	cx,1
   		mov     	bl,[cor]
    		int     	10h
		pop		bp
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		ret
;_____________________________________________________________________________
;
;   função plot_xy
;
; push x; push y; call plot_xy;  (x<639, y<479)
; cor definida na variavel cor
plot_xy:
		push		bp
		mov		bp,sp
		pushf
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
	    mov     	ah,0ch
	    mov     	al,[cor]
	    mov     	bh,0
	    mov     	dx,479
		sub		dx,[bp+4]
	    mov     	cx,[bp+6]
	    int     	10h
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		pop		bp
		ret		4
;_____________________________________________________________________________
;    função circle
;	 push xc; push yc; push r; call circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor
circle:
	push 	bp
	mov	 	bp,sp
	pushf                        ;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di
	
	mov		ax,[bp+8]    ; resgata xc
	mov		bx,[bp+6]    ; resgata yc
	mov		cx,[bp+4]    ; resgata r
	
	mov 	dx,bx	
	add		dx,cx       ;ponto extremo superior
	push    ax			
	push	dx
	call plot_xy
	
	mov		dx,bx
	sub		dx,cx       ;ponto extremo inferior
	push    ax			
	push	dx
	call plot_xy
	
	mov 	dx,ax	
	add		dx,cx       ;ponto extremo direita
	push    dx			
	push	bx
	call plot_xy
	
	mov		dx,ax
	sub		dx,cx       ;ponto extremo esquerda
	push    dx			
	push	bx
	call plot_xy
		
	mov		di,cx
	sub		di,1	 ;di=r-1
	mov		dx,0  	;dx será a variável x. cx é a variavel y
	
;aqui em cima a lógica foi invertida, 1-r => r-1
;e as comparações passaram a ser jl => jg, assim garante 
;valores positivos para d

stay:				;loop
	mov		si,di
	cmp		si,0
	jg		inf       ;caso d for menor que 0, seleciona pixel superior (não  salta)
	mov		si,dx		;o jl é importante porque trata-se de conta com sinal
	sal		si,1		;multiplica por doi (shift arithmetic left)
	add		si,3
	add		di,si     ;nesse ponto d=d+2*dx+3
	inc		dx		;incrementa dx
	jmp		plotar
inf:	
	mov		si,dx
	sub		si,cx  		;faz x - y (dx-cx), e salva em di 
	sal		si,1
	add		si,5
	add		di,si		;nesse ponto d=d+2*(dx-cx)+5
	inc		dx		;incrementa x (dx)
	dec		cx		;decrementa y (cx)
	
plotar:	
	mov		si,dx
	add		si,ax
	push    si			;coloca a abcisa x+xc na pilha
	mov		si,cx
	add		si,bx
	push    si			;coloca a ordenada y+yc na pilha
	call plot_xy		;toma conta do segundo octante
	mov		si,ax
	add		si,dx
	push    si			;coloca a abcisa xc+x na pilha
	mov		si,bx
	sub		si,cx
	push    si			;coloca a ordenada yc-y na pilha
	call plot_xy		;toma conta do sétimo octante
	mov		si,ax
	add		si,cx
	push    si			;coloca a abcisa xc+y na pilha
	mov		si,bx
	add		si,dx
	push    si			;coloca a ordenada yc+x na pilha
	call plot_xy		;toma conta do segundo octante
	mov		si,ax
	add		si,cx
	push    si			;coloca a abcisa xc+y na pilha
	mov		si,bx
	sub		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do oitavo octante
	mov		si,ax
	sub		si,dx
	push    si			;coloca a abcisa xc-x na pilha
	mov		si,bx
	add		si,cx
	push    si			;coloca a ordenada yc+y na pilha
	call plot_xy		;toma conta do terceiro octante
	mov		si,ax
	sub		si,dx
	push    si			;coloca a abcisa xc-x na pilha
	mov		si,bx
	sub		si,cx
	push    si			;coloca a ordenada yc-y na pilha
	call plot_xy		;toma conta do sexto octante
	mov		si,ax
	sub		si,cx
	push    si			;coloca a abcisa xc-y na pilha
	mov		si,bx
	sub		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do quinto octante
	mov		si,ax
	sub		si,cx
	push    si			;coloca a abcisa xc-y na pilha
	mov		si,bx
	add		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do quarto octante
	
	cmp		cx,dx
	jb		fim_circle  ;se cx (y) está abaixo de dx (x), termina     
	jmp		stay		;se cx (y) está acima de dx (x), continua no loop
	
	
fim_circle:
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		6
;-----------------------------------------------------------------------------
;    função full_circle
;	 push xc; push yc; push r; call full_circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor					  
full_circle:
	push 	bp
	mov	 	bp,sp
	pushf                        ;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di

	mov		ax,[bp+8]    ; resgata xc
	mov		bx,[bp+6]    ; resgata yc
	mov		cx,[bp+4]    ; resgata r
	
	mov		si,bx
	sub		si,cx
	push    ax			;coloca xc na pilha			
	push	si			;coloca yc-r na pilha
	mov		si,bx
	add		si,cx
	push	ax		;coloca xc na pilha
	push	si		;coloca yc+r na pilha
	call line
	
		
	mov		di,cx
	sub		di,1	 ;di=r-1
	mov		dx,0  	;dx será a variável x. cx é a variavel y
	
;aqui em cima a lógica foi invertida, 1-r => r-1
;e as comparações passaram a ser jl => jg, assim garante 
;valores positivos para d

stay_full:				;loop
	mov		si,di
	cmp		si,0
	jg		inf_full       ;caso d for menor que 0, seleciona pixel superior (não  salta)
	mov		si,dx		;o jl é importante porque trata-se de conta com sinal
	sal		si,1		;multiplica por doi (shift arithmetic left)
	add		si,3
	add		di,si     ;nesse ponto d=d+2*dx+3
	inc		dx		;incrementa dx
	jmp		plotar_full
inf_full:	
	mov		si,dx
	sub		si,cx  		;faz x - y (dx-cx), e salva em di 
	sal		si,1
	add		si,5
	add		di,si		;nesse ponto d=d+2*(dx-cx)+5
	inc		dx		;incrementa x (dx)
	dec		cx		;decrementa y (cx)
	
plotar_full:	
	mov		si,ax
	add		si,cx
	push	si		;coloca a abcisa y+xc na pilha			
	mov		si,bx
	sub		si,dx
	push    si		;coloca a ordenada yc-x na pilha
	mov		si,ax
	add		si,cx
	push	si		;coloca a abcisa y+xc na pilha	
	mov		si,bx
	add		si,dx
	push    si		;coloca a ordenada yc+x na pilha	
	call 	line
	
	mov		si,ax
	add		si,dx
	push	si		;coloca a abcisa xc+x na pilha			
	mov		si,bx
	sub		si,cx
	push    si		;coloca a ordenada yc-y na pilha
	mov		si,ax
	add		si,dx
	push	si		;coloca a abcisa xc+x na pilha	
	mov		si,bx
	add		si,cx
	push    si		;coloca a ordenada yc+y na pilha	
	call	line
	
	mov		si,ax
	sub		si,dx
	push	si		;coloca a abcisa xc-x na pilha			
	mov		si,bx
	sub		si,cx
	push    si		;coloca a ordenada yc-y na pilha
	mov		si,ax
	sub		si,dx
	push	si		;coloca a abcisa xc-x na pilha	
	mov		si,bx
	add		si,cx
	push    si		;coloca a ordenada yc+y na pilha	
	call	line
	
	mov		si,ax
	sub		si,cx
	push	si		;coloca a abcisa xc-y na pilha			
	mov		si,bx
	sub		si,dx
	push    si		;coloca a ordenada yc-x na pilha
	mov		si,ax
	sub		si,cx
	push	si		;coloca a abcisa xc-y na pilha	
	mov		si,bx
	add		si,dx
	push    si		;coloca a ordenada yc+x na pilha	
	call	line
	
	cmp		cx,dx
	jb		fim_full_circle  ;se cx (y) está abaixo de dx (x), termina     
	jmp		stay_full		;se cx (y) está acima de dx (x), continua no loop
	
	
fim_full_circle:
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		6
;-----------------------------------------------------------------------------
;
;   função line
;
; push x1; push y1; push x2; push y2; call line;  (x<639, y<479)
line:
		push		bp
		mov		bp,sp
		pushf                        ;coloca os flags na pilha
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
		mov		ax,[bp+10]   ; resgata os valores das coordenadas
		mov		bx,[bp+8]    ; resgata os valores das coordenadas
		mov		cx,[bp+6]    ; resgata os valores das coordenadas
		mov		dx,[bp+4]    ; resgata os valores das coordenadas
		cmp		ax,cx
		je		line2
		jb		line1
		xchg		ax,cx
		xchg		bx,dx
		jmp		line1
line2:		; deltax=0
		cmp		bx,dx  ;subtrai dx de bx
		jb		line3
		xchg		bx,dx        ;troca os valores de bx e dx entre eles
line3:	; dx > bx
		push		ax
		push		bx
		call 		plot_xy
		cmp		bx,dx
		jne		line31
		jmp		fim_line
line31:		inc		bx
		jmp		line3
;deltax <>0
line1:
; comparar módulos de deltax e deltay sabendo que cx>ax
	; cx > ax
		push		cx
		sub		cx,ax
		mov		[deltax],cx
		pop		cx
		push		dx
		sub		dx,bx
		ja		line32
		neg		dx
line32:		
		mov		[deltay],dx
		pop		dx

		push		ax
		mov		ax,[deltax]
		cmp		ax,[deltay]
		pop		ax
		jb		line5

	; cx > ax e deltax>deltay
		push		cx
		sub		cx,ax
		mov		[deltax],cx
		pop		cx
		push		dx
		sub		dx,bx
		mov		[deltay],dx
		pop		dx

		mov		si,ax
line4:
		push		ax
		push		dx
		push		si
		sub		si,ax	;(x-x1)
		mov		ax,[deltay]
		imul		si
		mov		si,[deltax]		;arredondar
		shr		si,1
; se numerador (DX)>0 soma se <0 subtrai
		cmp		dx,0
		jl		ar1
		add		ax,si
		adc		dx,0
		jmp		arc1
ar1:		sub		ax,si
		sbb		dx,0
arc1:
		idiv		word [deltax]
		add		ax,bx
		pop		si
		push		si
		push		ax
		call		plot_xy
		pop		dx
		pop		ax
		cmp		si,cx
		je		fim_line
		inc		si
		jmp		line4

line5:		cmp		bx,dx
		jb 		line7
		xchg		ax,cx
		xchg		bx,dx
line7:
		push		cx
		sub		cx,ax
		mov		[deltax],cx
		pop		cx
		push		dx
		sub		dx,bx
		mov		[deltay],dx
		pop		dx



		mov		si,bx
line6:
		push		dx
		push		si
		push		ax
		sub		si,bx	;(y-y1)
		mov		ax,[deltax]
		imul		si
		mov		si,[deltay]		;arredondar
		shr		si,1
; se numerador (DX)>0 soma se <0 subtrai
		cmp		dx,0
		jl		ar2
		add		ax,si
		adc		dx,0
		jmp		arc2
ar2:		sub		ax,si
		sbb		dx,0
arc2:
		idiv		word [deltay]
		mov		di,ax
		pop		ax
		add		di,ax
		pop		si
		push		di
		push		si
		call		plot_xy
		pop		dx
		cmp		si,dx
		je		fim_line
		inc		si
		jmp		line6

fim_line:
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		pop		bp
		ret		8
;_____________________________________________________________________________
;_____________________________________________________________________________


;_______________________________________________________________________________________
;Definição das variáveis
segment data
;_____________________________________________________________________________
;_____________________________________________________________________________
;Variaveis criadas por mim
texto_1 	  db	'Exercicio de Programacao de Sistemas Embarcados 1  2021_2';57 caracteres 
nome		  db	'Mateus Souza Coelho';19 caracteres  
adversario	  db	'Computador';10 caracteres
meu_placar_1  dw	48;ASCII para "0"
meu_placar_2  dw	48;ASCII para "0"
meu_placar_3  dw	48;ASCII para "0"
msg_x		  db    'x'
placar_pc_1   dw	48;ASCII para "0"
placar_pc_2   dw	48;ASCII para "0"
placar_pc_3   dw	48;ASCII para "0"
x_bola		  dw 129
y_bola		  dw 49
raio_bola	  dw 10
x_barras	  dw 589
y1_barra	  dw 190
y2_barra	  dw 240
y1_barra_preta	    dw 180
y2_barra_preta   	dw 250
eixos_xy            dw 00b;Se 00: direita pra cima, 01: direita pra baixo, 10: esquerda pra cima, 11: esquerda pra baixo
;_____________________________________________________________________________
;_____________________________________________________________________________


;_____________________________________________________________________________
;_____________________________________________________________________________
;Variaveis do linec
cor		db		branco_intenso

;	I R G B COR
;	0 0 0 0 preto
;	0 0 0 1 azul
;	0 0 1 0 verde
;	0 0 1 1 cyan
;	0 1 0 0 vermelho
;	0 1 0 1 magenta
;	0 1 1 0 marrom
;	0 1 1 1 branco
;	1 0 0 0 cinza
;	1 0 0 1 azul claro
;	1 0 1 0 verde claro
;	1 0 1 1 cyan claro
;	1 1 0 0 rosa
;	1 1 0 1 magenta claro
;	1 1 1 0 amarelo
;	1 1 1 1 branco intenso

preto		equ		0
azul		equ		1
verde		equ		2
cyan		equ		3
vermelho	equ		4
magenta		equ		5
marrom		equ		6
branco		equ		7
cinza		equ		8
azul_claro	equ		9
verde_claro	equ		10
cyan_claro	equ		11
rosa		equ		12
magenta_claro	equ		13
amarelo		equ		14
branco_intenso	equ		15

modo_anterior	db		0
linha   	dw  		0
coluna  	dw  		0
deltax		dw		0
deltay		dw		0	
mens    	db  		'Funcao Grafica'
;_____________________________________________________________________________
;_____________________________________________________________________________


;_______________________________________________________________________________________
; Reserva 256 bytes para pilha
segment stack stack
    		resb 		512
stacktop:
