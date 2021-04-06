-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 28-10-2018 a las 21:35:35
-- Versión del servidor: 5.7.23
-- Versión de PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pequescl_dbventas`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `ANIO_GRAFICO` ()  BEGIN
	select distinct year(Fecha) as anio from venta;
END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `reporte_grafico_dias` ()  SELECT
 v.fecha,dayname(v.Fecha) as mes, sum(v.totalpagar) as total_dia
	from venta v inner join detalleventa dv on v.IdVenta = dv.IdVenta

			where year(v.Fecha) = year(curdate())
		group by v.fecha
		order by day(v.Fecha) desc
			limit 15$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `reporte_grafico_mes` ()  SELECT
 monthname(v.Fecha) as mes, sum(v.totalpagar) as total_dia
	from venta v inner join detalleventa dv on v.IdVenta = dv.IdVenta

			where year(v.Fecha) = year(curdate())
		group by monthname(v.Fecha)
		order by month(v.Fecha) desc
			limit 12$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `reporte_grafico_totales` ()  SELECT
distinct monthname(v.Fecha) as mes ,
 sum(p.precioventa-p.preciocosto) as total_utilidad, sum(v.totalpagar) as total_venta,
	sum(c.total) as total_compra
	from venta v inner join detalleventa dv on v.IdVenta = dv.IdVenta
	inner join producto p on p.IdProducto = dv.IdProducto
	inner join detallecompra dc on dc.IdProducto = p.IdProducto
	inner join compra c on c.idcompra=dc.IdCompra
	where year(v.Fecha) = year(curdate())
		group by monthname(v.Fecha),p.IdProducto,v.IdVenta,c.idcompra
		order by monthname(v.Fecha) desc
			limit 1$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_I_Categoria` (`pdescripcion` VARCHAR(100))  BEGIN		
		INSERT INTO categoria(descripcion)
		VALUES(pdescripcion);
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_I_Cliente` (`pnombre` VARCHAR(100), `pruc` VARCHAR(11), `pdni` VARCHAR(8), `pdireccion` VARCHAR(50), `ptelefono` VARCHAR(15), `pobsv` TEXT, `pusuario` VARCHAR(30), `pcontrasena` VARCHAR(10))  BEGIN		
		INSERT INTO cliente(nombre,ruc,dni,direccion,telefono,obsv,usuario,contrasena)
		VALUES(pnombre,pruc,pdni,pdireccion,ptelefono,pobsv,pusuario,pcontrasena);
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_I_Compra` (`pidtipodocumento` INT, `pidproveedor` INT, `pidempleado` INT, `pnumero` VARCHAR(20), `pfecha` DATE, `psubtotal` DECIMAL(8,2), `pigv` DECIMAL(8,2), `ptotal` DECIMAL(8,2), `pestado` VARCHAR(30))  BEGIN		
		INSERT INTO compra(idtipodocumento,idproveedor,idempleado,numero,fecha,subtotal,igv,total,estado)
		VALUES(pidtipodocumento,pidproveedor,pidempleado,pnumero,pfecha,psubtotal,pigv,ptotal,pestado);
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_I_DetalleCompra` (`pidcompra` INT, `pidproducto` INT, `pcantidad` DECIMAL(8,2), `pprecio` DECIMAL(8,2), `ptotal` DECIMAL(8,2))  BEGIN		
		INSERT INTO detallecompra(idcompra,idproducto,cantidad,precio,total)
		VALUES(pidcompra,pidproducto,pcantidad,pprecio,ptotal);
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_I_DetalleVenta` (`pidventa` INT, `pidproducto` INT, `pcantidad` DECIMAL(8,2), `pcosto` DECIMAL(8,2), `pprecio` DECIMAL(8,2), `ptotal` DECIMAL(8,2))  BEGIN		
		INSERT INTO detalleventa(idventa,idproducto,cantidad,costo,precio,total)
		VALUES(pidventa,pidproducto,pcantidad,pcosto,pprecio,ptotal);
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_I_Empleado` (`pnombre` VARCHAR(50), `papellido` VARCHAR(80), `psexo` VARCHAR(1), `pfechanac` DATE, `pdireccion` VARCHAR(100), `ptelefono` VARCHAR(10), `pcelular` VARCHAR(15), `pemail` VARCHAR(80), `pdni` VARCHAR(8), `pfechaing` DATE, `psueldo` DECIMAL(8,2), `pestado` VARCHAR(30), `pusuario` VARCHAR(20), `pcontrasena` TEXT, `pidtipousuario` INT)  BEGIN		
		INSERT INTO empleado(nombre,apellido,sexo,fechanac,direccion,telefono,celular,email,dni,fechaing,sueldo,estado,usuario,contrasena,idtipousuario)
		VALUES(pnombre,papellido,psexo,pfechanac,pdireccion,ptelefono,pcelular,pemail,pdni,pfechaing,psueldo,pestado,pusuario,pcontrasena,pidtipousuario);
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_I_Producto` (`pcodigo` VARCHAR(50), `pnombre` VARCHAR(100), `pdescripcion` TEXT, `pstock` DECIMAL(8,2), `pstockmin` DECIMAL(8,2), `ppreciocosto` DECIMAL(8,2), `pprecioventa` DECIMAL(8,2), `putilidad` DECIMAL(8,2), `pestado` VARCHAR(30), `pimagen` VARCHAR(100), `pidcategoria` INT)  BEGIN		
		INSERT INTO producto(codigo,nombre,descripcion,stock,stockmin,preciocosto,precioventa,utilidad,estado,imagen,idcategoria)
		VALUES(pcodigo,pnombre,pdescripcion,pstock,pstockmin,ppreciocosto,pprecioventa,putilidad,pestado,pimagen,pidcategoria);
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_I_Proveedor` (`pnombre` VARCHAR(100), `pruc` VARCHAR(11), `pdni` VARCHAR(8), `pdireccion` VARCHAR(100), `ptelefono` VARCHAR(10), `pcelular` VARCHAR(15), `pemail` VARCHAR(80), `pcuenta1` VARCHAR(50), `pcuenta2` VARCHAR(50), `pestado` VARCHAR(30), `pobsv` TEXT)  BEGIN		
		INSERT INTO proveedor(nombre,ruc,dni,direccion,telefono,celular,email,cuenta1,cuenta2,estado,obsv)
		VALUES(pnombre,pruc,pdni,pdireccion,ptelefono,pcelular,pemail,pcuenta1,pcuenta2,pestado,pobsv);
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_I_TipoCambio` (`ptipocambio` DECIMAL(4,2))  BEGIN		
		INSERT INTO tipodocumento(tipocambio)
		VALUES(ptipocambio);
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_I_TipoDocumento` (`pdescripcion` VARCHAR(80))  BEGIN		
		INSERT INTO tipodocumento(descripcion)
		VALUES(pdescripcion);
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_I_TipoUsuario` (`pdescripcion` VARCHAR(80), `pp_venta` INT, `pp_compra` INT, `pp_producto` INT, `pp_proveedor` INT, `pp_empleado` INT, `pp_cliente` INT, `pp_categoria` INT, `pp_tipodoc` INT, `pp_tipouser` INT, `pp_anularv` INT, `pp_anularc` INT, `pp_estadoprod` INT, `pp_ventare` INT, `pp_ventade` INT, `pp_estadistica` INT, `pp_comprare` INT, `pp_comprade` INT, `pp_pass` INT, `pp_respaldar` INT, `pp_restaurar` INT, `pp_caja` INT)  BEGIN		
		INSERT INTO tipousuario(descripcion,p_venta,p_compra,p_producto,p_proveedor,p_empleado,p_cliente,p_categoria,p_tipodoc,p_tipouser,p_anularv,p_anularc,
		p_estadoprod,p_ventare,p_ventade,p_estadistica,p_comprare,p_comprade,p_pass,p_respaldar,p_restaurar,p_caja)
		VALUES(pdescripcion,pp_venta,pp_compra,pp_producto,pp_proveedor,pp_empleado,pp_cliente,pp_categoria,pp_tipodoc,pp_tipouser,pp_anularv,pp_anularc,
		pp_estadoprod,pp_ventare,pp_ventade,pp_estadistica,pp_comprare,pp_comprade,pp_pass,pp_respaldar,pp_restaurar,pp_caja);
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_I_Venta` (`pidtipodocumento` INT, `pidcliente` INT, `pidempleado` INT, `pserie` VARCHAR(5), `pnumero` VARCHAR(20), `pfecha` DATE, `ptotalventa` DECIMAL(8,2), `pigv` DECIMAL(8,2), `ptotalpagar` DECIMAL(8,2), `pestado` VARCHAR(30), `ppago` VARCHAR(30), `preferencia` VARCHAR(30))  BEGIN		
		INSERT INTO venta(idtipodocumento,idcliente,idempleado,serie,numero,fecha,totalventa,igv,totalpagar,estado,pago,referencia)
		VALUES(pidtipodocumento,pidcliente,pidempleado,pserie,pnumero,pfecha,ptotalventa,pigv,ptotalpagar,pestado,ppago,preferencia);
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_CANTIDAD_CATEGORIAS` ()  BEGIN
	select count(*) as cantidad_categoria from categoria;
