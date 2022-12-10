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

;Começa o jogo, zerando as variaveis, desenhando a tela e escrevendo o texto inicial
game_start:

    ;Zera variaveis
    call zera_variaveis

    mov     byte[cor],branco_intenso    ;Barra esquerda
    mov     ax,0
    push    ax
    mov     ax,0
    push    ax
    mov     ax,0
    push    ax
    mov     ax,479
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra superior 
    mov     ax,0
    push    ax
    mov     ax,479
    push    ax
    mov     ax,639
    push    ax
    mov     ax,479
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra direita
    mov     ax,639
    push    ax
    mov     ax,0
    push    ax
    mov     ax,639
    push    ax
    mov     ax,479
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra inferior
    mov     ax,0
    push    ax
    mov     ax,0
    push    ax
    mov     ax,639
    push    ax
    mov     ax,0
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra esquerda texto superior
    mov     ax,89
    push    ax
    mov     ax,429
    push    ax
    mov     ax,89
    push    ax
    mov     ax,479
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra inferior texto superior
    mov     ax,89
    push    ax
    mov     ax,429
    push    ax
    mov     ax,549
    push    ax
    mov     ax,429
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra direita texto superior
    mov     ax,549
    push    ax
    mov     ax,429
    push    ax
    mov     ax,549
    push    ax
    mov     ax,489
    push    ax
    call    line

     mov     byte[cor],branco_intenso    ;Barra esquerda texto inferior
    mov     ax,89
    push    ax
    mov     ax,10
    push    ax
    mov     ax,89
    push    ax
    mov     ax,74
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra superior texto inferior
    mov     ax,89
    push    ax
    mov     ax,74
    push    ax
    mov     ax,549
    push    ax
    mov     ax,74
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra horizontal na metade do texto inferior
    mov     ax,89
    push    ax
    mov     ax,39
    push    ax
    mov     ax,549
    push    ax
    mov     ax,39
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra vertical na metade do texto inferior
    mov     ax,319
    push    ax
    mov     ax,74
    push    ax
    mov     ax,319
    push    ax
    mov     ax,39
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra direita texto inferior
    mov     ax,549
    push    ax
    mov     ax,10
    push    ax
    mov     ax,549
    push    ax
    mov     ax,74
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra inferior do texto inferior
    mov     ax,89
    push    ax
    mov     ax,10
    push    ax
    mov     ax,549
    push    ax
    mov     ax,10
    push    ax
    call    line

    ;Espaço para o jogo da velha
    mov     byte[cor],branco_intenso    ;Barra superior horizontal
    mov     ax,89
    push    ax
    mov     ax,299
    push    ax
    mov     ax,549
    push    ax
    mov     ax,299
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra inferior horizontal
    mov     ax,89
    push    ax
    mov     ax,199
    push    ax
    mov     ax,549
    push    ax
    mov     ax,199
    push    ax
    call    line 

    mov     byte[cor],branco_intenso    ;Barra esquerda vertical
    mov     ax,229
    push    ax
    mov     ax,99
    push    ax
    mov     ax,229
    push    ax
    mov     ax,399
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra direita vertical
    mov     ax,414
    push    ax
    mov     ax,99
    push    ax
    mov     ax,414
    push    ax
    mov     ax,399
    push    ax
    call    line   


    ;Escreve o texto_1
    mov     cx,39   ;número de caracteres
    mov     bx,0
    mov     dh,1    ;linha 0-29
    mov     dl,21    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_msg1:

    call    cursor
    mov     al,[bx+texto_1]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_msg1

    ;Escreve o texto comandos:
    mov     cx,9   ;número de caracteres
    mov     bx,0
    mov     dh,26    ;linha 0-29
    mov     dl,1    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_comandos:

    call    cursor
    mov     al,[bx+comandos]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_comandos

    ;Escreve o texto mensagens:
    mov     cx,10   ;número de caracteres
    mov     bx,0
    mov     dh,28    ;linha 0-29
    mov     dl,1    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_mensagens:

    call    cursor
    mov     al,[bx+mensagens]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_mensagens

    ;Escreve os indices do jogo da velha
    mov     cx,2   ;número de caracteres
    mov     bx,0
    mov     dh,5    ;linha 0-29
    mov     dl,11    ;coluna 0-79
    mov     byte[cor],amarelo

    loop_11:

    call    cursor
    mov     al,[bx+msg_11]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_11

    mov     cx,2   ;número de caracteres
    mov     bx,0
    mov     dh,5    ;linha 0-29
    mov     dl,29    ;coluna 0-79
    mov     byte[cor],amarelo

    loop_12:

    call    cursor
    mov     al,[bx+msg_12]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_12

    mov     cx,2   ;número de caracteres
    mov     bx,0
    mov     dh,5    ;linha 0-29
    mov     dl,52    ;coluna 0-79
    mov     byte[cor],amarelo

    loop_13:

    call    cursor
    mov     al,[bx+msg_13]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_13

    mov     cx,2   ;número de caracteres
    mov     bx,0
    mov     dh,12    ;linha 0-29
    mov     dl,11    ;coluna 0-79
    mov     byte[cor],amarelo

    loop_21:

    call    cursor
    mov     al,[bx+msg_21]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_21

    mov     cx,2   ;número de caracteres
    mov     bx,0
    mov     dh,12    ;linha 0-29
    mov     dl,29    ;coluna 0-79
    mov     byte[cor],amarelo

    loop_22:

    call    cursor
    mov     al,[bx+msg_22]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_22

    mov     cx,2   ;número de caracteres
    mov     bx,0
    mov     dh,12    ;linha 0-29
    mov     dl,52    ;coluna 0-79
    mov     byte[cor],amarelo

    loop_23:

    call    cursor
    mov     al,[bx+msg_23]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_23

    mov     cx,2   ;número de caracteres
    mov     bx,0
    mov     dh,18    ;linha 0-29
    mov     dl,11    ;coluna 0-79
    mov     byte[cor],amarelo

    loop_31:

    call    cursor
    mov     al,[bx+msg_31]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_31

    mov     cx,2   ;número de caracteres
    mov     bx,0
    mov     dh,18    ;linha 0-29
    mov     dl,29    ;coluna 0-79
    mov     byte[cor],amarelo

    loop_32:

    call    cursor
    mov     al,[bx+msg_32]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_32

    mov     cx,2   ;número de caracteres
    mov     bx,0
    mov     dh,18    ;linha 0-29
    mov     dl,52    ;coluna 0-79
    mov     byte[cor],amarelo

    loop_33:

    call    cursor
    mov     al,[bx+msg_33]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_33

    jmp verifica_tecla


;_____________________________________________________________________________
;Verifica se o usuário apertou alguma tecla
verifica_tecla:  

    mov     ah, 0bh
    int     21h

;Grava o caracter 1 digitada pelo usuário
    mov     ah, 08
    int     21h
    mov     byte[input_user_1],al
;Printa o input 1
    mov     bx,0
    mov     dh,26   ;linha 0-29
    mov     dl,12   ;coluna 0-79
    mov     byte[cor],branco_intenso
    call    cursor
    mov     al,[bx+input_user_1]    
    call    caracter


;Grava o caracter 2 digitada pelo usuário
    mov     ah, 08
    int     21h
    mov     byte[input_user_2],al
;Se o usuário tiver precionado "enter" faz a verificação
    cmp     byte[input_user_2],13;Ascii decimal para "enter"
    je      verifica_input

;Printa o input 2
    mov     bx,0
    mov     dh,26   ;linha 0-29
    mov     dl,13   ;coluna 0-79
    mov     byte[cor],branco_intenso
    call    cursor
    mov     al,[bx+input_user_2]    
    call    caracter

