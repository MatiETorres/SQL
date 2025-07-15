
-- VISTAS

CREATE VIEW vista_empleados_por_departamento AS
SELECT e.legajo, e.nombre, e.apellido, d.nombre AS departamento, p.nombre AS puesto
FROM Empleado e
JOIN Departamento d ON e.id_dpto = d.id_dpto
JOIN Puesto p ON e.id_puesto = p.id_puesto;

CREATE VIEW vista_asistencias_totales AS
SELECT e.legajo, e.nombre, e.apellido, COUNT(a.id_asistencia) AS total_asistencias
FROM Empleado e
LEFT JOIN Asistencia a ON e.legajo = a.legajo
GROUP BY e.legajo, e.nombre, e.apellido;

CREATE VIEW vista_empleados_con_obra_social AS
SELECT e.legajo, e.nombre, e.apellido, o.nombre AS obra_social
FROM Empleado e
JOIN ObraSocial o ON e.id_obra = o.id_obra;

-- FUNCIONES

DELIMITER //
CREATE FUNCTION fn_calcular_edad(fecha_nac DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, fecha_nac, CURDATE());
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION fn_total_asistencias(empleado_legajo INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Asistencia
    WHERE legajo = empleado_legajo;
    RETURN total;
END;
//
DELIMITER ;

-- STORED PROCEDURES

DELIMITER //
CREATE PROCEDURE sp_registrar_asistencia(
    IN p_legajo INT,
    IN p_fecha DATE,
    IN p_estado ENUM('Presente', 'Ausente', 'Licencia', 'Tardanza')
)
BEGIN
    INSERT INTO Asistencia (legajo, fecha, estado)
    VALUES (p_legajo, p_fecha, p_estado);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_actualizar_obra_social(
    IN p_legajo INT,
    IN p_nueva_obra INT
)
BEGIN
    UPDATE Empleado
    SET id_obra = p_nueva_obra
    WHERE legajo = p_legajo;
END;
//
DELIMITER ;

-- TRIGGERS

CREATE TABLE IF NOT EXISTS LogAsistencia (
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    legajo INT,
    fecha DATE,
    estado VARCHAR(20),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER trg_log_asistencia_insert
AFTER INSERT ON Asistencia
FOR EACH ROW
BEGIN
    INSERT INTO LogAsistencia (legajo, fecha, estado)
    VALUES (NEW.legajo, NEW.fecha, NEW.estado);
END;
//
DELIMITER ;
