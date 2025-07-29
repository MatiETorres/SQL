
-- CREACIÓN DE BASE DE DATOS Y TABLAS
CREATE DATABASE IF NOT EXISTS RecursosHumanos;
USE RecursosHumanos;

-- Tabla Departamento
CREATE TABLE IF NOT EXISTS Departamento (
    id_dpto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100)
);

-- Tabla Puesto
CREATE TABLE IF NOT EXISTS Puesto (
    id_puesto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100),
    id_dpto INT,
    FOREIGN KEY (id_dpto) REFERENCES Departamento(id_dpto)
);

-- Tabla ObraSocial
CREATE TABLE IF NOT EXISTS ObraSocial (
    id_obra INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(100)
);

-- Tabla Empleado
CREATE TABLE IF NOT EXISTS Empleado (
    legajo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni CHAR(8) UNIQUE NOT NULL,
    fecha_nac DATE NOT NULL,
    edad INT,
    lugar_nacimiento VARCHAR(100),
    id_puesto INT,
    id_dpto INT,
    id_obra INT,
    telefono VARCHAR(20),
    email VARCHAR(50),
    FOREIGN KEY (id_puesto) REFERENCES Puesto(id_puesto),
    FOREIGN KEY (id_dpto) REFERENCES Departamento(id_dpto),
    FOREIGN KEY (id_obra) REFERENCES ObraSocial(id_obra)
);

-- Tabla Asistencia
CREATE TABLE IF NOT EXISTS Asistencia (
    id_asistencia INT PRIMARY KEY AUTO_INCREMENT,
    legajo INT NOT NULL,
    fecha DATE NOT NULL,
    estado ENUM('Presente', 'Ausente', 'Licencia', 'Tardanza') NOT NULL,
    FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);

-- Tabla ContactoEmergencia
CREATE TABLE IF NOT EXISTS ContactoEmergencia (
    id_contacto INT PRIMARY KEY AUTO_INCREMENT,
    legajo INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    parentesco VARCHAR(30),
    FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);

-- Tabla auxiliar LogAsistencia
CREATE TABLE IF NOT EXISTS LogAsistencia (
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    legajo INT,
    fecha DATE,
    estado VARCHAR(20)
);

-- FUNCIONES
DELIMITER //
CREATE FUNCTION fn_calcular_edad(fecha_nac DATE)
RETURNS INT DETERMINISTIC
BEGIN
  RETURN TIMESTAMPDIFF(YEAR, fecha_nac, CURDATE());
END;
//

CREATE FUNCTION fn_total_asistencias(emp_legajo INT)
RETURNS INT DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM Asistencia WHERE legajo = emp_legajo AND estado = 'Presente';
  RETURN total;
END;
//
DELIMITER ;

-- PROCEDIMIENTOS
DELIMITER //
CREATE PROCEDURE sp_registrar_asistencia(IN emp_legajo INT, IN fecha DATE, IN estado VARCHAR(20))
BEGIN
  INSERT INTO Asistencia (legajo, fecha, estado) VALUES (emp_legajo, fecha, estado);
END;
//

CREATE PROCEDURE sp_actualizar_obra_social(IN emp_legajo INT, IN nueva_obra INT)
BEGIN
  UPDATE Empleado SET id_obra = nueva_obra WHERE legajo = emp_legajo;
END;
//
DELIMITER ;

-- TRIGGER
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

-- VISTAS
CREATE VIEW vista_empleados_por_departamento AS
SELECT e.legajo, e.nombre, e.apellido, d.nombre AS departamento, p.nombre AS puesto
FROM Empleado e
JOIN Departamento d ON e.id_dpto = d.id_dpto
JOIN Puesto p ON e.id_puesto = p.id_puesto;

CREATE VIEW vista_asistencias_totales AS
SELECT e.legajo, e.nombre, e.apellido, COUNT(a.id_asistencia) AS total_asistencias
FROM Empleado e
LEFT JOIN Asistencia a ON e.legajo = a.legajo AND a.estado = 'Presente'
GROUP BY e.legajo;

CREATE VIEW vista_empleados_con_obra_social AS
SELECT e.legajo, e.nombre, e.apellido, o.nombre AS obra_social
FROM Empleado e
JOIN ObraSocial o ON e.id_obra = o.id_obra;