;Grava o caracter 3 digitada pelo usuário
    mov     ah, 08
    int     21h
    mov     byte[input_user_3],al
;Se o usuário tiver precionado "enter" faz a verificação
    cmp     byte[input_user_3],13;Ascii decimal para "enter"
    je      verifica_input
;Printa o input 3
    mov     bx,0
    mov     dh,26   ;linha 0-29
    mov     dl,14   ;coluna 0-79
    mov     byte[cor],branco_intenso
    call    cursor
    mov     al,[bx+input_user_3]    
    call    caracter

    jmp aguarda_enter


;_____________________________________________________________________________
;Intermediario game_start
inter_game_start:
    jmp game_start


;_____________________________________________________________________________
;Se tecla "enter" foi pressionada, faz a verificação
aguarda_enter:

    mov     ah, 08
    int     21h
    cmp     al, 13;Ascii decimal do enter
    je      verifica_input

    ;Aguarda o usuário apertar "enter"
    jmp     aguarda_enter 


;_____________________________________________________________________________
;Intermériario verifica_tecla
inter_verifica_tecla:
    jmp     verifica_tecla

;_____________________________________________________________________________
;Verifica o input digitado pelo usuário
verifica_input:
    
;Se a tecla enter não foi pressionada no segundo input significa que o input tem 3 caracteres   
    cmp     byte[input_user_2],13;Ascii decimal do enter
    jne     continua_verificacao

;Se a tecla s foi pressionada, sai do programa
    cmp     byte[input_user_1],'s'
    je      termina

;Se a tecla n foi pressinada, começa um novo jogo
    cmp     byte[input_user_1],'n'
    je      inter_game_start

    cmp     byte[game_end],1b
    ;Se o jogo acabou o usuário deve apertar as teclas de saída ou reinício de jogo
    je      inter_verifica_tecla
    jmp     continua_verificacao


;_____________________________________________________________________________
;Termina o programa e voltar para o sistema operacional
termina:

    mov     ah,0;set video mode
    mov     al,[modo_anterior];modo anterior
    int     10h
    mov     ax,4c00h
    int     21h

    
;_____________________________________________________________________________
;Continua a verificação do que foi digitado pelo usuário
continua_verificacao:

    ;Apaga a caixa de comando atual
    call    apaga_comando_atual

    cmp     byte[game_end],1b
    ;Se o jogo acabou o usuário deve apertar as teclas de saída ou reinício de jogo
    je      inter_verifica_tecla

    ;Verifica se o usuário digitou algo válido
    cmp     byte[input_user_1],'c'
    je      verifica_desenho_c

    cmp     byte[input_user_1],'q'
    je      inter_verifica_desenho_q

    jmp     comando_invalido


;_____________________________________________________________________________
;Printa que o usuário digitou um comando inválido e pede para ele digitar novamente
comando_invalido:

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg

    ;Escreve o texto de comando inválido:
    mov     cx,16   ;número de caracteres
    mov     bx,0
    mov     dh,28    ;linha 0-29
    mov     dl,12    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_comando_invalido:

    call    cursor
    mov     al,[bx+msg_comando_invalido]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_comando_invalido

    jmp     verifica_tecla


;_____________________________________________________________________________
;Verifica se o usuário escreveu um comando de desenho correto
verifica_desenho_c:

    ;Verifica se um desenho de x foi feito anteriormente
    cmp    byte[ultimo_jogador],'c'
    je     inter_jogada_invalida
    
    cmp    byte[input_user_2], 49;ASCII para "1"
    jb     comando_invalido
    cmp    byte[input_user_2], 51;ASCII para "3"
    ja     comando_invalido

    cmp    byte[input_user_3], 49;ASCII para "1"
    jb     comando_invalido
    cmp    byte[input_user_3], 51;ASCII para "3"
    ja     comando_invalido

    cmp    byte[input_user_2], 50;ASCII para '2'
    jb     verifica_q1_c
    je     verifica_q2_c
    ja     verifica_q3_c


;_____________________________________________________________________________
;Verifica se alguns dos quadrantes estão ocupados
verifica_q1_c:
    
    cmp    byte[input_user_3], 50;ASCII para '2'
    jb     verifica_q11_c
    je     verifica_q12_c
    ja     verifica_q13_c

verifica_q2_c:
    
    cmp    byte[input_user_3], 50;ASCII para '2'
    jb     verifica_q21_c
    je     verifica_q22_c
    ja     verifica_q23_c


;_____________________________________________________________________________
;Intermediario verifica_desenho_q
inter_verifica_desenho_q:
    jmp verifica_desenho_q


verifica_q3_c:
    
    cmp    byte[input_user_3], 50;ASCII para '2'
    jb     verifica_q31_c
    je     verifica_q32_c
    ja     verifica_q33_c

verifica_q11_c:
    cmp    byte[q11],0
    jne    inter_jogada_invalida
    jmp    desenha_q11_c

verifica_q12_c:
    cmp    byte[q12],0 
    jne    jogada_invalida
    jmp    desenha_q12_c


;_____________________________________________________________________________
;Intermediario comando_invalido
inter_comando_invalido:
    jmp comando_invalido

;_____________________________________________________________________________
;Intermediario jogada_invalida
inter_jogada_invalida:
    jmp jogada_invalida


verifica_q13_c:
    cmp    byte[q13],0 
    jne    jogada_invalida
    jmp    desenha_q13_c

verifica_q21_c:
    cmp    byte[q21],0 
    jne    jogada_invalida
    jmp    desenha_q21_c

verifica_q22_c:
    cmp    byte[q22],0 
    jne    jogada_invalida
    jmp    desenha_q22_c

verifica_q23_c:
    cmp    byte[q23],0 
    jne    jogada_invalida
    jmp    desenha_q23_c

verifica_q31_c:
    cmp    byte[q31],0 
    jne    jogada_invalida
    jmp    desenha_q31_c

verifica_q32_c:
    cmp    byte[q32],0 
    jne    jogada_invalida
    jmp    desenha_q32_c

verifica_q33_c:
    cmp    byte[q33],0 
    jne    jogada_invalida
    jmp    desenha_q33_c


;_____________________________________________________________________________
;Verifica se o usuário escreveu um comando de desenho correto
verifica_desenho_q:
    
    ;Verifica se um desenho de q foi feito anteriormente
    cmp    byte[ultimo_jogador],'q'
    je     jogada_invalida

    cmp    byte[input_user_2], 49;ASCII para "1"
    jb     inter_comando_invalido
    cmp    byte[input_user_2], 51;ASCII para "3"
    ja     inter_comando_invalido

    cmp    byte[input_user_3], 49;ASCII para "1"
    jb     inter_comando_invalido
    cmp    byte[input_user_3], 51;ASCII para "3"
    ja     inter_comando_invalido

    cmp    byte[input_user_2], 50;ASCII para '2'
    jb     verifica_q1_q
    je     verifica_q2_q
    ja     verifica_q3_q


;_____________________________________________________________________________
;Printa que o usuário digitou uma jogada inválido e pede para ele digitar novamente
jogada_invalida:

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg

    ;Escreve o texto de comando inválido:
    mov     cx,15   ;número de caracteres
    mov     bx,0
    mov     dh,28    ;linha 0-29
    mov     dl,12    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_jogada_invalida:

    call    cursor
    mov     al,[bx+msg_jogada_invalida]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_jogada_invalida

    jmp     verifica_tecla


;_____________________________________________________________________________
;Verifica se alguns dos quadrantes estão ocupados
verifica_q1_q:
    
    cmp    byte[input_user_3], 50;ASCII para '2'
    jb     verifica_q11_q
    je     verifica_q12_q
    ja     verifica_q13_q

