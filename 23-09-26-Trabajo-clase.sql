begin;
update estudiantes e 
set nombre = 'Carlos Mendoza'
where id_estudiante= 10;

rollback;

begin;
update estudiantes e 
set telefono = '6121234567'
where id_estudiante= 10;

--ACTUALIZAR TABLA DE DOCENTES

update docentes d 
set numero_empleado = 'EMP004'
where id_docente= 7;

--si hacemos un rollback o un commit, se regresa todo lo que este dentro del BEGIN
rollback;
 
select * from docentes d 

select * from estudiantes e 