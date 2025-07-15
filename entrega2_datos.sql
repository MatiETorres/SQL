
-- Insertar Departamentos
INSERT INTO Departamento (nombre, descripcion) VALUES
('Recursos Humanos', 'Área encargada de la gestión del personal'),
('Sistemas', 'Área de soporte y desarrollo tecnológico'),
('Administración', 'Área de finanzas y contabilidad');

-- Insertar Obras Sociales
INSERT INTO ObraSocial (nombre, telefono, direccion) VALUES
('OSDE', '011-4321-1000', 'Av. Corrientes 1234, CABA'),
('Swiss Medical', '011-4321-2000', 'Av. Santa Fe 4567, CABA');

-- Insertar Puestos
INSERT INTO Puesto (nombre, descripcion, id_dpto) VALUES
('Analista de RRHH', 'Gestiona procesos de RRHH', 1),
('Programador', 'Desarrolla software', 2),
('Contador', 'Maneja la contabilidad', 3);

-- Insertar Empleados
INSERT INTO Empleado (nombre, apellido, dni, fecha_nac, edad, lugar_nacimiento, id_puesto, id_dpto, id_obra, telefono, email) VALUES
('Juan', 'Pérez', '30123456', '1988-05-10', 36, 'Buenos Aires', 1, 1, 1, '11-4567-8901', 'juan.perez@email.com'),
('María', 'González', '29876543', '1990-08-22', 33, 'Rosario', 2, 2, 2, '341-555-1234', 'maria.gonzalez@email.com'),
('Carlos', 'Fernández', '31234567', '1985-03-15', 39, 'Córdoba', 3, 3, 1, '351-333-9876', 'carlos.fernandez@email.com');

-- Insertar Asistencias
INSERT INTO Asistencia (legajo, fecha, estado) VALUES
(1, '2025-07-14', 'Presente'),
(2, '2025-07-14', 'Ausente'),
(3, '2025-07-14', 'Presente');

-- Insertar Contactos de Emergencia
INSERT INTO ContactoEmergencia (legajo, nombre, telefono, parentesco) VALUES
(1, 'Ana Pérez', '11-4567-0001', 'Hermana'),
(2, 'Luis González', '341-555-0002', 'Padre'),
(3, 'Sofía Fernández', '351-333-0003', 'Esposa');