verifica_q2_q:
    
    cmp    byte[input_user_3], 50;ASCII para '2'
    jb     verifica_q21_q
    je     verifica_q22_q
    ja     verifica_q23_q

verifica_q3_q:
    
    cmp    byte[input_user_3], 50;ASCII para '2'
    jb     verifica_q31_q
    je     verifica_q32_q
    ja     verifica_q33_q

verifica_q11_q:
    cmp    byte[q11],0 
    jne    jogada_invalida
    jmp    desenha_q11_q

verifica_q12_q:
    cmp    byte[q12],0 
    jne    jogada_invalida
    jmp    desenha_q12_q

verifica_q13_q:
    cmp    byte[q13],0 
    jne    jogada_invalida
    jmp    desenha_q13_q


;_____________________________________________________________________________
;Intermediario jogada_invalida
inter_jogada_invalida2:
jmp jogada_invalida


verifica_q21_q:
    cmp    byte[q21],0 
    jne    jogada_invalida
    jmp    desenha_q21_q

verifica_q22_q:
    cmp    byte[q22],0 
    jne    inter_jogada_invalida2
    jmp    desenha_q22_q

verifica_q23_q:
    cmp    byte[q23],0 
    jne    inter_jogada_invalida2
    jmp    desenha_q23_q

verifica_q31_q:
    cmp    byte[q31],0 
    jne    inter_jogada_invalida2
    jmp    desenha_q31_q

verifica_q32_q:
    cmp    byte[q32],0 
    jne    inter_jogada_invalida2
    jmp    desenha_q32_q

verifica_q33_q:
    cmp    byte[q33],0 
    jne    inter_jogada_invalida2
    jmp    desenha_q33_q


;_____________________________________________________________________________
;Desenha a forma específica no quadrante desejado
desenha_q11_c:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'c'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o x em q11
    mov     byte[cor],azul_claro
    mov     ax,129
    push    ax
    mov     ax,319
    push    ax
    mov     ax,179
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],azul_claro
    mov     ax,179
    push    ax
    mov     ax,319
    push    ax
    mov     ax,129
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[q11],'c'

    jmp     verifica_ganhador

desenha_q12_c:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'c'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o x em q12
    mov     byte[cor],azul_claro
    mov     ax,294
    push    ax
    mov     ax,319
    push    ax
    mov     ax,344
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],azul_claro
    mov     ax,344
    push    ax
    mov     ax,319
    push    ax
    mov     ax,294
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[q12],'c'

    jmp     verifica_ganhador

desenha_q13_c:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'c'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o x em q13
    mov     byte[cor],azul_claro
    mov     ax,509
    push    ax
    mov     ax,319
    push    ax
    mov     ax,459
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],azul_claro
    mov     ax,459
    push    ax
    mov     ax,319
    push    ax
    mov     ax,509
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[q13],'c'

    jmp     verifica_ganhador

desenha_q21_c:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'c'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o x em q21
    mov     byte[cor],azul_claro
    mov     ax,129
    push    ax
    mov     ax,219
    push    ax
    mov     ax,179
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],azul_claro
    mov     ax,179
    push    ax
    mov     ax,219
    push    ax
    mov     ax,129
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[q21],'c'

    jmp     verifica_ganhador

desenha_q22_c:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'c'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o x em q22
    mov     byte[cor],azul_claro
    mov     ax,294
    push    ax
    mov     ax,219
    push    ax
    mov     ax,344
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],azul_claro
    mov     ax,344
    push    ax
    mov     ax,219
    push    ax
    mov     ax,294
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[q22],'c'

    jmp     verifica_ganhador

desenha_q23_c:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'c'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o x em q23
    mov     byte[cor],azul_claro
    mov     ax,509
    push    ax
    mov     ax,219
    push    ax
    mov     ax,459
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],azul_claro
    mov     ax,459
    push    ax
    mov     ax,219
    push    ax
    mov     ax,509
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[q23],'c'

    jmp     verifica_ganhador

desenha_q31_c:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'c'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o x em q31
    mov     byte[cor],azul_claro
    mov     ax,129
    push    ax
    mov     ax,119
    push    ax
    mov     ax,179
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],azul_claro
    mov     ax,179
    push    ax
    mov     ax,119
    push    ax
    mov     ax,129
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[q31],'c'

    jmp     verifica_ganhador

desenha_q32_c:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'c'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o x em q32
    mov     byte[cor],azul_claro
    mov     ax,294
    push    ax
    mov     ax,119
    push    ax
    mov     ax,344
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],azul_claro
    mov     ax,344
    push    ax
    mov     ax,119
    push    ax
    mov     ax,294
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[q32],'c'

    jmp     verifica_ganhador

desenha_q33_c:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'c'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o x em q33
    mov     byte[cor],azul_claro
    mov     ax,509
    push    ax
    mov     ax,119
    push    ax
    mov     ax,459
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],azul_claro
    mov     ax,459
    push    ax
    mov     ax,119
    push    ax
    mov     ax,509
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[q33],'c'

    jmp     verifica_ganhador

desenha_q11_q:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'q'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o q em q11
    mov     byte[cor],vermelho
    mov     ax,129
    push    ax
    mov     ax,319
    push    ax
    mov     ax,179
    push    ax
    mov     ax,319
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,179
    push    ax
    mov     ax,369
    push    ax
    mov     ax,129
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,129
    push    ax
    mov     ax,319
    push    ax
    mov     ax,129
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,179
    push    ax
    mov     ax,319
    push    ax
    mov     ax,179
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[q11],'q'

    jmp     verifica_ganhador

desenha_q12_q:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'q'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o q em q12
    mov     byte[cor],vermelho
    mov     ax,294
    push    ax
    mov     ax,319
    push    ax
    mov     ax,344
    push    ax
    mov     ax,319
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,344
    push    ax
    mov     ax,369
    push    ax
    mov     ax,294
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,294
    push    ax
    mov     ax,319
    push    ax
    mov     ax,294
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,344
    push    ax
    mov     ax,319
    push    ax
    mov     ax,344
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[q12],'q'

    jmp     verifica_ganhador

desenha_q13_q:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'q'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o q em q13
    mov     byte[cor],vermelho
    mov     ax,459
    push    ax
    mov     ax,319
    push    ax
    mov     ax,509
    push    ax
    mov     ax,319
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,509
    push    ax
    mov     ax,369
    push    ax
    mov     ax,459
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,459
    push    ax
    mov     ax,319
    push    ax
    mov     ax,459
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,509
    push    ax
    mov     ax,319
    push    ax
    mov     ax,509
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[q13],'q'

    jmp     verifica_ganhador

desenha_q21_q:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'q'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o q em q21
    mov     byte[cor],vermelho
    mov     ax,129
    push    ax
    mov     ax,219
    push    ax
    mov     ax,179
    push    ax
    mov     ax,219
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,179
    push    ax
    mov     ax,269
    push    ax
    mov     ax,129
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,129
    push    ax
    mov     ax,219
    push    ax
    mov     ax,129
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,179
    push    ax
    mov     ax,219
    push    ax
    mov     ax,179
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[q21],'q'

    jmp     verifica_ganhador

desenha_q22_q:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'q'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o q em q22
    mov     byte[cor],vermelho
    mov     ax,294
    push    ax
    mov     ax,219
    push    ax
    mov     ax,344
    push    ax
    mov     ax,219
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,344
    push    ax
    mov     ax,269
    push    ax
    mov     ax,294
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,294
    push    ax
    mov     ax,219
    push    ax
    mov     ax,294
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,344
    push    ax
    mov     ax,219
    push    ax
    mov     ax,344
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[q22],'q'

    jmp     verifica_ganhador

