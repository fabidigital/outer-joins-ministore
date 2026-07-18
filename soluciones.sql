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
WHERE v.venta_id IS NULL
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
WHERE p.producto_id IS NULL
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
WHERE p.producto_id IS NULL OR v.venta_id IS NULL
ORDER BY v.venta_id;
