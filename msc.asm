;Código feito por: Mateus Souza Coelho - 2018205790
;Turma 6.2 - Sistemas Embarcados 1
;Engenharia elétrica - UFES


segment code
..start:
;Inicia os registros de segmento DS e SS e o ponteiro de pilha SP
    mov     ax,data
    mov     ds,ax
    mov     ax,stack
    mov     ss,ax
    mov     sp,stacktop

;Salvar modo corrente de video(vendo como está o modo de video da maquina)
    mov     ah,0Fh
    int     10h
    mov     [modo_anterior],al   
;Alterar modo de video para gráfico 640x480 16 cores
    mov     al,12h
    mov     ah,0
    int     10h

;_____________________________________________________________________________
;_____________________________________________________________________________
;Funções criadas por mim

;Desenha o layout inicial do relógio
relogio_start:

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
    mov     ax,1
    push    ax
    mov     ax,89
    push    ax
    mov     ax,120
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra superior texto inferior
    mov     ax,89
    push    ax
    mov     ax,120
    push    ax
    mov     ax,549
    push    ax
    mov     ax,120
    push    ax
    call    line

    mov     byte[cor],branco_intenso    ;Barra direita texto inferior
    mov     ax,549
    push    ax
    mov     ax,1
    push    ax
    mov     ax,549
    push    ax
    mov     ax,120
    push    ax
    call    line


    ;Escreve o texto_1
    mov     cx,39   ;número de caracteres
    mov     bx,0
    mov     dh,1    ;linha 0-29
    mov     dl,21   ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_msg1:

    call    cursor
    mov     al,[bx+texto_1]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_msg1

    ;Escreve o texto Hora:
    mov     cx,5   ;número de caracteres
    mov     bx,0
    mov     dh,14    ;linha 0-29
    mov     dl,34    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_hora:

    call    cursor
    mov     al,[bx+hora]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_hora


    ;Escreve o menu:
    mov     cx,15   ;número de caracteres
    mov     bx,0
    mov     dh,23    ;linha 0-29
    mov     dl,25    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_menu:

    call    cursor
    mov     al,[bx+menu]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_menu

    ;Escreve o texto de x:
    mov     cx,7   ;número de caracteres
    mov     bx,0
    mov     dh,24    ;linha 0-29
    mov     dl,25    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_msg_x:

    call    cursor
    mov     al,[bx+msg_x]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_msg_x

    ;Escreve o texto de s:
    mov     cx,31   ;número de caracteres
    mov     bx,0
    mov     dh,25    ;linha 0-29
    mov     dl,25    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_msg_s:

    call    cursor
    mov     al,[bx+msg_s]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_msg_s

    ;Escreve o texto de m:
    mov     cx,30   ;número de caracteres
    mov     bx,0
    mov     dh,26    ;linha 0-29
    mov     dl,25    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_msg_m:

    call    cursor
    mov     al,[bx+msg_m]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_msg_m

    ;Escreve o texto de h:
    mov     cx,28   ;número de caracteres
    mov     bx,0
    mov     dh,27    ;linha 0-29
    mov     dl,25    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_msg_h:

    call    cursor
    mov     al,[bx+msg_h]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_msg_h

    ;Escreve o texto de p:
    mov     cx,33   ;número de caracteres
    mov     bx,0
    mov     dh,28    ;linha 0-29
    mov     dl,25    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_msg_p:

    call    cursor
    mov     al,[bx+msg_p]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_msg_p

    ;Escreve o texto de r:
    mov     cx,33   ;número de caracteres
    mov     bx,0
    mov     dh,29    ;linha 0-29
    mov     dl,25    ;coluna 0-79
    mov     byte[cor],branco_intenso

    loop_msg_r:

    call    cursor
    mov     al,[bx+msg_r]    
    call    caracter
    inc     bx          ;proximo caracter
    inc     dl          ;avanca a coluna
    loop    loop_msg_r

    ;_____________________________________________________________________________
    ;Parte do Código relogio.asm
    xor     ax, ax
    mov     es, ax
    mov     ax, [es:intr*4];carregou ax com offset anterior
    mov     [offset_dos_relogio], ax        ; offset_dos guarda o end. para qual ip de int 9 estava apontando anteriormente
    mov     ax, [es:intr*4+2]     ; cs_dos guarda o end. anterior de cs
    mov     [cs_dos_relogio], ax
    cli     
    mov     [es:intr*4+2], cs
    mov     word[es:intr*4],relogio
    ;_____________________________________________________________________________
    ;Parte do Código relogio.asm

    ;_____________________________________________________________________________
    ;Parte do Código tecbuf.asm
    XOR     AX, AX
    MOV     ES, AX
    MOV     AX, [ES:int9*4];carregou AX com offset anterior
    MOV     [offset_dos_tecbuf], AX        ; offset_dos guarda o end. para qual ip de int 9 estava apontando anteriormente
    MOV     AX, [ES:int9*4+2]     ; cs_dos guarda o end. anterior de CS
    MOV     [cs_dos_tecbuf], AX
    CLI     
    MOV     [ES:int9*4+2], CS
    MOV     WORD [ES:int9*4],keyint
    STI
    ;_____________________________________________________________________________
    ;Parte do Código tecbuf.asm


