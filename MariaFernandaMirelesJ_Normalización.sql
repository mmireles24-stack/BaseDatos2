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
add column materias varchar(150);

alter table alumnos
add constraint fk_alumno_carrera
foreign key (carrera_id)
references carreras(id);

select * from alumnos;
select * from carreras;

INSERT INTO carreras (nombre, semestre, modalidad) VALUES
('Software', 8, 'Presencial'),
('Inteligencia Artificial', 8, 'Presencial');

INSERT INTO alumnos (nombre, correo, edad, carrera_id, materias) VALUES
('Ana', 'ana@email.com', 20, 1, 'Base de Datos, Programación Web'),
('Carlos', 'carlos@email.com', 21, 1, 'Matemáticas, Base de Datos'),
('María', 'maria@email.com', 22, 2, 'Programación Web, Matemáticas'),
('Pedro', 'pedro@email.com', 20, 1, 'Redes, Base de Datos');

SELECT * 
FROM alumnos 
WHERE materias ILIKE '%Base de Datos%';
