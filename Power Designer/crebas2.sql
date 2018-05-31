/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     19/06/2013 15:28:57                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MATRICULA') and o.name = 'FK_MATRICUL_REFERENCE_ALUMNO')
alter table MATRICULA
   drop constraint FK_MATRICUL_REFERENCE_ALUMNO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MATRICULA') and o.name = 'FK_MATRICUL_REFERENCE_CARRERA')
alter table MATRICULA
   drop constraint FK_MATRICUL_REFERENCE_CARRERA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PLAN_ESTUDIO') and o.name = 'FK_PLAN_EST_REFERENCE_ASIGNATU')
alter table PLAN_ESTUDIO
   drop constraint FK_PLAN_EST_REFERENCE_ASIGNATU
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PLAN_ESTUDIO') and o.name = 'FK_PLAN_EST_REFERENCE_CARRERA')
alter table PLAN_ESTUDIO
   drop constraint FK_PLAN_EST_REFERENCE_CARRERA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ALUMNO')
            and   name  = 'DUI_UNQ'
            and   indid > 0
            and   indid < 255)
   drop index ALUMNO.DUI_UNQ
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ALUMNO')
            and   type = 'U')
   drop table ALUMNO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ASIGNATURA')
            and   type = 'U')
   drop table ASIGNATURA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CARRERA')
            and   type = 'U')
   drop table CARRERA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MATRICULA')
            and   type = 'U')
   drop table MATRICULA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PLAN_ESTUDIO')
            and   type = 'U')
   drop table PLAN_ESTUDIO
go

/*==============================================================*/
/* Table: ALUMNO                                                */
/*==============================================================*/
create table ALUMNO (
   CARNET               char(7)              not null,
   NOMBRE               varchar(50)          not null,
   APELLIDOS            varchar(50)          not null,
   DUI                  char(10)             not null,
   constraint PK_ALUMNO primary key (CARNET)
)
go

/*==============================================================*/
/* Index: DUI_UNQ                                               */
/*==============================================================*/
create unique index DUI_UNQ on ALUMNO (
DUI ASC
)
go

/*==============================================================*/
/* Table: ASIGNATURA                                            */
/*==============================================================*/
create table ASIGNATURA (
   CODIGO_ASIGNATURA    char(6)              not null,
   NOMBRE               varchar(50)          not null,
   constraint PK_ASIGNATURA primary key (CODIGO_ASIGNATURA)
)
go

/*==============================================================*/
/* Table: CARRERA                                               */
/*==============================================================*/
create table CARRERA (
   CODIGO_CARRERA       char(6)              not null,
   NOMBRE               varchar(50)          not null,
   constraint PK_CARRERA primary key (CODIGO_CARRERA)
)
go

/*==============================================================*/
/* Table: MATRICULA                                             */
/*==============================================================*/
create table MATRICULA (
   CARNET               char(7)              not null,
   CODIGO_CARRERA       char(6)              not null,
   CICLO_MATRICULA      char(6)              not null,
   ACTIVO               smallint             not null,
   constraint PK_MATRICULA primary key (CARNET, CODIGO_CARRERA)
)
go

/*==============================================================*/
/* Table: PLAN_ESTUDIO                                          */
/*==============================================================*/
create table PLAN_ESTUDIO (
   CODIGO_ASIGNATURA    char(6)              not null,
   CODIGO_CARRERA       char(6)              not null,
   CICLO                char(6)              not null,
   UV                   smallint             not null,
   constraint PK_PLAN_ESTUDIO primary key (CODIGO_ASIGNATURA, CODIGO_CARRERA)
)
go

alter table MATRICULA
   add constraint FK_MATRICUL_REFERENCE_ALUMNO foreign key (CARNET)
      references ALUMNO (CARNET)
go

alter table MATRICULA
   add constraint FK_MATRICUL_REFERENCE_CARRERA foreign key (CODIGO_CARRERA)
      references CARRERA (CODIGO_CARRERA)
go

alter table PLAN_ESTUDIO
   add constraint FK_PLAN_EST_REFERENCE_ASIGNATU foreign key (CODIGO_ASIGNATURA)
      references ASIGNATURA (CODIGO_ASIGNATURA)
go

alter table PLAN_ESTUDIO
   add constraint FK_PLAN_EST_REFERENCE_CARRERA foreign key (CODIGO_CARRERA)
      references CARRERA (CODIGO_CARRERA)
go

