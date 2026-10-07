CREATE TABLE acceso
(
    id_acceso     SERIAL PRIMARY KEY,
    correo        VARCHAR(150)  NOT NULL UNIQUE,
    contrasena    VARCHAR(100)  NOT NULL
);
 
INSERT INTO acceso (correo, contrasena)
VALUES
    ('juan.perez@universidad.edu',  '12345'),
    ('maria.lopez@universidad.edu', 'abcde');
 
CREATE OR REPLACE PROCEDURE sp_validar_login(
    p_correo     VARCHAR,
    p_contrasena VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_existe INT;
BEGIN
    SELECT COUNT(*)
    INTO v_existe
    FROM acceso
    WHERE correo = p_correo
      AND contrasena = p_contrasena;
 
    IF v_existe > 0 THEN
        RAISE NOTICE 'Acceso Correcto';
    ELSE
        RAISE EXCEPTION 'Acceso Denegado: credenciales inválidas para %', p_correo;
    END IF;
END;
$$;
 
CALL sp_validar_login('juan.perez@universidad.edu', '12345');   -- Acceso Correcto
CALL sp_validar_login('juan.perez@universidad.edu', 'xxxxx');   -- Acceso Denegado
CALL sp_validar_login('no.existe@universidad.edu',  '12345');   -- Acceso Denegado