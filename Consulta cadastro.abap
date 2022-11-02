*&---------------------------------------------------------------------*
*& Report  ZTESTECONSULTA
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ztesteconsulta MESSAGE-ID 00.

*Lembrar que precisa informar a base de dados de tabela interna (ti) e de work area (wa).
DATA: wa_cadastro type table ztbisa001.

*Para inciar um bloco na tela e informar o texto principal com o comando abaixo:
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

*Para declarar os campos, tipos e tamanho, o parametro começa com 'p_' para sinalizar que é um parâmetro.
PARAMETERS: p_nome TYPE c LENGTH 40,
            p_cpf type c LENGTH 14 OBLIGATORY,
            p_end type c LENGTH 50,
            p_bairro type c LENGTH 50,
            p_numero type i,
            p_cidade type c LENGTH 30,
            p_estado type c LENGTH 2,
            p_idade type i.

*Para pular uma linha usar o comando abaixo:
SELECTION-SCREEN SKIP.

*Aqui está iniciando um novo bloco na mesma tela, o comando abaixo é de uma caixa selecionável com uma opção já marcada como default.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

*O 'rb_' é para informar que ele é do comando radiobutton, para ficar mais fácil visualizar.
PARAMETERS: rb_masc RADIOBUTTON GROUP rb1,
            rb_fem RADIOBUTTON GROUP rb2 DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN END OF BLOCK b2.

FORM zf_consultacadastro.
    
    SELECT-OPTIONS p_cpf INTO wa_cadastro default sy_datum.

    SELECT SINGLE *
      from ztbisa001
      INTO wa_cadastro
      WHERE CPF = p_cpf.
    
      IF sy-subrc <> 0.
        message s001 with 'CPF não encontrado'.
        return.
        ENDIF.
    
        WRITE: wa_cadastro-nome.
    ENDFORM.


    ZISADORATESTECADASTRO
    MODIFY ztbisa001 FROM wa_cadastro.