END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_CANTIDAD_COMPRAS` ()  BEGIN
	select count(*) as cantidad_compras from compra where Fecha like curdate();
END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_CANTIDAD_PRODUCTOS` ()  BEGIN
	select count(*) as cantidad_producto from producto;
END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_CANTIDAD_PROVEEDORES` ()  BEGIN
	select count(*) as cantidad_proveedores from proveedor;
END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_CANTIDAD_VENTAS` ()  BEGIN
	select count(*) as cantidad_ventas from venta where Fecha like curdate();
END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_Categoria` ()  BEGIN
		SELECT * FROM categoria ORDER BY descripcion ASC;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_CategoriaCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM categoria;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_CategoriaIdMaximo` ()  BEGIN
		SELECT MAX(IdCategoria) AS Maximo FROM categoria;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_CategoriaPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
		IF pcriterio = "id" THEN		
			SET @sentencia = CONCAT("SELECT c.IdCategoria,c.Descripcion FROM categoria AS c WHERE c.IdCategoria=",pbusqueda," ORDER BY c.IdCategoria DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "descripcion" THEN
			SET @sentencia = CONCAT("SELECT c.IdCategoria,c.Descripcion FROM categoria AS c WHERE c.Descripcion LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY c.IdCategoria DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
		ELSE	
			SET @sentencia = CONCAT("SELECT c.IdCategoria,c.Descripcion FROM categoria AS c ORDER BY c.IdCategoria DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
		END IF; 
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_Cliente` ()  BEGIN
		SELECT * FROM cliente;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_ClienteCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM cliente;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_ClienteIdMaximo` ()  BEGIN
		SELECT MAX(IdCliente) AS Maximo FROM cliente;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_ClientePorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN	
		IF pcriterio = "id" THEN		
			SET @sentencia = CONCAT("SELECT c.IdCliente,c.Nombre,c.Ruc,c.Dni,c.Direccion,c.Telefono,c.Obsv,c.Usuario,c.Contrasena FROM cliente AS c WHERE c.IdCliente=",pbusqueda," ORDER BY c.IdCliente DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "nombre" THEN
			SET @sentencia = CONCAT("SELECT c.IdCliente,c.Nombre,c.Ruc,c.Dni,c.Direccion,c.Telefono,c.Obsv,c.Usuario,c.Contrasena FROM cliente AS c WHERE c.Nombre LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY c.IdCliente DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;			
		ELSEIF pcriterio = "ruc" THEN
			SET @sentencia = CONCAT("SELECT c.IdCliente,c.Nombre,c.Ruc,c.Dni,c.Direccion,c.Telefono,c.Obsv,c.Usuario,c.Contrasena FROM cliente AS c WHERE c.Ruc LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY c.IdCliente DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "dni" THEN
			SET @sentencia = CONCAT("SELECT c.IdCliente,c.Nombre,c.Ruc,c.Dni,c.Direccion,c.Telefono,c.Obsv,c.Usuario,c.Contrasena FROM cliente AS c WHERE c.Dni LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY c.IdCliente DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;		
		ELSE	
			SET @sentencia = CONCAT("SELECT c.IdCliente,c.Nombre,c.Ruc,c.Dni,c.Direccion,c.Telefono,c.Obsv,c.Usuario,c.Contrasena FROM cliente AS c ORDER BY c.IdCliente DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
		END IF; 
	 
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_Compra` ()  BEGIN
		SELECT c.IdCompra,td.Descripcion AS TipoDocumento,p.Nombre AS Proveedor,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,c.Numero,c.Fecha,c.SubTotal,c.Igv,c.Total,c.Estado
		FROM compra AS c
		INNER JOIN tipodocumento AS td ON c.IdTipoDocumento=td.IdTipoDocumento	 
		INNER JOIN proveedor AS p ON c.IdProveedor=p.IdProveedor		
		INNER JOIN empleado AS e ON c.IdEmpleado=e.IdEmpleado
		ORDER BY c.IdCompra;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_CompraPorDetalle` (`pcriterio` VARCHAR(30), `pfechaini` DATE, `pfechafin` DATE)  BEGIN
		IF pcriterio = "consultar" THEN
			SELECT p.Codigo,p.Nombre AS Producto,ca.Descripcion AS Categoria,dc.Precio,
			SUM(dc.Cantidad) AS Cantidad,SUM(dc.Total) AS Total FROM compra AS c
			INNER JOIN detallecompra AS dc ON c.IdCompra=dc.IdCompra
			INNER JOIN producto AS p ON dc.IdProducto=p.IdProducto
			INNER JOIN categoria AS ca ON p.IdCategoria=ca.IdCategoria
			WHERE (c.Fecha>=pfechaini AND c.Fecha<=pfechafin) AND c.Estado="NORMAL" GROUP BY p.IdProducto
			ORDER BY c.IdCompra DESC;
		END IF;

	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_CompraPorFecha` (`pcriterio` VARCHAR(30), `pfechaini` DATE, `pfechafin` DATE, `pdocumento` VARCHAR(30))  BEGIN
		IF pcriterio = "anular" THEN
			SELECT c.IdCompra,p.Nombre AS Proveedor,c.Fecha,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,td.Descripcion AS TipoDocumento,c.Numero,
			c.Estado,c.Total FROM compra AS c
			INNER JOIN tipodocumento AS td ON c.IdTipoDocumento=td.IdTipoDocumento
			INNER JOIN proveedor AS p ON c.IdProveedor=p.IdProveedor
			INNER JOIN empleado AS e ON c.IdEmpleado=e.IdEmpleado
			WHERE (c.Fecha>=pfechaini AND c.Fecha<=pfechafin) AND td.Descripcion=pdocumento ORDER BY c.IdCompra DESC;
		ELSEIF pcriterio = "consultar" THEN
		   SELECT c.IdCompra,p.Nombre AS Proveedor,c.Fecha,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,td.Descripcion AS TipoDocumento,c.Numero,
			c.Estado,c.Total FROM compra AS c
			INNER JOIN tipodocumento AS td ON c.IdTipoDocumento=td.IdTipoDocumento
			INNER JOIN proveedor AS p ON c.IdProveedor=p.IdProveedor
			INNER JOIN empleado AS e ON c.IdEmpleado=e.IdEmpleado
			WHERE c.Fecha>=pfechaini AND c.Fecha<=pfechafin ORDER BY c.IdCompra DESC;
		ELSE
		   SELECT c.IdCompra,p.Nombre AS Proveedor,c.Fecha,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,td.Descripcion AS TipoDocumento,c.Numero,
			c.Estado,c.Total FROM compra AS c
			INNER JOIN tipodocumento AS td ON c.IdTipoDocumento=td.IdTipoDocumento
			INNER JOIN proveedor AS p ON c.IdProveedor=p.IdProveedor
			INNER JOIN empleado AS e ON c.IdEmpleado=e.IdEmpleado ORDER BY c.IdCompra DESC LIMIT 10;			
		END IF;

	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_CompraPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
			IF pcriterio = "id" THEN
				SELECT c.IdCompra,td.Descripcion AS TipoDocumento,p.Nombre AS Proveedor,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,c.Numero,c.Fecha,c.SubTotal,
				c.Igv,c.Total,c.Estado  FROM compra AS c
				INNER JOIN tipodocumento AS td ON c.IdTipoDocumento=td.IdTipoDocumento
				INNER JOIN proveedor AS p ON c.IdProveedor=p.IdProveedor
				INNER JOIN empleado AS e ON c.IdEmpleado=e.IdEmpleado
				WHERE c.IdCompra=pbusqueda ORDER BY c.IdCompra;
			ELSEIF pcriterio = "documento" THEN
				SELECT c.IdCompra,td.Descripcion AS TipoDocumento,p.Nombre AS Proveedor,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,c.Numero,c.Fecha,c.SubTotal,
				c.Igv,c.Total,c.Estado  FROM compra AS c
				INNER JOIN tipodocumento AS td ON c.IdTipoDocumento=td.IdTipoDocumento
				INNER JOIN proveedor AS p ON c.IdProveedor=p.IdProveedor
				INNER JOIN empleado AS e ON c.IdEmpleado=e.IdEmpleado
				WHERE td.Descripcion=pbusqueda ORDER BY c.IdCompra;
			END IF; 
			

	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_COMPRA_TOTAL_DIARIA` ()  BEGIN
select sum(dc.Cantidad * dc.Precio) as total_compras from
	compra c inner join detallecompra dc on c.IdCompra = dc.IdCompra where c.Fecha like curdate();
END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_DetalleCompra` ()  BEGIN
		SELECT * FROM detallecompra;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_DetalleCompraPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
			IF pcriterio = "id" THEN
				SELECT dc.IdCompra,p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,dc.Cantidad,dc.Precio,dc.Total  FROM detallecompra AS dc
				INNER JOIN producto AS p ON dc.IdProducto=p.IdProducto
				WHERE dc.IdCompra=pbusqueda ORDER BY dc.IdCompra;
			
			END IF; 
			
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_DetalleVenta` ()  BEGIN
		SELECT * FROM detalleventa;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_DetalleVentaPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
			IF pcriterio = "id" THEN
				SELECT dv.IdVenta,p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,dv.Cantidad,dv.Precio,dv.Total  FROM detalleventa AS dv
				INNER JOIN producto AS p ON dv.IdProducto=p.IdProducto
				WHERE dv.IdVenta=pbusqueda ORDER BY dv.IdVenta;
			
			END IF; 
			
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_Empleado` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
	IF pcriterio = "id" THEN
		SELECT e.IdEmpleado,e.Nombre,e.Apellido,e.Sexo,e.FechaNac,e.Direccion,e.Telefono,e.Celular,e.Email,
		e.Dni,e.FechaIng,e.Sueldo,e.Estado,e.Usuario,e.Contrasena,e.IdTipoUsuario
		FROM empleado AS e WHERE e.IdEmpleado=pbusqueda;
	ELSEIF pcriterio = "nombre" THEN
		SELECT e.IdEmpleado,e.Nombre,e.Apellido,e.Sexo,e.FechaNac,e.Direccion,e.Telefono,e.Celular,e.Email,
		e.Dni,e.FechaIng,e.Sueldo,e.Estado,e.Usuario,e.Contrasena,e.IdTipoUsuario
		FROM empleado AS e WHERE ((e.Nombre LIKE CONCAT("%",pbusqueda,"%")) OR (e.Apellido LIKE CONCAT("%",pbusqueda,"%")));
	ELSEIF pcriterio = "dni" THEN
		SELECT e.IdEmpleado,e.Nombre,e.Apellido,e.Sexo,e.FechaNac,e.Direccion,e.Telefono,e.Celular,e.Email,
		e.Dni,e.FechaIng,e.Sueldo,e.Estado,e.Usuario,e.Contrasena,e.IdTipoUsuario
		FROM empleado AS e WHERE e.Dni LIKE CONCAT("%",pbusqueda,"%");
	ELSE
	   SELECT e.IdEmpleado,e.Nombre,e.Apellido,e.Sexo,e.FechaNac,e.Direccion,e.Telefono,e.Celular,e.Email,
		e.Dni,e.FechaIng,e.Sueldo,e.Estado,e.Usuario,e.Contrasena,e.IdTipoUsuario FROM empleado AS e;
	END IF; 
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_EmpleadoCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM empleado;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_EmpleadoIdMaximo` ()  BEGIN
		SELECT MAX(IdEmpleado) AS Maximo FROM empleado;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_EmpleadoPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
	
	
	IF pcriterio = "id" THEN					
			SET @sentencia = CONCAT("SELECT e.IdEmpleado,e.Nombre,e.Apellido,e.Sexo,e.FechaNac,e.Direccion,e.Telefono,e.Celular,e.Email,e.Dni,e.FechaIng,e.Sueldo,e.Estado,e.Usuario,e.Contrasena,tu.Descripcion AS TipoUsuario FROM empleado AS e INNER JOIN tipousuario AS tu ON e.IdTipoUsuario = tu.IdTipoUsuario WHERE e.IdEmpleado=",pbusqueda," ORDER BY e.IdEmpleado DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "nombre" THEN
			SET @sentencia = CONCAT("SELECT e.IdEmpleado,e.Nombre,e.Apellido,e.Sexo,e.FechaNac,e.Direccion,e.Telefono,e.Celular,e.Email,e.Dni,e.FechaIng,e.Sueldo,e.Estado,e.Usuario,e.Contrasena,tu.Descripcion AS TipoUsuario FROM empleado AS e INNER JOIN tipousuario AS tu ON e.IdTipoUsuario = tu.IdTipoUsuario WHERE (e.Nombre LIKE '",CONCAT("%",pbusqueda,"%"),"') OR (e.Apellido LIKE '",CONCAT("%",pbusqueda,"%"),"')"," ORDER BY e.IdEmpleado DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;			
		ELSEIF pcriterio = "dni" THEN
			SET @sentencia = CONCAT("SELECT e.IdEmpleado,e.Nombre,e.Apellido,e.Sexo,e.FechaNac,e.Direccion,e.Telefono,e.Celular,e.Email,e.Dni,e.FechaIng,e.Sueldo,e.Estado,e.Usuario,e.Contrasena,tu.Descripcion AS TipoUsuario FROM empleado AS e INNER JOIN tipousuario AS tu ON e.IdTipoUsuario = tu.IdTipoUsuario WHERE e.Dni LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY e.IdEmpleado DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSE	
			SET @sentencia = CONCAT("SELECT e.IdEmpleado,e.Nombre,e.Apellido,e.Sexo,e.FechaNac,e.Direccion,e.Telefono,e.Celular,e.Email,e.Dni,e.FechaIng,e.Sueldo,e.Estado,e.Usuario,e.Contrasena,tu.Descripcion AS TipoUsuario FROM empleado AS e INNER JOIN tipousuario AS tu ON e.IdTipoUsuario = tu.IdTipoUsuario ORDER BY e.IdEmpleado DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
	END IF; 
	
	
	
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_INGRESAR_SISTEMA` (`n_usuario` VARCHAR(20), `n_contrasena` TEXT)  BEGIN

select e.*, tu.Descripcion from empleado e inner join tipousuario tu 
	WHERE e.Usuario like n_usuario and e.Contrasena like MD5(n_contrasena);
END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_Login` (`pusuario` VARCHAR(20), `pcontrasena` TEXT, `pdescripcion` VARCHAR(80))  BEGIN
	
		SELECT e.IdEmpleado,e.Nombre,e.Apellido,e.Sexo,e.FechaNac,e.Direccion,e.Telefono,e.Celular,e.Email,
		e.Dni,e.FechaIng,e.Sueldo,e.Estado,e.Usuario,e.Contrasena,tu.Descripcion
		FROM empleado AS e INNER JOIN tipousuario AS tu ON e.IdTipoUsuario = tu.IdTipoUsuario WHERE e.Usuario = pusuario AND e.`Contraseña` = pcontrasena AND tu.Descripcion=pdescripcion;
		
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_LoginPermisos` (`pnombre_usuario` VARCHAR(20), `pdescripcion_tipousuario` VARCHAR(80))  BEGIN
	
		SELECT tu.IdTipoUsuario,e.Usuario,tu.Descripcion,tu.p_venta,tu.p_compra,tu.p_producto,tu.p_proveedor,tu.p_empleado,tu.p_cliente,tu.p_categoria,tu.p_tipodoc,tu.p_tipouser,
		tu.p_anularv,tu.p_anularc,tu.p_estadoprod,tu.p_ventare,tu.p_ventade,tu.p_estadistica,tu.p_comprare,tu.p_comprade,tu.p_pass,tu.p_respaldar,tu.p_restaurar,tu.p_caja
		FROM tipousuario AS tu INNER JOIN empleado AS e ON tu.IdTipoUsuario = e.IdTipoUsuario WHERE e.Usuario = pnombre_usuario AND tu.Descripcion=pdescripcion_tipousuario;
		
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_Producto` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(50))  BEGIN
	IF pcriterio = "id" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,p.IdCategoria
		FROM producto AS p WHERE p.IdProducto=pbusqueda;
	ELSEIF pcriterio = "codigo" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,p.IdCategoria
		FROM producto AS p WHERE p.Codigo=pbusqueda;
	ELSEIF pcriterio = "nombre" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,p.IdCategoria
		FROM producto AS p WHERE p.Nombre LIKE CONCAT("%",pbusqueda,"%");
	ELSEIF pcriterio = "descripcion" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,p.IdCategoria
		FROM producto AS p WHERE p.Descripcion LIKE CONCAT("%",pbusqueda,"%");
	ELSE
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,p.IdCategoria
		FROM producto AS p;
	END IF; 
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_ProductoActivo` ()  BEGIN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS categoria
		FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria=c.IdCategoria WHERE p.Estado="Activo"
		ORDER BY p.IdProducto;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_ProductoActivoPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(50))  BEGIN
	IF pcriterio = "id" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria
		FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria
		WHERE p.IdProducto=pbusqueda AND p.Estado="ACTIVO";
 	ELSEIF pcriterio = "codigo" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria
		FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria
		WHERE p.Codigo=pbusqueda AND p.Estado="Activo";
	ELSEIF pcriterio = "nombre" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria
		FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria
		WHERE p.Nombre LIKE CONCAT("%",pbusqueda,"%") AND p.Estado="Activo";
	ELSEIF pcriterio = "descripcion" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria
		FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria
		WHERE p.Descripcion LIKE CONCAT("%",pbusqueda,"%") AND p.Estado="Activo";
	ELSEIF pcriterio = "categoria" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria
		FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria
		WHERE c.Descripcion LIKE CONCAT("%",pbusqueda,"%") AND p.Estado="Activo";
	ELSE
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria
		FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria WHERE p.Estado="Activo";
	END IF; 
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_ProductoCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM producto;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_ProductoIdMaximo` ()  BEGIN
		SELECT MAX(IdProducto) AS Maximo FROM producto;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_ProductoPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(50), `plimit` VARCHAR(50))  BEGIN		
		
	IF pcriterio = "id" THEN					
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria WHERE p.IdProducto=",pbusqueda," ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "codigo" THEN
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria WHERE p.Codigo=",pbusqueda," ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;				
		ELSEIF pcriterio = "nombre" THEN
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria WHERE p.Nombre LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;			
		ELSEIF pcriterio = "descripcion" THEN
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria WHERE p.Descripcion LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;		
		ELSEIF pcriterio = "categoria" THEN
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria WHERE c.Descripcion LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;							
		ELSE	
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
	END IF; 		
		
		
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_ProductoVerificarCodigoBar` (`pbusqueda` VARCHAR(50))  BEGIN
	
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria
		FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria
		WHERE p.Codigo=pbusqueda;

	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_Proveedor` ()  BEGIN
		SELECT * FROM proveedor;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_ProveedorCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM proveedor;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_ProveedorIdMaximo` ()  BEGIN
		SELECT MAX(IdProveedor) AS Maximo FROM proveedor;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_ProveedorPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
	
	
	IF pcriterio = "id" THEN					
			SET @sentencia = CONCAT("SELECT p.IdProveedor,p.Nombre,p.Ruc,p.Dni,p.Direccion,p.Telefono,p.Celular,p.Email,p.Cuenta1,p.Cuenta2,p.Estado,p.Obsv FROM proveedor AS p WHERE p.IdProveedor=",pbusqueda," ORDER BY p.IdProveedor DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "nombre" THEN
			SET @sentencia = CONCAT("SELECT p.IdProveedor,p.Nombre,p.Ruc,p.Dni,p.Direccion,p.Telefono,p.Celular,p.Email,p.Cuenta1,p.Cuenta2,p.Estado,p.Obsv FROM proveedor AS p WHERE p.Nombre LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdProveedor DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;			
		ELSEIF pcriterio = "ruc" THEN
			SET @sentencia = CONCAT("SELECT p.IdProveedor,p.Nombre,p.Ruc,p.Dni,p.Direccion,p.Telefono,p.Celular,p.Email,p.Cuenta1,p.Cuenta2,p.Estado,p.Obsv FROM proveedor AS p WHERE p.Ruc LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdProveedor DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "dni" THEN
			SET @sentencia = CONCAT("SELECT p.IdProveedor,p.Nombre,p.Ruc,p.Dni,p.Direccion,p.Telefono,p.Celular,p.Email,p.Cuenta1,p.Cuenta2,p.Estado,p.Obsv FROM proveedor AS p WHERE p.Dni LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdProveedor DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;			
		ELSE	
			SET @sentencia = CONCAT("SELECT p.IdProveedor,p.Nombre,p.Ruc,p.Dni,p.Direccion,p.Telefono,p.Celular,p.Email,p.Cuenta1,p.Cuenta2,p.Estado,p.Obsv FROM proveedor AS p ORDER BY p.IdProveedor DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
	END IF; 
	
	
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_TipoCambio` ()  BEGIN
		SELECT TipoCambio FROM tipocambio;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_TipoCambioCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM tipocambio;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_TipoCambioIdMaximo` ()  BEGIN
		SELECT MAX(IdTipoCambio) AS Maximo FROM tipocambio;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_TipoCambioPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
			
	IF pcriterio = "id" THEN		
			SET @sentencia = CONCAT("SELECT tc.IdTipoCambio,tc.TipoCambio FROM tipocambio AS tc WHERE tc.IdTipoCambio=",pbusqueda," ORDER BY tc.IdTipoCambio DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "tipocambio" THEN
			SET @sentencia = CONCAT("SELECT tc.IdTipoCambio,tc.TipoCambio FROM tipocambio AS tc WHERE tc.TipoCambio LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY tc.IdTipoCambio DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
		ELSE	
			SET @sentencia = CONCAT("SELECT tc.IdTipoCambio,tc.TipoCambio FROM tipocambio AS tc ORDER BY tc.IdTipoCambio DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
	END IF; 

	
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_TipoDocumento` ()  BEGIN
		SELECT * FROM tipodocumento;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_TipoDocumentoCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM tipodocumento;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_TipoDocumentoIdMaximo` ()  BEGIN
		SELECT MAX(IdTipoDocumento) AS Maximo FROM tipodocumento;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_TipoDocumentoPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
			
	IF pcriterio = "id" THEN		
			SET @sentencia = CONCAT("SELECT td.IdTipoDocumento,td.Descripcion FROM tipodocumento AS td WHERE td.IdTipoDocumento=",pbusqueda," ORDER BY td.IdTipoDocumento DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "descripcion" THEN
			SET @sentencia = CONCAT("SELECT td.IdTipoDocumento,td.Descripcion FROM tipodocumento AS td WHERE td.Descripcion LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY td.IdTipoDocumento DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
		ELSE	
			SET @sentencia = CONCAT("SELECT td.IdTipoDocumento,td.Descripcion FROM tipodocumento AS td ORDER BY td.IdTipoDocumento DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
	END IF; 

	
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_TipoUsuario` ()  BEGIN
		SELECT * FROM tipousuario;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_TipoUsuarioPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
	IF pcriterio = "id" THEN
		SELECT * FROM tipousuario AS tp WHERE tp.IdTipoUsuario=pbusqueda;
	ELSEIF pcriterio = "descripcion" THEN
		SELECT * FROM tipousuario AS tp WHERE tp.Descripcion LIKE CONCAT("%",pbusqueda,"%");
	ELSE
		SELECT * FROM tipousuario AS tp;
	END IF; 
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_UltimoIdCompra` ()  BEGIN
		SELECT MAX(IdCompra) AS id FROM compra;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_UltimoIdVenta` ()  BEGIN
		SELECT MAX(IdVenta) AS id FROM venta;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_Venta` ()  BEGIN
		SELECT v.IdVenta,td.Descripcion AS TipoDocumento,c.Nombre AS Cliente,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,v.Serie,v.Numero,v.Fecha,v.TotalVenta,
		v.Igv,v.TotalPagar,v.Estado,v.Pago
		FROM venta AS v 
		INNER JOIN tipodocumento AS td ON v.IdTipoDocumento=td.IdTipoDocumento
		INNER JOIN cliente AS c ON v.IdCliente=c.IdCliente
		INNER JOIN empleado AS e ON v.IdEmpleado=e.IdEmpleado
		ORDER BY v.IdVenta;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_VentaMensual` (`pcriterio` VARCHAR(20), `pfecha_ini` VARCHAR(20), `pfecha_fin` VARCHAR(20))  BEGIN
			IF pcriterio = "consultar" THEN
			SELECT CONCAT(DAY(v.Fecha)," ",UPPER(MONTHNAME(v.Fecha))," ",YEAR(v.Fecha)) AS Fecha,SUM(v.TotalPagar) AS Total,
				ROUND((SUM(v.TotalPagar)*100)/(SELECT SUM(v.TotalPagar) AS TotalVenta FROM venta AS v WHERE ((date_format(v.Fecha,'%Y-%m') >= pfecha_ini) AND (date_format(v.Fecha,'%Y-%m') <= pfecha_fin)) AND v.Estado="EMITIDO")) AS Porcentaje
				FROM venta AS v
				WHERE ((date_format(v.Fecha,'%Y-%m') >= pfecha_ini) AND (date_format(v.Fecha,'%Y-%m') <= pfecha_fin)) AND v.Estado="EMITIDO" GROUP BY v.Fecha;			
								
			END IF; 
			

	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_VentaPorDetalle` (`pcriterio` VARCHAR(30), `pfechaini` DATE, `pfechafin` DATE)  BEGIN
		IF pcriterio = "consultar" THEN
			SELECT p.Codigo,p.Nombre AS Producto,c.Descripcion AS Categoria,dv.Costo,dv.Precio,
			SUM(dv.Cantidad) AS Cantidad,SUM(dv.Total) AS Total,
			SUM(TRUNCATE((Total-(dv.Costo*dv.Cantidad)),2)) AS Ganancia FROM venta AS v
			INNER JOIN detalleventa AS dv ON v.IdVenta=dv.IdVenta
			INNER JOIN producto AS p ON dv.IdProducto=p.IdProducto
			INNER JOIN categoria AS c ON p.IdCategoria=c.IdCategoria
			WHERE (v.Fecha>=pfechaini AND v.Fecha<=pfechafin) AND v.Estado="EMITIDO" GROUP BY p.IdProducto
			ORDER BY v.IdVenta DESC;
		ELSEIF pcriterio = "EFECTIVO" THEN
			SELECT p.Codigo,p.Nombre AS Producto,c.Descripcion AS Categoria,dv.Costo,dv.Precio,
			SUM(dv.Cantidad) AS Cantidad,SUM(dv.Total) AS Total,
			SUM(TRUNCATE((Total-(dv.Costo*dv.Cantidad)),2)) AS Ganancia FROM venta AS v
			INNER JOIN detalleventa AS dv ON v.IdVenta=dv.IdVenta
			INNER JOIN producto AS p ON dv.IdProducto=p.IdProducto
			INNER JOIN categoria AS c ON p.IdCategoria=c.IdCategoria
			WHERE (v.Fecha>=pfechaini AND v.Fecha<=pfechafin) AND v.Estado="EMITIDO" AND v.Pago="EFECTIVO" GROUP BY p.IdProducto
			ORDER BY v.IdVenta DESC;
		ELSEIF pcriterio = "TARJETA" THEN
			SELECT p.Codigo,p.Nombre AS Producto,c.Descripcion AS Categoria,dv.Costo,dv.Precio,
			SUM(dv.Cantidad) AS Cantidad,SUM(dv.Total) AS Total,
			SUM(TRUNCATE((Total-(dv.Costo*dv.Cantidad)),2)) AS Ganancia FROM venta AS v
			INNER JOIN detalleventa AS dv ON v.IdVenta=dv.IdVenta
			INNER JOIN producto AS p ON dv.IdProducto=p.IdProducto
			INNER JOIN categoria AS c ON p.IdCategoria=c.IdCategoria
			WHERE (v.Fecha>=pfechaini AND v.Fecha<=pfechafin) AND (v.Estado="EMITIDO" AND v.Pago="TARJETA") GROUP BY p.IdProducto
			ORDER BY v.IdVenta DESC;
		ELSE
			SELECT p.Codigo,p.Nombre AS Producto,c.Descripcion AS Categoria,dv.Costo,dv.Precio,
			SUM(dv.Cantidad) AS Cantidad,v.Pago,SUM(dv.Total) AS Total,
			SUM(TRUNCATE((Total-(dv.Costo*dv.Cantidad)),2)) AS Ganancia FROM venta AS v
			INNER JOIN detalleventa AS dv ON v.IdVenta=dv.IdVenta
			INNER JOIN producto AS p ON dv.IdProducto=p.IdProducto
			INNER JOIN categoria AS c ON p.IdCategoria=c.IdCategoria
			WHERE v.Estado="EMITIDO" GROUP BY p.IdProducto
			ORDER BY v.IdVenta DESC LIMIT 10;
		END IF;

	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_VentaPorFecha` (`pcriterio` VARCHAR(30), `pfechaini` DATE, `pfechafin` DATE, `pdocumento` VARCHAR(30))  BEGIN
		IF pcriterio = "anular" THEN
			SELECT v.IdVenta,c.Nombre AS Cliente,v.Fecha,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,td.Descripcion AS TipoDocumento,v.Serie,v.Numero,
			v.Estado,V.Pago,v.TotalPagar  FROM venta AS v
			INNER JOIN tipodocumento AS td ON v.IdTipoDocumento=td.IdTipoDocumento
			INNER JOIN cliente AS c ON v.IdCliente=c.IdCliente
			INNER JOIN empleado AS e ON v.IdEmpleado=e.IdEmpleado
			WHERE (v.Fecha>=pfechaini AND v.Fecha<=pfechafin) AND td.Descripcion=pdocumento ORDER BY v.IdVenta DESC;
		
		ELSEIF pcriterio = "consultar" THEN	
			SELECT v.IdVenta,c.Nombre AS Cliente,v.Fecha,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,td.Descripcion AS TipoDocumento,v.Serie,v.Numero,
			v.Estado,v.Pago,v.Referencia,v.TotalVenta,v.Igv,v.TotalPagar  FROM venta AS v 
			INNER JOIN tipodocumento AS td ON v.IdTipoDocumento=td.IdTipoDocumento 
			INNER JOIN cliente AS c ON v.IdCliente=c.IdCliente 
			INNER JOIN empleado AS e ON v.IdEmpleado=e.IdEmpleado 
			WHERE (v.Fecha>=pfechaini AND v.Fecha<=pfechafin) ORDER BY v.IdVenta DESC;
	
		ELSEIF pcriterio = "caja" THEN	
		   SELECT SUM(dv.Cantidad) AS Cantidad,p.Nombre AS Producto,dv.Precio,
			SUM(dv.Total) AS Total, SUM(TRUNCATE((Total-(dv.Costo*dv.Cantidad)),2)) AS Ganancia,v.Fecha FROM venta AS v
			INNER JOIN detalleventa AS dv ON v.IdVenta=dv.IdVenta
			INNER JOIN producto AS p ON dv.IdProducto=p.IdProducto
			INNER JOIN categoria AS c ON p.IdCategoria=c.IdCategoria
			WHERE v.Fecha=pfechaini AND v.Estado="EMITIDO" GROUP BY p.IdProducto
			ORDER BY v.IdVenta DESC;
			
		ELSE
			SELECT v.IdVenta,c.Nombre AS Cliente,v.Fecha,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,td.Descripcion AS TipoDocumento,v.Serie,v.Numero,
			v.Estado,v.Pago,v.Referencia,v.TotalVenta,v.Igv,v.TotalPagar  FROM venta AS v 
			INNER JOIN tipodocumento AS td ON v.IdTipoDocumento=td.IdTipoDocumento 
			INNER JOIN cliente AS c ON v.IdCliente=c.IdCliente 
			INNER JOIN empleado AS e ON v.IdEmpleado=e.IdEmpleado ORDER BY v.IdVenta DESC LIMIT 10;	
		END IF;

	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_VentaPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
			IF pcriterio = "id" THEN
				SELECT v.IdVenta,td.Descripcion AS TipoDocumento,c.Nombre AS Cliente,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,v.Serie,v.Numero,v.Fecha,v.TotalVenta,
				v.Igv,v.TotalPagar,v.Estado  FROM venta AS v
				INNER JOIN tipodocumento AS td ON v.IdTipoDocumento=td.IdTipoDocumento
				INNER JOIN cliente AS c ON v.IdCliente=c.IdCliente
				INNER JOIN empleado AS e ON v.IdEmpleado=e.IdEmpleado
				WHERE v.IdVenta=pbusqueda ORDER BY v.IdVenta;
			ELSEIF pcriterio = "documento" THEN
				SELECT v.IdVenta,td.Descripcion AS TipoDocumento,c.Nombre AS Cliente,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,v.Serie,v.Numero,v.Fecha,v.TotalVenta,
				v.Igv,v.TotalPagar,v.Estado  FROM venta AS v
				INNER JOIN tipodocumento AS td ON v.IdTipoDocumento=td.IdTipoDocumento
				INNER JOIN cliente AS c ON v.IdCliente=c.IdCliente
				INNER JOIN empleado AS e ON v.IdEmpleado=e.IdEmpleado
				WHERE td.Descripcion=pbusqueda ORDER BY v.IdVenta;
			END IF; 
			

	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_Venta_DetallePorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
			IF pcriterio = "id" THEN
				SELECT v.IdVenta,td.Descripcion AS TipoDocumento,c.Nombre AS Cliente,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,v.Serie,v.Numero,v.Fecha,v.TotalVenta,
				v.Igv,v.TotalPagar,v.Estado,p.Codigo,p.Nombre,dv.Cantidad,p.PrecioVenta,dv.Total  FROM venta AS v
				INNER JOIN tipodocumento AS td ON v.IdTipoDocumento=td.IdTipoDocumento
				INNER JOIN cliente AS c ON v.IdCliente=c.IdCliente
				INNER JOIN empleado AS e ON v.IdEmpleado=e.IdEmpleado
				INNER JOIN detalleventa AS dv ON v.IdVenta=dv.IdVenta
				INNER JOIN producto AS p ON dv.IdProducto=p.IdProducto
				WHERE v.IdVenta=pbusqueda ORDER BY v.IdVenta;
			
			END IF; 
			

	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_S_VENTA_TOTAL_DIARIA` ()  BEGIN
	select sum(dv.Cantidad * dv.Precio) as total_ventas from
	venta v inner join detalleventa dv on v.IdVenta = dv.IdVenta where v.Fecha like curdate();
END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_ActualizarCompraEstado` (`pidcompra` INT, `pestado` VARCHAR(30))  BEGIN
		UPDATE compra SET
			estado=pestado
		WHERE idcompra = pidcompra;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_ActualizarProductoStock` (`pidproducto` INT, `pstock` DECIMAL(8,2))  BEGIN
		UPDATE producto SET
			stock=pstock
		WHERE idproducto = pidproducto;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_ActualizarVentaEstado` (`pidventa` INT, `pestado` VARCHAR(30))  BEGIN
		UPDATE venta SET
			estado=pestado
		WHERE idventa = pidventa;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_CambiarPass` (`pidempleado` INT, `pcontrasena` TEXT)  BEGIN
		UPDATE empleado SET
			contrasena=pcontrasena
		WHERE idempleado = pidempleado;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_Categoria` (`pidcategoria` INT, `pdescripcion` VARCHAR(100))  BEGIN
		UPDATE categoria SET
			descripcion=pdescripcion	
		WHERE idcategoria = pidcategoria;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_Cliente` (`pidcliente` INT, `pnombre` VARCHAR(100), `pruc` VARCHAR(11), `pdni` VARCHAR(8), `pdireccion` VARCHAR(50), `ptelefono` VARCHAR(15), `pobsv` TEXT, `pusuario` VARCHAR(30), `pcontrasena` VARCHAR(10))  BEGIN
		UPDATE cliente SET
			nombre=pnombre,
			ruc=pruc,
			dni=pdni,
			direccion=pdireccion,
			telefono=ptelefono,
			obsv=pobsv,
			usuario=pusuario,
			contrasena=pcontrasena
		WHERE idcliente = pidcliente;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_Compra` (`pidcompra` INT, `pidtipodocumento` INT, `pidproveedor` INT, `pidempleado` INT, `pnumero` VARCHAR(20), `pfecha` DATE, `psubtotal` DECIMAL(8,2), `pigv` DECIMAL(8,2), `ptotal` DECIMAL(8,2), `pestado` VARCHAR(30))  BEGIN
		UPDATE compra SET
			idtipodocumento=pidtipodocumento,
			idproveedor=pidproveedor,
			idempleado=pidempleado,
			numero=pnumero,
			fecha=pfecha,
			subtotal=psubtotal,
			igv=pigv,
			total=ptotal,
			estado=pestado
		WHERE idcompra = pidcompra;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_DetalleCompra` (`pidcompra` INT, `pidproducto` INT, `pcantidad` DECIMAL(8,2), `pprecio` DECIMAL(8,2), `ptotal` DECIMAL(8,2))  BEGIN
		UPDATE venta SET
			idcompra=pidcompra,
			idproducto=pidproducto,
			cantidad=pcantidad,
			precio=pprecio,
			total=ptotal
		WHERE idcompra = pidcompra;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_DetalleVenta` (`pidventa` INT, `pidproducto` INT, `pcantidad` DECIMAL(8,2), `pcosto` DECIMAL(8,2), `pprecio` DECIMAL(8,2), `ptotal` DECIMAL(8,2))  BEGIN
		UPDATE venta SET
			idventa=pidventa,
			idproducto=pidproducto,
			cantidad=pcantidad,
			costo=pcosto,
			precio=pprecio,
			total=ptotal
		WHERE idventa = pidventa;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_Empleado` (`pidempleado` INT, `pnombre` VARCHAR(50), `papellido` VARCHAR(80), `psexo` VARCHAR(1), `pfechanac` DATE, `pdireccion` VARCHAR(100), `ptelefono` VARCHAR(10), `pcelular` VARCHAR(15), `pemail` VARCHAR(80), `pdni` VARCHAR(8), `pfechaing` DATE, `psueldo` DECIMAL(8,2), `pestado` VARCHAR(30), `pusuario` VARCHAR(20), `pcontrasena` TEXT, `pidtipousuario` INT)  BEGIN
		UPDATE empleado SET
			nombre=pnombre,
			apellido=papellido,
			sexo=psexo,
			fechanac=pfechanac,
			direccion=pdireccion,
			telefono=ptelefono,
			celular=pcelular,
			email=pemail,
			dni=pdni,
			fechaing=pfechaing,
			sueldo=psueldo,
			estado=pestado,
			usuario=pusuario,
			contrasena=pcontrasena,
			idtipousuario=pidtipousuario			
		WHERE idempleado = pidempleado;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_Producto` (`pidproducto` INT, `pcodigo` VARCHAR(50), `pnombre` VARCHAR(100), `pdescripcion` TEXT, `pstock` DECIMAL(8,2), `pstockmin` DECIMAL(8,2), `ppreciocosto` DECIMAL(8,2), `pprecioventa` DECIMAL(8,2), `putilidad` DECIMAL(8,2), `pestado` VARCHAR(30), `pimagen` VARCHAR(100), `pidcategoria` INT)  BEGIN
		UPDATE producto SET
			codigo=pcodigo,
			nombre=pnombre,
			descripcion=pdescripcion,
			stock=pstock,
			stockmin=pstockmin,
			preciocosto=ppreciocosto,
			precioventa=pprecioventa,
			utilidad=putilidad,
			estado=pestado,
			imagen=pimagen,
			idcategoria=pidcategoria
			
		WHERE idproducto = pidproducto;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_Proveedor` (`pidproveedor` INT, `pnombre` VARCHAR(100), `pruc` VARCHAR(11), `pdni` VARCHAR(8), `pdireccion` VARCHAR(100), `ptelefono` VARCHAR(10), `pcelular` VARCHAR(15), `pemail` VARCHAR(80), `pcuenta1` VARCHAR(50), `pcuenta2` VARCHAR(50), `pestado` VARCHAR(30), `pobsv` TEXT)  BEGIN
		UPDATE proveedor SET
			nombre=pnombre,
			ruc=pruc,
			dni=pdni,
			direccion=pdireccion,
			telefono=ptelefono,
			celular=pcelular,
			email=pemail,
			cuenta1=pcuenta1,
			cuenta2=pcuenta2,
			estado=pestado,
			obsv=pobsv
		WHERE idproveedor = pidproveedor;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_TipoCambio` (`pidtipocambio` INT, `ptipocambio` DECIMAL(4,2))  BEGIN
		UPDATE tipocambio SET
			tipocambio=ptipocambio	
		WHERE idtipocambio = pidtipocambio;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_TipoDocumento` (`pidtipodocumento` INT, `pdescripcion` VARCHAR(80))  BEGIN
		UPDATE tipodocumento SET
			descripcion=pdescripcion	
		WHERE idtipodocumento = pidtipodocumento;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_TipoUsuario` (`pidtipousuario` INT, `pdescripcion` VARCHAR(80), `pp_venta` INT, `pp_compra` INT, `pp_producto` INT, `pp_proveedor` INT, `pp_empleado` INT, `pp_cliente` INT, `pp_categoria` INT, `pp_tipodoc` INT, `pp_tipouser` INT, `pp_anularv` INT, `pp_anularc` INT, `pp_estadoprod` INT, `pp_ventare` INT, `pp_ventade` INT, `pp_estadistica` INT, `pp_comprare` INT, `pp_comprade` INT, `pp_pass` INT, `pp_respaldar` INT, `pp_restaurar` INT, `pp_caja` INT)  BEGIN
		UPDATE tipousuario SET
			descripcion=pdescripcion,
			p_venta=pp_venta,
			p_compra=pp_compra,
			p_producto=pp_producto,
			p_proveedor=pp_proveedor,
			p_empleado=pp_empleado,
			p_cliente=pp_cliente,
			p_categoria=pp_categoria,
			p_tipodoc=pp_tipodoc,
			p_tipouser=pp_tipouser,
			p_anularv=pp_anularv,
			p_anularc=pp_anularc,
			p_estadoprod=pp_estadoprod,
			p_ventare=pp_ventare,
			p_ventade=pp_ventade,
			p_estadistica=pp_estadistica,
			p_comprare=pp_comprare,
			p_comprade=pp_comprade,
			p_pass=pp_pass,
			p_respaldar=pp_respaldar,
			p_restaurar=pp_restaurar,
			p_caja=pp_caja
		WHERE idtipousuario = pidtipousuario;
	END$$

CREATE DEFINER=`pequescl`@`localhost` PROCEDURE `SP_U_Venta` (`pidventa` INT, `pidtipodocumento` INT, `pidcliente` INT, `pidempleado` INT, `pserie` VARCHAR(5), `pnumero` VARCHAR(20), `pfecha` DATE, `ptotalventa` DECIMAL(8,2), `pigv` DECIMAL(8,2), `ptotalpagar` DECIMAL(8,2), `pestado` VARCHAR(30))  BEGIN
		UPDATE venta SET
			idtipodocumento=pidtipodocumento,
			idcliente=pidcliente,
			idempleado=pidempleado,
			serie=pserie,
			numero=pnumero,
			fecha=pfecha,
			totalventa=ptotalventa,
			igv=pigv,
			totalpagar=ptotalpagar,
			estado=pestado
		WHERE idventa = pidventa;
	END$$

--
-- Funciones
--
CREATE DEFINER=`pequescl`@`localhost` FUNCTION `DiaEnLetras` (`pfecha` DATE) RETURNS VARCHAR(10) CHARSET latin1 BEGIN
DECLARE Dia varchar(10);
SELECT 
CONCAT(ELT(WEEKDAY( PFECHA ) + 1, 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo')) 
into Dia;
RETURN Dia;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `IdCategoria` int(11) NOT NULL,
  `Descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`IdCategoria`, `Descripcion`) VALUES
(1, 'GENERAL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `IdCliente` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Ruc` varchar(11) DEFAULT NULL,
  `Dni` varchar(8) DEFAULT NULL,
  `Direccion` varchar(50) DEFAULT NULL,
  `Telefono` varchar(15) DEFAULT NULL,
  `Obsv` text,
  `Usuario` varchar(30) DEFAULT NULL,
  `Contrasena` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`IdCliente`, `Nombre`, `Ruc`, `Dni`, `Direccion`, `Telefono`, `Obsv`, `Usuario`, `Contrasena`) VALUES
(1, 'PUBLICO GENERAL', '20477157771', '47715777', 'Chiclayo', '455630', 'aaa', 'cliente', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `IdCompra` int(11) NOT NULL,
  `IdTipoDocumento` int(11) NOT NULL,
  `IdProveedor` int(11) NOT NULL,
  `IdEmpleado` int(11) NOT NULL,
  `Numero` varchar(20) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `SubTotal` decimal(8,2) DEFAULT NULL,
  `Igv` decimal(8,2) DEFAULT NULL,
  `Total` decimal(8,2) DEFAULT NULL,
  `Estado` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`IdCompra`, `IdTipoDocumento`, `IdProveedor`, `IdEmpleado`, `Numero`, `Fecha`, `SubTotal`, `Igv`, `Total`, `Estado`) VALUES
(1, 1, 1, 1, 'C0000000001', '2018-10-18', '83699.15', '15065.85', '98765.00', 'EMITIDO'),
(2, 1, 1, 2, 'C0000000002', '2018-10-18', '10043.90', '1807.90', '11851.80', 'EMITIDO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallecompra`
--

CREATE TABLE `detallecompra` (
  `IdCompra` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `Cantidad` decimal(8,2) NOT NULL,
  `Precio` decimal(8,2) NOT NULL,
  `Total` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detallecompra`
--

INSERT INTO `detallecompra` (`IdCompra`, `IdProducto`, `Cantidad`, `Precio`, `Total`) VALUES
(1, 1, '100.00', '987.65', '98765.00'),
(2, 1, '12.00', '987.65', '11851.80');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallepedido`
--

CREATE TABLE `detallepedido` (
  `IdPedido` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `Cantidad` decimal(8,2) DEFAULT NULL,
  `Precio` decimal(8,2) DEFAULT NULL,
  `Total` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleventa`
--

CREATE TABLE `detalleventa` (
  `IdVenta` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `Cantidad` decimal(8,2) NOT NULL,
  `Costo` decimal(8,2) NOT NULL,
  `Precio` decimal(8,2) NOT NULL,
  `Total` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalleventa`
--

INSERT INTO `detalleventa` (`IdVenta`, `IdProducto`, `Cantidad`, `Costo`, `Precio`, `Total`) VALUES
(1, 1, '1.00', '987.65', '1500.00', '1500.00'),
(2, 1, '5.00', '987.65', '1500.00', '7500.00'),
(3, 1, '1.00', '987.65', '1500.00', '1500.00'),
(4, 1, '3.00', '987.65', '1500.00', '4500.00'),
(5, 1, '1.00', '987.65', '1500.00', '1500.00'),
(6, 1, '10.00', '987.65', '1500.00', '15000.00'),
(7, 1, '2.00', '987.65', '1500.00', '3000.00'),
(8, 1, '1.00', '987.65', '1500.00', '1500.00'),
(9, 1, '20.00', '987.65', '1500.00', '30000.00'),
(10, 1, '50.00', '987.65', '1500.00', '75000.00'),
(11, 1, '2.00', '987.65', '1500.00', '3000.00'),
(12, 2, '1.00', '890.00', '1350.00', '1350.00'),
(13, 2, '2.00', '890.00', '1350.00', '2700.00'),
(13, 1, '1.00', '987.65', '1500.00', '1500.00'),
(14, 3, '5.00', '200.00', '320.00', '1600.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `IdEmpleado` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(80) NOT NULL,
  `Sexo` varchar(1) NOT NULL,
  `FechaNac` date NOT NULL,
  `Direccion` varchar(100) DEFAULT NULL,
  `Telefono` varchar(10) DEFAULT NULL,
  `Celular` varchar(15) DEFAULT NULL,
  `Email` varchar(80) DEFAULT NULL,
  `Dni` varchar(8) DEFAULT NULL,
  `FechaIng` date NOT NULL,
  `Sueldo` decimal(8,2) DEFAULT NULL,
  `Estado` varchar(30) NOT NULL,
  `Usuario` varchar(20) DEFAULT NULL,
  `Contrasena` text,
  `IdTipoUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`IdEmpleado`, `Nombre`, `Apellido`, `Sexo`, `FechaNac`, `Direccion`, `Telefono`, `Celular`, `Email`, `Dni`, `FechaIng`, `Sueldo`, `Estado`, `Usuario`, `Contrasena`, `IdTipoUsuario`) VALUES
(1, 'Juan Carlos', 'Arcila DÃ­az', 'M', '2013-06-15', 'Chiclayo - PerÃº', '455630', '979026684', 'jcarlos.ad7@gmail.com', '47715777', '2013-06-15', '2500.00', 'ACTIVO', 'admin', '21232f297a57a5a743894a0e4a801fc3', 1),
(2, 'Gustavo', 'Rosas Martinez', 'M', '1987-04-27', '', '', '9981113869', 'goldem64@yahoo.com.mx', '', '2018-10-01', '25000.00', 'ACTIVO', 'goldem64', 'c3581516868fb3b71746931cac66390e', 1),
(3, 'Filiberto', 'Cocom Mukul', 'M', '0000-00-00', '', '', '', '', '', '0000-00-00', '0.00', 'ACTIVO', 'cocom', '13b1c60ea8ad6db4ea5a08e86d65235b', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `IdPedido` int(11) NOT NULL,
  `IdCliente` int(11) NOT NULL,
  `Fecha_solicitud` datetime DEFAULT NULL,
  `Fecha_entrega` datetime DEFAULT NULL,
  `Total` decimal(8,2) DEFAULT NULL,
  `Estado` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `IdProducto` int(11) NOT NULL,
  `Codigo` varchar(50) DEFAULT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Descripcion` text,
  `Stock` decimal(8,2) DEFAULT NULL,
  `StockMin` decimal(8,2) DEFAULT NULL,
  `PrecioCosto` decimal(8,2) DEFAULT NULL,
  `PrecioVenta` decimal(8,2) DEFAULT NULL,
  `Utilidad` decimal(8,2) DEFAULT NULL,
  `Estado` varchar(30) NOT NULL,
  `Imagen` varchar(100) DEFAULT NULL,
  `IdCategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`IdProducto`, `Codigo`, `Nombre`, `Descripcion`, `Stock`, `StockMin`, `PrecioCosto`, `PrecioVenta`, `Utilidad`, `Estado`, `Imagen`, `IdCategoria`) VALUES
(1, '00000000001', 'SustanciaX', 'Producto para registro de prueba', '114.00', '1.00', '987.65', '1500.00', '512.35', 'ACTIVO', '1539913725-nuevoProducto.jpg', 1),
(2, '12345667', 'hd 1 tb', 'disco duro de 1 tb seguete', '0.00', '5.00', '890.00', '1350.00', '460.00', 'ACTIVO', '', 1),
(3, '6935364050573', 'Tarjeta Inalambrica', 'Tarjeta de 2 antenas', '95.00', '10.00', '200.00', '320.00', '120.00', 'ACTIVO', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `IdProveedor` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Ruc` varchar(11) DEFAULT NULL,
  `Dni` varchar(8) DEFAULT NULL,
  `Direccion` varchar(100) DEFAULT NULL,
  `Telefono` varchar(10) DEFAULT NULL,
  `Celular` varchar(15) DEFAULT NULL,
  `Email` varchar(80) DEFAULT NULL,
  `Cuenta1` varchar(50) DEFAULT NULL,
  `Cuenta2` varchar(50) DEFAULT NULL,
  `Estado` varchar(30) NOT NULL,
  `Obsv` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`IdProveedor`, `Nombre`, `Ruc`, `Dni`, `Direccion`, `Telefono`, `Celular`, `Email`, `Cuenta1`, `Cuenta2`, `Estado`, `Obsv`) VALUES
(1, 'SIN PROVEEDOR', '', '', '', '', '', '', '', '', 'ACTIVO', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipocambio`
--

CREATE TABLE `tipocambio` (
  `IdTipoCambio` int(11) NOT NULL,
  `TipoCambio` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipocambio`
--

INSERT INTO `tipocambio` (`IdTipoCambio`, `TipoCambio`) VALUES
(1, '19.02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipodocumento`
--

CREATE TABLE `tipodocumento` (
  `IdTipoDocumento` int(11) NOT NULL,
  `Descripcion` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipodocumento`
--

INSERT INTO `tipodocumento` (`IdTipoDocumento`, `Descripcion`) VALUES
(1, 'TICKET');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipousuario`
--

CREATE TABLE `tipousuario` (
  `IdTipoUsuario` int(11) NOT NULL,
  `Descripcion` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipousuario`
--

INSERT INTO `tipousuario` (`IdTipoUsuario`, `Descripcion`) VALUES
(1, 'ADMINISTRADOR'),
(2, 'CAJERO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `IdVenta` int(11) NOT NULL,
  `IdTipoDocumento` int(11) NOT NULL,
  `IdCliente` int(11) NOT NULL,
  `IdEmpleado` int(11) NOT NULL,
  `Serie` varchar(5) DEFAULT NULL,
  `Numero` varchar(20) DEFAULT NULL,
  `Fecha` date NOT NULL,
  `TotalVenta` decimal(8,2) NOT NULL,
  `Igv` decimal(8,2) NOT NULL,
  `TotalPagar` decimal(8,2) NOT NULL,
  `Estado` varchar(30) NOT NULL,
  `Pago` varchar(30) NOT NULL,
  `Referencia` varchar(30) DEFAULT 'NO APLICA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`IdVenta`, `IdTipoDocumento`, `IdCliente`, `IdEmpleado`, `Serie`, `Numero`, `Fecha`, `TotalVenta`, `Igv`, `TotalPagar`, `Estado`, `Pago`, `Referencia`) VALUES
(1, 1, 1, 1, '001', 'C0000000001', '2018-10-18', '1293.10', '206.90', '1500.00', 'EMITIDO', 'EFECTIVO', 'NO APLICA'),
(2, 1, 1, 1, '001', 'C0000000002', '2018-10-18', '6465.52', '1034.48', '7500.00', 'EMITIDO', 'TARJETA', '01'),
(3, 1, 1, 1, '001', 'C0000000003', '2018-10-18', '1293.10', '206.90', '1500.00', 'EMITIDO', 'EFECTIVO', 'NO APLICA'),
(4, 1, 1, 1, '001', 'C0000000004', '2018-10-18', '3879.31', '620.69', '4500.00', 'EMITIDO', 'TARJETA', '02'),
(5, 1, 1, 1, '001', 'C0000000005', '2018-10-18', '1293.10', '206.90', '1500.00', 'EMITIDO', 'EFECTIVO', 'NO APLICA'),
(6, 1, 1, 1, '001', 'C0000000006', '2018-10-18', '12931.03', '2068.96', '15000.00', 'EMITIDO', 'TARJETA', '03'),
(7, 1, 1, 2, '001', 'C0000000007', '2018-10-18', '2586.21', '413.79', '3000.00', 'EMITIDO', 'EFECTIVO', 'NO APLICA'),
(8, 1, 1, 2, '001', 'C0000000008', '2018-10-18', '1293.10', '206.90', '1500.00', 'EMITIDO', 'TARJETA', '04'),
(9, 1, 1, 2, '001', 'C0000000009', '2018-10-18', '25862.07', '4137.93', '30000.00', 'EMITIDO', 'TARJETA', '04'),
(10, 1, 1, 2, '001', 'C0000000010', '2018-10-18', '64655.17', '10344.83', '75000.00', 'EMITIDO', 'TARJETA', '05'),
(11, 1, 1, 2, '001', 'C0000000011', '2018-10-18', '2586.21', '413.79', '3000.00', 'EMITIDO', 'EFECTIVO', 'NO APLICA'),
(12, 1, 1, 3, '001', 'C0000000012', '2018-10-19', '1163.79', '186.21', '1350.00', 'EMITIDO', 'EFECTIVO', 'NO APLICA'),
(13, 1, 1, 3, '001', 'C0000000013', '2018-10-19', '3620.69', '579.31', '4200.00', 'EMITIDO', 'TARJETA', '234'),
(14, 1, 1, 2, '001', 'C0000000014', '2018-10-20', '1379.31', '220.69', '1600.00', 'EMITIDO', 'EFECTIVO', 'NO APLICA');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`IdCategoria`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`IdCliente`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`IdCompra`),
  ADD KEY `fk_Compra_Proveedor1_idx` (`IdProveedor`),
  ADD KEY `fk_Compra_Empleado1_idx` (`IdEmpleado`),
  ADD KEY `fk_Compra_TipoDocumento1_idx` (`IdTipoDocumento`);

--
-- Indices de la tabla `detallecompra`
--
ALTER TABLE `detallecompra`
  ADD KEY `fk_DetalleCompra_Compra1_idx` (`IdCompra`),
  ADD KEY `fk_DetalleCompra_Producto1_idx` (`IdProducto`);

--
-- Indices de la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  ADD KEY `fk_DetallePedido_Pedido1` (`IdPedido`),
  ADD KEY `fk_DetallePedido_Producto1` (`IdProducto`);

--
-- Indices de la tabla `detalleventa`
--
ALTER TABLE `detalleventa`
  ADD KEY `fk_DetalleVenta_Producto1_idx` (`IdProducto`),
  ADD KEY `fk_DetalleVenta_Venta1_idx` (`IdVenta`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`IdEmpleado`),
  ADD KEY `fk_Empleado_TipoUsuario1_idx` (`IdTipoUsuario`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`IdPedido`),
  ADD KEY `fk_Pedido_Cliente1` (`IdCliente`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`IdProducto`),
  ADD KEY `fk_Producto_Categoria_idx` (`IdCategoria`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`IdProveedor`);

--
-- Indices de la tabla `tipocambio`
--
ALTER TABLE `tipocambio`
  ADD PRIMARY KEY (`IdTipoCambio`);

--
-- Indices de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  ADD PRIMARY KEY (`IdTipoDocumento`);

--
-- Indices de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  ADD PRIMARY KEY (`IdTipoUsuario`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`IdVenta`),
  ADD KEY `fk_Venta_TipoDocumento1_idx` (`IdTipoDocumento`),
  ADD KEY `fk_Venta_Cliente1_idx` (`IdCliente`),
  ADD KEY `fk_Venta_Empleado1_idx` (`IdEmpleado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `IdCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `IdCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `IdCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `IdEmpleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `IdPedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `IdProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `IdProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tipocambio`
--
ALTER TABLE `tipocambio`
  MODIFY `IdTipoCambio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  MODIFY `IdTipoDocumento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  MODIFY `IdTipoUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `IdVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
