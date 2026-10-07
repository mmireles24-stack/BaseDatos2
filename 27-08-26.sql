/*  9. Tabla grupos
Esta tabla es especialmente importante para explicar el tema de  arquitectura.

Una materia existe independientemente, por ejemplo:

Programación Web

Pero un grupo representa que esa materia será impartida por un docente, en un aula y durante un periodo determinado.*/


CREATE TABLE grupos (
    id_grupo SERIAL PRIMARY KEY,
    id_materia INT NOT NULL,
    id_docente INT NOT NULL,
    id_periodo INT NOT NULL,
    id_aula INT NOT NULL,
    grupo VARCHAR(10) NOT NULL,
    horario VARCHAR(100),
    cupo_maximo INT DEFAULT 30,

    CONSTRAINT fk_grupo_materia
        FOREIGN KEY (id_materia)
        REFERENCES materias(id_materia),

    CONSTRAINT fk_grupo_docente
        FOREIGN KEY (id_docente)
        REFERENCES docentes(id_docente),

    CONSTRAINT fk_grupo_periodo
        FOREIGN KEY (id_periodo)
        REFERENCES periodos_academicos(id_periodo),

    CONSTRAINT fk_grupo_aula
        FOREIGN KEY (id_aula)
        REFERENCES aulas(id_aula)
);

INSERT INTO grupos
(id_materia, id_docente, id_periodo, id_aula, grupo, horario, cupo_maximo)
VALUES
(1, 7, 2, 1, 'A', 'Lunes y Miércoles 08:00-10:00', 30),
(2, 8, 2, 2, 'A', 'Martes y Jueves 10:00-12:00', 35),
(3, 7, 2, 3, 'A', 'Lunes y Miércoles 12:00-14:00', 25);

select * from grupos 


/* 10. Tabla inscripciones
 Una relación muchos a muchos.

Un estudiante puede estar en muchos grupos y un grupo puede tener muchos estudiantes.

Por eso necesitamos una tabla intermedia.*/

CREATE TABLE inscripciones (
    id_inscripcion SERIAL PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_grupo INT NOT NULL,
    id_periodo INT NOT NULL,
    fecha_inscripcion DATE DEFAULT CURRENT_DATE,
    estado VARCHAR(20) DEFAULT 'INSCRITO',

    CONSTRAINT fk_inscripcion_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiantes(id_estudiante),

    CONSTRAINT fk_inscripcion_grupo
        FOREIGN KEY (id_grupo)
        REFERENCES grupos(id_grupo),

    CONSTRAINT fk_inscripcion_periodo
        FOREIGN KEY (id_periodo)
        REFERENCES periodos_academicos(id_periodo),

    CONSTRAINT uq_estudiante_grupo
        UNIQUE(id_estudiante, id_grupo)
);


INSERT INTO inscripciones
(id_estudiante, id_grupo, id_periodo)
VALUES
(9, 1, 2),
(9, 2, 2),
(9, 3, 2),

(10, 1, 2),
(10, 2, 2),

(11, 1, 2);

select * from inscripciones


-- # 11. Tabla calificaciones
CREATE TABLE calificaciones (
    id_calificacion SERIAL PRIMARY KEY,
    id_inscripcion INT NOT NULL,
    calificacion DECIMAL(5,2),
    fecha_registro DATE DEFAULT CURRENT_DATE,
    observaciones TEXT,
    tipo_evaluacion VARCHAR(50),

    CONSTRAINT fk_calificacion_inscripcion
        FOREIGN KEY (id_inscripcion)
        REFERENCES inscripciones(id_inscripcion),

    CONSTRAINT chk_calificacion
        CHECK (calificacion >= 0 AND calificacion <= 100) --sirve para validar
);

INSERT INTO calificaciones
(id_inscripcion, calificacion, observaciones, tipo_evaluacion)
VALUES
(1, 90, 'Buen desempeño', 'Final'),
(2, 85, 'Cumplió con las actividades', 'Final'),
(3, 95, 'Excelente desempeño', 'Final'),
(4, 78, 'Debe mejorar prácticas', 'Final'),
(5, 88, 'Buen desempeño', 'Final');

select * from calificaciones

CREATE TABLE pagos (
    id_pago SERIAL PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_periodo INT NOT NULL,
    concepto VARCHAR(100) NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago VARCHAR(30),
    referencia VARCHAR(100),
    estado VARCHAR(20) DEFAULT 'PAGADO',

    CONSTRAINT fk_pago_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiantes(id_estudiante),

    CONSTRAINT fk_pago_periodo
        FOREIGN KEY (id_periodo)
        REFERENCES periodos_academicos(id_periodo),

    CONSTRAINT chk_monto
        CHECK (monto > 0)
);


INSERT INTO pagos
(id_estudiante, id_periodo, concepto, monto, metodo_pago, referencia)
VALUES
(9, 2, 'Inscripción', 3500.00, 'Tarjeta', 'REF001'),
(10, 2, 'Inscripción', 3500.00, 'Transferencia', 'REF002'),
(11, 2, 'Inscripción', 3500.00, 'Efectivo', 'REF003');

select * from pagos 




