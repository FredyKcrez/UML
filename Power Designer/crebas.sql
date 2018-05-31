/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     19/06/2013 11:46:05                          */
/*==============================================================*/


drop index ASEGURADORA_PK;

drop table ASEGURADORA;

drop index ATIENDE_FK;

drop index PASA_A_FK;

drop index CONSULTA_PK;

drop table CONSULTA;

drop index ESPECIALIDAD_PK;

drop table ESPECIALIDAD;

drop index FINANCIA_FK;

drop index FINANCIA2_FK;

drop index FINANCIA_PK;

drop table FINANCIA;

drop index ES_UN_FK;

drop index MEDICO_PK;

drop table MEDICO;

drop index ES_UN2_FK;

drop index PACIENTE_PK;

drop table PACIENTE;

drop index ES_DE_FK;

drop index PERSONA_PK;

drop table PERSONA;

drop index SEXO_PK;

drop table SEXO;

drop index TIENE_FK;

drop index TIENE2_FK;

drop index TIENE_PK;

drop table TIENE;

/*==============================================================*/
/* Table: ASEGURADORA                                           */
/*==============================================================*/
create table ASEGURADORA (
   CODIGO               VARCHAR(10)          not null,
   NOMBRE_ASEGURADO     VARCHAR(50)          not null,
   constraint PK_ASEGURADORA primary key (CODIGO)
);

/*==============================================================*/
/* Index: ASEGURADORA_PK                                        */
/*==============================================================*/
create unique index ASEGURADORA_PK on ASEGURADORA (
CODIGO
);

/*==============================================================*/
/* Table: CONSULTA                                              */
/*==============================================================*/
create table CONSULTA (
   NUM_REGISTRO         VARCHAR(10)          not null,
   NUM_CONSULTA         INT4                 not null,
   NUM_EXPEDIENTE       VARCHAR(10)          null,
   CONSULTA_POR         VARCHAR(500)         not null,
   DIAGNOSTICO          VARCHAR(500)         null,
   FECHA                DATE                 not null,
   constraint PK_CONSULTA primary key (NUM_REGISTRO, NUM_CONSULTA)
);

/*==============================================================*/
/* Index: CONSULTA_PK                                           */
/*==============================================================*/
create unique index CONSULTA_PK on CONSULTA (
NUM_REGISTRO,
NUM_CONSULTA
);

/*==============================================================*/
/* Index: PASA_A_FK                                             */
/*==============================================================*/
create  index PASA_A_FK on CONSULTA (
NUM_EXPEDIENTE
);

/*==============================================================*/
/* Index: ATIENDE_FK                                            */
/*==============================================================*/
create  index ATIENDE_FK on CONSULTA (
NUM_REGISTRO
);

/*==============================================================*/
/* Table: ESPECIALIDAD                                          */
/*==============================================================*/
create table ESPECIALIDAD (
   CODIGO_ESP           VARCHAR(10)          not null,
   ESPECIALIDAD         VARCHAR(50)          not null,
   constraint PK_ESPECIALIDAD primary key (CODIGO_ESP)
);

/*==============================================================*/
/* Index: ESPECIALIDAD_PK                                       */
/*==============================================================*/
create unique index ESPECIALIDAD_PK on ESPECIALIDAD (
CODIGO_ESP
);

/*==============================================================*/
/* Table: FINANCIA                                              */
/*==============================================================*/
create table FINANCIA (
   CODIGO               VARCHAR(10)          not null,
   NUM_EXPEDIENTE       VARCHAR(10)          not null,
   constraint PK_FINANCIA primary key (CODIGO, NUM_EXPEDIENTE)
);

/*==============================================================*/
/* Index: FINANCIA_PK                                           */
/*==============================================================*/
create unique index FINANCIA_PK on FINANCIA (
CODIGO,
NUM_EXPEDIENTE
);

/*==============================================================*/
/* Index: FINANCIA2_FK                                          */
/*==============================================================*/
create  index FINANCIA2_FK on FINANCIA (
NUM_EXPEDIENTE
);

/*==============================================================*/
/* Index: FINANCIA_FK                                           */
/*==============================================================*/
create  index FINANCIA_FK on FINANCIA (
CODIGO
);

/*==============================================================*/
/* Table: MEDICO                                                */
/*==============================================================*/
create table MEDICO (
   NUM_REGISTRO         VARCHAR(10)          not null,
   DOCUMENTO_IDENTIDAD  VARCHAR(10)          null,
   COD_EMPLEADO         VARCHAR(10)          not null,
   TARIFA               DECIMAL(10,2)        not null,
   constraint PK_MEDICO primary key (NUM_REGISTRO)
);

/*==============================================================*/
/* Index: MEDICO_PK                                             */
/*==============================================================*/
create unique index MEDICO_PK on MEDICO (
NUM_REGISTRO
);

/*==============================================================*/
/* Index: ES_UN_FK                                              */
/*==============================================================*/
create  index ES_UN_FK on MEDICO (
DOCUMENTO_IDENTIDAD
);

