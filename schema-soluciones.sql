-- ══════════════════════════════════════════
-- MiniStore — Schema y datos de prueba
-- ══════════════════════════════════════════

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;

-- Tabla de catálogo de productos
CREATE TABLE productos (
    producto_id   INT PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    categoria     VARCHAR(50)  NOT NULL,
    precio        DECIMAL(10,2)
);

-- Tabla de transacciones de ventas
CREATE TABLE ventas (
    venta_id     INT PRIMARY KEY,
    producto_id  INT,
    cliente_id   INT,
    cantidad     INT          NOT NULL,
    fecha_venta  DATE         NOT NULL
);

-- Datos: productos del catálogo (incluye productos nunca vendidos)
INSERT INTO productos VALUES (101, 'Laptop Pro 15',      'Computación',    1200.00);
INSERT INTO productos VALUES (102, 'Mouse Inalámbrico',  'Accesorios',       28.00);
INSERT INTO productos VALUES (103, 'Monitor 4K 27"',     'Computación',     450.00);
INSERT INTO productos VALUES (104, 'Teclado Mecánico',   'Accesorios',       95.00);
INSERT INTO productos VALUES (105, 'Auriculares BT Pro', 'Audio',           120.00);
INSERT INTO productos VALUES (106, 'SSD Externo 1TB',    'Almacenamiento',  130.00);
INSERT INTO productos VALUES (107, 'Webcam HD 1080p',    'Accesorios',       85.00);
-- Estos dos productos NUNCA fueron vendidos (importantes para el LEFT JOIN)
INSERT INTO productos VALUES (108, 'Hub USB-C 7p',       'Accesorios',       45.00);
INSERT INTO productos VALUES (109, 'Parlante Bluetooth', 'Audio',            60.00);

-- Datos: ventas (incluye un producto_id inexistente en el catálogo)
INSERT INTO ventas VALUES (1, 101, 201, 2, '2024-01-05');
INSERT INTO ventas VALUES (2, 102, 202, 5, '2024-01-08');
INSERT INTO ventas VALUES (3, 103, 203, 1, '2024-01-12');
INSERT INTO ventas VALUES (4, 101, 201, 1, '2024-02-03');
INSERT INTO ventas VALUES (5, 104, 204, 3, '2024-02-10');
INSERT INTO ventas VALUES (6, 105, 202, 2, '2024-02-18');
INSERT INTO ventas VALUES (7, 106, 205, 3, '2024-03-05');
INSERT INTO ventas VALUES (8, 102, 203, 8, '2024-03-12');
INSERT INTO ventas VALUES (9, 107, 204, 2, '2024-03-20');
-- Esta venta tiene un producto_id que NO existe en el catálogo (importante para el RIGHT JOIN)
INSERT INTO ventas VALUES (10, 999, 205, 1, '2024-03-25');

--Ejemplo de INNER JOIN -ventas con el nombre y total de cada producto

SELECT v.venta_id,
       p.nombre,
       p.categoria,
       v.cantidad,
       (v.cantidad * p.precio) AS total
FROM ventas v
INNER JOIN productos p ON v.producto_id = p.producto_id
ORDER BY v.venta_id;

SELECT * FROM productos;
SELECT * FROM ventas;

-- ══════════════════════════════════════════
-- MiniStore — Soluciones con Outer JOINs
-- Autor: Fabiana Aguirre
-- Fecha: 18/07/2026
-- ══════════════════════════════════════════
-- ── CONSULTA 1: LEFT JOIN ─────────────────
-- Pregunta de negocio: ¿Qué productos del catálogo nunca fueron vendidos?
   SELECT p.producto_id,
          p.nombre,
          p.categoria,
          v.venta_id,
          v.cantidad,
         (v.cantidad * p.precio) AS total
FROM productos p
LEFT JOIN ventas v ON v.producto_id = p.producto_id
ORDER BY v.venta_id;
--**Los productos del catálogo que no registron ventas son:
-- 108-Hub USB-C 7p y 109 Parlante Bluetooth.**
 
-- Mostrá todos los productos y sus ventas asociadas.
SELECT p.producto_id,
          p.nombre,
          p.categoria,
         (v.cantidad * p.precio) AS total
FROM productos p
INNER JOIN ventas v ON v.producto_id = p.producto_id
ORDER BY v.venta_id;

-- Los productos sin ventas aparecerán con NULL en las columnas de ventas.
-- **SI**

-- ── CONSULTA 2: RIGHT JOIN ────────────────
-- Pregunta de negocio: ¿Existen ventas registradas con productos
-- que no figuran en nuestro catálogo? (posible error de carga de datos)

SELECT p.producto_id,
          p.nombre,
          p.categoria,
          v.venta_id,
          v.cantidad,
         (v.cantidad * p.precio) AS total
FROM productos p
RIGHT JOIN ventas v ON v.producto_id = p.producto_id
ORDER BY v.venta_id;

--**Si venta_id 10 cantidad 1- posible error de carga**

-- Los registros huérfanos aparecerán con NULL en las columnas de productos.
-- **Si aparecen NULL**

-- ── CONSULTA 3: FULL OUTER JOIN ───────────
-- Pregunta de negocio: Vista completa de auditoría que muestre
-- todos los productos y todas las ventas sin perder ninguna fila,
-- identificando tanto productos sin ventas como ventas sin producto.

SELECT  
        p.producto_id,
        p.nombre,
        p.categoria,
        p.precio,
        (v.cantidad * p.precio) AS total
FROM productos p
FULL OUTER JOIN ventas v ON v.producto_id = p.producto_id
ORDER BY v.venta_id;