desenha_q23_q:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'q'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o q em q23
    mov     byte[cor],vermelho
    mov     ax,459
    push    ax
    mov     ax,219
    push    ax
    mov     ax,509
    push    ax
    mov     ax,219
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,509
    push    ax
    mov     ax,269
    push    ax
    mov     ax,459
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,459
    push    ax
    mov     ax,219
    push    ax
    mov     ax,459
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,509
    push    ax
    mov     ax,219
    push    ax
    mov     ax,509
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[q23],'q'

    jmp     verifica_ganhador    

desenha_q31_q:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'q'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o q em q31
    mov     byte[cor],vermelho
    mov     ax,129
    push    ax
    mov     ax,119
    push    ax
    mov     ax,179
    push    ax
    mov     ax,119
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,179
    push    ax
    mov     ax,169
    push    ax
    mov     ax,129
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,129
    push    ax
    mov     ax,119
    push    ax
    mov     ax,129
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,179
    push    ax
    mov     ax,119
    push    ax
    mov     ax,179
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[q31],'q'

    jmp     verifica_ganhador

desenha_q32_q:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'q'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o q em q32
    mov     byte[cor],vermelho
    mov     ax,294
    push    ax
    mov     ax,119
    push    ax
    mov     ax,344
    push    ax
    mov     ax,119
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,344
    push    ax
    mov     ax,169
    push    ax
    mov     ax,294
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,294
    push    ax
    mov     ax,119
    push    ax
    mov     ax,294
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,344
    push    ax
    mov     ax,119
    push    ax
    mov     ax,344
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[q32],'q'

    jmp     verifica_ganhador

desenha_q33_q:
    
    ;Informa ao programa que a ultima forma que foi desenhada
    mov     byte[ultimo_jogador],'q'

    ;Apaga a caixa de mensagens
    call    apaga_cx_msg
    ;Digita o comando anterior valido
    call    comando_anterior_valido

    ;Desenha o q em q33
    mov     byte[cor],vermelho
    mov     ax,459
    push    ax
    mov     ax,119
    push    ax
    mov     ax,509
    push    ax
    mov     ax,119
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,509
    push    ax
    mov     ax,169
    push    ax
    mov     ax,459
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,459
    push    ax
    mov     ax,119
    push    ax
    mov     ax,459
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],vermelho
    mov     ax,509
    push    ax
    mov     ax,119
    push    ax
    mov     ax,509
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[q33],'q'

    jmp     verifica_ganhador 


;_____________________________________________________________________________
;Verifica se houve um ganhador ou se houve empate
verifica_ganhador:

    jmp     verifica_ganhador_linhas

    ;Se o verifica_ganhador_linhas falhou, o programa retorna para próxima verificação
    verifica_linha_falhou:

    jmp     verifica_ganhador_colunas

    ;Se o verifica_ganhador_colunas falhou, o programa retorna para próxima verificação
    verifica_coluna_falhou:

    jmp     verifica_ganhador_diag

    ;Se o verifica_ganhador_diagonal falhou, houve empate
    verifica_diag_falhou:
    jmp     verifica_empate

    ;Se verifica_empate falhou, o jogo ainda não acabou
    verifica_empate_falhou:

    jmp  verifica_tecla


;_____________________________________________________________________________
;Verifica se houve um ganhador usando as linhas
verifica_ganhador_linhas:
    
    ;Carrega o ultimo jogador para ax
    mov    ah,byte[ultimo_jogador]

    linha_1:
    cmp    ah,byte[q11]
    jne    linha_2
    je     linha_12
        linha_12:
        cmp    ah,byte[q12]
        jne    linha_2
        je     linha_123
            linha_123:
            cmp    ah,byte[q13]
            ;Se igual houve ganhador na linha 1
            je     ganhou_linha_1

    linha_2:
    cmp    ah,byte[q21]
    jne    linha_3
    je     linha_22
        linha_22:
        cmp    ah,byte[q22]
        jne    linha_3
        je     linha_223
            linha_223:
            cmp    ah,byte[q23]
            ;Se igual houve ganhador na linha 2
            je     ganhou_linha_2

    linha_3:
    cmp    ah,byte[q31]
    jne    verifica_linha_falhou
    je     linha_32
        linha_32:
        cmp    ah,byte[q32]
        jne    verifica_linha_falhou
        je     linha_321
            linha_321:
            cmp    ah,byte[q33]
            ;Se igual houve ganhador na linha 3
            je     ganhou_linha_3

    jmp    verifica_linha_falhou    


;_____________________________________________________________________________
;Jogador ganhou usando uma sequência de linhas
ganhou_linha_1:

    mov     byte[cor],amarelo    ;linha 1
    mov     ax,89
    push    ax
    mov     ax,344
    push    ax
    mov     ax,549
    push    ax
    mov     ax,344
    push    ax
    call    line

    ;Significa que o jogo acabou
    mov     byte[game_end],1b

    jmp    msg_jogador_ganhou

ganhou_linha_2:

    mov     byte[cor],amarelo    ;linha 2
    mov     ax,89
    push    ax
    mov     ax,244
    push    ax
    mov     ax,549
    push    ax
    mov     ax,244
    push    ax
    call    line

    ;Significa que o jogo acabou
    mov     byte[game_end],1b

    jmp    msg_jogador_ganhou


ganhou_linha_3

    mov     byte[cor],amarelo    ;linha 3
    mov     ax,89
    push    ax
    mov     ax,144
    push    ax
    mov     ax,549
    push    ax
    mov     ax,144
    push    ax
    call    line

    ;Significa que o jogo acabou
    mov     byte[game_end],1b

    jmp    msg_jogador_ganhou


;_____________________________________________________________________________
;Verifica se houve um ganhador usando as colunas
verifica_ganhador_colunas:

    ;Carrega o ultimo jogador para ax
    mov    ah,byte[ultimo_jogador]

    coluna_1:
    cmp    ah,byte[q11]
    jne    coluna_2
    je     coluna_12
        coluna_12:
        cmp    ah,byte[q21]
        jne    coluna_2
        je     coluna_123
            coluna_123:
            cmp    ah,byte[q31]
            ;Se igual houve ganhador na coluna 1
            je     ganhou_coluna_1

    coluna_2:
    cmp    ah,byte[q12]
    jne    coluna_3
    je     coluna_22
        coluna_22:
        cmp    ah,byte[q22]
        jne    coluna_3
        je     coluna_223
            coluna_223:
            cmp    ah,byte[q32]
            ;Se igual houve ganhador na coluna 2
            je     ganhou_coluna_2

    coluna_3:
    cmp    ah,byte[q13]
    jne    inter_verifica_coluna_falhou
    je     coluna_32
        coluna_32:
        cmp    ah,byte[q23]
        jne    inter_verifica_coluna_falhou
        je     coluna_323
            coluna_323:
            cmp    ah,byte[q33]
            ;Se igual houve ganhador na coluna 3
            je     ganhou_coluna_3

    inter_verifica_coluna_falhou:
    jmp    verifica_coluna_falhou


;_____________________________________________________________________________
;Jogador ganhou usando uma sequência de colunas
ganhou_coluna_1:

    mov     byte[cor],amarelo    ;coluna 1
    mov     ax,154
    push    ax
    mov     ax,99
    push    ax
    mov     ax,154
    push    ax
    mov     ax,399
    push    ax
    call    line

    ;Significa que o jogo acabou
    mov     byte[game_end],1b

    jmp    msg_jogador_ganhou


ganhou_coluna_2:
    
    mov     byte[cor],amarelo    ;coluna 2
    mov     ax,319
    push    ax
    mov     ax,99
    push    ax
    mov     ax,319
    push    ax
    mov     ax,399
    push    ax
    call    line

    ;Significa que o jogo acabou
    mov     byte[game_end],1b

    jmp    msg_jogador_ganhou


