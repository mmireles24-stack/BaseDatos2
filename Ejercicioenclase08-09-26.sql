select * from estudiantes
/* =========================================================
   5. PROCEDIMIENTO - CAMBIAR ESTADO DE ESTUDIANTE
   ========================================================= 
   
   Datos de entrada:Matricula del estudiante
   
   Datos de salida:
   
   Objetivo:Cambiar el estado
   **/

CREATE OR REPLACE PROCEDURE cambiar_estado_estudiante(
    p_matricula VARCHAR,
    p_estado VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE estudiantes
    SET estado = p_estado
    WHERE matricula = p_matricula;


    IF NOT FOUND THEN

        RAISE EXCEPTION
        'No existe un estudiante con la matrícula %',
        p_matricula;

    END IF;


    RAISE NOTICE
    'Estado del estudiante actualizado correctamente.';

END;
$$;



/* =========================================================
   EJECUTAR PROCEDIMIENTO
   ========================================================= */

CALL cambiar_estado_estudiante(
    '2026001',
    'INACTIVO'
);


/* Verificar */

SELECT
    matricula,
    nombre,
    apellido,
    estado
FROM estudiantes
WHERE matricula = '2026001';


/* Regresarlo a ACTIVO */

CALL cambiar_estado_estudiante(
    '2026001',
    'ACTIVO'
);


