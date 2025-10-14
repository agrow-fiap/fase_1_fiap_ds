-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2025-09-16 15:53:26 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE MC_SGV_BAIRRO CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_CATEGORIA CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_CIDADE CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_CLI_PF CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_CLI_PJ CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_CLIENTE CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_DEPTO CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_END_CLI CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_END_FUNC CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_ESTADO CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_FUNCIONARIO CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_LOGRADOURO CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_PRODUTO CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_SAC CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_VIDEO CASCADE CONSTRAINTS 
;

DROP TABLE MC_SGV_VISUALIZACAO_VIDEO CASCADE CONSTRAINTS 
;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE MC_SGV_BAIRRO 
    ( 
     cd_bairro      NUMBER (8)  NOT NULL , 
     cd_cidade      NUMBER (8)  NOT NULL , 
     nm_bairro      VARCHAR2 (45)  NOT NULL , 
     nm_zona_bairro VARCHAR2 (20)  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_SGV_BAIRRO.cd_bairro IS 'Esta coluna irá receber o codigo do bairro e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_BAIRRO.cd_cidade IS 'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_BAIRRO.nm_bairro IS 'Esta coluna ira receber o nome do Bairro. Esse conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_BAIRRO.nm_zona_bairro IS 'Esta coluna irá receber a localização da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.' 
;

ALTER TABLE MC_SGV_BAIRRO 
    ADD CONSTRAINT PK_MC_BAIRRO PRIMARY KEY ( cd_bairro ) ;

CREATE TABLE MC_SGV_CATEGORIA 
    ( 
     cd_cat         NUMBER (10) 
         CONSTRAINT NN_MC_SGV_CATEGORIA_cd_cat NOT NULL , 
     nm_cat         VARCHAR2 (30) 
         CONSTRAINT NN_MC_SGV_CATEGORIA_nm_cat NOT NULL , 
     sg_cat         CHAR (3) , 
     ds_cat         VARCHAR2 (30) 
         CONSTRAINT NN_MC_SGV_CATEGORIA_ds_cat NOT NULL , 
     st_cat         CHAR (1) 
         CONSTRAINT NN_MC_SGV_CATEGORIA_st_cat NOT NULL , 
     dt_inicio_cat  DATE 
         CONSTRAINT NN_MC_SGV_CATEGORIA_dt_ini_cat NOT NULL , 
     dt_termino_cat DATE 
    ) 
;

COMMENT ON COLUMN MC_SGV_CATEGORIA.st_cat IS 'Pode ser "A" (ativo) ou "I" (inativo).' 
;

ALTER TABLE MC_SGV_CATEGORIA 
    ADD CONSTRAINT CK_MC_SGV_CAT 
    CHECK (dt_termino_cat >= dt_inicio_cat)
;


ALTER TABLE MC_SGV_CATEGORIA 
    ADD CONSTRAINT CK_MC_SGV_CAT_2 
    CHECK (st_cat = 'A' or st_cat ='I')
;
ALTER TABLE MC_SGV_CATEGORIA 
    ADD CONSTRAINT PK_MC_SGV_CAT PRIMARY KEY ( cd_cat ) ;

ALTER TABLE MC_SGV_CATEGORIA 
    ADD CONSTRAINT UN_MC_SGV_CAT UNIQUE ( ds_cat , sg_cat ) ;

CREATE TABLE MC_SGV_CIDADE 
    ( 
     cd_cidade NUMBER (8)  NOT NULL , 
     sg_estado CHAR (2)  NOT NULL , 
     nm_cidade VARCHAR2 (60)  NOT NULL , 
     cd_ibge   NUMBER (8) , 
     nd_ddd    NUMBER (3) 
    ) 
;

COMMENT ON COLUMN MC_SGV_CIDADE.cd_cidade IS 'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_CIDADE.sg_estado IS 'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_CIDADE.nm_cidade IS 'Esta coluna ira receber o nome da Cidade. Esse conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_CIDADE.cd_ibge IS 'Esta coluna irá receber o código do IBGE que fornece informações para geração da NFe.' 
;

COMMENT ON COLUMN MC_SGV_CIDADE.nd_ddd IS 'Esta coluna irá receber o número do DDD da cidade para ser utilizado no contato telefônico. Seu conteudo é opcional.' 
;

ALTER TABLE MC_SGV_CIDADE 
    ADD CONSTRAINT PK_MC_CIDADE PRIMARY KEY ( cd_cidade ) ;

CREATE TABLE MC_SGV_CLI_PF 
    ( 
     nr_cliente    NUMBER (10)  NOT NULL , 
     nr_cpf_cli_pf VARCHAR2 (14)  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_SGV_CLI_PF.nr_cpf_cli_pf IS 'Este atributo irá receber o número do CPF já com a sua respectiva máscara. Exemplo: 09.08.554-09. Seu conteúdo é opcional pois o cliente pode ser pessoa física ou juridica.' 
;

ALTER TABLE MC_SGV_CLI_PF 
    ADD CONSTRAINT MC_SGV_CLI_PF_PK PRIMARY KEY ( nr_cliente ) ;

CREATE TABLE MC_SGV_CLI_PJ 
    ( 
     nr_cliente     NUMBER (10)  NOT NULL , 
     nr_cnpj_cli_pj VARCHAR2 (19)  NOT NULL 
    ) 
;

ALTER TABLE MC_SGV_CLI_PJ 
    ADD CONSTRAINT MC_SGV_CLI_PJ_PK PRIMARY KEY ( nr_cliente ) ;

CREATE TABLE MC_SGV_CLIENTE 
    ( 
     nr_cliente              NUMBER (10)  NOT NULL , 
     nm_cliente              VARCHAR2 (160)  NOT NULL , 
     qt_estrelas_cliente     NUMBER (1)  NOT NULL , 
     vl_medio_compra_cliente NUMBER (10,2)  NOT NULL , 
     st_cliente              CHAR (1)  NOT NULL , 
     ds_email_cliente        VARCHAR2 (100) , 
     nr_telefone_cliente     VARCHAR2 (20) , 
     nm_login_cliente        VARCHAR2 (50)  NOT NULL , 
     ds_senha_cliente        VARCHAR2 (50)  NOT NULL , 
     dt_nascimento_cliente   DATE , 
     tp_cliente              CHAR (2)  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_SGV_CLIENTE.nr_cliente IS 'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras. Seu conteúdo deve ser obrigatório, único e preenchido a parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual terá sempre o número disponivel para uso.' 
;

COMMENT ON COLUMN MC_SGV_CLIENTE.nm_cliente IS 'Essa coluna irá armazenar o nome do cliente na plataforma ecommerce da Melhores Compras. Seu conteúdo deve ser obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_CLIENTE.qt_estrelas_cliente IS 'Essa coluna irá armazenar a quantiade de estrelas do cliente na plataforma ecommerce da Melhores Compras. Seu conteúdo deve ser obrigatório e ser possível de estar entre 1 e 5 estrelas.' 
;

COMMENT ON COLUMN MC_SGV_CLIENTE.vl_medio_compra_cliente IS 'Essa coluna irá armazenar o valor  médio de gastos f eito pelo cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório e deve ser calculado diariamente.' 
;

COMMENT ON COLUMN MC_SGV_CLIENTE.st_cliente IS 'Essa coluna irá armazenar o status do cliente da Melhores Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).' 
;

COMMENT ON COLUMN MC_SGV_CLIENTE.ds_email_cliente IS 'Essa coluna irá armazenar o email  do cliente da Melhorees Compras. No minimo é esperado um email contendo o caractere (@) em seu conteúdo.' 
;

COMMENT ON COLUMN MC_SGV_CLIENTE.nr_telefone_cliente IS 'Essa coluna irá armazenar o número do cliente da Melhorees Compras. A mascara de armazenamento deve ser: (<nr_ddd>) 99999-9999 e  deve ser utilizada pré definida.' 
;

COMMENT ON COLUMN MC_SGV_CLIENTE.nm_login_cliente IS 'Essa coluna irá armazenar o login de cada cliente na plataforma ecommerce da Melhores Compras. Seu conteúdo deve ser obrigatório e  único para cada cliente.' 
;

COMMENT ON COLUMN MC_SGV_CLIENTE.ds_senha_cliente IS 'Essa coluna irá armazenar a senha de cada cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_CLIENTE.dt_nascimento_cliente IS 'Este atributo irá receber a data de nascimento ou data de fundação do cliente e seu conteúdo é opcional.' 
;

COMMENT ON COLUMN MC_SGV_CLIENTE.tp_cliente IS 'Este atirbuto irá receber o tipo do cliente, que poderá ser PF (para pessao física) ou PJ (para pessoa jurídica).' 
;

ALTER TABLE MC_SGV_CLIENTE 
    ADD CONSTRAINT CK_MC_SGV_CLI_1 
    CHECK (st_cliente ='A' or st_cliente ='I' )
;


ALTER TABLE MC_SGV_CLIENTE 
    ADD CONSTRAINT CK_MC_SGV_CLI_2 
    CHECK (tp_cliente = 'PF' or tp_cliente = 'PJ')
;
ALTER TABLE MC_SGV_CLIENTE 
    ADD CONSTRAINT PK_MC_CLIENTE PRIMARY KEY ( nr_cliente ) ;

CREATE TABLE MC_SGV_DEPTO 
    ( 
     cd_depto NUMBER (3)  NOT NULL , 
     nm_depto VARCHAR2 (100)  NOT NULL , 
     st_depto CHAR (1)  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_SGV_DEPTO.cd_depto IS 'Esta coluna irá receber o codigo do departamento  e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_DEPTO.nm_depto IS 'Esta coluna irá receber o nome do  departamento  e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_DEPTO.st_depto IS 'Esta coluna irá receber o status do  departamento  e seu conteúdo é obrigatório. Os valores possíveis são: (A)tivo e (I)nativo.' 
;

ALTER TABLE MC_SGV_DEPTO 
    ADD CONSTRAINT CK_MC_SGV_DEPTO_1 
    CHECK (st_depto = 'A' or st_depto ='I')
;
ALTER TABLE MC_SGV_DEPTO 
    ADD CONSTRAINT PK_MC_DEPTO PRIMARY KEY ( cd_depto ) ;

CREATE TABLE MC_SGV_END_CLI 
    ( 
     nr_cli            NUMBER (10)  NOT NULL , 
     cd_logradouro     NUMBER (10)  NOT NULL , 
     nr_end_cli        NUMBER (8) , 
     ds_compl_end_cli  VARCHAR2 (80) , 
     dt_inicio_end_cli DATE  NOT NULL , 
     dt_term_end_cli   DATE , 
     st_end_cli        CHAR (1)  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_SGV_END_CLI.nr_cli IS 'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual terá sempre o número disponivel para uso.' 
;

COMMENT ON COLUMN MC_SGV_END_CLI.cd_logradouro IS 'Esta coluna irá receber o código do logradouro e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_END_CLI.nr_end_cli IS 'Número do Endereço do Cliente. O número da Rua/Localidade onde o cliente está associado.' 
;

COMMENT ON COLUMN MC_SGV_END_CLI.ds_compl_end_cli IS 'Esta coluna irá receber o complemento do endereço do cliente e seu conteúdo pode ser opcional.' 
;

COMMENT ON COLUMN MC_SGV_END_CLI.dt_inicio_end_cli IS 'Data de início do endereço associado ao cliente.' 
;

COMMENT ON COLUMN MC_SGV_END_CLI.dt_term_end_cli IS 'Data de término do endereço associado ao cliente.' 
;

COMMENT ON COLUMN MC_SGV_END_CLI.st_end_cli IS 'Status do endereço. (A)itvo ou (I)nativo.' 
;

ALTER TABLE MC_SGV_END_CLI 
    ADD CONSTRAINT CK_MC_SGV_END_CLI_1 
    CHECK (dt_term_end_cli >= dt_inicio_end_cli)
;


ALTER TABLE MC_SGV_END_CLI 
    ADD CONSTRAINT CK_MC_SGV_END_CLI_2 
    CHECK (st_end_cli ='A' or st_end_cli ='I')
;
ALTER TABLE MC_SGV_END_CLI 
    ADD CONSTRAINT PK_MC_END_CLI PRIMARY KEY ( cd_logradouro, nr_cli ) ;

CREATE TABLE MC_SGV_END_FUNC 
    ( 
     cd_func             NUMBER (10)  NOT NULL , 
     cd_logradouro       NUMBER (10)  NOT NULL , 
     nr_end_func         NUMBER (8)  NOT NULL , 
     ds_compl_end_func   VARCHAR2 (80) , 
     dt_inicio_end_func  DATE  NOT NULL , 
     dt_termino_end_func DATE , 
     st_end_func         CHAR (1)  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_SGV_END_FUNC.cd_func IS 'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_END_FUNC.cd_logradouro IS 'Esta coluna irá receber o código do logradouro e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_END_FUNC.nr_end_func IS 'Número do Endereço do Cliente. O número da Rua/Localidade onde o cliente está associado.' 
;

COMMENT ON COLUMN MC_SGV_END_FUNC.dt_inicio_end_func IS 'Data de início do endereço associado ao cliente.' 
;

COMMENT ON COLUMN MC_SGV_END_FUNC.dt_termino_end_func IS 'Data de término do endereço associado ao cliente.' 
;

COMMENT ON COLUMN MC_SGV_END_FUNC.st_end_func IS 'Status do endereço. (A)itvo ou (I)nativo.' 
;

ALTER TABLE MC_SGV_END_FUNC 
    ADD CONSTRAINT CK_MC_SGV_END_FUNC_1 
    CHECK (dt_termino_end_func >= dt_inicio_end_func)
;


ALTER TABLE MC_SGV_END_FUNC 
    ADD CONSTRAINT CK_MC_SGV_END_FUNC_2 
    CHECK (st_end_func ='A' or st_end_func ='I')
;
ALTER TABLE MC_SGV_END_FUNC 
    ADD CONSTRAINT PK_MC_END_FUNC PRIMARY KEY ( cd_logradouro, cd_func ) ;

CREATE TABLE MC_SGV_ESTADO 
    ( 
     sg_estado CHAR (2)  NOT NULL , 
     nm_estado VARCHAR2 (30)  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_SGV_ESTADO.sg_estado IS 'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_ESTADO.nm_estado IS 'Esta coluna irá receber o nome do estado' 
;

ALTER TABLE MC_SGV_ESTADO 
    ADD CONSTRAINT PK_MC_ESTADO PRIMARY KEY ( sg_estado ) ;

CREATE TABLE MC_SGV_FUNCIONARIO 
    ( 
     cd_funcionario               NUMBER (10)  NOT NULL , 
     cd_depto                     NUMBER (3)  NOT NULL , 
     cd_funcionario1              NUMBER (10) , 
     nm_funcionario               VARCHAR2 (160)  NOT NULL , 
     dt_nascimento_funcionario    DATE  NOT NULL , 
     vl_sexo_bio_func             CHAR (1)  NOT NULL , 
     ds_genero_funcionario        VARCHAR2 (100) , 
     ds_cargo_funcionario         VARCHAR2 (80) , 
     vl_salario_funcionario       NUMBER (10,2) , 
     ds_email_funcionario         VARCHAR2 (80) , 
     st_funcionario               CHAR (1)  NOT NULL , 
     dt_cadastramento_funcionario DATE  NOT NULL , 
     dt_desligamento_funcionario  DATE 
    ) 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.cd_funcionario IS 'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.cd_depto IS 'Esta coluna irá receber o codigo do departamento  e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.cd_funcionario1 IS 'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.nm_funcionario IS 'Esta coluna irá receber o nome do funcionário e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.dt_nascimento_funcionario IS 'Esta coluna irá receber a data de nascimento  do funcionário e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.vl_sexo_bio_func IS 'Esta coluna irá receber o sexo biológico do funcionário e seu conteúdo é obrigatório.Os valores permitidos aqui seriam: (F)eminino; (M)asculino ou (Hermafrodita)' 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.ds_genero_funcionario IS 'Esta coluna irá receber o genero atribuido ao funcionário e seu conteúdo é opcional.' 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.ds_cargo_funcionario IS 'Esta coluna irá receber o cargo do funcionário e seu conteúdo é opcional.' 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.vl_salario_funcionario IS 'Esta coluna irá receber o valor do salário do funcionário e seu conteúdo é opcional.' 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.ds_email_funcionario IS 'Esta coluna irá receber o email do funcionário e seu conteúdo é opcional.' 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.st_funcionario IS 'Essa coluna irá armazenar o stauts do funcionário da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).' 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.dt_cadastramento_funcionario IS 'Data de cadastramento do Funcionario' 
;

COMMENT ON COLUMN MC_SGV_FUNCIONARIO.dt_desligamento_funcionario IS 'Data de desligamento  do Funcionario. Seu conteúdo é opcional.' 
;

ALTER TABLE MC_SGV_FUNCIONARIO 
    ADD CONSTRAINT CK_MC_SGV_FUNC 
    CHECK (dt_cadastramento_funcionario <= dt_desligamento_funcionario)
;


ALTER TABLE MC_SGV_FUNCIONARIO 
    ADD CONSTRAINT CK_MC_SGV_FUNC_2 
    CHECK (st_funcionario ='A' or st_funcionario ='I' )
;
ALTER TABLE MC_SGV_FUNCIONARIO 
    ADD CONSTRAINT PK_MC_FUNCIONARIO PRIMARY KEY ( cd_funcionario ) ;

CREATE TABLE MC_SGV_LOGRADOURO 
    ( 
     cd_logradouro NUMBER (10)  NOT NULL , 
     cd_bairro     NUMBER (8)  NOT NULL , 
     nm_logradouro VARCHAR2 (160)  NOT NULL , 
     nr_cep        NUMBER (8)  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_SGV_LOGRADOURO.cd_logradouro IS 'Esta coluna irá receber o código do logradouro e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_LOGRADOURO.cd_bairro IS 'Esta coluna irá receber o codigo do bairro e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_LOGRADOURO.nm_logradouro IS 'Esta coluna irá receber o nome do logradouro e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_LOGRADOURO.nr_cep IS 'Esta coluna irá receber o numero do CEP do Logradouro e seu conteúdo é obrigatório.' 
;

ALTER TABLE MC_SGV_LOGRADOURO 
    ADD CONSTRAINT PK_MC_LOGRADOURO PRIMARY KEY ( cd_logradouro ) ;

CREATE TABLE MC_SGV_PRODUTO 
    ( 
     cd_produto         NUMBER (10)  NOT NULL , 
     cd_categoria       NUMBER (10)  NOT NULL , 
     ds_produto         VARCHAR2 (80)  NOT NULL , 
     nr_cd_barras_prod  VARCHAR2 (50) , 
     vl_preco_unitario  NUMBER (8,2)  NOT NULL , 
     tp_embalagem       VARCHAR2 (15) , 
     st_produto         CHAR (1)  NOT NULL , 
     vl_perc_lucro      NUMBER (8,2) , 
     ds_completa_prod   CLOB  NOT NULL , 
     vl_total_impto_pg  NUMBER (10,2)  NOT NULL , 
     dt_inicio_produto  DATE  NOT NULL , 
     dt_termino_produto DATE 
    ) 
;

COMMENT ON COLUMN MC_SGV_PRODUTO.cd_produto IS 'Essa coluna irá armazenar a chave primária da tabela de produtos da Melhorees Compras. A cada produto cadastrado será acionada a Sequence  SQ_MC_PRODUTO que se encarregará de gerar o próximo número único do produto.' 
;

COMMENT ON COLUMN MC_SGV_PRODUTO.ds_produto IS 'Essa coluna irá armazenar a descrição principal do produto. Seu conteúdo deve ser  obrigatorio.' 
;

COMMENT ON COLUMN MC_SGV_PRODUTO.nr_cd_barras_prod IS 'Essa coluna irá armazenar o número do codigo de barras  do produto. Seu conteúdo deve ser opcional.' 
;

COMMENT ON COLUMN MC_SGV_PRODUTO.vl_preco_unitario IS 'Essa coluna irá armazenar o valor unitário do produto. Seu conteúdo deve ser > 0 ' 
;

COMMENT ON COLUMN MC_SGV_PRODUTO.tp_embalagem IS 'Essa coluna irá armazenar o tipo de embalagem do produto. Seu conteúdo pode ser opcional.' 
;

COMMENT ON COLUMN MC_SGV_PRODUTO.st_produto IS 'Essa coluna irá armazenar o status do produto da Melhores Compras. Os valores permitidos aqui são: A(tivo), I(nativo) ou P(rospecção).' 
;

COMMENT ON COLUMN MC_SGV_PRODUTO.vl_perc_lucro IS 'Essa coluna irá armazenar o percentual  do lucro médio para cada produto. Seu conteúdo deve ser opcional.' 
;

COMMENT ON COLUMN MC_SGV_PRODUTO.ds_completa_prod IS 'Essa coluna irá armazenar a descrição completa do produto. Seu conteúdo deve ser  obrigatorio.' 
;

COMMENT ON COLUMN MC_SGV_PRODUTO.vl_total_impto_pg IS 'Essa coluna irá armazenar o total de imposto pago' 
;

ALTER TABLE MC_SGV_PRODUTO 
    ADD CONSTRAINT CK_MC_SGV_PROD 
    CHECK (dt_termino_produto >= dt_inicio_produto)
;


ALTER TABLE MC_SGV_PRODUTO 
    ADD CONSTRAINT CK_MC_SGV_PROD_2 
    CHECK (st_produto = 'A' or st_produto ='I' or st_produto ='P'
)
;
ALTER TABLE MC_SGV_PRODUTO 
    ADD CONSTRAINT PK_MC_PRODUTO PRIMARY KEY ( cd_produto ) ;

ALTER TABLE MC_SGV_PRODUTO 
    ADD CONSTRAINT UN_MC_SGV_PROD UNIQUE ( ds_produto ) ;

CREATE TABLE MC_SGV_SAC 
    ( 
     nr_chamado_sac         NUMBER (10)  NOT NULL , 
     nr_cliente             NUMBER (10)  NOT NULL , 
     cd_funcionario         NUMBER (10) , 
     cd_produto             NUMBER (10)  NOT NULL , 
     ds_detlh_chamado       VARCHAR2 (4000)  NOT NULL , 
     dt_abertura_chamado    DATE  NOT NULL , 
     dt_atendimento_chamado DATE , 
     nr_tempo_total_chamado DATE  NOT NULL , 
     ds_detlh_retn_chamado  CLOB , 
     tp_chamado_sac         CHAR (1)  NOT NULL , 
     st_chamado             CHAR (1)  NOT NULL , 
     nr_indice_satisfacao   NUMBER (2) 
    ) 
;

COMMENT ON COLUMN MC_SGV_SAC.nr_chamado_sac IS 'Essa coluna irá armazenar a chave primária da tabela de SAC de vídeo  da Melhorees Compras. A cada SAC cadastrado pelo cliente será acionada a Sequence  SQ_MC_SGV_SAC que se encarregará de gerar o próximo número único do chamado SAC feito pelo Cliente.' 
;

COMMENT ON COLUMN MC_SGV_SAC.nr_cliente IS 'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual terá sempre o número disponivel para uso.' 
;

COMMENT ON COLUMN MC_SGV_SAC.cd_funcionario IS 'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_SAC.ds_detlh_chamado IS 'Essa coluna  irá  receber a descrição completa do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_SAC.dt_abertura_chamado IS 'Essa coluna  irá  receber a data e horário do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_SAC.dt_atendimento_chamado IS 'Essa coluna  irá  receber a data e horário do atendmiento SAC feita pelo funcionário da Melhores Compras. Seu conteudo deve ser opcional..' 
;

COMMENT ON COLUMN MC_SGV_SAC.nr_tempo_total_chamado IS 'Essa coluna  irá  receber o tempo total em horas  (HH24) computado desde a abertura até a conclusão dele. A unidade de medida é horas, ou seja, em quantas horas o chamado foi concluído desde a sua abertura.' 
;

COMMENT ON COLUMN MC_SGV_SAC.ds_detlh_retn_chamado IS 'Essa coluna  irá  receber a descrição detalhada do retorno feito pelo funcionário a partir da solicitação do cliente. Seu conteúdo deve ser opcional e preenchido pelo funcionário.' 
;

COMMENT ON COLUMN MC_SGV_SAC.tp_chamado_sac IS 'Essa coluna  irá  receber o TIPO  do chamado SAC aberto pelo cliente.  Seu conteúdo deve ser  obrigatório e os possíveis valores são: Tipo 1 - (S)ugestão; Tipo 2 - (R)eclamação.' 
;

COMMENT ON COLUMN MC_SGV_SAC.st_chamado IS 'Essa coluna  irá  receber o STATUS  do chamado SAC aberto pelo cliente.  Seu conteúdo deve ser  obrigatório e os possíveis valores são: (E)m Atendimento; (C)ancelado; (F)echado com sucesso ou (X)Fechado com Insatisfação do cliente.' 
;

COMMENT ON COLUMN MC_SGV_SAC.nr_indice_satisfacao IS 'Essa coluna  irá  receber o índice de satisfação, computado como um valor simples de 1 a 10, onde 1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito. Esse índice de satisfação é opcional e informado pelo cliente ao final do atendimento.' 
;

ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT CK_MC_SGV_SAC_1 
    CHECK (dt_atendimento_chamado >= dt_abertura_chamado )
;


ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT CK_MC_SGV_SAC_2 
    CHECK (st_chamado = 'E' or st_chamado ='C' or st_chamado ='F' or st_chamado ='X')
;


ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT CK_MC_SGV_SAC_3 
    CHECK (( 10 >= nr_indice_satisfacao) and (nr_indice_satisfacao >= 0))
;


ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT CK_MC_SGV_SAC_4 
    CHECK (tp_chamado_sac = 'S' or tp_chamado_sac = 'R')
;
ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT PK_MC_SGV_SAC PRIMARY KEY ( nr_chamado_sac ) ;

CREATE TABLE MC_SGV_VIDEO 
    ( 
     cd_video          NUMBER (10)  NOT NULL , 
     cd_categoria      NUMBER (10)  NOT NULL , 
     cd_produto        NUMBER (10)  NOT NULL , 
     st_video          CHAR (1)  NOT NULL , 
     dt_inicio_video   DATE  NOT NULL , 
     dt_termino_video  DATE , 
     dt_cadastro_video DATE  NOT NULL , 
     ds_video          VARCHAR2 (50)  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_SGV_VIDEO.cd_video IS '	' 
;

COMMENT ON COLUMN MC_SGV_VIDEO.st_video IS 'O status do vídeo pode ser "A" (ativo)  ou "I" (inativo).' 
;

COMMENT ON COLUMN MC_SGV_VIDEO.dt_cadastro_video IS 'Data em que o vídeo foi cadastrado na plataforma. PROVAVELMENTE é o mesmo que o atributo "dt_inicio".' 
;

COMMENT ON COLUMN MC_SGV_VIDEO.ds_video IS 'Breve descrição do vídeo.' 
;

ALTER TABLE MC_SGV_VIDEO 
    ADD CONSTRAINT CK_MC_SGV_VID 
    CHECK (dt_termino_video >= dt_inicio_video
)
;


ALTER TABLE MC_SGV_VIDEO 
    ADD CONSTRAINT CK_MC_SGV_VID_2 
    CHECK (st_video = 'A' or st_video ='I')
;
ALTER TABLE MC_SGV_VIDEO 
    ADD CONSTRAINT MC_VIDEO_PK PRIMARY KEY ( cd_video ) ;

CREATE TABLE MC_SGV_VISUALIZACAO_VIDEO 
    ( 
     nr_visualizacao   NUMBER  NOT NULL , 
     cd_video          NUMBER (10)  NOT NULL , 
     nr_cliente        NUMBER (10) , 
     dt_visita_usuario DATE  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_SGV_VISUALIZACAO_VIDEO.nr_visualizacao IS 'Esse atributo irá representar a unicidade de cada registro na tabela visualização.' 
;

COMMENT ON COLUMN MC_SGV_VISUALIZACAO_VIDEO.dt_visita_usuario IS 'Esse atributo irá representar a data/hora que um usuário visualizou um vídeo.' 
;

ALTER TABLE MC_SGV_VISUALIZACAO_VIDEO 
    ADD CONSTRAINT MC_SGV_VISUALIZACAO_VIDEO_PK PRIMARY KEY ( nr_visualizacao ) ;

ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT atender FOREIGN KEY 
    ( 
     cd_funcionario
    ) 
    REFERENCES MC_SGV_FUNCIONARIO 
    ( 
     cd_funcionario
    ) 
;

ALTER TABLE MC_SGV_PRODUTO 
    ADD CONSTRAINT classificar FOREIGN KEY 
    ( 
     cd_categoria
    ) 
    REFERENCES MC_SGV_CATEGORIA 
    ( 
     cd_cat
    ) 
;

ALTER TABLE MC_SGV_VIDEO 
    ADD CONSTRAINT classificar1 FOREIGN KEY 
    ( 
     cd_categoria
    ) 
    REFERENCES MC_SGV_CATEGORIA 
    ( 
     cd_cat
    ) 
;

ALTER TABLE MC_SGV_FUNCIONARIO 
    ADD CONSTRAINT gerir FOREIGN KEY 
    ( 
     cd_funcionario1
    ) 
    REFERENCES MC_SGV_FUNCIONARIO 
    ( 
     cd_funcionario
    ) 
;

ALTER TABLE MC_SGV_FUNCIONARIO 
    ADD CONSTRAINT pertencer FOREIGN KEY 
    ( 
     cd_depto
    ) 
    REFERENCES MC_SGV_DEPTO 
    ( 
     cd_depto
    ) 
;

ALTER TABLE MC_SGV_END_FUNC 
    ADD CONSTRAINT possuir FOREIGN KEY 
    ( 
     cd_func
    ) 
    REFERENCES MC_SGV_FUNCIONARIO 
    ( 
     cd_funcionario
    ) 
;

ALTER TABLE MC_SGV_END_CLI 
    ADD CONSTRAINT possuir1 FOREIGN KEY 
    ( 
     nr_cli
    ) 
    REFERENCES MC_SGV_CLIENTE 
    ( 
     nr_cliente
    ) 
;

ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT referir FOREIGN KEY 
    ( 
     cd_produto
    ) 
    REFERENCES MC_SGV_PRODUTO 
    ( 
     cd_produto
    ) 
;

ALTER TABLE MC_SGV_CLI_PF 
    ADD CONSTRAINT ser FOREIGN KEY 
    ( 
     nr_cliente
    ) 
    REFERENCES MC_SGV_CLIENTE 
    ( 
     nr_cliente
    ) 
;

ALTER TABLE MC_SGV_CLI_PJ 
    ADD CONSTRAINT ser1 FOREIGN KEY 
    ( 
     nr_cliente
    ) 
    REFERENCES MC_SGV_CLIENTE 
    ( 
     nr_cliente
    ) 
;

ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT solicitar FOREIGN KEY 
    ( 
     nr_cliente
    ) 
    REFERENCES MC_SGV_CLIENTE 
    ( 
     nr_cliente
    ) 
;

ALTER TABLE MC_SGV_VIDEO 
    ADD CONSTRAINT ter FOREIGN KEY 
    ( 
     cd_produto
    ) 
    REFERENCES MC_SGV_PRODUTO 
    ( 
     cd_produto
    ) 
;

ALTER TABLE MC_SGV_VISUALIZACAO_VIDEO 
    ADD CONSTRAINT ter1 FOREIGN KEY 
    ( 
     cd_video
    ) 
    REFERENCES MC_SGV_VIDEO 
    ( 
     cd_video
    ) 
;

ALTER TABLE MC_SGV_END_FUNC 
    ADD CONSTRAINT ter2 FOREIGN KEY 
    ( 
     cd_logradouro
    ) 
    REFERENCES MC_SGV_LOGRADOURO 
    ( 
     cd_logradouro
    ) 
;

ALTER TABLE MC_SGV_LOGRADOURO 
    ADD CONSTRAINT ter3 FOREIGN KEY 
    ( 
     cd_bairro
    ) 
    REFERENCES MC_SGV_BAIRRO 
    ( 
     cd_bairro
    ) 
;

ALTER TABLE MC_SGV_BAIRRO 
    ADD CONSTRAINT ter4 FOREIGN KEY 
    ( 
     cd_cidade
    ) 
    REFERENCES MC_SGV_CIDADE 
    ( 
     cd_cidade
    ) 
;

ALTER TABLE MC_SGV_CIDADE 
    ADD CONSTRAINT ter5 FOREIGN KEY 
    ( 
     sg_estado
    ) 
    REFERENCES MC_SGV_ESTADO 
    ( 
     sg_estado
    ) 
;

ALTER TABLE MC_SGV_END_CLI 
    ADD CONSTRAINT ter6 FOREIGN KEY 
    ( 
     cd_logradouro
    ) 
    REFERENCES MC_SGV_LOGRADOURO 
    ( 
     cd_logradouro
    ) 
;

ALTER TABLE MC_SGV_VISUALIZACAO_VIDEO 
    ADD CONSTRAINT visualizar FOREIGN KEY 
    ( 
     nr_cliente
    ) 
    REFERENCES MC_SGV_CLIENTE 
    ( 
     nr_cliente
    ) 
;

CREATE OR REPLACE TRIGGER ARC_Arc_1_MC_SGV_CLI_PF 
BEFORE INSERT OR UPDATE OF nr_cliente 
ON MC_SGV_CLI_PF 
FOR EACH ROW 
DECLARE 
    d CHAR (2); 
BEGIN 
    SELECT A.tp_cliente INTO d 
    FROM MC_SGV_CLIENTE A 
    WHERE A.nr_cliente = :new.nr_cliente; 
    IF (d IS NULL OR d <> 'PF') THEN 
        raise_application_error(-20223,'FK ser in Table MC_SGV_CLI_PF violates Arc constraint on Table MC_SGV_CLIENTE - discriminator column tp_cliente doesn''t have value ''PF'''); 
    END IF; 
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        NULL; 
    WHEN OTHERS THEN 
        RAISE; 
END; 
/

CREATE OR REPLACE TRIGGER ARC_Arc_1_MC_SGV_CLI_PJ 
BEFORE INSERT OR UPDATE OF nr_cliente 
ON MC_SGV_CLI_PJ 
FOR EACH ROW 
DECLARE 
    d CHAR (2); 
BEGIN 
    SELECT A.tp_cliente INTO d 
    FROM MC_SGV_CLIENTE A 
    WHERE A.nr_cliente = :new.nr_cliente; 
    IF (d IS NULL OR d <> 'PJ') THEN 
        raise_application_error(-20223,'FK ser1 in Table MC_SGV_CLI_PJ violates Arc constraint on Table MC_SGV_CLIENTE - discriminator column tp_cliente doesn''t have value ''PJ'''); 
    END IF; 
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        NULL; 
    WHEN OTHERS THEN 
        RAISE; 
END; 
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             56
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