ganhou_coluna_3
    
    mov     byte[cor],amarelo    ;coluna 3
    mov     ax,484
    push    ax
    mov     ax,99
    push    ax
    mov     ax,484
    push    ax
    mov     ax,399
    push    ax
    call    line

    ;Significa que o jogo acabou
    mov     byte[game_end],1b

    jmp    msg_jogador_ganhou

;_____________________________________________________________________________
;Verifica se houve um ganhador usando as diagonais
verifica_ganhador_diag:

    ;Carrega o ultimo jogador para ax
    mov    ah,byte[ultimo_jogador]

    diag_1:
    cmp    ah,byte[q11]
    jne    diag_2
    je     diag_12
        diag_12:
        cmp    ah,byte[q22]
        jne    diag_2
        je     diag_123
            diag_123:
            cmp    ah,byte[q33]
            ;Se igual houve ganhador na diagonal 1
            je     ganhou_diag_1

    diag_2:
    cmp    ah,byte[q31]
    jne    inter_verifica_diag_falhou
    je     diag_22
        diag_22:
        cmp    ah,byte[q22]
        jne    inter_verifica_diag_falhou
        je     diag_223
            diag_223:
            cmp    ah,byte[q13]
            ;Se igual houve ganhador na diagonal 2
            je     ganhou_diag_2

    inter_verifica_diag_falhou:
    jmp    verifica_diag_falhou


;_____________________________________________________________________________
;Jogador ganhou usando uma sequência de diagonais
ganhou_diag_1:
    
    mov     byte[cor],amarelo    ;diagonal 1
    mov     ax,89
    push    ax
    mov     ax,399
    push    ax
    mov     ax,549
    push    ax
    mov     ax,99
    push    ax
    call    line

    ;Significa que o jogo acabou
    mov     byte[game_end],1b

    jmp    msg_jogador_ganhou


ganhou_diag_2:

    mov     byte[cor],amarelo    ;diagonal 2
    mov     ax,89
    push    ax
    mov     ax,99
    push    ax
    mov     ax,549
    push    ax
    mov     ax,399
    push    ax
    call    line

    ;Significa que o jogo acabou
    mov     byte[game_end],1b

    jmp    msg_jogador_ganhou


;_____________________________________________________________________________
;Verifica se houve um empate
verifica_empate:

    ;Verifica se todos os quadrantes estão preenchidos
    cmp    byte[q11],0
    je     inter_verifica_empate_falhou
    cmp    byte[q12],0
    je     inter_verifica_empate_falhou
    cmp    byte[q13],0
    je     inter_verifica_empate_falhou
    cmp    byte[q21],0
    je     inter_verifica_empate_falhou
    cmp    byte[q22],0
    je     inter_verifica_empate_falhou
    cmp    byte[q23],0
    je     inter_verifica_empate_falhou
    cmp    byte[q31],0
    je     inter_verifica_empate_falhou
    cmp    byte[q32],0
    je     inter_verifica_empate_falhou
    cmp    byte[q33],0
    je     inter_verifica_empate_falhou

    ;Se todas estão preechidas, empatou

    mov     cx,7   ;número de caracteres
    mov     bx,0
    mov     dh,28    ;linha 0-29
    mov     dl,12    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_empate:

    call    cursor
    mov     al,[bx+msg_empate]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_empate

    ;Significa que o jogo acabou
    mov     byte[game_end],1b

    jmp     verifica_tecla

    inter_verifica_empate_falhou:
    jmp    verifica_empate_falhou


;_____________________________________________________________________________
;Zera as varáveis fazendo o layout voltar para sua forma inicial
zera_variaveis:

    ;Reseta as variáveis
    mov     byte[input_user_1],0
    mov     byte[input_user_2],0
    mov     byte[input_user_3],0
    mov     byte[ultimo_jogador],0
    mov     byte[q11],0
    mov     byte[q12],0
    mov     byte[q13],0
    mov     byte[q21],0
    mov     byte[q22],0
    mov     byte[q23],0
    mov     byte[q31],0
    mov     byte[q32],0
    mov     byte[q33],0
    mov     byte[game_end],0b
  

    ;Apaga os campos de mensagens
    call    comando_anterior_valido
    call    apaga_cx_msg
    call    apaga_comando_atual

    ;Apaga o jogo da velha
    call    apaga_jogo_velha

    ret


;_____________________________________________________________________________
;Apaga a caixa de mensagens
apaga_cx_msg:
    
    mov     cx,25   ;número de caracteres
    mov     bx,0
    mov     dh,28    ;linha 0-29
    mov     dl,12    ;coluna 0-79
    mov     byte[cor],preto

    loop_apaga_cx_msg:

    call    cursor
    mov     al,[bx+0]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_apaga_cx_msg

    ret


;_____________________________________________________________________________
;Escreve comando anterior valido
comando_anterior_valido:

    mov     bx,0
    mov     dh,26   ;linha 0-29
    mov     dl,41   ;coluna 0-79
    mov     byte[cor],branco_intenso
    call    cursor
    mov     al,[bx+input_user_1]    
    call    caracter
    mov     bx,0
    mov     dh,26   ;linha 0-29
    mov     dl,42   ;coluna 0-79
    mov     byte[cor],branco_intenso
    call    cursor
    mov     al,[bx+input_user_2]    
    call    caracter
    mov     bx,0
    mov     dh,26   ;linha 0-29
    mov     dl,43   ;coluna 0-79
    mov     byte[cor],branco_intenso
    call    cursor
    mov     al,[bx+input_user_3]    
    call    caracter

    ret


;_____________________________________________________________________________
;Apaga comando atual
apaga_comando_atual:

    mov     bx,0
    mov     dh,26   ;linha 0-29
    mov     dl,12   ;coluna 0-79
    mov     byte[cor],preto
    call    cursor
    mov     al,[bx+0]    
    call    caracter
    mov     bx,0
    mov     dh,26   ;linha 0-29
    mov     dl,13   ;coluna 0-79
    mov     byte[cor],preto
    call    cursor
    mov     al,[bx+0]    
    call    caracter
    mov     bx,0
    mov     dh,26   ;linha 0-29
    mov     dl,14   ;coluna 0-79
    mov     byte[cor],preto
    call    cursor
    mov     al,[bx+0]    
    call    caracter

    ret


;_____________________________________________________________________________
;Printa mensagem sobre qual jogador ganhou
msg_jogador_ganhou:

    cmp     byte[ultimo_jogador],'q'
    je      jogador_q_ganhou

    jogador_x_ganhou:
    mov     cx,16   ;número de caracteres
    mov     bx,0
    mov     dh,28    ;linha 0-29
    mov     dl,12    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_jog_x:

    call    cursor
    mov     al,[bx+msg_jog_x]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_jog_x

    jmp     verifica_tecla

    jogador_q_ganhou:
    mov     cx,16   ;número de caracteres
    mov     bx,0
    mov     dh,28    ;linha 0-29
    mov     dl,12    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_jog_q:

    call    cursor
    mov     al,[bx+msg_jog_q]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_jog_q

    jmp     verifica_tecla


