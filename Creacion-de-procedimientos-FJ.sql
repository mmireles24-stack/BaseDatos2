CREATE OR REPLACE PROCEDURE cambiar_docente_grupo(
    p_id_grupo INT,
    p_id_docente INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_grupo INT;
BEGIN

    SELECT id_grupo
    INTO v_id_grupo
    FROM grupos
    WHERE id_grupo = p_id_grupo;

    IF NOT FOUND THEN
        RAISE EXCEPTION
        'No existe un grupo con ID %',
        p_id_grupo;
    END IF;

    UPDATE grupos
    SET id_docente = p_id_docente
    WHERE id_grupo = p_id_grupo;

    RAISE NOTICE
    'Docente del grupo actualizado correctamente.';

END;
$$;