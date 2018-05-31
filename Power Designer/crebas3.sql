/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     19/06/2013 17:40:02                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.MATRICULA') and o.name = 'FK_MATRICUL_REFERENCE_ALUMNO')
alter table dbo.MATRICULA
   drop constraint FK_MATRICUL_REFERENCE_ALUMNO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.MATRICULA') and o.name = 'FK_MATRICUL_REFERENCE_CARRERA')
alter table dbo.MATRICULA
   drop constraint FK_MATRICUL_REFERENCE_CARRERA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.PLAN_ESTUDIO') and o.name = 'FK_PLAN_EST_REFERENCE_ASIGNATU')
alter table dbo.PLAN_ESTUDIO
   drop constraint FK_PLAN_EST_REFERENCE_ASIGNATU
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.PLAN_ESTUDIO') and o.name = 'FK_PLAN_EST_REFERENCE_CARRERA')
alter table dbo.PLAN_ESTUDIO
   drop constraint FK_PLAN_EST_REFERENCE_CARRERA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.ALUMNO')
            and   name  = 'DUI_UNQ'
            and   indid > 0
            and   indid < 255)
   drop index dbo.ALUMNO.DUI_UNQ
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.ALUMNO')
            and   type = 'U')
   drop table dbo.ALUMNO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.ASIGNATURA')
            and   type = 'U')
   drop table dbo.ASIGNATURA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.CARRERA')
            and   type = 'U')
   drop table dbo.CARRERA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.MATRICULA')
            and   type = 'U')
   drop table dbo.MATRICULA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.PLAN_ESTUDIO')
            and   type = 'U')
   drop table dbo.PLAN_ESTUDIO
go

drop schema dbo
go

/*==============================================================*/
/* User: dbo                                                    */
/*==============================================================*/
create schema dbo
go

/*==============================================================*/
/* Table: ALUMNO                                                */
/*==============================================================*/
create table dbo.ALUMNO (
   CARNET               char(7)              collate Modern_Spanish_CI_AS not null,
   NOMBRE               varchar(50)          collate Modern_Spanish_CI_AS not null,
   APELLIDOS            varchar(50)          collate Modern_Spanish_CI_AS not null,
   DUI                  char(10)             collate Modern_Spanish_CI_AS not null,
   constraint PK_ALUMNO primary key (CARNET)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Index: DUI_UNQ                                               */
/*==============================================================*/
create unique index DUI_UNQ on dbo.ALUMNO (
DUI ASC
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: ASIGNATURA                                            */
/*==============================================================*/
create table dbo.ASIGNATURA (
   CODIGO_ASIGNATURA    char(6)              collate Modern_Spanish_CI_AS not null,
   NOMBRE               varchar(50)          collate Modern_Spanish_CI_AS not null,
   constraint PK_ASIGNATURA primary key (CODIGO_ASIGNATURA)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: CARRERA                                               */
/*==============================================================*/
create table dbo.CARRERA (
   CODIGO_CARRERA       char(6)              collate Modern_Spanish_CI_AS not null,
   NOMBRE               varchar(50)          collate Modern_Spanish_CI_AS not null,
   constraint PK_CARRERA primary key (CODIGO_CARRERA)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: MATRICULA                                             */
/*==============================================================*/
create table dbo.MATRICULA (
   CARNET               char(7)              collate Modern_Spanish_CI_AS not null,
   CODIGO_CARRERA       char(6)              collate Modern_Spanish_CI_AS not null,
   CICLO_MATRICULA      char(6)              collate Modern_Spanish_CI_AS not null,
   ACTIVO               smallint             not null,
   constraint PK_MATRICULA primary key (CARNET, CODIGO_CARRERA)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: PLAN_ESTUDIO                                          */
/*==============================================================*/
create table dbo.PLAN_ESTUDIO (
   CODIGO_ASIGNATURA    char(6)              collate Modern_Spanish_CI_AS not null,
   CODIGO_CARRERA       char(6)              collate Modern_Spanish_CI_AS not null,
   CICLO                char(6)              collate Modern_Spanish_CI_AS not null,
   UV                   smallint             not null,
   constraint PK_PLAN_ESTUDIO primary key (CODIGO_ASIGNATURA, CODIGO_CARRERA)
         on "PRIMARY"
)
on "PRIMARY"
go

alter table dbo.MATRICULA
   add constraint FK_MATRICUL_REFERENCE_ALUMNO foreign key (CARNET)
      references dbo.ALUMNO (CARNET)
go

alter table dbo.MATRICULA
   add constraint FK_MATRICUL_REFERENCE_CARRERA foreign key (CODIGO_CARRERA)
      references dbo.CARRERA (CODIGO_CARRERA)
go

alter table dbo.PLAN_ESTUDIO
   add constraint FK_PLAN_EST_REFERENCE_ASIGNATU foreign key (CODIGO_ASIGNATURA)
      references dbo.ASIGNATURA (CODIGO_ASIGNATURA)
go

alter table dbo.PLAN_ESTUDIO
   add constraint FK_PLAN_EST_REFERENCE_CARRERA foreign key (CODIGO_CARRERA)
      references dbo.CARRERA (CODIGO_CARRERA)
go