;_____________________________________________________________________________
;Apaga jogo da velha
apaga_jogo_velha:

    mov     byte[cor],preto
    mov     ax,129
    push    ax
    mov     ax,319
    push    ax
    mov     ax,179
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,179
    push    ax
    mov     ax,319
    push    ax
    mov     ax,129
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,294
    push    ax
    mov     ax,319
    push    ax
    mov     ax,344
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,344
    push    ax
    mov     ax,319
    push    ax
    mov     ax,294
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,509
    push    ax
    mov     ax,319
    push    ax
    mov     ax,459
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,459
    push    ax
    mov     ax,319
    push    ax
    mov     ax,509
    push    ax
    mov     ax,369
    push    ax
    call    line
    
    mov     byte[cor],preto
    mov     ax,129
    push    ax
    mov     ax,219
    push    ax
    mov     ax,179
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,179
    push    ax
    mov     ax,219
    push    ax
    mov     ax,129
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,294
    push    ax
    mov     ax,219
    push    ax
    mov     ax,344
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,344
    push    ax
    mov     ax,219
    push    ax
    mov     ax,294
    push    ax
    mov     ax,269
    push    ax
    call    line
    
    mov     byte[cor],preto
    mov     ax,509
    push    ax
    mov     ax,219
    push    ax
    mov     ax,459
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,459
    push    ax
    mov     ax,219
    push    ax
    mov     ax,509
    push    ax
    mov     ax,269
    push    ax
    call    line
    
    mov     byte[cor],preto
    mov     ax,129
    push    ax
    mov     ax,119
    push    ax
    mov     ax,179
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,179
    push    ax
    mov     ax,119
    push    ax
    mov     ax,129
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,294
    push    ax
    mov     ax,119
    push    ax
    mov     ax,344
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,344
    push    ax
    mov     ax,119
    push    ax
    mov     ax,294
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,509
    push    ax
    mov     ax,119
    push    ax
    mov     ax,459
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,459
    push    ax
    mov     ax,119
    push    ax
    mov     ax,509
    push    ax
    mov     ax,169
    push    ax
    call    line
    
    mov     byte[cor],preto
    mov     ax,129
    push    ax
    mov     ax,319
    push    ax
    mov     ax,179
    push    ax
    mov     ax,319
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,179
    push    ax
    mov     ax,369
    push    ax
    mov     ax,129
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,129
    push    ax
    mov     ax,319
    push    ax
    mov     ax,129
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,179
    push    ax
    mov     ax,319
    push    ax
    mov     ax,179
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,294
    push    ax
    mov     ax,319
    push    ax
    mov     ax,344
    push    ax
    mov     ax,319
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,344
    push    ax
    mov     ax,369
    push    ax
    mov     ax,294
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,294
    push    ax
    mov     ax,319
    push    ax
    mov     ax,294
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,344
    push    ax
    mov     ax,319
    push    ax
    mov     ax,344
    push    ax
    mov     ax,369
    push    ax
    call    line
    
    mov     byte[cor],preto
    mov     ax,459
    push    ax
    mov     ax,319
    push    ax
    mov     ax,509
    push    ax
    mov     ax,319
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,509
    push    ax
    mov     ax,369
    push    ax
    mov     ax,459
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,459
    push    ax
    mov     ax,319
    push    ax
    mov     ax,459
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,509
    push    ax
    mov     ax,319
    push    ax
    mov     ax,509
    push    ax
    mov     ax,369
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,129
    push    ax
    mov     ax,219
    push    ax
    mov     ax,179
    push    ax
    mov     ax,219
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,179
    push    ax
    mov     ax,269
    push    ax
    mov     ax,129
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,129
    push    ax
    mov     ax,219
    push    ax
    mov     ax,129
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,179
    push    ax
    mov     ax,219
    push    ax
    mov     ax,179
    push    ax
    mov     ax,269
    push    ax
    call    line
    
    mov     byte[cor],preto
    mov     ax,294
    push    ax
    mov     ax,219
    push    ax
    mov     ax,344
    push    ax
    mov     ax,219
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,344
    push    ax
    mov     ax,269
    push    ax
    mov     ax,294
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,294
    push    ax
    mov     ax,219
    push    ax
    mov     ax,294
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,344
    push    ax
    mov     ax,219
    push    ax
    mov     ax,344
    push    ax
    mov     ax,269
    push    ax
    call    line
    
    mov     byte[cor],preto
    mov     ax,459
    push    ax
    mov     ax,219
    push    ax
    mov     ax,509
    push    ax
    mov     ax,219
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,509
    push    ax
    mov     ax,269
    push    ax
    mov     ax,459
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,459
    push    ax
    mov     ax,219
    push    ax
    mov     ax,459
    push    ax
    mov     ax,269
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,509
    push    ax
    mov     ax,219
    push    ax
    mov     ax,509
    push    ax
    mov     ax,269
    push    ax
    call    line
    
    mov     byte[cor],preto
    mov     ax,129
    push    ax
    mov     ax,119
    push    ax
    mov     ax,179
    push    ax
    mov     ax,119
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,179
    push    ax
    mov     ax,169
    push    ax
    mov     ax,129
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,129
    push    ax
    mov     ax,119
    push    ax
    mov     ax,129
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,179
    push    ax
    mov     ax,119
    push    ax
    mov     ax,179
    push    ax
    mov     ax,169
    push    ax
    call    line
    
    mov     byte[cor],preto
    mov     ax,294
    push    ax
    mov     ax,119
    push    ax
    mov     ax,344
    push    ax
    mov     ax,119
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,344
    push    ax
    mov     ax,169
    push    ax
    mov     ax,294
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,294
    push    ax
    mov     ax,119
    push    ax
    mov     ax,294
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,344
    push    ax
    mov     ax,119
    push    ax
    mov     ax,344
    push    ax
    mov     ax,169
    push    ax
    call    line
    
    mov     byte[cor],preto
    mov     ax,459
    push    ax
    mov     ax,119
    push    ax
    mov     ax,509
    push    ax
    mov     ax,119
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,509
    push    ax
    mov     ax,169
    push    ax
    mov     ax,459
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,459
    push    ax
    mov     ax,119
    push    ax
    mov     ax,459
    push    ax
    mov     ax,169
    push    ax
    call    line

    mov     byte[cor],preto
    mov     ax,509
    push    ax
    mov     ax,119
    push    ax
    mov     ax,509
    push    ax
    mov     ax,169
    push    ax
    call    line

    ;Linhas de vitória
    mov     byte[cor],preto    ;linha 1
    mov     ax,89
    push    ax
    mov     ax,344
    push    ax
    mov     ax,549
    push    ax
    mov     ax,344
    push    ax
    call    line

    mov     byte[cor],preto    ;linha 2
    mov     ax,89
    push    ax
    mov     ax,244
    push    ax
    mov     ax,549
    push    ax
    mov     ax,244
    push    ax
    call    line

    mov     byte[cor],preto    ;linha 3
    mov     ax,89
    push    ax
    mov     ax,144
    push    ax
    mov     ax,549
    push    ax
    mov     ax,144
    push    ax
    call    line

    mov     byte[cor],preto    ;coluna 1
    mov     ax,154
    push    ax
    mov     ax,99
    push    ax
    mov     ax,154
    push    ax
    mov     ax,399
    push    ax
    call    line

    mov     byte[cor],preto    ;coluna 2
    mov     ax,319
    push    ax
    mov     ax,99
    push    ax
    mov     ax,319
    push    ax
    mov     ax,399
    push    ax
    call    line

    mov     byte[cor],preto    ;coluna 3
    mov     ax,484
    push    ax
    mov     ax,99
    push    ax
    mov     ax,484
    push    ax
    mov     ax,399
    push    ax
    call    line

    mov     byte[cor],preto    ;diagonal 1
    mov     ax,89
    push    ax
    mov     ax,399
    push    ax
    mov     ax,549
    push    ax
    mov     ax,99
    push    ax
    call    line

    mov     byte[cor],preto    ;diagonal 2
    mov     ax,89
    push    ax
    mov     ax,99
    push    ax
    mov     ax,549
    push    ax
    mov     ax,399
    push    ax
    call    line

    ret
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
        push        ax
        push        bx
        push        cx
        push        dx
        push        si
        push        di
        push        bp
        mov         ah,2
        mov         bh,0
        int         10h
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
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
        push        ax
        push        bx
        push        cx
        push        dx
        push        si
        push        di
        push        bp
            mov         ah,9
            mov         bh,0
            mov         cx,1
        mov         bl,[cor]
            int         10h
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        popf
        ret
