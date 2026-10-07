create table carreras (
id serial primary key,
nombre varchar (100) not null,
semestre int not null,
modalidad varchar (100) not null
);

create table alumnos (
id serial primary key, --autoincrementable 
nombre varchar (100) not null,
correo varchar (150) unique,
edad int
);

alter table alumnos
add column carrera_id int;


alter table alumnos
add constraint fk_alumno_carrera
foreign key (carrera_id)
references carreras(id);

select * from alumnos
select * from carreras