;_____________________________________________________________________________
;Incrementa o relógio
inc_relogio:

    ;_____________________________________________________________________________
    ;Parte do Código relogio.asm
    cmp     byte[tique], 0
    jne     inc_relogio
    call    converte
        
    mov     ax,[p_i]
    cmp     ax,[p_t]
    je      inc_relogio
    inc     word[p_t]
    and     word[p_t],7
    mov     bx,[p_t]
    xor     ax, ax
    mov     al, [bx+tecla]
    mov     [tecla_u],al
    mov     BL, 16
    div     BL
    add     al, 30h
    cmp     al, 3Ah                                                                                              
    jb      continua
    add     al, 07h

    continua:        
        mov     [teclasc], al
        add     AH, 30h
        cmp     AH, 3Ah
        jb      verifica_break
        add     AH, 07h
    ;_____________________________________________________________________________
    ;Parte do Código relogio.asm

    ;Verefica qual tecla foi soltada (break da tecla)
    verifica_break:

    MOV     [teclasc+1], AH
    MOV     DX,teclasc
        
    CMP     BYTE [tecla_u], 0xAD;Código IBM-PC de break para 'x'
    JE      func_x

    CMP     BYTE [tecla_u], 0x9F;Código IBM-PC de break para 's'
    JE      func_s

    CMP     BYTE [tecla_u], 0xB2;Código IBM-PC de break para 'm'
    JE      func_m

    CMP     BYTE [tecla_u], 0xA3;Código IBM-PC de break para 'h'
    JE      func_h

    CMP     BYTE [tecla_u], 0x99;Código IBM-PC de break para 'p'
    JE      func_p

    CMP     BYTE [tecla_u], 0x93;Código IBM-PC de break para 'r'
    JE      func_r

    ;Volta a incrementar
    jmp     inc_relogio


;_____________________________________________________________________________
;termina o código
func_x:

    mov     ah,0            ; set video mode
    mov     al,[modo_anterior]      ; modo anterior
    int     10h

    ;_____________________________________________________________________________
    ;Parte do Código tecbuf.asm
    CLI
    XOR     AX, AX
    MOV     ES, AX
    MOV     AX, [cs_dos_relogio]
    MOV     [ES:int9*4+2], AX
    MOV     AX, [offset_dos_tecbuf]
    MOV     [ES:int9*4], AX 
    ;_____________________________________________________________________________
    ;Parte do Código tecbuf.asm

    ;_____________________________________________________________________________
    ;Parte do Código relogio.asm
    xor     ax, ax
    mov     es, ax
    mov     ax, [cs_dos_tecbuf]
    mov     [es:int9*4+2], ax
    mov     ax, [offset_dos_tecbuf]
    mov     [es:int9*4], ax 
    mov     AH, 4Ch
    int     21h
    ;_____________________________________________________________________________
    ;Parte do Código relogio.asm


;_____________________________________________________________________________
;zera o contador dos segundos
func_s:

    mov byte[segundos],0; Zera os segundos
    
    jmp inc_relogio


;_____________________________________________________________________________
;zera o contador dos minutos
func_m:

    mov byte[minutos],0; Zera os minutos
    
    jmp inc_relogio


;_____________________________________________________________________________
;zera o contador das horas
func_h:

    mov byte[horas],0; Zera os minutos
    
    jmp inc_relogio


;_____________________________________________________________________________
;ajusta o relógio para 06:59:59
func_p:

    mov byte[horas],6
    mov byte[minutos],59
    mov byte[segundos],59

    jmp     inc_relogio


;_____________________________________________________________________________
;ajusta o relógio para 23:59:51
func_r:

    mov byte[horas],23
    mov byte[minutos],59
    mov byte[segundos],51

    jmp     inc_relogio
;_____________________________________________________________________________
;_____________________________________________________________________________

;_____________________________________________________________________________
;_____________________________________________________________________________
;Funções professor
;_____________________________________________________________________________
;Parte do Código tecbuf.asm
keyint:
        PUSH    AX
        push    bx
        push    ds
        mov     ax,data
        mov     ds,ax
        IN      AL, kb_data
        inc     WORD [p_i]
        and     WORD [p_i],7
        mov     bx,[p_i]
        mov     [bx+tecla],al
        IN      AL, kb_ctl
        OR      AL, 80h
        OUT     kb_ctl, AL
        AND     AL, 7Fh
        OUT     kb_ctl, AL
        MOV     AL, eoi
        OUT     pictrl, AL
        pop     ds
        pop     bx
        POP     AX
        IRET
;_____________________________________________________________________________
;Parte do Código tecbuf.asm


;_____________________________________________________________________________
;Parte do Código relogio.asm
relogio:
        push    ax
        push    ds
        mov     ax,data 
        mov     ds,ax   
        
        inc byte[tique]
        cmp byte[tique], 18 
        jb  Fimrel
        
        mov byte[tique], 0
        inc byte[segundos]
        cmp byte[segundos], 60
        jb      Fimrel
        
        mov byte[segundos], 0
        inc byte[minutos]
        cmp byte[minutos], 60
        jb      Fimrel
        
        mov byte[minutos], 0
        inc byte[horas]
        cmp byte[horas], 24
        jb      Fimrel
        
        mov byte[horas], 0   
    
    Fimrel:
        mov al,20h
        out 20h,al
        pop ds
        pop ax
        iret
    
    converte:
        push    ax
        push    ds
        mov     ax, data
        mov     ds, ax
        xor     ah, ah
        mov     BL, 10
        mov     al, byte[segundos]
        div     BL
        add     al, 30h                                                                                          
        mov     byte[horario+6], al
        add     AH, 30h
        mov     byte[horario+7], AH
        
        xor     ah, ah
        mov     al, byte[minutos]
        div     BL
        add     al, 30h                                                                                          
        mov     byte[horario+3], al
        add     AH, 30h
        mov     byte[horario+4], AH
        
        xor     ah, ah
        mov     al, byte[horas]
        div     BL
        add     al, 30h                                                                                          
        mov     byte[horario], al
        add     AH, 30h
        mov     byte[horario+1], AH
        
        mov     ah,2
        mov     dh,14
        mov     dl,39
        mov     bh,0
        int     10h
        mov     ah, 09h
        mov     dx, horario
        int     21h
        pop     ds
        pop     ax
        ret  
;_____________________________________________________________________________
;Parte do Código relogio.asm


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
texto_1                 db      'TL-2021_2 Mateus Souza Coelho Turma 6.2';39 caracteres
hora                    db      'Hora:';5 caracteres
dois_pontos             db      ':';1 caracteres
menu                    db      'Menu de teclas:';15 caracteres
msg_x                   db      'x: sair';7 caracteres
msg_s                   db      's: zera o contador dos segundos';31 caracteres
msg_m                   db      'm: zera o contador dos minutos';30 caracteres
msg_h                   db      'h: zera o contador das horas';28 caracteres
msg_p                   db      'p: ajusta o relogio para 06:59:59';33 caracteres
msg_r                   db      'r: ajusta o relogio para 23:59:51';33 caracteres
;_____________________________________________________________________________
;_____________________________________________________________________________


;_____________________________________________________________________________
;_____________________________________________________________________________
;Variaveis do professor
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


;_____________________________________________________________________________
;Parte do Código relogio.asm
eoi                 equ     20h
intr                equ     08h
offset_dos_relogio  dw      0
cs_dos_relogio      dw      0
tique               db      0
segundos            db      0
minutos             db      0
horas               db      0
horario             db      0,0,':',0,0,':',0,0,' ', 13,'$'
;_____________________________________________________________________________
;Parte do Código relogio.asm


;_____________________________________________________________________________
;Parte do Código tecbuf.asm
kb_data             equ     60h  ;PORTA DE LEITURA DE TECLADO
kb_ctl              equ     61h  ;PORTA DE RESET PARA PEDIR NOVA INTERRUPCAO
pictrl              equ     20h
int9                equ     9h
offset_dos_tecbuf   dw      1
cs_dos_tecbuf       dw      1
tecla_u             db      0
tecla               resb    8 
p_i                 dw      0   ;ponteiro p/ interrupcao (qnd pressiona tecla)  
p_t                 dw      0   ;ponteiro p/ interrupcao ( qnd solta tecla)    
teclasc             db      0,0,13,10,'$'
;_____________________________________________________________________________
;Parte do Código tecbuf.asm

;_______________________________________________________________________________________
; Reserva 256 bytes para pilha
segment stack stack
            resb        512
stacktop: