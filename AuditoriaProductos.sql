SELECT * FROM sumerca.productos;
/*Auditoria accion de un usuario*/
/*creacion de tabla para alojar resultados del trigger*/

CREATE TABLE IF NOT EXISTS AuditoriaProductos (
    idAuditoria INT AUTO_INCREMENT PRIMARY KEY,
    idProducto INT NOT NULL,
    nombreProducto VARCHAR(50) NOT NULL, /*Nombre del producto*/
    usuario VARCHAR(45) NOT NULL, /*Usuario que realizó el ingreso de un producto*/
    fechaIngreso DATETIME NOT NULL,
    accion VARCHAR(45) NOT NULL /*saber qué hizo el usuario*/
);
drop table AuditoriaProductos;
select * from tipoproductos;/*Generamos las tablas a usar*/
select * from productos;

select * from AuditoriaProductos; /*Generamos la tabla creada para ver sus valores*/


drop trigger if exists auditoria_ingreso_productos/*eliminar el trigger existente*/

/*Inicio trigger*/
DELIMITER // 
CREATE TRIGGER auditoria_ingreso_productos
AFTER INSERT ON productos
FOR EACH ROW
BEGIN
    /* Insertar los datos en la tabla de auditoría cuando se inserte un nuevo producto*/
    INSERT INTO AuditoriaProductos (idProducto, nombreProducto, usuario, fechaIngreso, accion)
    VALUES (NEW.idProducto, NEW.nombreProducto, USER(), NOW(), 'Insertó un producto');
END //

DELIMITER ;
select * from tipoproductos;

select * from productos;
select * from AuditoriaProductos;