;_____________________________________________________________________________
;
;   função plot_xy
;
; push x; push y; call plot_xy;  (x<639, y<479)
; cor definida na variavel cor
plot_xy:
        push        bp
        mov     bp,sp
        pushf
        push        ax
        push        bx
        push        cx
        push        dx
        push        si
        push        di
        mov         ah,0ch
        mov         al,[cor]
        mov         bh,0
        mov         dx,479
        sub     dx,[bp+4]
        mov         cx,[bp+6]
        int         10h
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        popf
        pop     bp
        ret     4
;_____________________________________________________________________________
;    função circle
;    push xc; push yc; push r; call circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor
circle:
    push    bp
    mov     bp,sp
    pushf                        ;coloca os flags na pilha
    push    ax
    push    bx
    push    cx
    push    dx
    push    si
    push    di
    
    mov     ax,[bp+8]    ; resgata xc
    mov     bx,[bp+6]    ; resgata yc
    mov     cx,[bp+4]    ; resgata r
    
    mov     dx,bx   
    add     dx,cx       ;ponto extremo superior
    push    ax          
    push    dx
    call plot_xy
    
    mov     dx,bx
    sub     dx,cx       ;ponto extremo inferior
    push    ax          
    push    dx
    call plot_xy
    
    mov     dx,ax   
    add     dx,cx       ;ponto extremo direita
    push    dx          
    push    bx
    call plot_xy
    
    mov     dx,ax
    sub     dx,cx       ;ponto extremo esquerda
    push    dx          
    push    bx
    call plot_xy
        
    mov     di,cx
    sub     di,1     ;di=r-1
    mov     dx,0    ;dx será a variável x. cx é a variavel y
    
;aqui em cima a lógica foi invertida, 1-r => r-1
;e as comparações passaram a ser jl => jg, assim garante 
;valores positivos para d

stay:               ;loop
    mov     si,di
    cmp     si,0
    jg      inf       ;caso d for menor que 0, seleciona pixel superior (não  salta)
    mov     si,dx       ;o jl é importante porque trata-se de conta com sinal
    sal     si,1        ;multiplica por doi (shift arithmetic left)
    add     si,3
    add     di,si     ;nesse ponto d=d+2*dx+3
    inc     dx      ;incrementa dx
    jmp     plotar
inf:    
    mov     si,dx
    sub     si,cx       ;faz x - y (dx-cx), e salva em di 
    sal     si,1
    add     si,5
    add     di,si       ;nesse ponto d=d+2*(dx-cx)+5
    inc     dx      ;incrementa x (dx)
    dec     cx      ;decrementa y (cx)
    
plotar: 
    mov     si,dx
    add     si,ax
    push    si          ;coloca a abcisa x+xc na pilha
    mov     si,cx
    add     si,bx
    push    si          ;coloca a ordenada y+yc na pilha
    call plot_xy        ;toma conta do segundo octante
    mov     si,ax
    add     si,dx
    push    si          ;coloca a abcisa xc+x na pilha
    mov     si,bx
    sub     si,cx
    push    si          ;coloca a ordenada yc-y na pilha
    call plot_xy        ;toma conta do sétimo octante
    mov     si,ax
    add     si,cx
    push    si          ;coloca a abcisa xc+y na pilha
    mov     si,bx
    add     si,dx
    push    si          ;coloca a ordenada yc+x na pilha
    call plot_xy        ;toma conta do segundo octante
    mov     si,ax
    add     si,cx
    push    si          ;coloca a abcisa xc+y na pilha
    mov     si,bx
    sub     si,dx
    push    si          ;coloca a ordenada yc-x na pilha
    call plot_xy        ;toma conta do oitavo octante
    mov     si,ax
    sub     si,dx
    push    si          ;coloca a abcisa xc-x na pilha
    mov     si,bx
    add     si,cx
    push    si          ;coloca a ordenada yc+y na pilha
    call plot_xy        ;toma conta do terceiro octante
    mov     si,ax
    sub     si,dx
    push    si          ;coloca a abcisa xc-x na pilha
    mov     si,bx
    sub     si,cx
    push    si          ;coloca a ordenada yc-y na pilha
    call plot_xy        ;toma conta do sexto octante
    mov     si,ax
    sub     si,cx
    push    si          ;coloca a abcisa xc-y na pilha
    mov     si,bx
    sub     si,dx
    push    si          ;coloca a ordenada yc-x na pilha
    call plot_xy        ;toma conta do quinto octante
    mov     si,ax
    sub     si,cx
    push    si          ;coloca a abcisa xc-y na pilha
    mov     si,bx
    add     si,dx
    push    si          ;coloca a ordenada yc-x na pilha
    call plot_xy        ;toma conta do quarto octante
    
    cmp     cx,dx
    jb      fim_circle  ;se cx (y) está abaixo de dx (x), termina     
    jmp     stay        ;se cx (y) está acima de dx (x), continua no loop
    
    
fim_circle:
    pop     di
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    popf
    pop     bp
    ret     6
;-----------------------------------------------------------------------------
;    função full_circle
;    push xc; push yc; push r; call full_circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor                    
full_circle:
    push    bp
    mov     bp,sp
    pushf                        ;coloca os flags na pilha
    push    ax
    push    bx
    push    cx
    push    dx
    push    si
    push    di

    mov     ax,[bp+8]    ; resgata xc
    mov     bx,[bp+6]    ; resgata yc
    mov     cx,[bp+4]    ; resgata r
    
    mov     si,bx
    sub     si,cx
    push    ax          ;coloca xc na pilha         
    push    si          ;coloca yc-r na pilha
    mov     si,bx
    add     si,cx
    push    ax      ;coloca xc na pilha
    push    si      ;coloca yc+r na pilha
    call line
    
        
    mov     di,cx
    sub     di,1     ;di=r-1
    mov     dx,0    ;dx será a variável x. cx é a variavel y
    
;aqui em cima a lógica foi invertida, 1-r => r-1
;e as comparações passaram a ser jl => jg, assim garante 
;valores positivos para d

stay_full:              ;loop
    mov     si,di
    cmp     si,0
    jg      inf_full       ;caso d for menor que 0, seleciona pixel superior (não  salta)
    mov     si,dx       ;o jl é importante porque trata-se de conta com sinal
    sal     si,1        ;multiplica por doi (shift arithmetic left)
    add     si,3
    add     di,si     ;nesse ponto d=d+2*dx+3
    inc     dx      ;incrementa dx
    jmp     plotar_full
inf_full:   
    mov     si,dx
    sub     si,cx       ;faz x - y (dx-cx), e salva em di 
    sal     si,1
    add     si,5
    add     di,si       ;nesse ponto d=d+2*(dx-cx)+5
    inc     dx      ;incrementa x (dx)
    dec     cx      ;decrementa y (cx)
    