/*==============================================================*/
/* Table: PACIENTE                                              */
/*==============================================================*/
create table PACIENTE (
   NUM_EXPEDIENTE       VARCHAR(10)          not null,
   DOCUMENTO_IDENTIDAD  VARCHAR(10)          null,
   constraint PK_PACIENTE primary key (NUM_EXPEDIENTE)
);

/*==============================================================*/
/* Index: PACIENTE_PK                                           */
/*==============================================================*/
create unique index PACIENTE_PK on PACIENTE (
NUM_EXPEDIENTE
);

/*==============================================================*/
/* Index: ES_UN2_FK                                             */
/*==============================================================*/
create  index ES_UN2_FK on PACIENTE (
DOCUMENTO_IDENTIDAD
);

/*==============================================================*/
/* Table: PERSONA                                               */
/*==============================================================*/
create table PERSONA (
   DOCUMENTO_IDENTIDAD  VARCHAR(10)          not null,
   CODIGO_SEX           VARCHAR(1)           null,
   NOMBRE               VARCHAR(50)          not null,
   APELLIDOS            VARCHAR(50)          not null,
   FECHA_NACIMIENTO     DATE                 not null,
   constraint PK_PERSONA primary key (DOCUMENTO_IDENTIDAD)
);

/*==============================================================*/
/* Index: PERSONA_PK                                            */
/*==============================================================*/
create unique index PERSONA_PK on PERSONA (
DOCUMENTO_IDENTIDAD
);

/*==============================================================*/
/* Index: ES_DE_FK                                              */
/*==============================================================*/
create  index ES_DE_FK on PERSONA (
CODIGO_SEX
);

/*==============================================================*/
/* Table: SEXO                                                  */
/*==============================================================*/
create table SEXO (
   CODIGO_SEX           VARCHAR(1)           not null,
   SEXO                 VARCHAR(10)          not null,
   constraint PK_SEXO primary key (CODIGO_SEX)
);

/*==============================================================*/
/* Index: SEXO_PK                                               */
/*==============================================================*/
create unique index SEXO_PK on SEXO (
CODIGO_SEX
);

/*==============================================================*/
/* Table: TIENE                                                 */
/*==============================================================*/
create table TIENE (
   CODIGO_ESP           VARCHAR(10)          not null,
   NUM_REGISTRO         VARCHAR(10)          not null,
   constraint PK_TIENE primary key (CODIGO_ESP, NUM_REGISTRO)
);

/*==============================================================*/
/* Index: TIENE_PK                                              */
/*==============================================================*/
create unique index TIENE_PK on TIENE (
CODIGO_ESP,
NUM_REGISTRO
);

/*==============================================================*/
/* Index: TIENE2_FK                                             */
/*==============================================================*/
create  index TIENE2_FK on TIENE (
NUM_REGISTRO
);

/*==============================================================*/
/* Index: TIENE_FK                                              */
/*==============================================================*/
create  index TIENE_FK on TIENE (
CODIGO_ESP
);

alter table CONSULTA
   add constraint FK_CONSULTA_ATIENDE_MEDICO foreign key (NUM_REGISTRO)
      references MEDICO (NUM_REGISTRO)
      on delete restrict on update restrict;

alter table CONSULTA
   add constraint FK_CONSULTA_PASA_A_PACIENTE foreign key (NUM_EXPEDIENTE)
      references PACIENTE (NUM_EXPEDIENTE)
      on delete restrict on update restrict;

alter table FINANCIA
   add constraint FK_FINANCIA_FINANCIA_ASEGURAD foreign key (CODIGO)
      references ASEGURADORA (CODIGO)
      on delete restrict on update restrict;

alter table FINANCIA
   add constraint FK_FINANCIA_FINANCIA2_PACIENTE foreign key (NUM_EXPEDIENTE)
      references PACIENTE (NUM_EXPEDIENTE)
      on delete restrict on update restrict;

alter table MEDICO
   add constraint FK_MEDICO_ES_UN_PERSONA foreign key (DOCUMENTO_IDENTIDAD)
      references PERSONA (DOCUMENTO_IDENTIDAD)
      on delete restrict on update restrict;

alter table PACIENTE
   add constraint FK_PACIENTE_ES_UN2_PERSONA foreign key (DOCUMENTO_IDENTIDAD)
      references PERSONA (DOCUMENTO_IDENTIDAD)
      on delete restrict on update restrict;

alter table PERSONA
   add constraint FK_PERSONA_ES_DE_SEXO foreign key (CODIGO_SEX)
      references SEXO (CODIGO_SEX)
      on delete restrict on update restrict;

alter table TIENE
   add constraint FK_TIENE_TIENE_ESPECIAL foreign key (CODIGO_ESP)
      references ESPECIALIDAD (CODIGO_ESP)
      on delete restrict on update restrict;

alter table TIENE
   add constraint FK_TIENE_TIENE2_MEDICO foreign key (NUM_REGISTRO)
      references MEDICO (NUM_REGISTRO)
      on delete restrict on update restrict;

