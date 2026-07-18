¿Por qué usaste LEFT JOIN para la Consulta 1 y no INNER JOIN? ¿Qué se perdería si usaras INNER JOIN?

**Se uso LEFT JOIN para seleccionar todos los registros de la tabla izquierda y los registros que coincidan de la tabla derecha
 Si no hay coincidencia, se reflejan los null registros vacíos.
 Si se hubiera usado INNER JOIN los null no se visualizan.**

¿Por qué usaste RIGHT JOIN para la Consulta 2? ¿Qué tabla está a la izquierda y cuál a la derecha en tu consulta?

 **Se uso RIGH JOIN para visualizar todos los registros de la tabla deecha y los registros que coinciden de la tabla izquierda
 si no hay coincidencias las columnas de la tabla izquierda aparecen con null.
 A la derecha esta mi Tabla Ventas y a la Izquierda la Tabla Productos.**

  
¿Qué representan los valores NULL en cada resultado? Explicá con un ejemplo concreto de los datos qué significa que venta_id sea NULL en la Consulta 1 y que producto_id de productos sea NULL en la Consulta 2.
¿Cuándo usarías FULL OUTER JOIN en un caso real de negocio

**Los Null son registros vacíos, a veces es la información que se esta buscando.
En la consulta 1 los Null indican los productos no vendidos. 
y en la Consulta 2 registra Null por que no se cargo el producto y si esta si venta.
Se usaría FULL OUTER JOIN en caso de auditorias, para validar todos los datos de ambas tablas.
Proporciona una visión completa de las relaciones y muestra si faltan datos.**