plotar_full:    
    mov     si,ax
    add     si,cx
    push    si      ;coloca a abcisa y+xc na pilha          
    mov     si,bx
    sub     si,dx
    push    si      ;coloca a ordenada yc-x na pilha
    mov     si,ax
    add     si,cx
    push    si      ;coloca a abcisa y+xc na pilha  
    mov     si,bx
    add     si,dx
    push    si      ;coloca a ordenada yc+x na pilha    
    call    line
    
    mov     si,ax
    add     si,dx
    push    si      ;coloca a abcisa xc+x na pilha          
    mov     si,bx
    sub     si,cx
    push    si      ;coloca a ordenada yc-y na pilha
    mov     si,ax
    add     si,dx
    push    si      ;coloca a abcisa xc+x na pilha  
    mov     si,bx
    add     si,cx
    push    si      ;coloca a ordenada yc+y na pilha    
    call    line
    
    mov     si,ax
    sub     si,dx
    push    si      ;coloca a abcisa xc-x na pilha          
    mov     si,bx
    sub     si,cx
    push    si      ;coloca a ordenada yc-y na pilha
    mov     si,ax
    sub     si,dx
    push    si      ;coloca a abcisa xc-x na pilha  
    mov     si,bx
    add     si,cx
    push    si      ;coloca a ordenada yc+y na pilha    
    call    line
    
    mov     si,ax
    sub     si,cx
    push    si      ;coloca a abcisa xc-y na pilha          
    mov     si,bx
    sub     si,dx
    push    si      ;coloca a ordenada yc-x na pilha
    mov     si,ax
    sub     si,cx
    push    si      ;coloca a abcisa xc-y na pilha  
    mov     si,bx
    add     si,dx
    push    si      ;coloca a ordenada yc+x na pilha    
    call    line
    
    cmp     cx,dx
    jb      fim_full_circle  ;se cx (y) está abaixo de dx (x), termina     
    jmp     stay_full       ;se cx (y) está acima de dx (x), continua no loop
    
    
fim_full_circle:
    pop     di
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    popf
    pop     bp
    ret     6
;-----------------------------------------------------------------------------
;
;   função line
;
; push x1; push y1; push x2; push y2; call line;  (x<639, y<479)
line:
        push        bp
        mov     bp,sp
        pushf                        ;coloca os flags na pilha
        push        ax
        push        bx
        push        cx
        push        dx
        push        si
        push        di
        mov     ax,[bp+10]   ; resgata os valores das coordenadas
        mov     bx,[bp+8]    ; resgata os valores das coordenadas
        mov     cx,[bp+6]    ; resgata os valores das coordenadas
        mov     dx,[bp+4]    ; resgata os valores das coordenadas
        cmp     ax,cx
        je      line2
        jb      line1
        xchg        ax,cx
        xchg        bx,dx
        jmp     line1
line2:      ; deltax=0
        cmp     bx,dx  ;subtrai dx de bx
        jb      line3
        xchg        bx,dx        ;troca os valores de bx e dx entre eles
line3:  ; dx > bx
        push        ax
        push        bx
        call        plot_xy
        cmp     bx,dx
        jne     line31
        jmp     fim_line
line31:     inc     bx
        jmp     line3
;deltax <>0
line1:
; comparar módulos de deltax e deltay sabendo que cx>ax
    ; cx > ax
        push        cx
        sub     cx,ax
        mov     [deltax],cx
        pop     cx
        push        dx
        sub     dx,bx
        ja      line32
        neg     dx
line32:     
        mov     [deltay],dx
        pop     dx

        push        ax
        mov     ax,[deltax]
        cmp     ax,[deltay]
        pop     ax
        jb      line5

    ; cx > ax e deltax>deltay
        push        cx
        sub     cx,ax
        mov     [deltax],cx
        pop     cx
        push        dx
        sub     dx,bx
        mov     [deltay],dx
        pop     dx

        mov     si,ax
line4:
        push        ax
        push        dx
        push        si
        sub     si,ax   ;(x-x1)
        mov     ax,[deltay]
        imul        si
        mov     si,[deltax]     ;arredondar
        shr     si,1
; se numerador (DX)>0 soma se <0 subtrai
        cmp     dx,0
        jl      ar1
        add     ax,si
        adc     dx,0
        jmp     arc1
ar1:        sub     ax,si
        sbb     dx,0
arc1:
        idiv        word [deltax]
        add     ax,bx
        pop     si
        push        si
        push        ax
        call        plot_xy
        pop     dx
        pop     ax
        cmp     si,cx
        je      fim_line
        inc     si
        jmp     line4

line5:      cmp     bx,dx
        jb      line7
        xchg        ax,cx
        xchg        bx,dx
line7:
        push        cx
        sub     cx,ax
        mov     [deltax],cx
        pop     cx
        push        dx
        sub     dx,bx
        mov     [deltay],dx
        pop     dx



        mov     si,bx
line6:
        push        dx
        push        si
        push        ax
        sub     si,bx   ;(y-y1)
        mov     ax,[deltax]
        imul        si
        mov     si,[deltay]     ;arredondar
        shr     si,1
; se numerador (DX)>0 soma se <0 subtrai
        cmp     dx,0
        jl      ar2
        add     ax,si
        adc     dx,0
        jmp     arc2
ar2:        sub     ax,si
        sbb     dx,0
arc2:
        idiv        word [deltay]
        mov     di,ax
        pop     ax
        add     di,ax
        pop     si
        push        di
        push        si
        call        plot_xy
        pop     dx
        cmp     si,dx
        je      fim_line
        inc     si
        jmp     line6

fim_line:
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        popf
        pop     bp
        ret     8
;_____________________________________________________________________________
;_____________________________________________________________________________


;_______________________________________________________________________________________
;Definição das variáveis
segment data
;_____________________________________________________________________________
;_____________________________________________________________________________
;Variaveis criadas por mim
texto_1                 db      'TC-2021_2 Mateus Souza Coelho Turma 6.2';39 caracteres
comandos                db      'Comandos:';9 caracteres
mensagens               db      'Mensagens:';10 caracteres
msg_comando_invalido    db      'Comando invalido';16 caracteres      
msg_jogada_invalida     db      'Jogada invalida';15 caracteres
msg_jog_x               db      'Jogador X ganhou';16 caracteres
msg_jog_q               db      'Jogador Q ganhou';16 caracteres
msg_empate              db      'Empatou';7 caracteres
msg_11                  db      '11'
msg_12                  db      '12'
msg_13                  db      '13'
msg_21                  db      '21'
msg_22                  db      '22'
msg_23                  db      '23'
msg_31                  db      '31'
msg_32                  db      '32'
msg_33                  db      '33'
input_user_1            db       0
input_user_2            db       0
input_user_3            db       0
ultimo_jogador          db       0
;Variaveis de estado para os quadrantes, se 0 está vazio, se 'c' tem um x, se 'q' tem um q
q11                     db       0
q12                     db       0
q13                     db       0
q21                     db       0
q22                     db       0
q23                     db       0
q31                     db       0
q32                     db       0
q33                     db       0
game_end                db       0b
;_____________________________________________________________________________
;_____________________________________________________________________________


;_____________________________________________________________________________
;_____________________________________________________________________________
;Variaveis do linec
cor     db      branco_intenso

;   I R G B COR
;   0 0 0 0 preto
;   0 0 0 1 azul
;   0 0 1 0 verde
;   0 0 1 1 cyan
;   0 1 0 0 vermelho
;   0 1 0 1 magenta
;   0 1 1 0 marrom
;   0 1 1 1 branco
;   1 0 0 0 cinza
;   1 0 0 1 azul claro
;   1 0 1 0 verde claro
;   1 0 1 1 cyan claro
;   1 1 0 0 rosa
;   1 1 0 1 magenta claro
;   1 1 1 0 amarelo
;   1 1 1 1 branco intenso

preto       equ     0
azul        equ     1
verde       equ     2
cyan        equ     3
vermelho    equ     4
magenta     equ     5
marrom      equ     6
branco      equ     7
cinza       equ     8
azul_claro  equ     9
verde_claro equ     10
cyan_claro  equ     11
rosa        equ     12
magenta_claro   equ     13
amarelo     equ     14
branco_intenso  equ     15

modo_anterior   db      0
linha       dw          0
coluna      dw          0
deltax      dw      0
deltay      dw      0   
mens        db          'Funcao Grafica'
;_____________________________________________________________________________
;_____________________________________________________________________________


;_______________________________________________________________________________________
; Reserva 256 bytes para pilha
segment stack stack
            resb        512
stacktop:
