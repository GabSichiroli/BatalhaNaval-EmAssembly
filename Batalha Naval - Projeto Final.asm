TITLE Batalha Naval - Projeto Final
.MODEL SMALL
.stack 0100h
IMPMENSAG MACRO MGSDESJ
              LEA DX, MGSDESJ
              MOV AH,09
              INT 21H
ENDM

PULA_LINHA MACRO
               PUSH AX
               PUSH DX
               MOV  AH, 02
               MOV  DL, 10
               INT  21H
               POP  DX
               POP  AX
ENDM

;Remover em Projeto Final;
Controle_Programa MACRO CONTROLE
                      LEA DX, CONTROLE
                      MOV AH,09
                      INT 21H
ENDM

INFORMATRIZ MACRO COLUNAINICIAL, LINHAINICIAL,LINHAFINAL
                MOV BX,COLUNAINICIAL
                MOV SI,LINHAINICIAL
                MOV DI,LINHAFINAL
ENDM
LIMPA_TELA MACRO
    ;Limpa a Tela
               MOV AH, 06H
               MOV AL, 0
               MOV BH, 07H
               MOV CX, 0
               MOV DX, 184FH
               INT 10H

    ;Move Cursor
               MOV AH, 02H
               MOV BH, 0        ;Coluna
               MOV DH, 5        ;Linha
               MOV DL, 0
               INT 10H
ENDM
SALVAMJOGO MACRO
               PUSH BX
               PUSH SI
               PUSH DI
ENDM
VOLTAVALOR MACRO
               POP BX
               POP SI
               POP DI

ImprimeQUA macro VALORCOL,INCIALSI,REGVALOR,MATRIZIMP
                     Local      MudaLinha
                     Local      L1
                     Local      IMPRIMELINHA
                     Local      Retornaimp

                     MOV        BX,VALORCOL
                     MOV        SI,INCIALSI
                     MOV        CX,10
                     JMP        L1
        MudaLinha:   
                     MOV        BX,VALORCOL                   ; zera o índice da coluna
                     ADD        SI,40                         ; Muda a linha
                     MOV        CX,10                         ;Volta o valor de cx para o loop
                     CMP        SI,REGVALOR
                     JG         Retornaimp
        L1:          
                     pula_linha
                     MOV        AH, 02H
        IMPRIMELINHA:
                     MOV        DX, MATRIZIMP [SI][BX]        ; coloca o elemento MATRIZ4X4[0,0] em AL
                     OR         DL,30H                        ; nUmero em caractere
                     INT        21H
                     ADD        BX,2
                     LOOP       IMPRIMELINHA
                     JMP        MudaLinha
        Retornaimp:  
endm
.DATA
        MATRIZ       DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                     DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                     DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                     DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                     DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                     DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                     DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                     DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                     DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                     DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2

                     DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                     DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                     DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                     DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                     DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                     DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                     DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                     DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                     DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                     DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4


        VETOR        DB 10 DUP (0)
        ;Mensagens;
        ;Pagina Inicial;
        LOGO1        DB 13,10,'              ===================================================              ', '$'
        LOGO2        DB 13,10,'              =                                                 =            ', '$'
        LOGO3        DB 13,10,'              =     Batalha     Naval     Em     Assembly       =            ','$'
        LOGO4        DB 13,10,'              =                                                 =            ','$'
        LOGO5        DB 13,10,'              ===================================================              ', 13,10, '$'
        ENTMSG1      DB 13,10,'              Insira ate 3 numeros de 0-9 para iniciar o jogo:', '$'
        MSGCONTROLE  DB 13,10,'OK1', '$'
        MSGCONTROLE1 DB 13,10,'OK2', '$'
        MSGCONTROLE2 DB 13,10,'OK3', '$'
        MSGCONTROLE3 DB 13,10,'OK4', '$'


.CODE
MAIN PROC
        ;Acesso ao DATA
                      MOV               AX, @DATA
                      MOV               DS,AX
                      CALL              INICIAR
        ;Termina o programa
                      MOV               AH,4CH
                      INT               21H
MAIN ENDP
INICIAR PROC

                LIMPA_TELA
                  IMPMENSAG         LOGO1
                  IMPMENSAG         LOGO2
                  IMPMENSAG         LOGO3
                  IMPMENSAG         LOGO4
                  IMPMENSAG         LOGO5
                  IMPMENSAG         ENTMSG1


                      MOV               CX, 3
                      XOR               BX,BX
                      XOR               DX,DX
                      MOV               AH,1
                      

        LerEnt:       
                      INT               21h
                      CMP               AL, 0DH
                      JE                CompENT
                      MOV               DL,AL
                      ADD               BL, DL      
                      LOOP              LerEnt
                      limpar_tela             
        CompENT:      
                      CMP               BL, 4
                      JB                PulaParaFim

        DivDerminadaM:
                      MOV               AX, BX
                      MOV               BL, 4
                      DIV               BL
        CompQUA:      
                      CMP               AH, 1
                      JE                QUA1

                      CMP               AH, 2
                      JE                QUA2

                      CMP               AH, 3
                      JE                QUAQ3
                      
                      CMP               AH, 0
                      JE                QUAQ4
        PulaParaFim:  
                      JMP               RetornaEnt
        QUAQ3:        
                      JMP               QUA3
        QUA1:         

                      Controle_Programa MSGCONTROLE
                      JMP               RetornaEnt
        QUAQ4:        
                      JMP               QUA4
        QUA2:         

                      Controle_Programa MSGCONTROLE1
                      JMP               RetornaEnt
        QUA3:         

                      Controle_Programa MSGCONTROLE2
                      JMP               RetornaEnt
        QUA4:         

                      Controle_Programa MSGCONTROLE3
                      JMP               RetornaEnt

        RetornaEnt:   
                      RET
INICIAR ENDP
END MAIN