
USE RecursosHumanos;

-- Inserciones para Departamento
INSERT INTO Departamento (nombre, descripcion) VALUES
('Recursos Humanos', 'Gestión del personal'),
('Finanzas', 'Administración financiera'),
('Sistemas', 'Tecnología y soporte técnico');

-- Inserciones para Puesto
INSERT INTO Puesto (nombre, descripcion, id_dpto) VALUES
('Analista de RRHH', 'Encargado de selección y capacitación', 1),
('Contador', 'Responsable de balances y liquidaciones', 2),
('Desarrollador', 'Programador backend', 3);

-- Inserciones para ObraSocial
INSERT INTO ObraSocial (nombre, telefono, direccion) VALUES
('OSDE', '011-4321-1234', 'Av. Corrientes 1234'),
('Swiss Medical', '011-5678-8765', 'Calle Suipacha 456'),
('PAMI', '011-5555-0000', 'Av. Rivadavia 789');

-- Inserciones para Empleado
INSERT INTO Empleado (nombre, apellido, dni, fecha_nac, edad, lugar_nacimiento, id_puesto, id_dpto, id_obra, telefono, email) VALUES
('Juan', 'Pérez', '30567489', '1990-06-15', 34, 'Rosario', 1, 1, 1, '341-4567890', 'juan.perez@gmail.com'),
('María', 'Gómez', '28765432', '1988-03-10', 36, 'La Plata', 2, 2, 2, '221-1234567', 'maria.gomez@hotmail.com'),
('Lucas', 'Fernández', '32456789', '1995-09-22', 28, 'Córdoba', 3, 3, 3, '351-7654321', 'lucas.fernandez@yahoo.com');

-- Inserciones para Asistencia
INSERT INTO Asistencia (legajo, fecha, estado) VALUES
(1, '2025-07-01', 'Presente'),
(1, '2025-07-02', 'Ausente'),
(2, '2025-07-01', 'Presente'),
(2, '2025-07-02', 'Tardanza'),
(3, '2025-07-01', 'Licencia');

-- Inserciones para ContactoEmergencia
INSERT INTO ContactoEmergencia (legajo, nombre, telefono, parentesco) VALUES
(1, 'Carlos Pérez', '341-9988776', 'Padre'),
(2, 'Laura Gómez', '221-8877665', 'Hermana'),
(3, 'Martina Fernández', '351-7766554', 'Madre');
