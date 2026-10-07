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

# Facultad
CREATE TABLE facultades (
    id_facultad SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    decano VARCHAR(100),
    telefono VARCHAR(20)
);

DROP TABLE IF EXISTS carreras CASCADE;

CREATE TABLE carreras (
    id_carrera SERIAL PRIMARY KEY,
    id_facultad INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    duracion_semestres INT NOT NULL,
    estado VARCHAR(20) DEFAULT 'ACTIVA',

    CONSTRAINT fk_carrera_facultad
        FOREIGN KEY (id_facultad)
        REFERENCES facultades(id_facultad)
);


