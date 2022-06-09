create database ClinicaMedica
go

use ClinicaMedica
go

--Tabelas
create table TblPaciente(
IdPaciente int primary key identity not null,
Nome varchar(50) not null,
Email varchar(30)
)
go

insert into TblPaciente values('Maria Aparecida','mariaap@gmail.com.br')
go

create table TblMedico(
IdMedico int primary key identity not null,
Nome varchar(50) not null,
Especialidade varchar(50) not null,
)
go

insert into TblMedico values('Carlos silva','Cardiologista')
go

create table TblHospital(
IdHospital int primary key identity not null,
Nome varchar(50) not null,
Endereço varchar(50) not null,
Cidade varchar(50) not null
)
go

insert into TblHospital values('Hospital Renascentista','Rua A','Ubá')
go

create table TblConsulta(
IdConsulta int primary key identity not null,
Data date not null,
Diagnostico varchar(50) not null,
Internacao char(1), --S=Sim  N=Não
Id_Paciente int not null,
Id_Medico int not null,
Id_Hospital int not null

)
go

insert into TblConsulta 
values('09-06-2022','Pneumonia','S',1,1,1)
go

--Constraints
alter table TblConsulta add constraint FK_Consulta_Paciente
foreign key(Id_Paciente) references TblPaciente(IdPaciente)
go

alter table TblConsulta add constraint FK_Consulta_Medico
foreign key(Id_Medico) references TblMedico(IdMedico)
go

alter table TblConsulta add constraint FK_Consulta_Hospital
foreign key(Id_Hospital) references TblHospital(IdHospital)
go

--Procedure de inserir na tabela de Pacientes
Create procedure spInserirPaciente
@Nome varchar(50),
@Email varchar(30)

as begin
begin try
begin tran

insert into TblPaciente(Nome,Email)
values(@Nome,@Email)

commit tran
end try
begin catch
select ERROR_MESSAGE() as Retorno
end catch
end 
go

--Alterar tabela de Pacientes
Create procedure spAlterarPaciente
@IdPaciente int,
@Nome varchar(50),
@Email varchar(30)

as begin
begin try
begin tran

update TblPaciente
set Nome=@Nome,Email=@Email
where IdPaciente = @IdPaciente
select @IdPaciente as Retorno

commit tran
end try
begin catch
select ERROR_MESSAGE() as Retorno
end catch
end 
go

--Excluir tabela de Pacientes
Create procedure spExcluirPaciente
@IdPaciente int
as begin
begin try
begin tran

delete from TblPaciente
where IdPaciente = @IdPaciente
select @IdPaciente as Retorno

commit tran
end try
begin catch
select ERROR_MESSAGE() as Retorno
end catch
end 
go

--Listar Pacientes
Create procedure spListarPaciente
 as begin
 begin tran
 begin try

 select * from TblPaciente
 order by Nome asc

 commit tran
 end try
 begin catch
 select ERROR_Message() as Retorno
 end catch
 end
 go

 /* ------------------------------------------- */

 --Procedure de inserir na tabela de Medicos
 Create procedure spInserirMedico
@Nome varchar(50),
@Especialidade varchar(50)

as begin
begin try
begin tran

insert into TblMedico(Nome,Especialidade)
values(@Nome,@Especialidade)

commit tran
end try
begin catch
select ERROR_MESSAGE() as Retorno
end catch
end 
go

--Alterar na tabela de Médicos
Create procedure spAlterarMedico
@IdMedico int,
@Nome varchar(50),
@Especialidade varchar(50)

as begin
begin try
begin tran

update TblMedico
set Nome=@Nome,Especialidade=@Especialidade
where IdMedico = @IdMedico
select @IdMedico as Retorno

commit tran
end try
begin catch
select ERROR_MESSAGE() as Retorno
end catch
end 
go

--Excluir tabela de Médicos
Create procedure spExcluirMedico
@IdMedico int
as begin
begin try
begin tran

delete from TblMedico
where IdMedico = @IdMedico
select @Idmedico as Retorno

commit tran
end try
begin catch
select ERROR_MESSAGE() as Retorno
end catch
end 
go

--Listar Pacientes
Create procedure spListarMedico
 as begin
 begin tran
 begin try

 select * from TblMedico
 order by Nome asc

 commit tran
 end try
 begin catch
 select ERROR_Message() as Retorno
 end catch
 end
 go

 /* ---------------------------------------------- */

  --Procedure de inserir na tabela de Hospitais
 Create procedure spInserirHospital
@Nome varchar(50),
@Endereco varchar(50),
@Cidade varchar(50)

as begin
begin try
begin tran

insert into TblHospital(Nome,Endereço,Cidade)
values(@Nome,@Endereco,@Cidade)

commit tran
end try
begin catch
select ERROR_MESSAGE() as Retorno
end catch
end 
go

--Alterar na tabela de Médicos
Create procedure spAlterarHospital
@IdHospital int,
@Nome varchar(50),
@Endereco varchar(50),
@Cidade varchar(50)

as begin
begin try
begin tran

update TblHospital
set Nome=@Nome,@Endereco=@Endereco,Cidade=@Cidade
where IdHospital = @IdHospital
select @IdHospital as Retorno

commit tran
end try
begin catch
select ERROR_MESSAGE() as Retorno
end catch
end 
go

--Excluir tabela de Médicos
Create procedure spExcluirHospital
@IdHospital int
as begin
begin try
begin tran

delete from TblHospital
where IdHospital = @IdHospital
select @IdHospital as Retorno

commit tran
end try
begin catch
select ERROR_MESSAGE() as Retorno
end catch
end 
go

--Listar Pacientes
Create procedure spListarHospital
 as begin
 begin tran
 begin try

 select * from TblHospital
 order by Nome asc

 commit tran
 end try
 begin catch
 select ERROR_Message() as Retorno
 end catch
 end
 go

 /* ----------------------------------------- */

 --Consultas na tabela de Consultas
 alter view vListarConsultas
 as
 select c.IdConsulta,
        c.Data,
		p.Nome as Paciente,
		m.Nome as Medico,
		m.Especialidade as Especialidade
		
		from TblConsulta c join
		TblPaciente p on p.IdPaciente = c.Id_Paciente join
		TblMedico m on m.IdMedico = c.Id_Medico join
		TblHospital h on h.IdHospital = c.Id_Hospital
		
 go

 select * from vListarConsultas
 go