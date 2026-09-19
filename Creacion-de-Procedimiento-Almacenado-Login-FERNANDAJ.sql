
CREATE TABLE acceso
(
    id_estudiante INT PRIMARY KEY,
    correo VARCHAR(150) NOT NULL UNIQUE,
    contrasena VARCHAR(100) NOT NULL,

    FOREIGN KEY (id_estudiante)
        REFERENCES estudiantes(id_estudiante)
);


select * from estudiantes e

INSERT INTO acceso (id_estudiante, correo, contrasena)
VALUES
    (10, 'carlos.gomez@universidad.edu', '12345'),
    (11, 'maria.lopez@universidad.edu', 'abcde');


CREATE OR REPLACE PROCEDURE validar_login(
    p_correo VARCHAR,
    p_contrasena VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    si_existe INT;
BEGIN

    SELECT COUNT(*)
    INTO si_existe
    FROM acceso
    WHERE correo = p_correo
      AND contrasena = p_contrasena;

    IF si_existe > 0 THEN
        RAISE NOTICE 'Acceso correcto';
    ELSE
        RAISE EXCEPTION
        'Acceso denegado: credenciales inválidas para %',
        p_correo;
    END IF;

END;
$$;


call validar_login(
    'carlos.gomez@universidad.edu',
    '12345'
);


CALL validar_login(
    'carlos.gomez@universidad.edu',
    'eeee'
);



call validar_login(
    'carlos_gomez@universidad.edu',
    '12345'
);