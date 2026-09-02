/* =========================================================
   1. TRIGGER - VALIDAR CUPO DEL GRUPO
   ========================================================= */

CREATE OR REPLACE FUNCTION validar_cupo_grupo()
RETURNS TRIGGER
AS $$
DECLARE
    total_inscritos INT;
    limite_grupo INT;
BEGIN
	--OBTENIENDO EL TOTAL DE INSCRITOS 
    SELECT COUNT(*)  --COUNT CONTABILIZA TODO LO QUE ENCUENTRE EN EL WHERE 
    INTO total_inscritos --SIRVE PARA DECLARAR UNA VARIABLE
    FROM inscripciones --DE QUE TABLA LO OBTENDREMOS 
    WHERE id_grupo = NEW.id_grupo
      AND estado = 'INSCRITO';

	--TOTAL DE CUPO MÁXIMO 
    SELECT cupo_maximo
    INTO limite_grupo
    FROM pagos
    WHERE id_grupo = NEW.id_grupo;


    IF total_inscritos >= limite_grupo THEN
        RAISE EXCEPTION
        'No se puede realizar la inscripción. El grupo está lleno.';
    END IF;


    RETURN NEW;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_validar_cupo_grupo
BEFORE INSERT
ON inscripciones
FOR EACH ROW
EXECUTE FUNCTION validar_cupo_grupo();



/* =========================================================
   PRUEBA DEL TRIGGER
   ========================================================= */

SELECT
    g.id_grupo,
    m.nombre AS materia,
    g.grupo,
    g.cupo_maximo,
    COUNT(i.id_inscripcion) AS alumnos_inscritos
FROM grupos g
INNER JOIN materias m
    ON g.id_materia = m.id_materia
LEFT JOIN inscripciones i
    ON g.id_grupo = i.id_grupo
    AND i.estado = 'INSCRITO'
GROUP by --SIRVE PARA AGRUPAR LO QUE NO ESTÁ EN LA TABLA, COMO EL COUNT, SUM, ETC.
    g.id_grupo,
    m.nombre,
    g.grupo,
    g.cupo_maximo
ORDER BY g.id_grupo;


/*
Ejemplo:

INSERT INTO inscripciones
(id_estudiante, id_grupo, id_periodo)
VALUES
(9, 1, 2);
*/

select * from grupos g
select * from inscripciones i



--Trabajo en clase

CREATE OR REPLACE FUNCTION validar_monto_pago()
RETURNS TRIGGER
AS $$
DECLARE
    monto_maximo INT;
BEGIN

    SELECT NEW.monto
    INTO monto_maximo;

    IF monto_maximo > 20000 THEN
        RAISE EXCEPTION
        'El monto supera el límite permitido.';
    END IF;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_validar_monto_pago
BEFORE INSERT
ON pagos
FOR EACH ROW
EXECUTE FUNCTION validar_monto_pago();



/* =========================================================
   PRUEBA DEL TRIGGER
   ========================================================= */

select 
    p.id_pago,
    p.id_estudiante,
    p.monto,
    p.estado
FROM pagos p
ORDER BY p.id_pago;

INSERT INTO pagos 
    (id_estudiante, id_periodo, concepto, monto, metodo_pago, estado)
VALUES 
    (9, 2, 'Inscripción', 20000, 'Tarjeta', 'PAGADO');

INSERT INTO pagos 
    (id_estudiante, id_periodo, concepto, monto, metodo_pago, estado)
VALUES 
    (10, 2, 'Inscripción', 20001, 'Transferencia', 'PAGADO');

-- COMPROBACIÓN
SELECT 
    p.id_pago,
    p.id_estudiante,
    p.monto,
    p.estado
FROM pagos p
ORDER BY p.id_pago;

