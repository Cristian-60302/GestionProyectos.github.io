DROP TABLE IF EXISTS inventario CASCADE;
DROP TABLE IF EXISTS productos CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;
DROP TABLE IF EXISTS empresas CASCADE;


CREATE TABLE empresas (
    id_empresa INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nit VARCHAR(20) UNIQUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE usuarios (
    id_usuario INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    id_empresa INTEGER NOT NULL,

    CONSTRAINT fk_usuario_empresa
        FOREIGN KEY (id_empresa)
        REFERENCES empresas(id_empresa)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);




CREATE TABLE categorias (
    id_categoria INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    id_empresa INTEGER NOT NULL,

    CONSTRAINT fk_categoria_empresa
        FOREIGN KEY (id_empresa)
        REFERENCES empresas(id_empresa)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);




CREATE TABLE productos (
    id_producto INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    marca VARCHAR(100),
    id_categoria INTEGER NOT NULL,
    id_empresa INTEGER NOT NULL,

    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_producto_empresa
        FOREIGN KEY (id_empresa)
        REFERENCES empresas(id_empresa)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);




CREATE TABLE inventario (
    id_objeto INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_producto INTEGER NOT NULL,
    codigo VARCHAR(100) UNIQUE,
    estado VARCHAR(20) NOT NULL DEFAULT 'Disponible',
    ubicacion VARCHAR(100),
    fecha_ingreso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_estado
        CHECK (
            estado IN (
                'Disponible',
                'Dañado',
                'Vendido',
                'Prestado'
            )
        ),

    CONSTRAINT fk_inventario_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


INSERT INTO empresas (nombre, nit)
VALUES
('Ferretería El Constructor', '900123456-1'),
('TechStore Colombia', '900987654-2'),
('Almacén La Economía', '901456789-3');




INSERT INTO usuarios
(nombre, correo, password, id_empresa)
VALUES
('Juan Pérez', 'juan@constructor.com', '123456', 1),
('Carlos Gómez', 'carlos@constructor.com', '123456', 1),
('María Rodríguez', 'maria@techstore.com', '123456', 2),
('Pedro Martínez', 'pedro@economia.com', '123456', 3);




INSERT INTO categorias
(nombre, descripcion, id_empresa)
VALUES
('Herramientas', 'Herramientas para construcción', 1),
('Materiales', 'Materiales de construcción', 1),

('Computadores', 'Computadores y portátiles', 2),
('Periféricos', 'Accesorios para computador', 2),

('Electrodomésticos', 'Electrodomésticos para el hogar', 3),
('Aseo', 'Productos de limpieza', 3);



INSERT INTO productos
(nombre, descripcion, marca, id_categoria, id_empresa)
VALUES

-- Empresa 1
('Martillo', 'Martillo de acero de 16 oz', 'Stanley', 1, 1),
('Taladro', 'Taladro eléctrico de 750W', 'Bosch', 1, 1),
('Cemento', 'Bulto de cemento de 50 kg', 'Argos', 2, 1),
('Tornillos 3 pulgadas', 'Caja de tornillos para madera', 'Fixser', 2, 1),

-- Empresa 2
('Laptop ThinkPad', 'Computador portátil empresarial', 'Lenovo', 3, 2),
('Laptop Aspire 5', 'Computador portátil para oficina', 'Acer', 3, 2),
('Mouse inalámbrico', 'Mouse inalámbrico USB', 'Logitech', 4, 2),
('Teclado mecánico', 'Teclado mecánico RGB', 'Redragon', 4, 2),

-- Empresa 3
('Nevera', 'Nevera de dos puertas', 'Haceb', 5, 3),
('Licuadora', 'Licuadora de 500W', 'Oster', 5, 3),
('Detergente', 'Detergente líquido 1 litro', 'Ariel', 6, 3);




INSERT INTO inventario
(id_producto, codigo, estado, ubicacion)
VALUES

-- Martillos
(1, 'MAR-001', 'Disponible', 'Estante A1'),
(1, 'MAR-002', 'Disponible', 'Estante A1'),
(1, 'MAR-003', 'Dañado', 'Taller'),

-- Taladros
(2, 'TAL-001', 'Disponible', 'Estante A2'),
(2, 'TAL-002', 'Prestado', 'Bodega'),

-- Cemento
(3, 'CEM-001', 'Disponible', 'Zona B1'),
(3, 'CEM-002', 'Disponible', 'Zona B1'),
(3, 'CEM-003', 'Disponible', 'Zona B1'),
(3, 'CEM-004', 'Vendido', 'Despacho'),

-- Tornillos
(4, 'TOR-001', 'Disponible', 'Estante C1'),
(4, 'TOR-002', 'Disponible', 'Estante C1'),
(4, 'TOR-003', 'Disponible', 'Estante C1'),

-- Laptops Lenovo
(5, 'LEN-001', 'Disponible', 'Estante T1'),
(5, 'LEN-002', 'Disponible', 'Estante T1'),
(5, 'LEN-003', 'Dañado', 'Soporte técnico'),
(5, 'LEN-004', 'Prestado', 'Oficina'),

-- Laptops Acer
(6, 'ACE-001', 'Disponible', 'Estante T2'),
(6, 'ACE-002', 'Disponible', 'Estante T2'),

-- Mouse
(7, 'MOU-001', 'Disponible', 'Estante T3'),
(7, 'MOU-002', 'Disponible', 'Estante T3'),
(7, 'MOU-003', 'Vendido', 'Despacho'),
(7, 'MOU-004', 'Disponible', 'Estante T3'),

-- Teclados
(8, 'TEC-001', 'Disponible', 'Estante T4'),
(8, 'TEC-002', 'Disponible', 'Estante T4'),

-- Electrodomésticos
(9, 'NEV-001', 'Disponible', 'Zona E1'),
(9, 'NEV-002', 'Vendido', 'Despacho'),

(10, 'LIC-001', 'Disponible', 'Zona E2'),
(10, 'LIC-002', 'Disponible', 'Zona E2'),

-- Aseo
(11, 'DET-001', 'Disponible', 'Estante Aseo 1'),
(11, 'DET-002', 'Disponible', 'Estante Aseo 1'),
(11, 'DET-003', 'Disponible', 'Estante Aseo 1');




SELECT * FROM empresas;

SELECT * FROM usuarios;

SELECT * FROM categorias;

SELECT * FROM productos;

SELECT * FROM inventario;