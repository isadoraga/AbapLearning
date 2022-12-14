*&---------------------------------------------------------------------*
*& Report  ZISADORATESTE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zisadorateste MESSAGE-ID 00.

DATA: ti_cadastro TYPE TABLE OF ztbisa001.
DATA: wa_cadastro TYPE ztbisa001.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

PARAMETERS: p_nome TYPE c LENGTH 40 OBLIGATORY,
            p_cpf TYPE c LENGTH 14 OBLIGATORY,
            p_end    TYPE c LENGTH 50 OBLIGATORY,
            p_bairro TYPE c LENGTH 50 OBLIGATORY,
            p_numero TYPE i OBLIGATORY,
            p_cidade TYPE c LENGTH 30 OBLIGATORY,
            p_estado TYPE c LENGTH 2 OBLIGATORY,
            p_idade  TYPE i OBLIGATORY.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.

PARAMETERS: rb_masc RADIOBUTTON GROUP rb1,
            rb_fem  RADIOBUTTON GROUP rb1 DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN END OF BLOCK b1.

*&---------------------------------------------------------------------*
*&      Form  ZF_CADASTRO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM zf_cadastro.
  wa_cadastro-cpf = p_cpf.
  wa_cadastro-nome = p_nome.
  wa_cadastro-endereco = p_end.
  wa_cadastro-bairro = p_bairro.
  wa_cadastro-num = p_numero.
  wa_cadastro-cidade = p_cidade.
  wa_cadastro-estado = p_estado.
  wa_cadastro-idade = p_idade.

  IF rb_fem = 'X'.
    wa_cadastro-sexo = 'F'.
  ELSE.
    wa_cadastro-sexo = 'M'.
  ENDIF.

  APPEND wa_cadastro TO ti_cadastro.

  MODIFY ztbisa001 FROM TABLE ti_cadastro.

  IF sy-subrc = 0.
    COMMIT WORK.
    MESSAGE s001 WITH text-011.
  ELSE.
    MESSAGE e001 WITH 'Cadastro não realizado.'(010).
  ENDIF.
  
ENDFORM.