select * from estudiantes e 
select * from grupos g
select * from inscripciones 
select * from pagos p


begin;

--Reducir el grupo
	update grupos g
	set cupo_maximo = cupo_maximo - 1
	where id_grupo = 2;

--Registrar Inscripciones
	insert into inscripciones (id_estudiante, id_periodo, id_grupo, estado)
	values (10, 2, 3, 'INSCRITO');

--Registrar Pago	
	insert into  pagos (id_estudiante,id_periodo, concepto,monto)
	values (10,2,'inscripción', 3800);
	--Si todo sale bien se usa COMMIT
commit 

-- O ROLLBACK si ocurre un error
/*rollback */