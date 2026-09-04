/*Ejercicio 1. Consulta con INNER JOIN
*
Escriba una consulta que muestre:
1.matrícula del estudiante,
2.nombre,
3.apellido,
4.nombre de la carrera a la que pertenece.
Debe utilizar las tablas estudiantes y carreras.*/
SELECT
    e.matricula,
    e.nombre,
    e.apellido,
    c.nombre AS carrera 

FROM estudiantes e
INNER JOIN carreras c
    ON e.id_carrera = c.id_carrera;


/*Consulta de grupos e inscritos
*
Escriba una consulta que muestre:
id del grupo,
nombre de la materia,
letra o nombre del grupo,
cupo máximo,
cantidad de alumnos inscritos.

Debe utilizar grupos, materias e inscripciones. Considere solamente inscripciones cuyo
estado sea ’INSCRITO’ y utilice agrupación.*/

SELECT 
    g.id_grupo,
    m.nombre AS materia,
    g.grupo,
    g.cupo_maximo,
    COUNT(i.id_estudiante) AS cantidad_inscritos
FROM grupos g
INNER JOIN materias m
    ON g.id_materia = m.id_materia
LEFT JOIN inscripciones i
    ON g.id_grupo = i.id_grupo
    AND i.estado = 'INSCRITO'
GROUP BY
    g.id_grupo,
    m.nombre,
    g.grupo,
    g.cupo_maximo;


/*Consulta de pagos
*
Escriba una consulta que muestre los pagos realizados por los estudiantes con las siguientes
columnas:

matrícula,
nombre,
apellido,
concepto,
monto,
método de pago,
referencia.

Utilice las tablas pagos y estudiantes.*/

SELECT
    e.matricula,
    e.nombre,
    e.apellido,
    p.concepto,
    p.monto,
    p.metodo_pago,
    p.referencia 
FROM pagos p
INNER JOIN estudiantes e
  ON p.id_estudiante = e.id_estudiante

  
  /*Trigger de validación
*
Se necesita evitar que se registre una calificación menor a 0 o mayor a 100 mediante un
trigger.
Escriba:
a) Una función PL/pgSQL llamada validar_rango_calificacion().
b) Una condición que revise NEW.calificacion.
c) Un RAISE EXCEPTION cuando la calificación esté fuera del rango.
d) El trigger trg_validar_rango_calificacion que se ejecute BEFORE INSERT OR UPDATE
sobre calificaciones.*/
  
CREATE OR REPLACE FUNCTION validar_rango_calificacion()
RETURNS TRIGGER
AS $$
BEGIN

    IF NEW.calificacion < 0 OR NEW.calificacion > 100 THEN
        RAISE EXCEPTION
        'La calificación debe ser mayor a 0 y menor que 100';
    END IF;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_validar_rango_calificacion
BEFORE INSERT OR UPDATE
ON calificaciones
FOR EACH ROW
EXECUTE FUNCTION validar_rango_calificacion();


/*Procedimiento almacenado
*
Cree un procedimiento llamado:
cambiar_estado_pago
El procedimiento debe recibir:
p_referencia VARCHAR
p_estado VARCHAR
Debe realizar las siguientes acciones:
1. Buscar el pago mediante su referencia.
2. Actualizar la columna estado de la tabla pagos.
3. Si no existe un pago con esa referencia, generar un RAISE EXCEPTION.
4. Si se actualiza correctamente, mostrar un RAISE NOTICE.
5. Finalmente, escriba un ejemplo de ejecución utilizando CALL.*/

CREATE OR REPLACE PROCEDURE cambiar_estado_pago(
    p_referencia VARCHAR,
    p_estado VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE PAGOS
    SET estado = p_estado
    WHERE referencia = p_referencia;


    IF NOT FOUND THEN

        RAISE EXCEPTION
        'No se encontró ningún pago con la referencia %',
        p_referencia;

    END IF;


    RAISE NOTICE
    'El estado del pago fue actualizado correctamente..';

END;
$$;

EJEMPLO:

CALL cambiar_estado_pago(
    'REF001',
    'PAGADO'
);

SELECT
    referencia,
    monto,
    metodo_pago,
    estado
FROM pagos
WHERE referencia = 'REF001';