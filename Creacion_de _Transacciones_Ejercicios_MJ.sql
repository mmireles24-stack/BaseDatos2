select * from estudiantes e 

begin;

update estudiantes e 
set estado= 'BAJA'
where id_estudiante= 9

select e.id_estudiante, nombre,apellido, estado
from estudiantes e 
where id_estudiante = 9

/*rollback;*/
commit;


--realizar un pago en la tabla pagos
--monto 3500
--metodo transferencia
--concepto de inscripcion
--estado pagado
--llaves foraneas
--estudiantes 
--periodo

select * from pagos p 

begin;

insert into  pagos (id_estudiante,id_periodo, concepto, monto, metodo_pago, estado)
	values (9,2,'reinscripción', 3500,'Transferencia','PAGADO');

select p.id_estudiante, concepto, p.fecha_pago, p.estado,p.concepto,p.metodo_pago 
from pagos p  
where id_estudiante = 9

rollback;

commit;


select * from estudiantes e 

begin;

update estudiantes e 
set telefono= '6123456789'
where id_estudiante= 12

insert into  pagos (id_estudiante,id_periodo, concepto, monto, metodo_pago, estado)
	values (12,2,'inscripción', 3500,'Tarjeta','PAGADO');

select e.id_estudiante, nombre,apellido, telefono 
from estudiantes e 
where id_estudiante = 12

select p.id_estudiante, concepto, p.fecha_pago, p.estado,p.concepto,p.metodo_pago 
from pagos p  
where id_estudiante = 12

commit;






