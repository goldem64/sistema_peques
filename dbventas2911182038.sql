-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 29-11-2018 a las 20:37:56
-- Versión del servidor: 5.7.17-log
-- Versión de PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbventas`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ANIO_GRAFICO` ()  BEGIN
	select distinct year(Fecha) as anio from venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_grafico_dias` ()  SELECT
 v.fecha,dayname(v.Fecha) as mes, sum(v.totalpagar) as total_dia
	from venta v inner join detalleventa dv on v.IdVenta = dv.IdVenta

			where year(v.Fecha) = year(curdate())
		group by v.fecha
		order by day(v.Fecha) desc
			limit 15$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_grafico_mes` ()  SELECT
 monthname(v.Fecha) as mes, sum(v.totalpagar) as total_dia
	from venta v inner join detalleventa dv on v.IdVenta = dv.IdVenta

			where year(v.Fecha) = year(curdate())
		group by monthname(v.Fecha)
		order by month(v.Fecha) desc
			limit 12$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_grafico_totales` ()  SELECT
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Categoria` (`pdescripcion` VARCHAR(100))  BEGIN		
		INSERT INTO categoria(descripcion)
		VALUES(pdescripcion);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Cliente` (`pnombre` VARCHAR(100), `pruc` VARCHAR(11), `pdni` VARCHAR(8), `pdireccion` VARCHAR(50), `ptelefono` VARCHAR(15), `pobsv` TEXT, `pusuario` VARCHAR(30), `pcontrasena` VARCHAR(10))  BEGIN		
		INSERT INTO cliente(nombre,ruc,dni,direccion,telefono,obsv,usuario,contrasena)
		VALUES(pnombre,pruc,pdni,pdireccion,ptelefono,pobsv,pusuario,pcontrasena);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Color` (`pdescripcion` VARCHAR(100))  BEGIN		
		INSERT INTO color(descripcion)
		VALUES(pdescripcion);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Compra` (`pidtipodocumento` INT, `pidproveedor` INT, `pidempleado` INT, `pnumero` VARCHAR(20), `pfecha` DATE, `psubtotal` DECIMAL(8,2), `pigv` DECIMAL(8,2), `ptotal` DECIMAL(8,2), `pestado` VARCHAR(30))  BEGIN		
		INSERT INTO compra(idtipodocumento,idproveedor,idempleado,numero,fecha,subtotal,igv,total,estado)
		VALUES(pidtipodocumento,pidproveedor,pidempleado,pnumero,pfecha,psubtotal,pigv,ptotal,pestado);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_DetalleCompra` (`pidcompra` INT, `pidproducto` INT, `pcantidad` DECIMAL(8,2), `pprecio` DECIMAL(8,2), `ptotal` DECIMAL(8,2))  BEGIN		
		INSERT INTO detallecompra(idcompra,idproducto,cantidad,precio,total)
		VALUES(pidcompra,pidproducto,pcantidad,pprecio,ptotal);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_DetalleVenta` (`pidventa` INT, `pidproducto` INT, `pcantidad` DECIMAL(8,2), `pcosto` DECIMAL(8,2), `pprecio` DECIMAL(8,2), `ptotal` DECIMAL(8,2))  BEGIN		
		INSERT INTO detalleventa(idventa,idproducto,cantidad,costo,precio,total)
		VALUES(pidventa,pidproducto,pcantidad,pcosto,pprecio,ptotal);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Empleado` (`pnombre` VARCHAR(50), `papellido` VARCHAR(80), `psexo` VARCHAR(1), `pfechanac` DATE, `pdireccion` VARCHAR(100), `ptelefono` VARCHAR(10), `pcelular` VARCHAR(15), `pemail` VARCHAR(80), `pdni` VARCHAR(8), `pfechaing` DATE, `psueldo` DECIMAL(8,2), `pestado` VARCHAR(30), `pusuario` VARCHAR(20), `pcontrasena` TEXT, `pidtipousuario` INT)  BEGIN		
		INSERT INTO empleado(nombre,apellido,sexo,fechanac,direccion,telefono,celular,email,dni,fechaing,sueldo,estado,usuario,contrasena,idtipousuario)
		VALUES(pnombre,papellido,psexo,pfechanac,pdireccion,ptelefono,pcelular,pemail,pdni,pfechaing,psueldo,pestado,pusuario,pcontrasena,pidtipousuario);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Producto` (`pcodigo` VARCHAR(50), `pnombre` VARCHAR(100), `pdescripcion` TEXT, `pstock` DECIMAL(8,2), `pstockmin` DECIMAL(8,2), `ppreciocosto` DECIMAL(8,2), `pprecioventa` DECIMAL(8,2), `putilidad` DECIMAL(8,2), `pestado` VARCHAR(30), `pimagen` VARCHAR(100), `pidcategoria` INT, `pidproveedor` INT, `pidcolor` INT, `pidtalla` INT)  BEGIN		
		INSERT INTO producto(codigo,nombre,descripcion,stock,stockmin,preciocosto,precioventa,utilidad,estado,imagen,idcategoria,idproveedor,idcolor,idtalla)
		VALUES(pcodigo,pnombre,pdescripcion,pstock,pstockmin,ppreciocosto,pprecioventa,putilidad,pestado,pimagen,pidcategoria,pidproveedor,pidcolor,pidtalla);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Promocion` (`pcodigo` VARCHAR(50), `pdescuento` DECIMAL(4,2), `pestado` VARCHAR(50))  BEGIN		
		INSERT INTO promocion(codigo,descuento,estado)
		VALUES(pcodigo,pdescuento,pestado);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Proveedor` (`pnombre` VARCHAR(100), `pruc` VARCHAR(11), `pdni` VARCHAR(8), `pdireccion` VARCHAR(100), `ptelefono` VARCHAR(10), `pcelular` VARCHAR(15), `pemail` VARCHAR(80), `pcuenta1` VARCHAR(50), `pcuenta2` VARCHAR(50), `pestado` VARCHAR(30), `pobsv` TEXT)  BEGIN		
		INSERT INTO proveedor(nombre,ruc,dni,direccion,telefono,celular,email,cuenta1,cuenta2,estado,obsv)
		VALUES(pnombre,pruc,pdni,pdireccion,ptelefono,pcelular,pemail,pcuenta1,pcuenta2,pestado,pobsv);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Talla` (`pdescripcion` VARCHAR(100))  BEGIN		
		INSERT INTO talla(descripcion)
		VALUES(pdescripcion);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_TipoCambio` (`ptipocambio` DECIMAL(4,2))  BEGIN		
		INSERT INTO tipodocumento(tipocambio)
		VALUES(ptipocambio);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_TipoDocumento` (`pdescripcion` VARCHAR(80))  BEGIN		
		INSERT INTO tipodocumento(descripcion)
		VALUES(pdescripcion);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_TipoUsuario` (`pdescripcion` VARCHAR(80), `pp_venta` INT, `pp_compra` INT, `pp_producto` INT, `pp_proveedor` INT, `pp_empleado` INT, `pp_cliente` INT, `pp_categoria` INT, `pp_tipodoc` INT, `pp_tipouser` INT, `pp_anularv` INT, `pp_anularc` INT, `pp_estadoprod` INT, `pp_ventare` INT, `pp_ventade` INT, `pp_estadistica` INT, `pp_comprare` INT, `pp_comprade` INT, `pp_pass` INT, `pp_respaldar` INT, `pp_restaurar` INT, `pp_caja` INT)  BEGIN		
		INSERT INTO tipousuario(descripcion,p_venta,p_compra,p_producto,p_proveedor,p_empleado,p_cliente,p_categoria,p_tipodoc,p_tipouser,p_anularv,p_anularc,
		p_estadoprod,p_ventare,p_ventade,p_estadistica,p_comprare,p_comprade,p_pass,p_respaldar,p_restaurar,p_caja)
		VALUES(pdescripcion,pp_venta,pp_compra,pp_producto,pp_proveedor,pp_empleado,pp_cliente,pp_categoria,pp_tipodoc,pp_tipouser,pp_anularv,pp_anularc,
		pp_estadoprod,pp_ventare,pp_ventade,pp_estadistica,pp_comprare,pp_comprade,pp_pass,pp_respaldar,pp_restaurar,pp_caja);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Venta` (`pidtipodocumento` INT, `pidcliente` INT, `pidempleado` INT, `pserie` VARCHAR(5), `pnumero` VARCHAR(20), `pfecha` DATE, `ptotalventa` DECIMAL(8,2), `pigv` DECIMAL(8,2), `ptotalpagar` DECIMAL(8,2), `pestado` VARCHAR(30), `ppago` VARCHAR(30), `ppromo` VARCHAR(50), `pdescuento` DECIMAL(8,2), `preferencia` VARCHAR(30), `pttotal` DECIMAL(8,2))  BEGIN		
		INSERT INTO venta(idtipodocumento,idcliente,idempleado,serie,numero,fecha,totalventa,igv,totalpagar,estado,pago,promo,descuento,referencia,ttotal)
		VALUES(pidtipodocumento,pidcliente,pidempleado,pserie,pnumero,pfecha,ptotalventa,pigv,ptotalpagar,pestado,ppago,ppromo,pdescuento,preferencia,pttotal);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CANTIDAD_CATEGORIAS` ()  BEGIN
	select count(*) as cantidad_categoria from categoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CANTIDAD_COLORES` ()  BEGIN
	select count(*) as cantidad_colores from color;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CANTIDAD_COMPRAS` ()  BEGIN
	select count(*) as cantidad_compras from compra where Fecha like curdate();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CANTIDAD_PRODUCTOS` ()  BEGIN
	select count(*) as cantidad_producto from producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CANTIDAD_PROVEEDORES` ()  BEGIN
	select count(*) as cantidad_proveedores from proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CANTIDAD_TALLAS` ()  BEGIN
	select count(*) as cantidad_tallas from talla;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CANTIDAD_VENTAS` ()  BEGIN
	select count(*) as cantidad_ventas from venta where Fecha like curdate();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Categoria` ()  BEGIN
		SELECT * FROM categoria ORDER BY descripcion ASC;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CategoriaCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM categoria;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CategoriaIdMaximo` ()  BEGIN
		SELECT MAX(IdCategoria) AS Maximo FROM categoria;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CategoriaPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Cliente` ()  BEGIN
		SELECT * FROM cliente;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ClienteCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM cliente;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ClienteIdMaximo` ()  BEGIN
		SELECT MAX(IdCliente) AS Maximo FROM cliente;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ClientePorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN	
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Color` ()  BEGIN
		SELECT * FROM color ORDER BY descripcion ASC;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ColorCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM color;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ColorIdMaximo` ()  BEGIN
		SELECT MAX(IdColor) AS Maximo FROM color;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ColorPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
		IF pcriterio = "id" THEN		
			SET @sentencia = CONCAT("SELECT c.IdColor,c.Descripcion FROM color AS c WHERE c.IdColor=",pbusqueda," ORDER BY c.IdColor DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "descripcion" THEN
			SET @sentencia = CONCAT("SELECT c.IdColor,c.Descripcion FROM color AS c WHERE c.Descripcion LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY c.IdColor DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
		ELSE	
			SET @sentencia = CONCAT("SELECT c.IdColor,c.Descripcion FROM color AS c ORDER BY c.IdColor DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
		END IF; 
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Compra` ()  BEGIN
		SELECT c.IdCompra,td.Descripcion AS TipoDocumento,p.Nombre AS Proveedor,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,c.Numero,c.Fecha,c.SubTotal,c.Igv,c.Total,c.Estado
		FROM compra AS c
		INNER JOIN tipodocumento AS td ON c.IdTipoDocumento=td.IdTipoDocumento	 
		INNER JOIN proveedor AS p ON c.IdProveedor=p.IdProveedor		
		INNER JOIN empleado AS e ON c.IdEmpleado=e.IdEmpleado
		ORDER BY c.IdCompra;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CompraPorDetalle` (`pcriterio` VARCHAR(30), `pfechaini` DATE, `pfechafin` DATE)  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CompraPorFecha` (`pcriterio` VARCHAR(30), `pfechaini` DATE, `pfechafin` DATE, `pdocumento` VARCHAR(30))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CompraPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_COMPRA_TOTAL_DIARIA` ()  BEGIN
select sum(dc.Cantidad * dc.Precio) as total_compras from
	compra c inner join detallecompra dc on c.IdCompra = dc.IdCompra where c.Fecha like curdate();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_DetalleCompra` ()  BEGIN
		SELECT * FROM detallecompra;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_DetalleCompraPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
			IF pcriterio = "id" THEN
				SELECT dc.IdCompra,p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,dc.Cantidad,dc.Precio,dc.Total  FROM detallecompra AS dc
				INNER JOIN producto AS p ON dc.IdProducto=p.IdProducto
				WHERE dc.IdCompra=pbusqueda ORDER BY dc.IdCompra;
			
			END IF; 
			
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_DetalleVenta` ()  BEGIN
		SELECT * FROM detalleventa;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_DetalleVentaPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
			IF pcriterio = "id" THEN
				SELECT dv.IdVenta,p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,dv.Cantidad,dv.Precio,dv.Descuento,dv.Total  FROM detalleventa AS dv
				INNER JOIN producto AS p ON dv.IdProducto=p.IdProducto
				WHERE dv.IdVenta=pbusqueda ORDER BY dv.IdVenta;
			
			END IF; 
			
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Empleado` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_EmpleadoCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM empleado;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_EmpleadoIdMaximo` ()  BEGIN
		SELECT MAX(IdEmpleado) AS Maximo FROM empleado;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_EmpleadoPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
	
	
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_INGRESAR_SISTEMA` (`n_usuario` VARCHAR(20), `n_contrasena` TEXT)  BEGIN

select e.*, tu.Descripcion from empleado e inner join tipousuario tu 
	WHERE e.Usuario like n_usuario and e.Contrasena like MD5(n_contrasena);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Login` (`pusuario` VARCHAR(20), `pcontrasena` TEXT, `pdescripcion` VARCHAR(80))  BEGIN
	
		SELECT e.IdEmpleado,e.Nombre,e.Apellido,e.Sexo,e.FechaNac,e.Direccion,e.Telefono,e.Celular,e.Email,
		e.Dni,e.FechaIng,e.Sueldo,e.Estado,e.Usuario,e.Contrasena,tu.Descripcion
		FROM empleado AS e INNER JOIN tipousuario AS tu ON e.IdTipoUsuario = tu.IdTipoUsuario WHERE e.Usuario = pusuario AND e.`Contraseña` = pcontrasena AND tu.Descripcion=pdescripcion;
		
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_LoginPermisos` (`pnombre_usuario` VARCHAR(20), `pdescripcion_tipousuario` VARCHAR(80))  BEGIN
	
		SELECT tu.IdTipoUsuario,e.Usuario,tu.Descripcion,tu.p_venta,tu.p_compra,tu.p_producto,tu.p_proveedor,tu.p_empleado,tu.p_cliente,tu.p_categoria,tu.p_tipodoc,tu.p_tipouser,
		tu.p_anularv,tu.p_anularc,tu.p_estadoprod,tu.p_ventare,tu.p_ventade,tu.p_estadistica,tu.p_comprare,tu.p_comprade,tu.p_pass,tu.p_respaldar,tu.p_restaurar,tu.p_caja
		FROM tipousuario AS tu INNER JOIN empleado AS e ON tu.IdTipoUsuario = e.IdTipoUsuario WHERE e.Usuario = pnombre_usuario AND tu.Descripcion=pdescripcion_tipousuario;
		
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Producto` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(50))  BEGIN
	IF pcriterio = "id" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,p.IdCategoria,p.IdProveedor,p.IdColor,p.IdTalla
		FROM producto AS p WHERE p.IdProducto=pbusqueda;
	ELSEIF pcriterio = "codigo" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,p.IdCategoria,p.IdProveedor,p.IdColor,p.IdTalla
		FROM producto AS p WHERE p.Codigo=pbusqueda;
	ELSEIF pcriterio = "nombre" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,p.IdCategoria,p.IdProveedor,p.IdColor,p.IdTalla
		FROM producto AS p WHERE p.Nombre LIKE CONCAT("%",pbusqueda,"%");
	ELSEIF pcriterio = "descripcion" THEN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,p.IdCategoria,p.IdProveedor,p.IdColor,p.IdTalla
		FROM producto AS p WHERE p.Descripcion LIKE CONCAT("%",pbusqueda,"%");
	ELSE
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,p.IdCategoria,p.IdProveedor,p.IdColor,p.IdTalla
		FROM producto AS p;
	END IF; 
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ProductoActivo` ()  BEGIN
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS categoria
		FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria=c.IdCategoria WHERE p.Estado="Activo"
		ORDER BY p.IdProducto;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ProductoActivoPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(50))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ProductoCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM producto;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ProductoIdMaximo` ()  BEGIN
		SELECT MAX(IdProducto) AS Maximo FROM producto;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ProductoPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(50), `plimit` VARCHAR(50))  BEGIN		
		
	IF pcriterio = "id" THEN					
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria ,pr.Nombre AS Proveedor, cl.Descripcion AS Color, t.Descripcion AS Talla FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria INNER JOIN proveedor AS pr ON p.IdProveedor = pr.IdProveedor INNER JOIN color AS cl ON p.IdColor = cl.IdColor INNER JOIN talla AS t ON p.IdTalla = t.IdTalla  WHERE p.IdProducto=",pbusqueda," ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "codigo" THEN
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria ,pr.Nombre AS Proveedor, cl.Descripcion AS Color, t.Descripcion AS Talla FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria INNER JOIN proveedor AS pr ON p.IdProveedor = pr.IdProveedor INNER JOIN color AS cl ON p.IdColor = cl.IdColor INNER JOIN talla AS t ON p.IdTalla = t.IdTalla  WHERE p.Codigo=",pbusqueda," ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;				
		ELSEIF pcriterio = "nombre" THEN
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria ,pr.Nombre AS Proveedor, cl.Descripcion AS Color, t.Descripcion AS Talla FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria INNER JOIN proveedor AS pr ON p.IdProveedor = pr.IdProveedor INNER JOIN color AS cl ON p.IdColor = cl.IdColor INNER JOIN talla AS t ON p.IdTalla = t.IdTalla  WHERE p.Nombre LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;			
		ELSEIF pcriterio = "descripcion" THEN
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria ,pr.Nombre AS Proveedor, cl.Descripcion AS Color, t.Descripcion AS Talla FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria INNER JOIN proveedor AS pr ON p.IdProveedor = pr.IdProveedor INNER JOIN color AS cl ON p.IdColor = cl.IdColor INNER JOIN talla AS t ON p.IdTalla = t.IdTalla  WHERE p.Descripcion LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdProducto DESC ",plimit); 
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;		
		ELSEIF pcriterio = "categoria" THEN
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria ,pr.Nombre AS Proveedor, cl.Descripcion AS Color, t.Descripcion AS Talla FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria INNER JOIN proveedor AS pr ON p.IdProveedor = pr.IdProveedor INNER JOIN color AS cl ON p.IdColor = cl.IdColor INNER JOIN talla AS t ON p.IdTalla = t.IdTalla  WHERE c.Descripcion LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;

		ELSEIF pcriterio = "proveedor" THEN
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria ,pr.Nombre AS Proveedor, cl.Descripcion AS Color, t.Descripcion AS Talla FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria INNER JOIN proveedor AS pr ON p.IdProveedor = pr.IdProveedor INNER JOIN color AS cl ON p.IdColor = cl.IdColor INNER JOIN talla AS t ON p.IdTalla = t.IdTalla  WHERE pr.Nombre LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;		

		ELSEIF pcriterio = "color" THEN
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria ,pr.Nombre AS Proveedor, cl.Descripcion AS Color, t.Descripcion AS Talla FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria INNER JOIN proveedor AS pr ON p.IdProveedor = pr.IdProveedor INNER JOIN color AS cl ON p.IdColor = cl.IdColor INNER JOIN talla AS t ON p.IdTalla = t.IdTalla  WHERE cl.Descripcion LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;		

		ELSEIF pcriterio = "talla" THEN
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria ,pr.Nombre AS Proveedor, cl.Descripcion AS Color, t.Descripcion AS Talla FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria INNER JOIN proveedor AS pr ON p.IdProveedor = pr.IdProveedor INNER JOIN color AS cl ON p.IdColor = cl.IdColor INNER JOIN talla AS t ON p.IdTalla = t.IdTalla  WHERE t.Descripcion LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;									
		ELSE	
			SET @sentencia = CONCAT("SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria,pr.Nombre AS Proveedor, cl.Descripcion AS Color, t.Descripcion AS Talla FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria INNER JOIN proveedor AS pr ON p.IdProveedor = pr.IdProveedor INNER JOIN color AS cl ON p.IdColor = cl.IdColor INNER JOIN talla AS t ON p.IdTalla = t.IdTalla ORDER BY p.IdProducto DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
	END IF; 		
		
		
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ProductoVerificarCodigoBar` (`pbusqueda` VARCHAR(50))  BEGIN
	
		SELECT p.IdProducto,p.Codigo,p.Nombre,p.Descripcion,p.Stock,p.StockMin,p.PrecioCosto,p.PrecioVenta,p.Utilidad,p.Estado,p.Imagen,c.Descripcion AS Categoria
		FROM producto AS p INNER JOIN categoria AS c ON p.IdCategoria = c.IdCategoria
		WHERE p.Codigo=pbusqueda;

	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Promocion` ()  BEGIN
		SELECT * FROM promocion;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_PromocionCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM promocion;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_PromocionIdMaximo` ()  BEGIN
		SELECT MAX(IdPromocion) AS Maximo FROM promocion;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_PromocionPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
			
	IF pcriterio = "id" THEN		
			SET @sentencia = CONCAT("SELECT p.IdPromocion,p.Codigo,p.Descuento,p.Estado FROM promocion AS p WHERE p.IdPromocion=",pbusqueda," ORDER BY p.IdPromocion DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "codigo" THEN
			SET @sentencia = CONCAT("SELECT p.IdPromocion,p.Codigo,p.Descuento,p.Estado FROM promocion AS p WHERE p.Codigo LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY p.IdPromocion DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
		ELSE	
			SET @sentencia = CONCAT("SELECT p.IdPromocion,p.Codigo,p.Descuento,p.Estado FROM promocion AS p ORDER BY p.IdPromocion DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
	END IF; 

	
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Proveedor` ()  BEGIN
		SELECT * FROM proveedor ORDER BY Nombre;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ProveedorCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM proveedor;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ProveedorIdMaximo` ()  BEGIN
		SELECT MAX(IdProveedor) AS Maximo FROM proveedor;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ProveedorPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
	
	
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Talla` ()  BEGIN
		SELECT * FROM talla ORDER BY descripcion ASC;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TallaCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM talla;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TallaIdMaximo` ()  BEGIN
		SELECT MAX(IdTalla) AS Maximo FROM talla;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TallaPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
		IF pcriterio = "id" THEN		
			SET @sentencia = CONCAT("SELECT t.IdTalla,t.Descripcion FROM talla AS t WHERE t.IdTalla=",pbusqueda," ORDER BY t.IdTalla DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;
		ELSEIF pcriterio = "descripcion" THEN
			SET @sentencia = CONCAT("SELECT t.IdTalla,t.Descripcion FROM talla AS t WHERE t.Descripcion LIKE '",CONCAT("%",pbusqueda,"%"),"'"," ORDER BY t.IdTalla DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
		ELSE	
			SET @sentencia = CONCAT("SELECT t.IdTalla,t.Descripcion FROM talla AS t ORDER BY t.IdTalla DESC ",plimit);
			PREPARE consulta FROM @sentencia;
			EXECUTE consulta;	
		END IF; 
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TipoCambio` ()  BEGIN
		SELECT TipoCambio FROM tipocambio;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TipoCambioCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM tipocambio;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TipoCambioIdMaximo` ()  BEGIN
		SELECT MAX(IdTipoCambio) AS Maximo FROM tipocambio;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TipoCambioPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
			
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TipoDocumento` ()  BEGIN
		SELECT * FROM tipodocumento;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TipoDocumentoCantidadTotal` ()  BEGIN
		SELECT COUNT(*) as total FROM tipodocumento;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TipoDocumentoIdMaximo` ()  BEGIN
		SELECT MAX(IdTipoDocumento) AS Maximo FROM tipodocumento;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TipoDocumentoPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20), `plimit` VARCHAR(20))  BEGIN
			
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TipoUsuario` ()  BEGIN
		SELECT * FROM tipousuario;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_TipoUsuarioPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
	IF pcriterio = "id" THEN
		SELECT * FROM tipousuario AS tp WHERE tp.IdTipoUsuario=pbusqueda;
	ELSEIF pcriterio = "descripcion" THEN
		SELECT * FROM tipousuario AS tp WHERE tp.Descripcion LIKE CONCAT("%",pbusqueda,"%");
	ELSE
		SELECT * FROM tipousuario AS tp;
	END IF; 
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_UltimoIdCompra` ()  BEGIN
		SELECT MAX(IdCompra) AS id FROM compra;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_UltimoIdVenta` ()  BEGIN
		SELECT MAX(IdVenta) AS id FROM venta;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Venta` ()  BEGIN
		SELECT v.IdVenta,td.Descripcion AS TipoDocumento,c.Nombre AS Cliente,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,v.Serie,v.Numero,v.Fecha,v.TotalVenta,
		v.Igv,v.TotalPagar,v.Estado,v.Pago
		FROM venta AS v 
		INNER JOIN tipodocumento AS td ON v.IdTipoDocumento=td.IdTipoDocumento
		INNER JOIN cliente AS c ON v.IdCliente=c.IdCliente
		INNER JOIN empleado AS e ON v.IdEmpleado=e.IdEmpleado
		ORDER BY v.IdVenta;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_VentaMensual` (`pcriterio` VARCHAR(20), `pfecha_ini` VARCHAR(20), `pfecha_fin` VARCHAR(20))  BEGIN
			IF pcriterio = "consultar" THEN
			SELECT CONCAT(DAY(v.Fecha)," ",UPPER(MONTHNAME(v.Fecha))," ",YEAR(v.Fecha)) AS Fecha,SUM(v.TotalPagar) AS Total,
				ROUND((SUM(v.TotalPagar)*100)/(SELECT SUM(v.TotalPagar) AS TotalVenta FROM venta AS v WHERE ((date_format(v.Fecha,'%Y-%m') >= pfecha_ini) AND (date_format(v.Fecha,'%Y-%m') <= pfecha_fin)) AND v.Estado="EMITIDO")) AS Porcentaje
				FROM venta AS v
				WHERE ((date_format(v.Fecha,'%Y-%m') >= pfecha_ini) AND (date_format(v.Fecha,'%Y-%m') <= pfecha_fin)) AND v.Estado="EMITIDO" GROUP BY v.Fecha;			
								
			END IF; 
			

	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_VentaPorDetalle` (`pcriterio` VARCHAR(30), `pfechaini` DATE, `pfechafin` DATE)  BEGIN
		IF pcriterio = "consultar" THEN
			SELECT p.Codigo,p.Nombre AS Producto,c.Descripcion AS Categoria,dv.Costo,dv.Precio,
			SUM(dv.Cantidad) AS Cantidad,SUM(dv.Total) AS Total, SUM(v.TTotal) AS Total2,
			SUM(TRUNCATE((Total-(dv.Costo*dv.Cantidad)),2)) AS Ganancia FROM venta AS v
			INNER JOIN detalleventa AS dv ON v.IdVenta=dv.IdVenta
			INNER JOIN producto AS p ON dv.IdProducto=p.IdProducto
			INNER JOIN categoria AS c ON p.IdCategoria=c.IdCategoria
			WHERE (v.Fecha>=pfechaini AND v.Fecha<=pfechafin) AND v.Estado="EMITIDO" GROUP BY p.IdProducto
			ORDER BY v.IdVenta DESC;
		ELSEIF pcriterio = "EFECTIVO" THEN
			SELECT p.Codigo,p.Nombre AS Producto,c.Descripcion AS Categoria,dv.Costo,dv.Precio,
			SUM(dv.Cantidad) AS Cantidad,SUM(dv.Total) AS Total, SUM(v.TTotal) AS Total2,
			SUM(TRUNCATE((Total-(dv.Costo*dv.Cantidad)),2)) AS Ganancia FROM venta AS v
			INNER JOIN detalleventa AS dv ON v.IdVenta=dv.IdVenta
			INNER JOIN producto AS p ON dv.IdProducto=p.IdProducto
			INNER JOIN categoria AS c ON p.IdCategoria=c.IdCategoria
			WHERE (v.Fecha>=pfechaini AND v.Fecha<=pfechafin) AND v.Estado="EMITIDO" AND v.Pago="EFECTIVO" GROUP BY p.IdProducto
			ORDER BY v.IdVenta DESC;
		ELSEIF pcriterio = "TARJETA" THEN
			SELECT p.Codigo,p.Nombre AS Producto,c.Descripcion AS Categoria,dv.Costo,dv.Precio,
			SUM(dv.Cantidad) AS Cantidad,SUM(dv.Total) AS Total, SUM(v.TTotal) AS Total2,
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_VentaPorFecha` (`pcriterio` VARCHAR(30), `pfechaini` DATE, `pfechafin` DATE, `pdocumento` VARCHAR(30))  BEGIN
		IF pcriterio = "anular" THEN
			SELECT v.IdVenta,c.Nombre AS Cliente,v.Fecha,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,td.Descripcion AS TipoDocumento,v.Serie,v.Numero,
			v.Estado,V.Pago,v.TotalPagar  FROM venta AS v
			INNER JOIN tipodocumento AS td ON v.IdTipoDocumento=td.IdTipoDocumento
			INNER JOIN cliente AS c ON v.IdCliente=c.IdCliente
			INNER JOIN empleado AS e ON v.IdEmpleado=e.IdEmpleado
			WHERE (v.Fecha>=pfechaini AND v.Fecha<=pfechafin) AND td.Descripcion=pdocumento ORDER BY v.IdVenta DESC;
		
		ELSEIF pcriterio = "consultar" THEN	
			SELECT v.IdVenta,c.Nombre AS Cliente,v.Fecha,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,td.Descripcion AS TipoDocumento,v.Serie,v.Numero,
			v.Estado,v.Pago,v.Referencia,v.TotalVenta,v.Igv,v.Promo,v.Descuento,v.TotalPagar  FROM venta AS v 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_VentaPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
			IF pcriterio = "id" THEN
				SELECT v.IdVenta,td.Descripcion AS TipoDocumento,c.Nombre AS Cliente,CONCAT(e.Nombre," ",e.Apellido) AS Empleado,v.Serie,v.Numero,v.Fecha,v.TotalVenta,
				v.Igv,v.Promo,v.Descuento,v.TotalPagar,v.Estado  FROM venta AS v
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Venta_DetallePorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_VENTA_TOTAL_DIARIA` ()  BEGIN
	select sum(dv.Cantidad * dv.Precio) as total_ventas, sum(v.TTotal) AS Total2 from
	venta v inner join detalleventa dv on v.IdVenta = dv.IdVenta where v.Fecha like curdate();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_ActualizarCompraEstado` (`pidcompra` INT, `pestado` VARCHAR(30))  BEGIN
		UPDATE compra SET
			estado=pestado
		WHERE idcompra = pidcompra;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_ActualizarProductoStock` (`pidproducto` INT, `pstock` DECIMAL(8,2))  BEGIN
		UPDATE producto SET
			stock=pstock
		WHERE idproducto = pidproducto;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_ActualizarVentaEstado` (`pidventa` INT, `pestado` VARCHAR(30))  BEGIN
		UPDATE venta SET
			estado=pestado
		WHERE idventa = pidventa;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_CambiarPass` (`pidempleado` INT, `pcontrasena` TEXT)  BEGIN
		UPDATE empleado SET
			contrasena=pcontrasena
		WHERE idempleado = pidempleado;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Categoria` (`pidcategoria` INT, `pdescripcion` VARCHAR(100))  BEGIN
		UPDATE categoria SET
			descripcion=pdescripcion	
		WHERE idcategoria = pidcategoria;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Cliente` (`pidcliente` INT, `pnombre` VARCHAR(100), `pruc` VARCHAR(11), `pdni` VARCHAR(8), `pdireccion` VARCHAR(50), `ptelefono` VARCHAR(15), `pobsv` TEXT, `pusuario` VARCHAR(30), `pcontrasena` VARCHAR(10))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Color` (`pidcategoria` INT, `pdescripcion` VARCHAR(100))  BEGIN
		UPDATE color SET
			descripcion=pdescripcion	
		WHERE idcolor = pidcolor;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Compra` (`pidcompra` INT, `pidtipodocumento` INT, `pidproveedor` INT, `pidempleado` INT, `pnumero` VARCHAR(20), `pfecha` DATE, `psubtotal` DECIMAL(8,2), `pigv` DECIMAL(8,2), `ptotal` DECIMAL(8,2), `pestado` VARCHAR(30))  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_DetalleCompra` (`pidcompra` INT, `pidproducto` INT, `pcantidad` DECIMAL(8,2), `pprecio` DECIMAL(8,2), `ptotal` DECIMAL(8,2))  BEGIN
		UPDATE venta SET
			idcompra=pidcompra,
			idproducto=pidproducto,
			cantidad=pcantidad,
			precio=pprecio,
			total=ptotal
		WHERE idcompra = pidcompra;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_DetalleVenta` (`pidventa` INT, `pidproducto` INT, `pcantidad` DECIMAL(8,2), `pcosto` DECIMAL(8,2), `pprecio` DECIMAL(8,2), `pdescuento` DECIMAL(8,2), `ptotal` DECIMAL(8,2))  BEGIN
		UPDATE venta SET
			idventa=pidventa,
			idproducto=pidproducto,
			cantidad=pcantidad,
			costo=pcosto,
			precio=pprecio,
			descuento=pdescuento,
			total=ptotal
		WHERE idventa = pidventa;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Empleado` (`pidempleado` INT, `pnombre` VARCHAR(50), `papellido` VARCHAR(80), `psexo` VARCHAR(1), `pfechanac` DATE, `pdireccion` VARCHAR(100), `ptelefono` VARCHAR(10), `pcelular` VARCHAR(15), `pemail` VARCHAR(80), `pdni` VARCHAR(8), `pfechaing` DATE, `psueldo` DECIMAL(8,2), `pestado` VARCHAR(30), `pusuario` VARCHAR(20), `pcontrasena` TEXT, `pidtipousuario` INT)  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Producto` (`pidproducto` INT, `pcodigo` VARCHAR(50), `pnombre` VARCHAR(100), `pdescripcion` TEXT, `pstock` DECIMAL(8,2), `pstockmin` DECIMAL(8,2), `ppreciocosto` DECIMAL(8,2), `pprecioventa` DECIMAL(8,2), `putilidad` DECIMAL(8,2), `pestado` VARCHAR(30), `pimagen` VARCHAR(100), `pidcategoria` INT, `pidproveedor` INT, `pidcolor` INT, `pidtalla` INT)  BEGIN
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
			idcategoria=pidcategoria,
			idproveedor=pidproveedor,
			idcolor=pidcolor,
			idtalla=pidtalla
			
		WHERE idproducto = pidproducto;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Promocion` (`pidpromocion` INT, `pcodigo` VARCHAR(50), `pdescuento` DECIMAL(4,2), `pestado` VARCHAR(50))  BEGIN
		UPDATE promocion SET
			codigo=pcodigo,
			descuento=pdescuento,
			estado=pestado	
		WHERE idpromocion = pidpromocion;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Proveedor` (`pidproveedor` INT, `pnombre` VARCHAR(100), `pruc` VARCHAR(11), `pdni` VARCHAR(8), `pdireccion` VARCHAR(100), `ptelefono` VARCHAR(10), `pcelular` VARCHAR(15), `pemail` VARCHAR(80), `pcuenta1` VARCHAR(50), `pcuenta2` VARCHAR(50), `pestado` VARCHAR(30), `pobsv` TEXT)  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Talla` (`pidcategoria` INT, `pdescripcion` VARCHAR(100))  BEGIN
		UPDATE talla SET
			descripcion=pdescripcion	
		WHERE idtalla = pidtalla;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_TipoCambio` (`pidtipocambio` INT, `ptipocambio` DECIMAL(4,2))  BEGIN
		UPDATE tipocambio SET
			tipocambio=ptipocambio	
		WHERE idtipocambio = pidtipocambio;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_TipoDocumento` (`pidtipodocumento` INT, `pdescripcion` VARCHAR(80))  BEGIN
		UPDATE tipodocumento SET
			descripcion=pdescripcion	
		WHERE idtipodocumento = pidtipodocumento;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_TipoUsuario` (`pidtipousuario` INT, `pdescripcion` VARCHAR(80), `pp_venta` INT, `pp_compra` INT, `pp_producto` INT, `pp_proveedor` INT, `pp_empleado` INT, `pp_cliente` INT, `pp_categoria` INT, `pp_tipodoc` INT, `pp_tipouser` INT, `pp_anularv` INT, `pp_anularc` INT, `pp_estadoprod` INT, `pp_ventare` INT, `pp_ventade` INT, `pp_estadistica` INT, `pp_comprare` INT, `pp_comprade` INT, `pp_pass` INT, `pp_respaldar` INT, `pp_restaurar` INT, `pp_caja` INT)  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Venta` (`pidventa` INT, `pidtipodocumento` INT, `pidcliente` INT, `pidempleado` INT, `pserie` VARCHAR(5), `pnumero` VARCHAR(20), `pfecha` DATE, `ptotalventa` DECIMAL(8,2), `pigv` DECIMAL(8,2), `ptotalpagar` DECIMAL(8,2), `pestado` VARCHAR(30))  BEGIN
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
CREATE DEFINER=`root`@`localhost` FUNCTION `DiaEnLetras` (`pfecha` DATE) RETURNS VARCHAR(10) CHARSET latin1 BEGIN
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
(1, 'General'),
(2, 'Bloqueador'),
(3, 'Esencia'),
(4, 'Repelente'),
(5, 'Cremas'),
(6, 'Shampoo'),
(7, 'Jabón '),
(8, 'Zacate'),
(9, 'Desodorante'),
(10, 'Serum'),
(11, 'Exfoliante'),
(12, 'Gel'),
(13, 'Bolso'),
(14, 'Cubrelactancia'),
(15, 'Babero Bandana'),
(16, 'Almohada'),
(17, 'Repetidor'),
(18, 'Cojín Estrella'),
(19, 'Cojín Nube'),
(20, 'Cojín Luna'),
(21, 'Funda Cambiador'),
(22, 'Juego de Sabanas'),
(23, 'Protector'),
(24, 'Cobija'),
(25, 'Banderines'),
(26, 'Bolsa para Pañales'),
(27, 'Cambiador'),
(28, 'Cesta'),
(29, 'Cesta Cuadrada'),
(30, 'Cesta Grande'),
(31, 'Cesta Pañales'),
(32, 'Cubre Carreola'),
(33, 'Estuche Impermeable'),
(34, 'Estuche Para Mudas'),
(35, 'Portachupón'),
(36, 'Set Pelotas'),
(37, 'Tapete Decorativo'),
(38, 'Tapete Impermeable'),
(39, 'Toallas'),
(40, 'Cojin Lactancia'),
(41, 'Cartera Para Bebes'),
(42, 'Funda Cojin Lactancia'),
(43, 'Organizador de Cuna'),
(44, 'Pinzas'),
(45, 'Baberos'),
(46, 'Vajilla'),
(47, 'Lentes'),
(48, 'Termo'),
(49, 'Camiseta Manga Corta'),
(50, 'Leggins'),
(51, 'Camiseta Manga Larga'),
(52, 'Pañalero Manga Larga'),
(53, 'Sudadera'),
(54, 'Vestido Manga Corta'),
(55, 'Short'),
(56, 'Pants'),
(57, 'Jumpsuit'),
(58, 'Chaleco'),
(59, 'Pañalero Sin Mangas'),
(60, 'Mameluco'),
(61, 'Vestido Manga Larga'),
(62, 'Conjunto'),
(63, 'Pantalón'),
(64, 'Palia cate'),
(65, 'Diadema'),
(66, 'Frazada'),
(67, 'Playera Polo Manga Larga'),
(68, 'Player Polo Manga Corta'),
(69, 'Blusa Polo Manga Larga'),
(70, 'Blusa Polo Manga Corta'),
(71, 'Kit 5 Piezas'),
(72, 'Kit Casita'),
(73, 'Pañalero Manga Corta'),
(74, 'Pantufla'),
(75, 'Kit Ternura');

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
-- Estructura de tabla para la tabla `color`
--

CREATE TABLE `color` (
  `IdColor` int(11) NOT NULL,
  `Descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `color`
--

INSERT INTO `color` (`IdColor`, `Descripcion`) VALUES
(1, 'SIN COLOR'),
(2, 'CITRONELA'),
(3, 'CIRUELA DULCE'),
(4, 'NEUTRO'),
(5, 'LAVANDA'),
(6, 'ALGAS MARINAS Y ROMERO'),
(7, 'ARBOL DE TE'),
(8, 'CARBON ACTIVADO'),
(9, 'MIEL'),
(10, 'RAYITAS KHAKI'),
(11, 'ESTRELLITAS GRAFITO'),
(12, 'BALLENAS/BLANCO'),
(13, 'CEBRAS AZUL'),
(14, 'CHEVRON AQUA'),
(15, 'CHEVRON GRIS'),
(16, 'CONFETTI GRIS'),
(17, 'PINGUINOS'),
(18, 'ELEFANTES ROSA'),
(19, 'ESTRELLITAS NEGRAS'),
(20, 'ZAPATILLAS'),
(21, 'RAYITAS GRAFITO'),
(22, 'RAYAS GRIS'),
(23, 'BLANCO'),
(24, 'BUHOS ROSA'),
(25, 'CHEVRON ROSA'),
(26, 'Estrellas Azul'),
(27, 'Puntos Gris'),
(28, 'Rayitas Rosas'),
(29, 'Cohetes'),
(30, 'Confetti Rosa'),
(31, 'Elefantes Gris'),
(32, 'Gris'),
(33, 'Rayas Rosa'),
(34, 'Rayas Celeste'),
(35, 'Beige'),
(36, 'Puntos Rosa'),
(37, 'Confetti Azul'),
(38, 'White Wall'),
(39, 'Medusa'),
(40, 'Pingüino Azul'),
(41, 'Tortuga'),
(42, 'Pajarito Pia'),
(43, 'Buho Huula'),
(44, 'Mapache Rocco'),
(45, 'Buho Azul'),
(46, 'Botella Leche'),
(47, 'Espirales de Colores'),
(48, 'Elefante Estrellas'),
(49, 'Amarillo y Verde'),
(50, 'Rojo y Azul'),
(51, 'Bolitas'),
(52, 'Oveja'),
(53, 'Varios'),
(54, 'Pulpo'),
(55, 'Vaca'),
(56, 'Bamboo Natural Realistic'),
(57, 'Bamboo Natural Eclectic'),
(58, 'Bamboo Natural/Azul'),
(59, 'Bamboo Natural/Aqua'),
(60, 'Bamboo Natural/Negro'),
(61, 'Bamboo Natural'),
(62, 'Calavera'),
(63, 'White XoXo'),
(64, 'Super Xolo Negro'),
(65, 'Super Dog Gray'),
(66, 'Xoy'),
(67, 'Hug'),
(68, 'SkateBoard'),
(69, 'Be Your Self'),
(70, 'Azul'),
(71, 'Heart Blue'),
(72, 'Heart White'),
(73, 'Skate'),
(74, 'Striped'),
(75, 'Coral Rayas'),
(76, 'Rojo Helados'),
(77, 'Verde Helados'),
(78, 'Crema Mangos'),
(79, 'Coral Mangos'),
(80, 'Rojo Mangos'),
(81, 'Limon Con Gusanito'),
(82, 'Agua de Limon'),
(83, 'Beige Limonada'),
(84, 'Verde'),
(85, 'Toronja'),
(86, 'Picnic'),
(87, 'Species Pink'),
(88, 'Species Blue'),
(89, 'Octopus'),
(90, 'Pink Coral'),
(91, 'Whale Shark Azul'),
(92, 'Whale Shark Pink'),
(93, 'Ocean'),
(94, 'Limonada'),
(95, 'Conejos Gris'),
(96, 'Conejos Rosa'),
(97, 'Waves Rosa'),
(98, 'Ocean Blue'),
(99, 'Ocean Pink'),
(100, 'Blowfish Pink'),
(101, 'Blowfish Blue'),
(102, 'Mostaza Limonada'),
(103, 'Verde Limonada'),
(104, 'Mostaza Gotas'),
(105, 'Gotas Coral'),
(106, 'Gotas Verde'),
(107, 'Gajos Gris'),
(108, 'Gajos Coral'),
(109, 'Rojo Sandia'),
(110, 'Sandia Oxford'),
(111, 'Paleta Verde'),
(112, 'Wall Pink'),
(113, 'Wall Gray'),
(114, 'Rescue Dog White'),
(115, 'Rojo/Blanco'),
(116, 'Café/Crema'),
(117, 'Rojo'),
(118, 'Amarillo'),
(119, 'Rosa'),
(120, 'Celeste'),
(121, 'Crema'),
(122, 'Menta'),
(123, 'Maiz'),
(124, 'Lila'),
(125, 'Fucsia'),
(126, 'Coral'),
(127, 'Café'),
(128, 'Azul Rey'),
(129, 'Organico'),
(130, 'Verde Agua'),
(131, 'Chango Café '),
(132, 'Hipopotamo Menta'),
(133, 'Coneja Rosa'),
(134, 'Pajaritos'),
(135, 'Africa'),
(136, 'Calaca');

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
  `Descuento` decimal(8,2) DEFAULT '0.00',
  `Total` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalleventa`
--

INSERT INTO `detalleventa` (`IdVenta`, `IdProducto`, `Cantidad`, `Costo`, `Precio`, `Descuento`, `Total`) VALUES
(3, 575, '1.00', '69.00', '159.00', '0.00', '159.00'),
(4, 275, '1.00', '600.00', '899.00', '0.00', '899.00'),
(4, 473, '1.00', '129.00', '219.00', '0.00', '219.00'),
(4, 44, '1.00', '168.20', '260.00', '0.00', '260.00');

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
(1, 'Gustavo', 'Rosas', 'M', '1987-04-27', '', '', '9981113869', 'goldem64@yahoo.com.mx', '', '2018-10-01', '25000.00', 'ACTIVO', 'goldem64', 'c3581516868fb3b71746931cac66390e', 1),
(2, 'Ileana', 'Romo', 'F', '1987-08-02', '', '', '5540443249', 'ileana@pequescloset.com', '', '2018-11-23', '0.00', 'ACTIVO', 'ileana', 'ed3d69342f0bf72f502c763813ab0162', 1),
(3, 'Francisco', 'Fuentes', 'M', '1986-01-17', '', '', '5543572192', 'arq.franciscofuentes@gmail.com', '', '2018-11-23', '0.00', 'ACTIVO', 'francisco', '1e6fd1695d7a0a635762703c1485ec31', 1),
(7, 'Marbella', 'Aburto', 'F', '1958-02-10', '', '5523244127', '5523244127', 'marbella@pequescloset.com', '', '2018-11-28', '0.00', 'ACTIVO', 'marbella', 'f9d0c8b70e7231b42a9f9adade43b741', 1),
(8, 'Vendedor', 'General', 'M', '2018-11-29', '', '', '', '', '', '2018-11-29', '0.00', 'ACTIVO', 'vendedor', '0407e8c8285ab85509ac2884025dcf42', 2);

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
  `IdCategoria` int(11) NOT NULL,
  `IdProveedor` int(11) DEFAULT '1',
  `IdColor` int(11) DEFAULT '1',
  `IdTalla` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`IdProducto`, `Codigo`, `Nombre`, `Descripcion`, `Stock`, `StockMin`, `PrecioCosto`, `PrecioVenta`, `Utilidad`, `Estado`, `Imagen`, `IdCategoria`, `IdProveedor`, `IdColor`, `IdTalla`) VALUES
(1, '0130031000002', 'Repelente de Mosquitos', 'Repelente de mosquitos para niños de citronela', '5.00', '1.00', '120.69', '185.00', '64.31', 'ACTIVO', '', 4, 2, 2, 1),
(2, '0130041000003', 'Crema Humectante de Ciruela Dulce', 'Crema Humectante de Ciruela Dulce', '3.00', '1.00', '189.66', '285.00', '95.34', 'ACTIVO', '', 5, 2, 3, 1),
(3, '0130014000000', 'Bloqueador Solar FPS 50', 'Bloqueador Solar FPS 50', '4.00', '1.00', '168.10', '255.00', '86.90', 'ACTIVO', '', 2, 2, 1, 1),
(4, '0130021000001', 'Brisa Dulces Sueños Lavanda', 'Brisa Dulces Sueños - Esencia de Lavanda.\r\n', '5.00', '1.00', '293.10', '410.00', '116.90', 'ACTIVO', '', 3, 2, 1, 1),
(5, '0130051000003', 'Shampoo Ultra Suave', 'Shampoo súper suave de ciruela dulce.\r\n', '2.00', '1.00', '193.97', '290.00', '96.03', 'ACTIVO', '', 6, 2, 1, 1),
(6, '0130061000004', 'Jabon Neutro', 'Jabón artesanal a base de aceite de oliva y coco.', '4.00', '1.00', '44.83', '70.00', '25.17', 'ACTIVO', '', 7, 2, 1, 1),
(7, '0130072000000', 'Zacate Corporal', 'Zacate Corporal Estrella', '1.00', '0.00', '125.00', '190.00', '65.00', 'ACTIVO', '', 8, 2, 1, 1),
(8, '0130033000002', 'Repelente de Mosquitos', 'Repelente de Mosquitos para adulto Citronela', '4.00', '1.00', '150.86', '230.00', '79.14', 'ACTIVO', '', 4, 2, 2, 1),
(9, '0130083000000', 'Desodorante Cristal', 'Desodorante Cristal ', '1.00', '0.00', '181.03', '270.00', '88.97', 'ACTIVO', '', 9, 2, 1, 1),
(10, '0130062000005', 'Jabon en Barra', 'Jabón en Barra de Algas Marinas y Romero', '1.00', '0.00', '44.83', '70.00', '25.17', 'ACTIVO', '', 7, 2, 6, 1),
(11, '0130062000006', 'Jabon en Barra', 'Jabón En Barra de Árbol de Te\r\n', '1.00', '0.00', '44.83', '70.00', '25.17', 'ACTIVO', '', 7, 2, 7, 1),
(12, '0130063000007', 'Jabon en Barra', 'Jabón de Carbón Activado\r\n', '1.00', '0.00', '51.72', '80.00', '28.28', 'ACTIVO', '', 7, 2, 8, 1),
(13, '0130093200008', 'Serum Contorno de Ojos', 'Serum Contorno de Ojos Miel\r\n', '1.00', '0.00', '275.86', '390.00', '114.14', 'ACTIVO', '', 10, 2, 9, 1),
(14, '0130103000008', 'Exfoliante Facial', 'Exfoliante Facial Miel\r\n', '1.00', '0.00', '159.48', '240.00', '80.52', 'ACTIVO', '', 11, 2, 9, 1),
(15, '0130113000000', 'Gel Control de Imperfecciones', 'Gel Control de Imperfecciones\r\n', '1.00', '0.00', '185.34', '280.00', '94.66', 'ACTIVO', '', 12, 2, 1, 1),
(16, '0220124000009', 'Bolso Ligero', 'Bolso Ligero Rayitas Khaki\r\n', '1.00', '0.00', '313.20', '440.00', '126.80', 'ACTIVO', '', 13, 3, 10, 1),
(17, '0260134000010', 'CubreLactancia Estrellas Grafito ', 'CubreLactancia Estrellas Grafito \r\n', '1.00', '0.00', '219.24', '330.00', '110.76', 'ACTIVO', '', 14, 3, 11, 1),
(18, '0260134000011', 'CubreLactancia Ballenas Blanco', 'CubreLactancia Ballenas Blanco\r\n', '1.00', '0.00', '219.24', '330.00', '110.76', 'ACTIVO', '', 14, 3, 12, 1),
(19, '0220141100012', 'Babero Bandana Cebras Azul', 'Babero Bandana Cebras Azul\r\n', '1.00', '0.00', '71.92', '90.00', '18.08', 'ACTIVO', '', 15, 3, 13, 1),
(20, '0220141000013', 'Babero Bandana Chevron Aqua', 'Babero Bandana Chevron Aqua\r\n', '1.00', '0.00', '71.92', '110.00', '38.08', 'ACTIVO', '', 15, 3, 14, 1),
(21, '0220141000014', 'Babero Bandana Chevron Gris', 'Babero Bandana Chevron Gris\r\n', '1.00', '0.00', '71.92', '110.00', '38.08', 'ACTIVO', '', 15, 3, 15, 1),
(22, '0220141000015', 'Babero Bandana Confetti Gris', 'Babero Bandana Confetti Gris\r\n', '1.00', '0.00', '71.92', '110.00', '38.08', 'ACTIVO', '', 15, 3, 16, 1),
(23, '0220141000016', 'Babero Bandana Pinguinos', 'Babero Bandana Pinguinos\r\n', '1.00', '0.00', '71.92', '110.00', '38.08', 'ACTIVO', '', 15, 3, 17, 1),
(24, '0220141200017', 'Babero Bandana Elefantes Rosas', 'Babero Bandana Elefantes Rosas\r\n', '1.00', '0.00', '71.92', '110.00', '38.08', 'ACTIVO', '', 15, 3, 18, 1),
(25, '0220141100018', 'Babero Bandana Estrellitas Negras', 'Babero Bandana Estrellitas Negras\r\n', '1.00', '0.00', '71.92', '110.00', '38.08', 'ACTIVO', '', 15, 3, 19, 1),
(26, '0220141200019', 'Babero Bandana Zapatillas', 'Babero Bandana Zapatillas\r\n', '1.00', '0.00', '71.92', '110.00', '38.08', 'ACTIVO', '', 15, 3, 20, 1),
(27, '0220141000020', 'Babero Bandana Rayitas Grafito', 'Babero Bandana Rayitas Grafito\r\n', '1.00', '0.00', '71.92', '110.00', '38.08', 'ACTIVO', '', 15, 3, 21, 1),
(28, '0220141000021', 'Babero Bandana Rayas Gris', 'Babero Bandana Rayas Gris\r\n', '1.00', '0.00', '71.92', '110.00', '38.08', 'ACTIVO', '', 15, 3, 22, 1),
(29, '0250151000022', 'Almohada Decorativa', 'Almohada Decorativa Blanco\r\n', '2.00', '0.00', '98.60', '150.00', '51.40', 'ACTIVO', '', 16, 3, 23, 1),
(30, '0220161200023', 'Repetidor Buhos Rosa', 'Repetidor Buhos Rosa\r\n', '1.00', '0.00', '84.10', '130.00', '45.90', 'ACTIVO', '', 17, 3, 24, 1),
(31, '0220161200024', 'Repetidor Chevron Rosa', 'Repetidor Chevron Rosa\r\n', '1.00', '0.00', '84.10', '130.00', '45.90', 'ACTIVO', '', 17, 3, 25, 1),
(32, '0220161000016', 'Repetidor Pinguinos', 'Repetidor Pinguinos\r\n', '1.00', '0.00', '84.10', '130.00', '45.90', 'ACTIVO', '', 17, 3, 17, 1),
(33, '0220161100012', 'Repetidor Cebras Azul', 'Repetidor Cebras Azul\r\n', '1.00', '0.00', '84.10', '130.00', '45.90', 'ACTIVO', '', 17, 3, 13, 1),
(34, '0220161200017', 'Repetidor Elefantes Rosa', 'Repetidor Elefantes Rosa\r\n', '1.00', '0.00', '84.10', '130.00', '45.90', 'ACTIVO', '', 17, 3, 18, 1),
(35, '0220161100025', 'Repetidor Estrellas Azul', 'Repetidor Estrellas Azul\r\n', '1.00', '0.00', '84.10', '130.00', '45.90', 'ACTIVO', '', 17, 3, 26, 1),
(36, '0220161000014', 'Repetidor Chevron Gris', 'Repetidor Chevron Gris\r\n', '1.00', '0.00', '84.10', '130.00', '45.90', 'ACTIVO', '', 17, 3, 15, 1),
(37, '0220161000026', 'Repetidor Puntos Gris', 'Repetidor Puntos Gris\r\n', '1.00', '0.00', '84.10', '130.00', '45.90', 'ACTIVO', '', 17, 3, 27, 1),
(38, '0220161200027', 'Repetidor Rayitas Rosas', 'Repetidor Rayitas Rosas\r\n', '1.00', '0.00', '84.10', '130.00', '45.90', 'ACTIVO', '', 17, 3, 28, 1),
(39, '0250174100028', 'Cojin Estrella Cohetes', 'Cojin Estrella Cohetes\r\n', '1.00', '0.00', '168.20', '260.00', '91.80', 'ACTIVO', '', 18, 3, 29, 1),
(40, '0250174200017', 'Cojin Estrella Elefantes Rosa', 'Cojin Estrella Elefantes Rosa\r\n', '1.00', '0.00', '168.20', '260.00', '91.80', 'ACTIVO', '', 18, 3, 18, 1),
(41, '0250184000021', 'Cojin Luna Rayas Gris', 'Cojin Luna Rayas Gris\r\n', '1.00', '0.00', '168.20', '260.00', '91.80', 'ACTIVO', '', 20, 3, 22, 1),
(42, '0250194000020', 'Cojin Nube Rayitas Grafito', 'Cojin Nube Rayitas Grafito\r\n', '1.00', '0.00', '168.20', '260.00', '91.80', 'ACTIVO', '', 19, 3, 21, 1),
(43, '0250201000010', 'Funda Para Cambiador', 'Funda Para Cambiador Estrellas Grafito\r\n', '1.00', '0.00', '191.40', '290.00', '98.60', 'ACTIVO', '', 21, 3, 11, 1),
(44, '0250194200029', 'Cojin Nube Confetti Rosa', 'Cojin Nube Confetti Rosa\r\n', '0.00', '0.00', '168.20', '260.00', '91.80', 'ACTIVO', '', 19, 3, 30, 1),
(45, '0250201000030', 'Funda Para Cambiador', 'Funda Para Cambiador Elefantes Gris\r\n', '1.00', '0.00', '191.40', '290.00', '98.60', 'ACTIVO', '', 21, 3, 31, 1),
(46, '0250211101018', 'Juegos de Sabanas', 'Juegos de Sabanas Para Cama Cuna Estrellas Negras\r\n', '1.00', '0.00', '395.56', '600.00', '204.44', 'ACTIVO', '', 22, 3, 19, 3),
(47, '0250221101018', 'Protector (Bumper)', 'Protector (Bumper) Estrellas Negras\r\n', '1.00', '0.00', '730.80', '1100.00', '369.20', 'ACTIVO', '', 23, 3, 19, 3),
(48, '0250231100018', 'Cobija Ligera', 'Cobija Ligera Estrellas Negras\r\n', '1.00', '0.00', '219.24', '330.00', '110.76', 'ACTIVO', '', 24, 3, 19, 1),
(49, '0250231100012', 'Cobija Ligera', 'Cobija Ligera Cebras Azul\r\n', '1.00', '0.00', '219.24', '330.00', '110.76', 'ACTIVO', '', 24, 3, 13, 1),
(50, '0250231000016', 'Cobija Ligera ', 'Cobija Ligera Pingüino\r\n', '1.00', '0.00', '219.24', '330.00', '110.76', 'ACTIVO', '', 24, 3, 17, 1),
(51, '0250231200017', 'Cobija Ligera', 'Cobija Ligera Elefantes Rosa\r\n', '1.00', '0.00', '219.24', '330.00', '110.76', 'ACTIVO', '', 24, 3, 18, 1),
(52, '0250231000013', 'Cobijita de Apego', 'Cobijita de Apego Chevron Gris\r\n', '1.00', '0.00', '98.60', '150.00', '51.40', 'ACTIVO', '', 24, 3, 15, 1),
(53, '0210241000031', 'Banderines', 'Banderines Gris\r\n', '2.00', '0.00', '208.80', '300.00', '91.20', 'ACTIVO', '', 25, 3, 32, 1),
(54, '0220251000014', 'Bolsa Para Pañales', 'Bolsa Para Pañales Chevron Gris\r\n', '1.00', '0.00', '84.68', '130.00', '45.32', 'ACTIVO', '', 26, 3, 15, 1),
(55, '0220251000013', 'Bolsa Para Pañales', 'Bolsa Para Pañales Chevron Aqua\r\n', '1.00', '0.00', '84.68', '130.00', '45.32', 'ACTIVO', '', 26, 3, 131, 1),
(56, '0220251200027', 'Bolsa Para Pañales', 'Bolsa Para Pañales Rayitas Rosas\r\n', '1.00', '0.00', '84.68', '130.00', '45.32', 'ACTIVO', '', 26, 3, 28, 1),
(57, '0220124000018', 'Bolso Ligero', 'Bolso Ligero Estrellitas Negras\r\n', '1.00', '0.00', '313.20', '440.00', '126.80', 'ACTIVO', '', 13, 3, 19, 1),
(58, '0260134200023', 'CubreLactancia Buhos Rosa', 'CubreLactancia Buhos Rosa\r\n', '1.00', '0.00', '219.24', '330.00', '110.76', 'ACTIVO', '', 14, 3, 24, 1),
(59, '0220271200023', 'Cambiador Portatil', 'Cambiador Portátil Búhos Rosa\r\n', '1.00', '0.00', '168.20', '260.00', '91.80', 'ACTIVO', '', 27, 3, 24, 1),
(60, '0220271000020', 'Cambiador Portátil', 'Cambiador Portátil Rayitas Grafito\r\n', '1.00', '0.00', '168.20', '260.00', '91.80', 'ACTIVO', '', 27, 3, 21, 1),
(61, '0220284000010', 'Cesta Organizadora', 'Cesta Organizadora Estrellitas Grafito\r\n', '1.00', '0.00', '104.40', '160.00', '55.60', 'ACTIVO', '', 28, 3, 11, 1),
(62, '0220284100025', 'Cesta Organizadora', 'Cesta Organizadora Estrellas Azul\r\n', '1.00', '0.00', '104.40', '160.00', '55.60', 'ACTIVO', '', 28, 3, 26, 1),
(63, '0220284100018', 'Cesta Organizadora', 'Cesta Organizadora Estrellitas Negras\r\n', '1.00', '0.00', '104.40', '160.00', '55.60', 'ACTIVO', '', 28, 3, 19, 1),
(64, '0220284100028', 'Cesta Organizadora', 'Cesta Organizadora Cohetes\r\n', '1.00', '0.00', '104.40', '160.00', '55.60', 'ACTIVO', '', 28, 3, 29, 1),
(65, '0220294000010', 'Cesta Organizadora Cuadrada', 'Cesta Organizadora Cuadrada Estrellitas Grafito\r\n', '1.00', '0.00', '145.00', '220.00', '75.00', 'ACTIVO', '', 29, 3, 11, 1),
(66, '02202894100025', 'Cesta Organizadora Cuadrada', 'Cesta Organizadora Cuadrada Estrellas Azul\r\n', '1.00', '0.00', '145.00', '220.00', '75.00', 'ACTIVO', '', 29, 3, 26, 1),
(67, '0220294000026', 'Cesta Organizadora Cuadrada', 'Cesta Organizadora Cuadrada Puntos Gris\r\n', '1.00', '0.00', '145.00', '220.00', '75.00', 'ACTIVO', '', 29, 3, 27, 1),
(68, '0220304202027', 'Cesta Organizadora Grande', 'Cesta Organizadora Grande Rayitas Rosas\r\n', '1.00', '0.00', '145.00', '220.00', '75.00', 'ACTIVO', '', 30, 3, 28, 1),
(69, '0220304002030', 'Cesta Organizadora Grande', 'Cesta Organizadora Grande Elefantes Gris\r\n', '1.00', '0.00', '145.00', '220.00', '75.00', 'ACTIVO', '', 30, 3, 31, 1),
(70, '0220304002010', 'Cesta Organizadora Grande', 'Cesta Organizadora Grande Estrellitas Grafito\r\n', '1.00', '0.00', '145.00', '220.00', '75.00', 'ACTIVO', '', 30, 3, 11, 1),
(71, '0220304002009', 'Cesta Organizadora Grande', 'Cesta Organizadora Grande Rayitas Khaki\r\n', '1.00', '0.00', '145.00', '220.00', '75.00', 'ACTIVO', '', 30, 3, 10, 1),
(72, '0220311200032', 'Cesta para Pañales', 'Cesta para Pañales Rayas Rosas\r\n', '1.00', '0.00', '191.40', '290.00', '98.60', 'ACTIVO', '', 31, 3, 33, 1),
(73, '0220311000010', 'Cesta para Pañales', 'Cesta para Pañales Estrellitas Grafito\r\n', '1.00', '0.00', '191.40', '290.00', '98.60', 'ACTIVO', '', 31, 3, 11, 1),
(74, '0220321100011', 'Cubre Carreola', 'Cubre Carreola Ballenas Blanco\r\n', '1.00', '0.00', '266.80', '399.00', '132.20', 'ACTIVO', '', 32, 3, 12, 1),
(75, '0220321200023', 'Cubre Carreola', 'Cubre Carreola Buhos Rosa\r\n', '1.00', '0.00', '266.80', '399.00', '132.20', 'ACTIVO', '', 32, 3, 24, 1),
(76, '220321000016', 'Cubre Carreola', 'Cubre Carreola Pingüinos\r\n', '1.00', '0.00', '266.80', '399.00', '132.20', 'ACTIVO', '', 32, 3, 17, 1),
(77, '0220331100011', 'Estuche Impermeable', 'Estuche Impermeable Ballenas Blanco\r\n', '1.00', '0.00', '95.12', '149.00', '53.88', 'ACTIVO', '', 33, 3, 12, 1),
(78, '0220331200023', 'Estuche Impermeable', 'Estuche Impermeable Búhos Rosa\r\n', '1.00', '0.00', '95.12', '149.00', '53.88', 'ACTIVO', '', 33, 3, 24, 1),
(79, '0220331000013', 'Estuche Impermeable', 'Estuche Impermeable Chevron Aqua\r\n', '1.00', '0.00', '95.12', '149.00', '53.88', 'ACTIVO', '', 33, 3, 14, 1),
(80, '0220331000026', 'Estuche Impermeable', 'Estuche Impermeable Puntos Gris\r\n', '1.00', '0.00', '95.12', '149.00', '53.88', 'ACTIVO', '', 33, 3, 27, 1),
(81, '0220341100012', 'Estuche Para Mudas', 'Estuche Para Mudas Cebras Azul\r\n', '1.00', '0.00', '156.60', '239.00', '82.40', 'ACTIVO', '', 34, 3, 13, 1),
(82, '0220341000016', 'Estuche Para Mudas', 'Estuche Para Mudas Pingüinos\r\n\r\n', '1.00', '0.00', '156.60', '239.00', '82.40', 'ACTIVO', '', 34, 3, 17, 1),
(83, '0220341200019', 'Estuche Para Mudas', 'Estuche Para Mudas Zapatillas\r\n', '1.00', '0.00', '156.60', '239.00', '82.40', 'ACTIVO', '', 34, 3, 20, 1),
(84, '0220351100033', 'Portachupon', 'Portachupon Rayas Celeste\r\n', '1.00', '0.00', '49.88', '79.00', '29.12', 'ACTIVO', '', 35, 3, 34, 1),
(85, '0220351000020', 'Portachupon', 'Portachupon Rayitas Grafito\r\n', '1.00', '0.00', '49.88', '79.00', '29.12', 'ACTIVO', '', 35, 3, 21, 1),
(86, '0220351200027', 'Portachupon', 'Portachupon Rayitas Rosas\r\n', '1.00', '0.00', '49.88', '79.00', '29.12', 'ACTIVO', '', 35, 3, 28, 1),
(87, '0220351100018', 'Portachupon', 'Portachupon Estrellitas Negras\r\n', '1.00', '0.00', '49.88', '79.00', '29.12', 'ACTIVO', '', 35, 3, 19, 1),
(88, '0220351200024', 'Portachupon', 'Portachupon Chevron Rosa\r\n', '1.00', '0.00', '49.88', '79.00', '29.12', 'ACTIVO', '', 35, 3, 25, 1),
(89, '0270361200023', 'Set de Pelotas Didacticas', 'Set de Pelotas Didácticas Búhos Rosa\r\n', '1.00', '0.00', '133.40', '199.00', '65.60', 'ACTIVO', '', 36, 3, 24, 1),
(90, '0270361000020', 'Set de Pelotas Didacticas', 'Set de Pelotas Didácticas Rayitas Grafito\r\n', '1.00', '0.00', '133.40', '199.00', '65.60', 'ACTIVO', '', 36, 3, 21, 1),
(91, '0220371000013', 'Tapete Decorativo', 'Tapete Decorativo Chevron Aqua\r\n', '1.00', '0.00', '423.40', '639.00', '215.60', 'ACTIVO', '', 37, 3, 14, 1),
(92, '0220384100018', 'Tapete Impermeable', 'Tapete Impermeable Estrellitas Negras\r\n', '1.00', '0.00', '330.60', '499.00', '168.40', 'ACTIVO', '', 38, 3, 19, 1),
(93, '0250391203022', 'Set de 3 Toallitas', 'Set de 3 Toallitas Blanco Niña\r\n', '2.00', '0.00', '164.72', '249.00', '84.28', 'ACTIVO', '', 39, 3, 23, 1),
(94, '0250391003034', 'Set de 3 Toallitas', 'Set de 3 Toallitas Beige Unisex\r\n', '1.00', '0.00', '164.72', '249.00', '84.28', 'ACTIVO', '', 39, 3, 35, 1),
(95, '0250221004031', 'Protector (Bumper)', 'Protector (Bumper) Moises/Colecho Gris\r\n', '1.00', '0.00', '595.08', '899.00', '303.92', 'ACTIVO', '', 23, 3, 32, 7),
(96, '0250391003022', 'Set de 3 Toallitas', 'Set de 3 Toallitas Unisex Blanco\r\n', '1.00', '0.00', '164.72', '249.00', '84.28', 'ACTIVO', '', 39, 3, 23, 1),
(97, '0250211004016', 'Juegos de Sabanas', 'Juegos de Sabanas Para Moisés/Colecho Pingüinos\r\n', '1.00', '0.00', '334.08', '499.00', '164.92', 'ACTIVO', '', 22, 3, 17, 7),
(98, '0260401100028', 'Cojin de Lactancia', 'Cojin de Lactancia Cohetes\r\n', '1.00', '0.00', '397.88', '599.00', '201.12', 'ACTIVO', '', 40, 3, 29, 1),
(99, '0260401200023', 'Cojin de Lactancia', 'Cojín de Lactancia Búhos Rosa\r\n', '1.00', '0.00', '397.88', '599.00', '201.12', 'ACTIVO', '', 40, 3, 24, 1),
(100, '0260401100011', 'Cojin de Lactancia', 'Cojín de Lactancia\r\n', '1.00', '0.00', '397.88', '599.00', '201.12', 'ACTIVO', '', 40, 3, 12, 1),
(101, '0220161000030', 'Repetidor', 'Repetidor Elefantes Gris\r\n', '1.00', '0.00', '84.10', '129.00', '44.90', 'ACTIVO', '', 17, 3, 31, 1),
(102, '0220411000010', 'Cartera Para Bebes', 'Cartera Para Bebes Estrellitas Grafito \r\n', '1.00', '0.00', '219.24', '329.00', '109.76', 'ACTIVO', '', 41, 3, 11, 1),
(103, '0250231000014', 'Cobija Ligera', 'Cobija Ligera Chevron Gris\r\n', '1.00', '0.00', '219.24', '329.00', '109.76', 'ACTIVO', '', 24, 3, 15, 1),
(104, '0260421200017', 'Funda Para Cojin de Lactancia', 'Funda Para Cojín de Lactancia Elefantes Gris\r\n', '1.00', '0.00', '191.40', '289.00', '97.60', 'ACTIVO', '', 42, 3, 31, 1),
(105, '0260421000030', 'Funda Para Cojin de Lactancia', 'Funda Para Cojín de Lactancia Elefantes Rosa\r\n', '1.00', '0.00', '191.40', '289.00', '97.60', 'ACTIVO', '', 42, 3, 18, 1),
(106, '0250184100025', 'Cojin Luna Estrellas Azul', 'Cojín Luna Estrellas Azul\r\n', '1.00', '0.00', '168.20', '260.00', '91.80', 'ACTIVO', '', 20, 3, 26, 1),
(107, '0250201200027', 'Funda Para Cambiador', 'Funda Para Cambiador Rayitas Rosas\r\n', '1.00', '0.00', '191.40', '289.00', '97.60', 'ACTIVO', '', 21, 3, 28, 1),
(108, '0260421000016', 'Funda Para Cojin de Lactancia', 'Funda Para Cojín de Lactancia Pingüinos\r\n', '1.00', '0.00', '191.40', '289.00', '97.60', 'ACTIVO', '', 42, 3, 17, 1),
(109, '0220431100018', 'Organizador de Cuna', 'Organizador de Cuna Estrellitas Negras\r\n', '1.00', '0.00', '156.60', '239.00', '82.40', 'ACTIVO', '', 43, 3, 19, 1),
(110, '0220284200027', 'Cesta Organizadora', 'Cesta Organizadora Rayitas Rosas\r\n', '1.00', '0.00', '104.40', '160.00', '55.60', 'ACTIVO', '', 28, 3, 28, 1),
(111, '0260134100012', 'Cubre Lactancia', 'Cubre Lactancia Cebras Azul\r\n', '1.00', '0.00', '197.32', '330.00', '132.68', 'ACTIVO', '', 14, 3, 13, 1),
(112, '0220161200035', 'Repetidor', 'Repetidor Puntos Rosas\r\n', '1.00', '0.00', '75.69', '130.00', '54.31', 'ACTIVO', '', 17, 3, 36, 1),
(113, '0220161000030', 'Repetidor', 'Repetidor Elefantes Gris\r\n', '1.00', '0.00', '75.69', '130.00', '54.31', 'ACTIVO', '', 17, 3, 31, 1),
(114, '0220161200029', 'Repetidor', 'Repetidor Confetti Rosa\r\n', '1.00', '0.00', '75.69', '130.00', '54.31', 'ACTIVO', '', 17, 3, 30, 1),
(115, '0220161000015', 'Repetidor', 'Repetidor Confetti Gris\r\n', '1.00', '0.00', '75.69', '130.00', '54.31', 'ACTIVO', '', 17, 3, 95, 1),
(116, '0220161100036', 'Repetidor', 'Repetidor Confetti Azul\r\n', '1.00', '0.00', '75.69', '130.00', '54.31', 'ACTIVO', '', 17, 3, 37, 1),
(117, '0220351100036', 'Portachupon', 'Portachupón Confetti Azul\r\n', '1.00', '0.00', '44.89', '79.00', '34.11', 'ACTIVO', '', 35, 3, 37, 1),
(118, '0220351000015', 'Portachupon', 'Portachupon Confetti Gris\r\n', '1.00', '0.00', '44.89', '79.00', '34.11', 'ACTIVO', '', 35, 3, 16, 1),
(119, '0220351000014', 'Portachupon', 'Portachupon Chevron Gris\r\n', '1.00', '0.00', '44.89', '79.00', '34.11', 'ACTIVO', '', 35, 3, 15, 1),
(120, '0220351200029', 'Portachupon', 'Portachupon Confetti Rosa\r\n', '1.00', '0.00', '44.89', '79.00', '34.11', 'ACTIVO', '', 35, 3, 30, 1),
(121, '0250231000013', 'Cobijita de Apego', 'Cobijita de Apego Chevron Aqua\r\n', '1.00', '0.00', '88.74', '150.00', '61.26', 'ACTIVO', '', 24, 3, 14, 1),
(122, '0250201000014', 'Funda Para Cambiador', 'Funda Para Cambiador Chevron Gris\r\n', '1.00', '0.00', '172.26', '290.00', '117.74', 'ACTIVO', '', 21, 3, 15, 1),
(123, '0250201100012', 'Funda Para Cambiador', 'Funda Para Cambiador Cebras Azul\r\n', '1.00', '0.00', '172.26', '290.00', '117.74', 'ACTIVO', '', 21, 3, 13, 1),
(124, '0250201000030', 'Funda Para Cambiador', 'Funda Para Cambiador Elefantes Gris\r\n', '1.00', '0.00', '172.26', '290.00', '117.74', 'ACTIVO', '', 21, 3, 31, 1),
(125, '0250201200029', 'Funda Para Cambiador', 'Funda Para Cambiador Confetti Rosa\r\n', '1.00', '0.00', '172.26', '290.00', '117.74', 'ACTIVO', '', 21, 3, 30, 1),
(126, '0220161000026', 'Repetidor', 'Repetidor Puntos Gris\r\n', '1.00', '0.00', '75.69', '130.00', '54.31', 'ACTIVO', '', 17, 3, 27, 1),
(127, '0260134200024', 'CubreLactancia', 'CubreLactancia Chevron Rosa\r\n', '1.00', '0.00', '197.32', '330.00', '132.68', 'ACTIVO', '', 14, 3, 25, 1),
(128, '0250231200023', 'Cobija Ligera', 'Cobija Ligera Búhos Rosa\r\n', '1.00', '0.00', '197.32', '329.00', '131.68', 'ACTIVO', '', 24, 3, 24, 1),
(129, '0250231000030', 'Cobija Ligera', 'Cobija Ligera Elefantes Gris\r\n', '1.00', '0.00', '197.32', '329.00', '131.68', 'ACTIVO', '', 24, 3, 31, 1),
(130, '0250231100028', 'Cobija Ligera', 'Cobija Ligera Cohetes\r\n', '1.00', '0.00', '197.32', '329.00', '131.68', 'ACTIVO', '', 24, 3, 29, 1),
(131, '0250231200024', 'Cobija Ligera', 'Cobija Ligera Chevron Rosa\r\n', '1.00', '0.00', '197.32', '329.00', '131.68', 'ACTIVO', '', 24, 3, 25, 1),
(132, '0250231000014', 'Cobija Ligera', 'Cobija Ligera Chevron Gris\r\n', '1.00', '0.00', '197.32', '329.00', '131.68', 'ACTIVO', '', 24, 3, 15, 1),
(133, '0220411000014', 'Cartera Para Bebes', 'Cartera Para Bebes Chevron Gris\r\n', '1.00', '0.00', '197.32', '329.00', '131.68', 'ACTIVO', '', 41, 3, 15, 1),
(134, '0250391000014', 'Toalla Para Bebe', 'Toalla Para Bebé Chevron Gris\r\n', '1.00', '0.00', '271.44', '399.00', '127.56', 'ACTIVO', '', 39, 3, 15, 1),
(135, '0250391000026', 'Toalla Para Bebe', 'Toalla Para Bebe Puntos Gris\r\n', '1.00', '0.00', '271.44', '399.00', '127.56', 'ACTIVO', '', 39, 3, 27, 1),
(136, '0220141000014', 'Babero Bandana Chevron Gris', 'Babero Bandana\r\n', '1.00', '0.00', '64.73', '109.00', '44.27', 'ACTIVO', '', 15, 3, 15, 1),
(137, '0220141200024', 'Babero Bandana', 'Babero Bandana Chevron Rosa\r\n', '1.00', '0.00', '64.73', '109.00', '44.27', 'ACTIVO', '', 15, 3, 25, 1),
(138, '0220141000030', 'Babero Bandana Elefantes Gris', 'Babero Bandana', '1.00', '0.00', '64.73', '109.00', '44.27', 'ACTIVO', '', 15, 3, 31, 1),
(139, '0220141000021', 'Babero Bandana', 'Babero Bandana Rayas Gris\r\n', '1.00', '0.00', '64.73', '109.00', '44.27', 'ACTIVO', '', 15, 3, 22, 1),
(140, '0350391200038', 'Toalla Con Gorro', 'Toalla Con Gorro Medusa\r\n', '3.00', '0.00', '446.60', '669.00', '222.40', 'ACTIVO', '', 39, 4, 39, 1),
(141, '0350391100039', 'Toalla Con Gorro', 'Toalla Con Gorro Pingüino Azul\r\n', '3.00', '0.00', '446.60', '669.00', '222.40', 'ACTIVO', '', 39, 4, 40, 1),
(142, '0350391000040', 'Toalla Con Gorro Tortuga', 'Toalla Con Gorro\r\n', '3.00', '0.00', '446.60', '669.00', '222.40', 'ACTIVO', '', 39, 4, 41, 1),
(143, '0350231000041', 'Muselina', 'Muselina Pajarito Pia\r\n', '1.00', '0.00', '446.60', '669.00', '222.40', 'ACTIVO', '', 24, 4, 42, 1),
(144, '0350231000042', 'Muselina', 'Muselina Búho Huula\r\n', '1.00', '0.00', '446.60', '669.00', '222.40', 'ACTIVO', '', 24, 4, 43, 1),
(145, '0350231000043', 'Muselina', 'Muselina Mapache Rocco\r\n', '1.00', '0.00', '446.60', '669.00', '222.40', 'ACTIVO', '', 24, 4, 44, 1),
(146, '0350231000044', 'Muselina', 'Muselina Búho Azul\r\n', '1.00', '0.00', '446.60', '669.00', '222.40', 'ACTIVO', '', 24, 4, 45, 1),
(147, '0350231000045', 'Muselina', 'Muselina Botella Leche\r\n', '2.00', '0.00', '446.60', '669.00', '222.40', 'ACTIVO', '', 24, 4, 46, 1),
(148, '0350231000046', 'Muselina', 'Muselina Espirales de Colores\r\n', '1.00', '0.00', '446.60', '669.00', '222.40', 'ACTIVO', '', 24, 4, 47, 1),
(149, '0350231000047', 'Muselina', 'Muselina Elefante Estrellas\r\n', '2.00', '0.00', '446.00', '669.00', '223.00', 'ACTIVO', '', 24, 4, 48, 1),
(150, '0320441000048', 'Kit de 4 Pinzas Para Carreola', 'Kit de 4 Pinzas Para Carreola Amarillo y Verde\r\n', '1.00', '0.00', '219.24', '329.00', '109.76', 'ACTIVO', '', 44, 4, 49, 1),
(151, '0320441000049', 'Kit de 4 Pinzas Para Carreola', 'Kit de 4 Pinzas Para Carreola Rojo y Azul\r\n', '1.00', '0.00', '219.24', '109.62', '-109.62', 'ACTIVO', '', 44, 4, 50, 1),
(152, '0350211217050', 'Set de Sabanas', 'Set de Sabanas Para Cuna Bolitas\r\n', '1.00', '0.00', '649.60', '979.00', '329.40', 'ACTIVO', '', 22, 4, 51, 20),
(153, '0350211017051', 'Set de Sabanas', 'Set de Sabanas Para Cuna Oveja\r\n', '1.00', '0.00', '649.60', '979.00', '329.40', 'ACTIVO', '', 22, 4, 52, 20),
(154, '0320451000051', 'Babero Bamboo', 'Babero Bamboo Oveja\r\n', '3.00', '1.00', '93.50', '139.00', '45.50', 'ACTIVO', '', 45, 4, 52, 1),
(155, '0320451000050', 'Babero Bamboo', 'Babero Bamboo Bolitas\r\n', '3.00', '1.00', '93.50', '139.00', '45.50', 'ACTIVO', '', 45, 4, 52, 1),
(156, '0320451000133', 'Babero Bamboo', 'Babero Bamboo Pajaritos', '3.00', '1.00', '93.50', '139.00', '45.50', 'ACTIVO', '', 45, 4, 134, 1),
(157, '0320451000134', 'Babero Bamboo Africa', 'Babero Bamboo Africa\r\n', '3.00', '1.00', '93.50', '139.00', '45.50', 'ACTIVO', '', 45, 4, 135, 1),
(158, '0320461000053', 'Vajilla Infantil Fibre de Bamboo 5 Piezas', 'Vajilla Infantil Fibre de Bamboo 5 Piezas Pulpo\r\n', '1.00', '0.00', '406.00', '609.00', '203.00', 'ACTIVO', '', 46, 4, 54, 1),
(159, '0320461000053', 'Vajilla Infantil Fibre de Bamboo 5 Piezas', 'Vajilla Infantil Fibre de Bamboo 5 Piezas Vaca\r\n', '1.00', '0.00', '406.00', '609.00', '203.00', 'ACTIVO', '', 46, 4, 55, 1),
(160, '0320472000055', 'Lentes de Sol ', 'Lentes de Sol Realistic Bamboo Natural Realistic\r\n', '1.00', '0.00', '893.20', '1339.00', '445.80', 'ACTIVO', '', 47, 4, 56, 1),
(161, '0320472000056', 'Lentes de Sol Eclectic ', 'Lentes de Sol Eclectic Bamboo Natural Eclectic\r\n', '1.00', '0.00', '893.20', '1339.00', '445.80', 'ACTIVO', '', 47, 4, 57, 1),
(162, '0320473000057', 'Lentes de Sol Funk Bamboo', 'Lentes de Sol Funk Bamboo Natural/Azul\r\n', '1.00', '0.00', '389.76', '589.00', '199.24', 'ACTIVO', '', 47, 4, 58, 1),
(163, '0320473000058', 'Lentes de Sol Funk Bamboo', 'Lentes de Sol Funk Bamboo Natural/Aqua\r\n', '2.00', '1.00', '389.76', '589.00', '199.24', 'ACTIVO', '', 47, 4, 59, 1),
(164, '0320473000059', 'Lentes de Sol Aviador Bamboo Natural/Negro', 'Lentes de Sol Aviador Bamboo Natural/Negro\r\n', '1.00', '0.00', '389.76', '589.00', '199.24', 'ACTIVO', '', 47, 4, 60, 1),
(165, '0320484000060', 'Termo de Bamboo', 'Termo de Bamboo Natural\r\n', '1.00', '0.00', '406.00', '609.00', '203.00', 'ACTIVO', '', 48, 4, 61, 1),
(166, '0440511109037', 'White Wall Tee', 'White Wall Tee 12M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 51, 5, 38, 12),
(167, '0440511111037', 'White Wall Tee', 'White Wall Tee 24M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 51, 5, 38, 12),
(168, '0440512112037', 'White Wall Tee', 'White Wall Tee 36M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 51, 5, 38, 15),
(169, '0440511107061', 'Calaca Tee 6M', 'Calaca Tee 6M', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 51, 5, 136, 10),
(170, '0440511109061', 'Calaca Tee 12M', 'Calaca Tee 12M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 51, 5, 136, 12),
(171, '0440511111061', 'Calaca Tee 24M', 'Calaca Tee 24M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 51, 5, 136, 14),
(172, '0440512112061', 'Calaca Tee 36M', 'Calaca Tee 36M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 51, 6, 136, 15),
(173, '0440511106062', 'White XoXo Tee 3M', 'White XoXo Tee 3M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 51, 5, 63, 9),
(174, '0440511107062', 'White XoXo Tee 6M', 'White XoXo Tee 6M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 51, 5, 63, 10),
(175, '0440511109062', 'White XoXo Tee 12M', 'White XoXo Tee 12M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 51, 5, 63, 12),
(176, '0440511111062', 'White XoXo Tee 24M', 'White XoXo Tee 24M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 51, 5, 63, 14),
(177, '0440512112062', 'White XoXo Tee 36M', 'White XoXo Tee 36M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 51, 5, 63, 15),
(178, '0440501006063', 'Leggins Super Xolo Negro 3M', 'Leggins Super Xolo Negro 3M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 50, 5, 64, 9),
(179, '0440501007063', 'Leggins Super Xolo Negro 6M', 'Leggins Super Xolo Negro 6M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 50, 5, 64, 10),
(180, '0440501009063', 'Leggins Super Xolo Negro 12M', 'Leggins Super Xolo Negro 12M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 50, 5, 64, 12),
(181, '0440501011063', 'Leggins Super Xolo Negro 24M', 'Leggins Super Xolo Negro 24M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 50, 6, 64, 14),
(182, '0440502012063', 'Leggins Super Xolo Negro 36M', 'Leggins Super Xolo Negro 36M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 50, 5, 64, 15),
(183, '0440521106064', 'Super Dog Gray Body 3M', 'Super Dog Gray Body 3M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 52, 5, 65, 9),
(184, '0440521107064', 'Super Dog Gray Body 6M', 'Super Dog Gray Body 6M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 52, 5, 65, 10),
(185, '0440521109064', 'Super Dog Gray Body 12M', 'Super Dog Gray Body 12M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 52, 5, 65, 12),
(186, '0440521105065', 'Xoy Body 0M', 'Xoy Body 0M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 52, 5, 66, 8),
(187, '0440521106065', 'Xoy Body 3M', 'Xoy Body 3M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 52, 5, 66, 9),
(188, '0440521107065', 'Xoy Body 6M', 'Xoy Body 6M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 52, 5, 66, 10),
(189, '0440521109065', 'Xoy Body 12M', 'Xoy Body 12M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 52, 5, 66, 12),
(190, '0440521206066', 'Hug Body 3M', 'Hug Body 3M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 52, 5, 67, 9),
(191, '0440521207066', 'Hug Body 6M', 'Hug Body 6M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 52, 5, 67, 10),
(192, '0440521209066', 'Hug Body 12M', 'Hug Body 12M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 52, 5, 67, 12),
(193, '0440511207066', 'Hug Tee 3M', 'Hug Tee 3M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 51, 5, 67, 10),
(194, '0440511209066', 'Hug Tee 12M', 'Hug Tee 12M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 51, 5, 67, 12),
(195, '0440511211066', 'Hug Tee 24M', 'Hug Tee 24M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 51, 5, 67, 14),
(196, '0440512212066', 'Hug Tee 36M', 'Hug Tee 36M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 51, 5, 67, 15),
(197, '0440531007037', 'Wall Sweatshirt 6M', 'Wall Sweatshirt 6M\r\n', '1.00', '0.00', '275.00', '419.00', '144.00', 'ACTIVO', '', 53, 5, 38, 10),
(198, '0440531009037', 'Wall Sweatshirt 12M', 'Wall Sweatshirt 12M\r\n', '1.00', '0.00', '275.00', '419.00', '144.00', 'ACTIVO', '', 53, 5, 38, 12),
(199, '0440531011037', 'Wall Sweatshirt 24M', 'Wall Sweatshirt 24M\r\n', '1.00', '0.00', '275.00', '419.00', '144.00', 'ACTIVO', '', 53, 5, 38, 14),
(200, '0440532012037', 'Wall Sweatshirt 36M', 'Wall Sweatshirt 36M\r\n', '1.00', '0.00', '275.00', '419.00', '144.00', 'ACTIVO', '', 53, 5, 38, 15),
(201, '0440541209066', 'Hug Dress 12M', 'Hug Dress 12M', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 54, 5, 67, 12),
(202, '0440541211066', 'Hug Dress 24M', 'Hug Dress 24M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 54, 5, 67, 14),
(203, '0440542212066', 'Hug Dress 36M', 'Hug Dress 36M\r\n', '1.00', '0.00', '195.00', '299.00', '104.00', 'ACTIVO', '', 54, 5, 67, 15),
(204, '0440491109067', 'SkateBoard Tee 12M', 'SkateBoard Tee 12M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 49, 5, 68, 12),
(205, '0440491111067', 'SkateBoard Tee 24M', 'SkateBoard Tee 24M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 49, 5, 68, 14),
(206, '0440492112067', 'SkateBoard Tee 36M', 'SkateBoard Tee 36M\r\n', '1.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 49, 5, 68, 15),
(207, '0440491109068', 'Be Your Self Tee 12M', 'Be Your Self Tee 12M\r\n', '1.00', '0.00', '200.00', '299.00', '99.00', 'ACTIVO', '', 49, 5, 69, 12),
(208, '0440491111068', 'Be Your Self Tee 24M', 'Be Your Self Tee 24M\r\n', '1.00', '0.00', '200.00', '299.00', '99.00', 'ACTIVO', '', 51, 5, 69, 14),
(209, '0440492112068', 'Be Your Self Tee 36M', 'Be Your Self Tee 36M\r\n', '1.00', '0.00', '200.00', '299.00', '99.00', 'ACTIVO', '', 27, 5, 69, 15),
(210, '0440551106067', 'SkateBoard Short 3M', 'SkateBoard Short 3M\r\n', '2.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 55, 5, 68, 9),
(211, '0440551107067', 'SkateBoard Short 6M', 'SkateBoard Short 6M\r\n', '2.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 55, 5, 68, 10),
(212, '0440551109067', 'SkateBoard Short 12M', 'SkateBoard Short 12M\r\n', '2.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 55, 5, 68, 12),
(213, '0440561106069', 'Blue Pants 3M', 'Blue Pants 3M\r\n', '1.00', '0.00', '240.00', '359.00', '119.00', 'ACTIVO', '', 56, 5, 70, 9),
(214, '0440561107069', 'Blue Pants 6M', 'Blue Pants 6M\r\n', '1.00', '0.00', '240.00', '359.00', '119.00', 'ACTIVO', '', 56, 5, 70, 10),
(215, '0440561109069', 'Blue Pants 12M', 'Blue Pants 12M\r\n', '1.00', '0.00', '240.00', '359.00', '119.00', 'ACTIVO', '', 56, 5, 70, 12),
(216, '0440561111069', 'Blue Pants 24M', 'Blue Pants 24M\r\n', '1.00', '0.00', '240.00', '359.00', '119.00', 'ACTIVO', '', 56, 5, 70, 14),
(217, '0440562112069', 'Blue Pants 36M', 'Blue Pants 36M\r\n', '1.00', '0.00', '240.00', '359.00', '119.00', 'ACTIVO', '', 56, 5, 70, 15),
(218, '0440542212069', 'Blue Dress 36M', 'Blue Dress 36M\r\n', '2.00', '0.00', '210.00', '319.00', '109.00', 'ACTIVO', '', 54, 5, 70, 15),
(219, '0440541206070', 'Heart Dress Blue 3M', 'Heart Dress Blue 3M\r\n', '1.00', '0.00', '260.00', '399.00', '139.00', 'ACTIVO', '', 54, 5, 71, 9),
(220, '0440541207070', 'Heart Dress Blue 6M ', 'Heart Dress Blue 6M \r\n', '1.00', '0.00', '260.00', '399.00', '139.00', 'ACTIVO', '', 54, 5, 71, 10),
(221, '0440541209070', 'Heart Dress Blue 12M', 'Heart Dress Blue 12M\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nHeart Dress Blue 12M\r\n\r\n', '1.00', '0.00', '260.00', '399.00', '139.00', 'ACTIVO', '', 54, 5, 71, 12),
(222, '0440541206071', 'Heart Dress White 3M', 'Heart Dress White 3M\r\n', '1.00', '0.00', '260.00', '399.00', '139.00', 'ACTIVO', '', 54, 5, 72, 9),
(223, '0440541207071', 'Heart Dress White 6M', 'Heart Dress White 6M\r\n', '1.00', '0.00', '260.00', '399.00', '139.00', 'ACTIVO', '', 54, 5, 72, 10),
(224, '0440541209071', 'Heart Dress White 12M', 'Heart Dress White 12M\r\n', '1.00', '0.00', '260.00', '399.00', '139.00', 'ACTIVO', '', 54, 5, 72, 12),
(225, '0440571106072', 'Skate Jumpsuit 3M', 'Skate Jumpsuit 3M\r\n', '3.00', '1.00', '225.00', '339.00', '114.00', 'ACTIVO', '', 57, 5, 73, 9),
(226, '0440571107072', 'Skate Jumpsuit 6M ', 'Skate Jumpsuit 6M \r\n', '4.00', '1.00', '225.00', '339.00', '114.00', 'ACTIVO', '', 57, 5, 73, 10),
(227, '0440571109072', 'Skate Jumpsuit 12M', 'Skate Jumpsuit 12M\r\n', '2.00', '0.00', '225.00', '339.00', '114.00', 'ACTIVO', '', 57, 5, 73, 12),
(228, '0440581109073', 'Striped Vest 12M', 'Striped Vest 12M\r\n', '1.00', '0.00', '295.00', '449.00', '154.00', 'ACTIVO', '', 58, 5, 74, 12),
(229, '0440581111073', 'Striped Vest 24M', 'Striped Vest 24M\r\n', '1.00', '0.00', '295.00', '449.00', '154.00', 'ACTIVO', '', 58, 5, 74, 14),
(230, '0440582112073', 'Striped Vest 36M', 'Striped Vest 36M\r\n', '1.00', '0.00', '295.00', '449.00', '154.00', 'ACTIVO', '', 31, 5, 74, 15),
(231, '0440501207074', 'Leggins Coral Rayas 6M', 'Leggins Coral Rayas 6M\r\n', '1.00', '0.00', '117.25', '179.00', '61.75', 'ACTIVO', '', 50, 5, 75, 10),
(232, '0440591106075', 'Pañalero Rojo Helados Sin Mangas 3M', 'Pañalero Rojo Helados Sin Mangas 3M\r\n', '1.00', '0.00', '113.75', '179.00', '65.25', 'ACTIVO', '', 59, 5, 76, 9),
(233, '0440591109075', 'Pañalero Rojo Helados Sin Mangas 12M', 'Pañalero Rojo Helados Sin Mangas 12M\r\n', '1.00', '0.00', '113.75', '179.00', '65.25', 'ACTIVO', '', 59, 5, 76, 12),
(234, '0440541207076', 'Vestido Verde Helado 6M', 'Vestido Verde Helado 6M\r\n', '1.00', '0.00', '122.50', '189.00', '66.50', 'ACTIVO', '', 54, 5, 77, 10),
(235, '0440541209076', 'Vestido Verde Helado 12M', 'Vestido Verde Helado 12M\r\n', '1.00', '0.00', '122.50', '189.00', '66.50', 'ACTIVO', '', 54, 5, 77, 12),
(236, '0440541211076', 'Vestido Verde Helado 24M', 'Vestido Verde Helado 24M\r\n', '2.00', '0.00', '122.50', '189.00', '66.50', 'ACTIVO', '', 54, 5, 77, 14),
(237, '0440501207077', 'Leggins Crema Mangos 6M', 'Leggins Crema Mangos 6M\r\n', '2.00', '0.00', '117.50', '179.00', '61.50', 'ACTIVO', '', 50, 5, 78, 10),
(238, '0440501207078', 'Leggins Coral Mangos 6M', 'Leggins Coral Mangos 6M\r\n', '1.00', '0.00', '117.50', '179.00', '61.50', 'ACTIVO', '', 50, 5, 79, 10),
(239, '0440501209078', 'Leggins Coral Mangos 12M', 'Leggins Coral Mangos 12M\r\n', '2.00', '0.00', '117.50', '179.00', '61.50', 'ACTIVO', '', 50, 6, 79, 12),
(240, '0440501211078', 'Leggins Coral Mangos 24M', 'Leggins Coral Mangos 24M\r\n', '1.00', '0.00', '117.50', '179.00', '61.50', 'ACTIVO', '', 50, 5, 79, 14),
(241, '0440541209079', 'Vestido Rojo Mangos 12M', 'Vestido Rojo Mangos 12M\r\n', '1.00', '0.00', '105.60', '189.00', '83.40', 'ACTIVO', '', 54, 5, 80, 12),
(242, '0440541211079', 'Vestido Rojo Mangos 24M', 'Vestido Rojo Mangos 24M\r\n', '2.00', '0.00', '105.60', '189.00', '83.40', 'ACTIVO', '', 54, 6, 80, 14),
(243, '0440601009080', 'Mameluco Limón con Gusanito 12M', 'Mameluco Limón con Gusanito 12M\r\n', '1.00', '0.00', '192.00', '299.00', '107.00', 'ACTIVO', '', 60, 5, 81, 12),
(244, '0440521007080', 'Pañalero Limon con Gusanito 6M', 'Pañalero Limon con Gusanito 6M\r\n', '1.00', '0.00', '140.00', '219.00', '79.00', 'ACTIVO', '', 52, 5, 81, 10),
(245, '0440511012081', 'Playera Agua de Limón 36M', 'Playera Agua de Limón 36M\r\n', '2.00', '0.00', '156.00', '239.00', '83.00', 'ACTIVO', '', 51, 5, 82, 15),
(246, '0440511009080', 'Playera Limón Con Gusanito 12M', 'Playera Limón Con Gusanito 12M\r\n', '1.00', '0.00', '156.00', '239.00', '83.00', 'ACTIVO', '', 51, 5, 81, 12),
(247, '0440512012080', 'Playera Limón Con Gusanito 36M', 'Playera Limón Con Gusanito 36M\r\n', '1.00', '0.00', '156.00', '239.00', '83.00', 'ACTIVO', '', 69, 5, 81, 15),
(248, '0440491109082', 'Playera Beige Limonada 12M', 'Playera Beige Limonada 12M\r\n', '1.00', '0.00', '156.00', '239.00', '83.00', 'ACTIVO', '', 49, 6, 83, 12),
(249, '0440492112082', 'Playera Beige Limonada 36M', 'Playera Beige Limonada 36M\r\n', '1.00', '0.00', '156.00', '239.00', '83.00', 'ACTIVO', '', 49, 5, 83, 14),
(250, '0440501005083', 'Leggins Liso Basico 0M', 'Leggins Liso Basico 0M\r\n', '1.00', '0.00', '116.00', '179.00', '63.00', 'ACTIVO', '', 50, 6, 84, 8),
(251, '0440501006083', 'Leggins Liso Basico 3M', 'Leggins Liso Basico 3M\r\n', '1.00', '0.00', '116.00', '179.00', '63.00', 'ACTIVO', '', 50, 5, 84, 9),
(252, '0440501007083', 'Leggins Liso Basico 6M', 'Leggins Liso Basico 6M\r\n', '1.00', '0.00', '116.00', '174.00', '58.00', 'ACTIVO', '', 50, 6, 84, 10),
(253, '0440611209084', 'Vestido Toronja 12M', 'Vestido Toronja 12M\r\n', '1.00', '0.00', '224.00', '339.00', '115.00', 'ACTIVO', '', 61, 5, 85, 12),
(254, '0440491211085', 'Playera Picnic 24M', 'Playera Picnic 24M\r\n', '2.00', '0.00', '156.00', '239.00', '83.00', 'ACTIVO', '', 49, 5, 86, 14),
(255, '0440621207086', 'Species Set Pink 6M ', 'Species Set Pink 6M \r\n', '1.00', '0.00', '337.50', '519.00', '181.50', 'ACTIVO', '', 62, 5, 87, 10),
(256, '0440621107087', 'Species Set Blue 6M', 'Species Set Blue 6M\r\n', '1.00', '0.00', '337.50', '519.00', '181.50', 'ACTIVO', '', 62, 5, 88, 10),
(257, '0440631205086', 'Species Pantalon Pink 0M', 'Species Pantalon Pink 0M\r\n', '1.00', '0.00', '129.31', '199.00', '69.69', 'ACTIVO', '', 63, 5, 87, 8),
(258, '0440631106087', 'Species Pantalon Blue 3M ', 'Species Pantalon Blue 3M \r\n', '1.00', '0.00', '129.31', '199.00', '69.69', 'ACTIVO', '', 63, 5, 88, 9),
(259, '0440631107087', 'Species Pantalon Blue 6M', 'Species Pantalon Blue 6M\r\n', '1.00', '0.00', '129.31', '199.00', '69.69', 'ACTIVO', '', 63, 5, 88, 10),
(260, '0440531106088', 'Octopus Jacket 3M', 'Octopus Jacket 3M\r\n', '1.00', '0.00', '310.50', '469.00', '158.50', 'ACTIVO', '', 53, 5, 89, 9),
(261, '0440531107088', 'Octopus Jacket 6M', 'Octopus Jacket 6M\r\n', '1.00', '0.00', '310.50', '469.00', '158.50', 'ACTIVO', '', 53, 5, 89, 10),
(262, '0440531109088', 'Octopus Jacket 12M', 'Octopus Jacket 12M\r\n', '1.00', '0.00', '310.50', '469.00', '158.50', 'ACTIVO', '', 53, 5, 89, 12),
(263, '0440501206089', 'Pink Coral Leggins 3M', 'Pink Coral Leggins 3M\r\n', '1.00', '0.00', '189.00', '289.00', '100.00', 'ACTIVO', '', 50, 5, 90, 9),
(264, '0440501211089', 'Pink Coral Leggings 24M', 'Pink Coral Leggings 24M\r\n', '1.00', '0.00', '189.00', '289.00', '100.00', 'ACTIVO', '', 50, 5, 90, 14),
(265, '0440502212089', 'Pink Coral Leggins 36M', 'Pink Coral Leggins 36M\r\n', '1.00', '0.00', '189.00', '289.00', '100.00', 'ACTIVO', '', 50, 5, 90, 15),
(266, '0440511109090', 'Whale Shark Tee Azul 12M', 'Whale Shark Tee Azul 12M\r\n', '1.00', '0.00', '175.50', '289.00', '113.50', 'ACTIVO', '', 69, 5, 91, 12),
(267, '0440511209091', 'Whale Shark Tee Pink 12M', 'Whale Shark Tee Pink 12M\r\n', '1.00', '0.00', '175.50', '289.00', '113.50', 'ACTIVO', '', 51, 5, 92, 12),
(268, '0440511209092', 'Ocean Leggins 12M', 'Ocean Leggins 12M\r\n', '1.00', '0.00', '180.00', '289.00', '109.00', 'ACTIVO', '', 50, 5, 93, 12),
(269, '0440511211092', 'Ocean Leggins 24M', 'Ocean Leggins 24M\r\n', '1.00', '0.00', '180.00', '289.00', '109.00', 'ACTIVO', '', 50, 6, 93, 14),
(270, '0440512212092', 'Ocean Leggins 36M', 'Ocean Leggins 36M\r\n', '1.00', '0.00', '180.00', '289.00', '109.00', 'ACTIVO', '', 50, 5, 93, 15),
(271, '0440521006093', 'Pañalero Limonada 3M', 'Pañalero Limonada 3M\r\n', '1.00', '0.00', '140.00', '219.00', '79.00', 'ACTIVO', '', 52, 5, 94, 9),
(272, '0440521007093', 'Pañalero Limonada 6M', 'Pañalero Limonada 6M\r\n', '1.00', '0.00', '140.00', '219.00', '79.00', 'ACTIVO', '', 52, 5, 94, 10),
(273, '0440621105094', 'Little Hair Gift ', 'Little Hair Gift Set 4 Piezas Gris 0M\r\n', '1.00', '0.00', '600.00', '899.00', '299.00', 'ACTIVO', '', 62, 5, 32, 8),
(274, '0440621106094', 'Little Hair Gift Set 4 Piezas Gris 3M', 'Little Hair Gift Set 4 Piezas Gris 3M\r\n\r\n', '1.00', '0.00', '600.00', '899.00', '299.00', 'ACTIVO', '', 62, 5, 32, 9),
(275, '0440621205095', 'Little Hair Gift Set 4 Piezas Rosa 0M', 'Little Hair Gift Set 4 Piezas Rosa 0M\r\n', '0.00', '0.00', '600.00', '899.00', '299.00', 'ACTIVO', '', 62, 5, 119, 8),
(276, '0440621206095', 'Little Hair Gift Set 4 Piezas Rosa 3M', 'Little Hair Gift Set 4 Piezas Rosa 3M\r\n', '1.00', '0.00', '600.00', '899.00', '299.00', 'ACTIVO', '', 62, 5, 119, 9),
(277, '0420141100097', 'Ocean Bandana', 'Ocean Bandana Blue\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 15, 5, 98, 1),
(278, '0420141200098', 'Ocean Bandana Pink', 'Ocean Bandana Pink\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 15, 5, 99, 1),
(279, '0420451200099', 'Babero Blowfish Pink', 'Babero Blowfish Pink\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 45, 5, 100, 1),
(280, '0420451100100', 'Babero Blowfish Blue', 'Babero Blowfish Blue\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 45, 5, 101, 1),
(281, '0420451000101', 'Babero Mostaza Limonada', 'Babero Mostaza Limonada\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 45, 5, 102, 1),
(282, '420451100102', 'Babero Verde Limonada', 'Babero Verde Limonada\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 45, 5, 103, 1),
(283, '0420451000103', 'Babero Mostaza Gotas', 'Babero Mostaza Gotas\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 45, 6, 104, 1),
(284, '0420141100102', 'Bandana Verde Limonada', 'Bandana Verde Limonada\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 15, 6, 103, 1),
(285, '0420141200104', 'Bandana Gotas Coral', 'Bandana Gotas Coral\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 15, 5, 105, 1),
(286, '0420141100105', 'Bandana Gotas Verde', 'Bandana Gotas Verde\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 15, 5, 106, 1),
(287, '0420451000084', 'Babero Toronjas', 'Babero Toronjas\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 45, 5, 85, 1),
(288, '0420451000106', 'Babero Gajos Gris', 'Babero Gajos Gris', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 45, 5, 107, 1),
(289, '0420451200107', 'Babero Gajos Coral', 'Babero Gajos Coral\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 45, 5, 108, 1),
(290, '0420141200107', 'Bandana Gajos Coral', 'Bandana Gajos Coral\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 15, 5, 108, 1),
(291, '0420141000106', 'Bandana Gajos Gris', 'Bandana Gajos Gris\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 15, 5, 107, 1),
(292, '0420451000108', 'Babero Rojo Sandia', 'Babero Rojo Sandia\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 45, 5, 109, 1),
(293, '0420451100109', 'Babero Sandia Oxford', 'Babero Sandia Oxford\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 45, 5, 110, 1),
(294, '0420451100110', 'Babero Paleta Verde', 'Babero Paleta Verde\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 45, 5, 111, 1);
INSERT INTO `producto` (`IdProducto`, `Codigo`, `Nombre`, `Descripcion`, `Stock`, `StockMin`, `PrecioCosto`, `PrecioVenta`, `Utilidad`, `Estado`, `Imagen`, `IdCategoria`, `IdProveedor`, `IdColor`, `IdTalla`) VALUES
(295, '0420451000077', 'Babero Crema Mangos', 'Babero Crema Mangos\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 45, 5, 78, 1),
(296, '0420641000072', 'Skate Scarf White', 'Skate Scarf White\r\n', '1.00', '0.00', '125.00', '189.00', '64.00', 'ACTIVO', '', 64, 5, 73, 1),
(297, '0420141000037', 'Wall Bandana', 'Wall Bandana\r\n', '1.00', '0.00', '100.00', '139.00', '39.00', 'ACTIVO', '', 15, 5, 38, 1),
(298, '0420451200111', 'Babero Wall Pink', 'Babero Wall Pink\r\n', '1.00', '0.00', '100.00', '139.00', '39.00', 'ACTIVO', '', 45, 5, 112, 1),
(299, '0420451100112', 'Babero Wall Gray', 'Babero Wall Gray\r\n', '1.00', '0.00', '100.00', '139.00', '39.00', 'ACTIVO', '', 45, 5, 113, 1),
(300, '0420451100113', 'Bebero Rescue Dog White', 'Bebero Rescue Dog White\r\n', '1.00', '0.00', '100.00', '139.00', '39.00', 'ACTIVO', '', 45, 5, 114, 1),
(301, '0420141200096', 'Waves Bandana Pink', 'Waves Bandana Pink\r\n', '1.00', '0.00', '80.00', '139.00', '59.00', 'ACTIVO', '', 16, 5, 97, 1),
(302, '0520651200114', 'Diadema Ternura', 'Diadema Ternura Roja/Blanca\r\n', '1.00', '0.00', '69.00', '109.00', '40.00', 'ACTIVO', '', 65, 6, 115, 1),
(303, '0520651200115', 'Diadema Ternura', 'Diadema Ternura Café/Crema\r\n', '1.00', '0.00', '69.00', '109.00', '40.00', 'ACTIVO', '', 65, 6, 127, 1),
(304, '0520651200116', 'Diadema Marta Roja', 'Diadema Marta Roja\r\n', '1.00', '0.00', '69.00', '109.00', '40.00', 'ACTIVO', '', 65, 6, 117, 1),
(305, '0520651200117', 'Diadema Marta Amarilla', 'Diadema Marta Amarilla\r\n', '1.00', '0.00', '69.00', '109.00', '40.00', 'ACTIVO', '', 65, 6, 118, 1),
(306, '0520651200118', 'Diadema Marta Rosa', 'Diadema Marta Rosa\r\n', '1.00', '0.00', '69.00', '109.00', '40.00', 'ACTIVO', '', 65, 6, 119, 1),
(307, '0520651200069', 'Diadema Marta Azul', 'Diadema Marta Azul\r\n', '1.00', '0.00', '69.00', '109.00', '40.00', 'ACTIVO', '', 65, 6, 70, 1),
(308, '0550661100119', 'Frazada Organica Celeste', 'Frazada Organica Celeste\r\n', '1.00', '0.00', '239.01', '359.00', '119.99', 'ACTIVO', '', 66, 6, 120, 1),
(309, '0550661200118', 'Frazada Organica Rosa', 'Frazada Organica Rosa\r\n', '1.00', '0.00', '239.01', '359.00', '119.99', 'ACTIVO', '', 66, 6, 119, 1),
(310, '0550661000120', 'Frazada Pima Crema', 'Frazada Pima Crema\r\n', '1.00', '0.00', '129.00', '199.00', '70.00', 'ACTIVO', '', 66, 6, 121, 1),
(311, '0550661000121', 'Frazada Pima Menta', 'Frazada Pima Menta\r\n', '1.00', '0.00', '129.00', '249.00', '120.00', 'ACTIVO', '', 66, 6, 122, 1),
(312, '0550661200118', 'Frazada Pima Rosa', 'Frazada Pima Rosa\r\n', '1.00', '0.00', '129.00', '249.00', '120.00', 'ACTIVO', '', 66, 6, 119, 1),
(313, '0550661000122', 'Frazada Pima Maiz', 'Frazada Pima Maiz\r\n', '1.00', '0.00', '129.00', '249.00', '120.00', 'ACTIVO', '', 66, 6, 123, 1),
(314, '0550661200123', 'Frazada Pima Lila', 'Frazada Pima Lila\r\n', '1.00', '0.00', '129.00', '249.00', '120.00', 'ACTIVO', '', 66, 6, 124, 1),
(315, '0550661200124', 'Frazada Pima Fucsia', 'Frazada Pima Fucsia\r\n', '1.00', '0.00', '129.31', '249.00', '119.69', 'ACTIVO', '', 66, 6, 125, 1),
(316, '0550661200125', 'Frazada Pima Coral', 'Frazada Pima Coral\r\n', '1.00', '0.00', '129.00', '249.00', '120.00', 'ACTIVO', '', 66, 6, 126, 1),
(317, '0550661100119', 'Frazada Pima Celeste', 'Frazada Pima Celeste\r\n', '1.00', '0.00', '129.00', '249.00', '120.00', 'ACTIVO', '', 66, 6, 120, 1),
(318, '0550661000117', 'Frazada Pima Amarilla', 'Frazada Pima Amarilla\r\n', '1.00', '0.00', '129.00', '249.00', '120.00', 'ACTIVO', '', 66, 6, 118, 1),
(319, '0540672115022', 'Playera Polo Blanca', 'Playera Polo Blanca Manga Larga\r\n', '2.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 67, 6, 23, 18),
(320, '0540672113022', 'Playera Polo Blanca 4A', 'Playera Polo Blanca Manga Larga 4A\r\n', '2.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 67, 6, 23, 16),
(321, '0540672112022', 'Playera Polo Blanca Manga Larga 3A', 'Playera Polo Blanca Manga Larga 3A\r\n', '2.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 67, 6, 23, 15),
(322, '0540671111022', 'Playera Polo Blanca Manga Larga 24M', 'Playera Polo Blanca Manga Larga 24M\r\n', '2.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 67, 6, 23, 14),
(323, '0540671109022', 'Playera Polo Blanca Manga Larga 12M', 'Playera Polo Blanca Manga Larga 12M\r\n', '2.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 52, 6, 23, 12),
(324, '0540671107022', 'Playera Polo Blanca Manga Larga 6M', 'Playera Polo Blanca Manga Larga 6M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 67, 6, 23, 10),
(325, '0540672115122', 'Playera Polo Maiz Manga Larga 6A', 'Playera Polo Maiz Manga Larga 6A\r\n', '2.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 67, 6, 123, 18),
(326, '0540672113122', 'Playera Polo Maiz Manga Larga 4A', 'Playera Polo Maiz Manga Larga 4A\r\n\r\n', '2.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 67, 6, 123, 16),
(327, '0540672112122', 'Playera Polo Maiz Manga Larga 3A', 'Playera Polo Maiz Manga Larga 3A\r\n', '2.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 67, 6, 123, 15),
(328, '0540671111122', 'Playera Polo Maiz Manga Larga 24M', 'Playera Polo Maiz Manga Larga 24M\r\n', '2.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 67, 6, 123, 14),
(329, '0540671109122', 'Playera Polo Maiz Manga Larga 12M', 'Playera Polo Maiz Manga Larga 12M\r\n', '2.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 52, 6, 123, 12),
(330, '0540671107122', 'Playera Polo Maiz Manga Larga 6M', 'Playera Polo Maiz Manga Larga 6M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 67, 6, 123, 10),
(331, '0540672115119', 'Playera Polo Celeste Manga Larga 6A', 'Playera Polo Celeste Manga Larga 6A\r\n', '2.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 120, 18),
(332, '0540672113119', 'Playera Polo Celeste Manga Larga 4A', 'Playera Polo Celeste Manga Larga 4A\r\n', '2.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 67, 6, 120, 16),
(333, '0540672112119', 'Playera Polo Celeste Manga Larga 3A', 'Playera Polo Celeste Manga Larga 3A\r\n', '2.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 67, 6, 120, 15),
(334, '0540671111119', 'Playera Polo Celeste Manga Larga 24M', 'Playera Polo Celeste Manga Larga 24M\r\n', '2.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 67, 6, 120, 14),
(335, '0540671109119', 'Playera Polo Celeste Manga Larga 12M', 'Playera Polo Celeste Manga Larga 12M\r\n', '2.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 67, 6, 120, 12),
(336, '0540671107119', 'Playera Polo Celeste Manga Larga 6M', 'Playera Polo Celeste Manga Larga 6M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 67, 6, 120, 10),
(337, '0540692215121', 'Blusa Polo Menta Manga Larga 6A', 'Blusa Polo Menta Manga Larga 6A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 122, 18),
(338, '0540692213121', 'Blusa Polo Menta Manga Larga 4A', 'Blusa Polo Menta Manga Larga 4A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 122, 16),
(339, '0540692212121', 'Blusa Polo Menta Manga Larga 3A', 'Blusa Polo Menta Manga Larga 3A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 122, 15),
(340, '0540691211121', 'Blusa Polo Menta Manga Larga 24M', 'Blusa Polo Menta Manga Larga 24M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 122, 14),
(341, '0540691209121', 'Blusa Polo Menta Manga Larga 12M', 'Blusa Polo Menta Manga Larga 12M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 122, 12),
(342, '0540691207121', 'Blusa Polo Menta Manga Larga 6M', 'Blusa Polo Menta Manga Larga 6M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 122, 10),
(343, '0540692215022', 'Blusa Polo Blanca Manga Larga 6A', 'Blusa Polo Blanca Manga Larga 6A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 23, 18),
(344, '0540692213022', 'Blusa Polo Blanca Manga Larga 4A', 'Blusa Polo Blanca Manga Larga 4A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 23, 16),
(345, '0540692212022', 'Blusa Polo Blanca Manga Larga 3A', 'Blusa Polo Blanca Manga Larga 3A\r\n', '1.00', '0.00', '149.00', '132.00', '-17.00', 'ACTIVO', '', 69, 6, 23, 15),
(346, '0540691211022', 'Blusa Polo Blanca Manga Larga 24M', 'Blusa Polo Blanca Manga Larga 24M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 23, 14),
(347, '0540691209022', 'Blusa Polo Blanca Manga Larga 12M', 'Blusa Polo Blanca Manga Larga 12M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 23, 12),
(348, '0540691207022', 'Blusa Polo Blanca Manga Larga 6M', 'Blusa Polo Blanca Manga Larga 6M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 23, 10),
(349, '0540692215118', 'Blusa Polo Rosa Manga Larga 6A', 'Blusa Polo Rosa Manga Larga 6A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 119, 18),
(350, '0540692213118', 'Blusa Polo Rosa Manga Larga 4A', 'Blusa Polo Rosa Manga Larga 4A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 115, 16),
(351, '0540692213118', 'Blusa Polo Rosa Manga Larga 4A', 'Blusa Polo Rosa Manga Larga 4A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 119, 16),
(352, '0540692212118', 'Blusa Polo Rosa Manga Larga 3A', 'Blusa Polo Rosa Manga Larga 3A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 119, 15),
(353, '0540691211118', 'Blusa Polo Rosa Manga Larga 24M', 'Blusa Polo Rosa Manga Larga 24M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 115, 14),
(354, '0540691209118', 'Blusa Polo Rosa Manga Larga 12M', 'Blusa Polo Rosa Manga Larga 12M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 119, 12),
(355, '0540691207118', 'Blusa Polo Rosa Manga Larga 6M', 'Blusa Polo Rosa Manga Larga 6M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 119, 10),
(356, '0540692215119', 'Blusa Polo Celeste Manga Larga 6A', 'Blusa Polo Celeste Manga Larga 6A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 120, 18),
(357, '0540692213119', 'Blusa Polo Celeste Manga Larga 4A', 'Blusa Polo Celeste Manga Larga 4A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 120, 16),
(358, '0540692212119', 'Blusa Polo Celeste Manga Larga 3A', 'Blusa Polo Celeste Manga Larga 3A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 120, 15),
(359, '0540691211119', 'Blusa Polo Celeste Manga Larga 24M', 'Blusa Polo Celeste Manga Larga 24M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 120, 14),
(360, '0540691209119', 'Blusa Polo Celeste Manga Larga 12M', 'Blusa Polo Celeste Manga Larga 12M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 120, 12),
(361, '0540691207119', 'Blusa Polo Celeste Manga Larga 6M', 'Blusa Polo Celeste Manga Larga 6M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 120, 10),
(362, '0540692215117', 'Blusa Polo Amarilla Manga Larga 6A', 'Blusa Polo Amarilla Manga Larga 6A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 118, 18),
(363, '0540692213117', 'Blusa Polo Amarilla Manga Larga 4A', 'Blusa Polo Amarilla Manga Larga 4A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 118, 16),
(364, '0540692212117', 'Blusa Polo Amarilla Manga Larga 3A', 'Blusa Polo Amarilla Manga Larga 3A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 69, 6, 118, 15),
(365, '0540691211117', 'Blusa Polo Amarilla Manga Larga 24M', 'Blusa Polo Amarilla Manga Larga 24M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 118, 14),
(366, '0540691209117', 'Blusa Polo Amarilla Manga Larga 12M', 'Blusa Polo Amarilla Manga Larga 12M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 118, 12),
(367, '0540691207117', 'Blusa Polo Amarilla Manga Larga 6M', 'Blusa Polo Amarilla Manga Larga 6M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 69, 6, 118, 10),
(368, '0540682115126', 'Playera Polo Café Manga Corta 6A', 'Playera Polo Café Manga Corta 6A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 127, 18),
(369, '0540682113126', 'Playera Polo Café Manga Corta 4A', 'Playera Polo Café Manga Corta 4A\r\n', '1.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 24, 16),
(370, '0540682112126', 'Playera Polo Café Manga Corta 3A', 'Playera Polo Café Manga Corta 3A\r\n', '2.00', '0.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 127, 15),
(371, '0540681111126', 'Playera Polo Café Manga Corta 24M', 'Playera Polo Café Manga Corta 24M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 68, 6, 127, 14),
(372, '0540681109126', 'Playera Polo Café Manga Corta 12M', 'Playera Polo Café Manga Corta 12M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 68, 6, 127, 12),
(373, '0540681107126', 'Playera Polo Café Manga Corta 6M', 'Playera Polo Café Manga Corta 6M\r\n', '1.00', '0.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 68, 6, 127, 10),
(374, '0540682115022', 'Playera Polo Blanca Manga Corta 6A', 'Playera Polo Blanca Manga Corta 6A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 23, 18),
(375, '0540682113022', 'Playera Polo Blanca Manga Corta 4A', 'Playera Polo Blanca Manga Corta 4A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 23, 16),
(376, '0540681111022', 'Playera Polo Blanca Manga Corta 24M', 'Playera Polo Blanca Manga Corta 24M\r\n', '2.00', '1.00', '132.00', '198.00', '66.00', 'ACTIVO', '', 68, 6, 23, 14),
(377, '0540681109022', 'Playera Polo Blanca Manga Corta 12M', 'Playera Polo Blanca Manga Corta 12M\r\n', '2.00', '1.00', '132.00', '198.00', '66.00', 'ACTIVO', '', 68, 6, 23, 12),
(378, '0540681107022', 'Playera Polo Blanca Manga Corta 6M', 'Playera Polo Blanca Manga Corta 6M\r\n', '1.00', '1.00', '132.00', '198.00', '66.00', 'ACTIVO', '', 68, 6, 23, 10),
(379, '0540682115127', 'Playera Polo Azul Rey Manga Corta 6A', 'Playera Polo Azul Rey Manga Corta 6A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 128, 18),
(380, '0540682113127', 'Playera Polo Azul Rey Manga Corta 4A', 'Playera Polo Azul Rey Manga Corta 4A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 128, 16),
(381, ' 0540682112127', 'Playera Polo Azul Rey Manga Corta 3A', 'Playera Polo Azul Rey Manga Corta 3A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 128, 15),
(382, '0540681111127', 'Playera Polo Azul Rey Manga Corta 24M', 'Playera Polo Azul Rey Manga Corta 24M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 68, 6, 128, 14),
(383, '0540681109127', 'Playera Polo Azul Rey Manga Corta 12M', 'Playera Polo Azul Rey Manga Corta 12M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 68, 6, 128, 12),
(384, '0540681107127', 'Playera Polo Azul Rey Manga Corta 6M', 'Playera Polo Azul Rey Manga Corta 6M\r\n', '1.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 68, 6, 128, 10),
(385, '0540682115122', 'Playera Polo Maiz Manga Corta 6A', 'Playera Polo Maiz Manga Corta 6A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 123, 18),
(386, '0540682113122', 'Playera Polo Maiz Manga Corta 4A', 'Playera Polo Maiz Manga Corta 4A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 123, 16),
(387, '0540682112122', 'Playera Polo Maiz Manga Corta 3A', 'Playera Polo Maiz Manga Corta 3A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 123, 15),
(388, '0540681111122', 'Playera Polo Maiz Manga Corta 24M', 'Playera Polo Maiz Manga Corta 24M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 68, 6, 123, 14),
(389, '0540681109122', 'Playera Polo Maiz Manga Corta 12M', 'Playera Polo Maiz Manga Corta 12M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 68, 6, 123, 12),
(390, '0540681107122', 'Playera Polo Maiz Manga Corta 6M', 'Playera Polo Maiz Manga Corta 6M\r\n', '1.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 68, 6, 123, 10),
(391, '0540682115119', 'Playera Polo Celeste Manga Corta 6A', 'Playera Polo Celeste Manga Corta 6A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 120, 19),
(392, '0540682113119', 'Playera Polo Celeste Manga Corta 4A', 'Playera Polo Celeste Manga Corta 4A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 120, 16),
(393, '0540682112119', 'Playera Polo Celeste Manga Corta 3A', 'Playera Polo Celeste Manga Corta 3A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 68, 6, 120, 15),
(394, '0540681111119', 'Playera Polo Celeste Manga Corta 24M', 'Playera Polo Celeste Manga Corta 24M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 68, 6, 120, 14),
(395, '0540681109119', 'Playera Polo Celeste Manga Corta 12M', 'Playera Polo Celeste Manga Corta 12M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 68, 6, 120, 12),
(396, '0540681107119', 'Playera Polo Celeste Manga Corta 6M', 'Playera Polo Celeste Manga Corta 6M\r\n', '1.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 68, 6, 120, 10),
(397, '0540702215121', 'Blusa Polo Menta Manga Corta 6A', 'Blusa Polo Menta Manga Corta 6A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 122, 18),
(398, '0540702213121', 'Blusa Polo Menta Manga Corta 4A', 'Blusa Polo Menta Manga Corta 4A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 122, 16),
(399, '0540702212121', 'Blusa Polo Menta Manga Corta 3A', 'Blusa Polo Menta Manga Corta 3A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 122, 15),
(400, '0540701211121', 'Blusa Polo Menta Manga Corta 24M', 'Blusa Polo Menta Manga Corta 24M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 122, 14),
(401, '0540701209121', 'Blusa Polo Menta Manga Corta 12M', 'Blusa Polo Menta Manga Corta 12M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 122, 12),
(402, '0540701207121', 'Blusa Polo Menta Manga Corta 6M', 'Blusa Polo Menta Manga Corta 6M\r\n', '1.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 122, 10),
(403, '0540702215022', 'Blusa Polo Blanca Manga Corta 6A', 'Blusa Polo Blanca Manga Corta 6A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 23, 18),
(404, '0540702213022', 'Blusa Polo Blanca Manga Corta 4A', 'Blusa Polo Blanca Manga Corta 4A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 23, 16),
(405, '0540701211022', 'Blusa Polo Blanca Manga Corta 24M', 'Blusa Polo Blanca Manga Corta 24M\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 23, 14),
(406, '0540701209022', 'Blusa Polo Blanca Manga Corta 12M', 'Blusa Polo Blanca Manga Corta 12M\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 23, 12),
(407, '0540701207022', 'Blusa Polo Blanca Manga Corta 6M', 'Blusa Polo Blanca Manga Corta 6M\r\n', '1.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 23, 10),
(408, '0540701215118', 'Blusa Polo Rosa Manga Corta 6A', 'Blusa Polo Rosa Manga Corta 6A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 119, 18),
(409, '0540701213118', 'Blusa Polo Rosa Manga Corta 4A', 'Blusa Polo Rosa Manga Corta 4A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 119, 16),
(410, '0540701212118', 'Blusa Polo Rosa Manga Corta 3A', 'Blusa Polo Rosa Manga Corta 3A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 119, 15),
(411, '0540701211118', 'Blusa Polo Rosa Manga Corta 24M', 'Blusa Polo Rosa Manga Corta 24M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 119, 14),
(412, '0540701209118', 'Blusa Polo Rosa Manga Corta 12M', 'Blusa Polo Rosa Manga Corta 12M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 119, 12),
(413, '0540701207118', 'Blusa Polo Rosa Manga Corta 6M', 'Blusa Polo Rosa Manga Corta 6M\r\n', '1.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 119, 10),
(414, '0540702215119', 'Blusa Polo Celeste Manga Corta 6A', 'Blusa Polo Celeste Manga Corta 6A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 120, 18),
(415, '0540702213119', 'Blusa Polo Celeste Manga Corta 4A', 'Blusa Polo Celeste Manga Corta 4A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 120, 16),
(416, '0540702212119', 'Blusa Polo Celeste Manga Corta 3A', 'Blusa Polo Celeste Manga Corta 3A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 120, 15),
(417, '0540701211119', 'Blusa Polo Celeste Manga Corta 24M', 'Blusa Polo Celeste Manga Corta 24M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 120, 14),
(418, '0540701209119', 'Blusa Polo Celeste Manga Corta 12M', 'Blusa Polo Celeste Manga Corta 12M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 120, 12),
(419, '0540701207119', 'Blusa Polo Celeste Manga Corta 6M', 'Blusa Polo Celeste Manga Corta 6M\r\n', '1.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 120, 10),
(420, '0540701215117', 'Blusa Polo Amarillo Manga Corta 6A', 'Blusa Polo Amarillo Manga Corta 6A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 118, 18),
(421, '0540701213117', 'Blusa Polo Amarillo Manga Corta 4A', 'Blusa Polo Amarillo Manga Corta 4A\r\n', '2.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 118, 16),
(422, '0540701212117', 'Blusa Polo Amarillo Manga Corta 3A', 'Blusa Polo Amarillo Manga Corta 3A\r\n', '0.00', '1.00', '149.00', '249.00', '100.00', 'ACTIVO', '', 70, 6, 118, 15),
(423, '0540701211117', 'Blusa Polo Amarillo Manga Corta 24M', 'Blusa Polo Amarillo Manga Corta 24M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 118, 14),
(424, '0540701209117', 'Blusa Polo Amarillo Manga Corta 12M', 'Blusa Polo Amarillo Manga Corta 12M\r\n', '2.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 118, 12),
(425, '0540701207117', 'Blusa Polo Amarillo Manga Corta 6M', 'Blusa Polo Amarillo Manga Corta 6M\r\n', '1.00', '1.00', '132.00', '249.00', '117.00', 'ACTIVO', '', 70, 6, 118, 10),
(426, '0540711205118', 'Kit 5 Rosa 0 Meses', 'Kit 5 Rosa 0 Meses\r\n', '1.00', '1.00', '257.00', '399.00', '142.00', 'ACTIVO', '', 71, 6, 119, 8),
(427, '0540711005117', 'Kit 5 Amarillo 0 Meses', 'Kit 5 Amarillo 0 Meses\r\n', '1.00', '1.00', '257.00', '399.00', '142.00', 'ACTIVO', '', 71, 6, 118, 8),
(428, '0540721006121', 'Kit Casita Menta 3 Meses', 'Kit Casita Menta 3 Meses\r\n', '2.00', '1.00', '234.00', '359.00', '125.00', 'ACTIVO', '', 72, 6, 122, 9),
(429, '0540721205118', 'Kit Casita Rosa 0 Meses', 'Kit Casita Rosa 0 Meses\r\n', '2.00', '1.00', '234.00', '359.00', '125.00', 'ACTIVO', '', 72, 6, 119, 8),
(430, '0540721005117', 'Kit Casita Amarilla 0 Meses', 'Kit Casita Amarilla 0 Meses\r\n', '2.00', '1.00', '234.00', '359.00', '125.00', 'ACTIVO', '', 72, 6, 118, 8),
(431, '0540721005128', 'Kit Casita Organico 0 Meses', 'Kit Casita Organico 0 Meses\r\n', '1.00', '1.00', '311.00', '469.00', '158.00', 'ACTIVO', '', 72, 6, 129, 8),
(432, 'JCA0B0540721006128', 'Kit Casita Organico 3 Meses', 'Kit Casita Organico 3 Meses\r\n', '1.00', '1.00', '311.00', '469.00', '158.00', 'ACTIVO', '', 72, 6, 129, 9),
(433, '0540601110129', 'Mameluco Basico Verde Agua 18M', 'Mameluco Basico Verde Agua 18M\r\n', '1.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 130, 13),
(434, '0540601108129', 'Mameluco Basico Verde Agua 9M', 'Mameluco Basico Verde Agua 9M\r\n', '2.00', '1.00', '129.00', '229.00', '100.00', 'ACTIVO', '', 60, 6, 130, 11),
(435, '0540601211118', 'Mameluco Basico Rosa 24M', 'Mameluco Basico Rosa 24M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 119, 14),
(436, '0540601210118', 'Mameluco Basico Rosa 18M', 'Mameluco Basico Rosa 18M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 119, 13),
(437, '0540601209118', 'Mameluco Basico Rosa 12M', 'Mameluco Basico Rosa 12M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 119, 12),
(438, '0540601208118', 'Mameluco Basico Rosa 09M', 'Mameluco Basico Rosa 09M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 119, 11),
(439, '0540601207118', 'Mameluco Basico Rosa 06M', 'Mameluco Basico Rosa 06M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 119, 10),
(440, '0540601206118', 'Mameluco Basico Rosa 03M', 'Mameluco Basico Rosa 03M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 119, 9),
(441, '0540601205118', 'Mameluco Basico Rosa 00M', 'Mameluco Basico Rosa 00M\r\n', '1.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 119, 8),
(442, '0540601011121', 'Mameluco Basico Menta 24M', 'Mameluco Basico Menta 24M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 122, 14),
(443, '0540601010121', 'Mameluco Basico Menta 18M', 'Mameluco Basico Menta 18M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 122, 13),
(444, '0540601008121', 'Mameluco Basico Menta 09M', 'Mameluco Basico Menta 09M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 122, 11),
(445, '0540601007121', 'Mameluco Basico Menta 06M', 'Mameluco Basico Menta 06M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 122, 10),
(446, '0540601006121', 'Mameluco Basico Menta 03M', 'Mameluco Basico Menta 03M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 122, 9),
(447, '0540601005121', 'Mameluco Basico Menta 00M', 'Mameluco Basico Menta 00M\r\n', '1.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 122, 8),
(448, '0540601205123', 'Mameluco Basico Lila 00M', 'Mameluco Basico Lila 00M\r\n', '1.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 124, 8),
(449, '0540601211123', 'Mameluco Basico Lila 24M', 'Mameluco Basico Lila 24M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 124, 14),
(450, '0540601210123', 'Mameluco Basico Lila 18M', 'Mameluco Basico Lila 18M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 124, 13),
(451, '0540601209123', 'Mameluco Basico Lila 12M', 'Mameluco Basico Lila 12M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 124, 12),
(452, '0540601207123', 'Mameluco Basico Lila 06M', 'Mameluco Basico Lila 06M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 124, 10),
(453, '0540601206123', 'Mameluco Basico Lila 03M', 'Mameluco Basico Lila 03M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 124, 9),
(454, '0540601211125', 'Mameluco Basico Coral 24M', 'Mameluco Basico Coral 24M\r\n', '2.00', '1.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 126, 14),
(455, '0540601210125', 'Mameluco Basico Coral 18M', 'Mameluco Basico Coral 18M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 126, 13),
(456, '0540601209125', 'Mameluco Basico Coral 12M', 'Mameluco Basico Coral 12M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 126, 12),
(457, '0540601208125', 'Mameluco Basico Coral 09M', 'Mameluco Basico Coral 09M\r\n', '1.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 126, 11),
(458, '0540601207125', 'Mameluco Basico Coral 06M', 'Mameluco Basico Coral 06M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 126, 10),
(459, '0540601206125', 'Mameluco Basico Coral 03M', 'Mameluco Basico Coral 03M\r\n', '2.00', '0.00', '129.31', '219.00', '89.69', 'ACTIVO', '', 60, 6, 126, 9),
(460, '0540601205125', 'Mameluco Basico Coral 00M', 'Mameluco Basico Coral 00M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 126, 8),
(461, '0540601111119', 'Mameluco Basico Celeste 24M', 'Mameluco Basico Celeste 24M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 120, 14),
(462, '0540601110119', 'Mameluco Basico Celeste 18M', 'Mameluco Basico Celeste 18M\r\n', '1.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 120, 13),
(463, '0540601109119', 'Mameluco Basico Celeste 12M', 'Mameluco Basico Celeste 12M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 120, 12),
(464, '0540601108119', 'Mameluco Basico Celeste 09M', 'Mameluco Basico Celeste 09M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 120, 11),
(465, '0540601107119', 'Mameluco Basico Celeste 06M', 'Mameluco Basico Celeste 06M\r\n', '1.00', '0.00', '129.31', '219.00', '89.69', 'ACTIVO', '', 60, 6, 120, 10),
(466, '0540601106119', 'Mameluco Basico Celeste 03M', 'Mameluco Basico Celeste 03M\r\n', '2.00', '10.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 120, 9),
(467, '0540601105119', 'Mameluco Basico Celeste 00M', 'Mameluco Basico Celeste 00M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 120, 8),
(468, '0540601010122', 'Mameluco Basico Maiz 18M', 'Mameluco Basico Maiz 18M\r\n', '1.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 123, 13),
(469, '0540601009122', 'Mameluco Basico Maiz 12M', 'Mameluco Basico Maiz 12M\r\n', '1.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 123, 12),
(470, '0540601008122', 'Mameluco Basico Maiz 09M', 'Mameluco Basico Maiz 09M\r\n', '1.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 123, 11),
(471, '0540601007122', 'Mameluco Basico Maiz 06M', 'Mameluco Basico Maiz 06M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 123, 10),
(472, '0540601006122', 'Mameluco Basico Maiz 03M', 'Mameluco Basico Maiz 03M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 123, 9),
(473, '0540601005122', 'Mameluco Basico Maiz 00M', 'Mameluco Basico Maiz 00M\r\n', '0.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 123, 8),
(474, '0540601011117', 'Mameluco Basico Amarillo 24M', 'Mameluco Basico Amarillo 24M\r\n', '1.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 118, 14),
(475, '0540601010117', 'Mameluco Basico Amarillo 18M', 'Mameluco Basico Amarillo 18M\r\n', '1.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 118, 13),
(476, '0540601009117', 'Mameluco Basico Amarillo 12M', 'Mameluco Basico Amarillo 12M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 118, 12),
(477, '0540601008117', 'Mameluco Basico Amarillo 09M', 'Mameluco Basico Amarillo 09M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 118, 11),
(478, '0540601007117', 'Mameluco Basico Amarillo 06M', 'Mameluco Basico Amarillo 06M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 118, 10),
(479, '0540601006117', 'Mameluco Basico Amarillo 03M', 'Mameluco Basico Amarillo 03M\r\n', '2.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 118, 9),
(480, '0540601005117', 'Mameluco Basico Amarillo 00M', 'Mameluco Basico Amarillo 00M\r\n', '1.00', '0.00', '129.00', '219.00', '90.00', 'ACTIVO', '', 60, 6, 118, 8),
(481, '0540591211124', 'Pañalero Basico Sin Mangas Fucsia 24M', 'Pañalero Basico Sin Mangas Fucsia 24M\r\n', '2.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 125, 14),
(482, '0540591209124', 'Pañalero Basico Sin Mangas Fucsia 12M', 'Pañalero Basico Sin Mangas Fucsia 12M\r\n', '2.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 125, 12),
(483, '0540591207124', 'Pañalero Basico Sin Mangas Fucsia 06M', 'Pañalero Basico Sin Mangas Fucsia 06M\r\n', '4.00', '1.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 125, 10),
(484, '0540591206124', 'Pañalero Basico Sin Mangas Fucsia 03M', 'Pañalero Basico Sin Mangas Fucsia 03M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 125, 9),
(485, '0540591211125', 'Pañalero Basico Sin Mangas Coral 24M', 'Pañalero Basico Sin Mangas Coral 24M\r\n', '2.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 126, 14),
(486, '0540591207125', 'Pañalero Basico Sin Mangas Coral 06M', 'Pañalero Basico Sin Mangas Coral 06M\r\n', '4.00', '1.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 126, 10),
(487, '0540591206125', 'Pañalero Basico Sin Mangas Coral 03M', 'Pañalero Basico Sin Mangas Coral 03M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 126, 9),
(488, '0540591111119', 'Pañalero Basico Sin Mangas Celeste 24M', 'Pañalero Basico Sin Mangas Celeste 24M\r\n', '2.00', '1.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 120, 14),
(489, '0540591108119', 'Pañalero Basico Sin Mangas Celeste 09M', 'Pañalero Basico Sin Mangas Celeste 09M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 120, 11),
(490, '0540591106119', 'Pañalero Basico Sin Mangas Celeste 03M', 'Pañalero Basico Sin Mangas Celeste 03M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 120, 9),
(491, '0540591111127', 'Pañalero Basico Sin Mangas Azul Rey 24M', 'Pañalero Basico Sin Mangas Azul Rey 24M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 128, 14),
(492, '0540591109127', 'Pañalero Basico Sin Mangas Azul Rey 12M', 'Pañalero Basico Sin Mangas Azul Rey 12M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 128, 12),
(493, '0540591107127', 'Pañalero Basico Sin Mangas Azul Rey 06M', 'Pañalero Basico Sin Mangas Azul Rey 06M\r\n', '2.00', '1.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 70, 10),
(494, '0540591106127', 'Pañalero Basico Sin Mangas Azul Rey 03M', 'Pañalero Basico Sin Mangas Azul Rey 03M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 128, 9),
(495, '0540591110129', 'Pañalero Basico Sin Mangas Verde Agua 18M', 'Pañalero Basico Sin Mangas Verde Agua 18M\r\n', '2.00', '1.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 130, 13),
(496, '0540591106129', 'Pañalero Basico Sin Mangas Verde Agua 03M', 'Pañalero Basico Sin Mangas Verde Agua 03M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 130, 9),
(497, '0540591010121', 'Pañalero Basico Sin Mangas Menta 18M', 'Pañalero Basico Sin Mangas Menta 18M\r\n', '2.00', '1.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 122, 13),
(498, '0540591009121', 'Pañalero Basico Sin Mangas Menta 12M', 'Pañalero Basico Sin Mangas Menta 12M\r\n', '2.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 122, 12),
(499, '0540591007121', 'Pañalero Basico Sin Mangas Menta 06M', 'Pañalero Basico Sin Mangas Menta 06M\r\n', '4.00', '1.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 122, 10),
(500, '0540591006121', 'Pañalero Basico Sin Mangas Menta 03M', 'Pañalero Basico Sin Mangas Menta 03M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 52, 6, 122, 9),
(501, '0540591010122', 'Pañalero Basico Sin Mangas Maiz 18M', 'Pañalero Basico Sin Mangas Maiz 18M\r\n', '2.00', '1.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 123, 13),
(502, '0540591009122', 'Pañalero Basico Sin Mangas Maiz 12M', 'Pañalero Basico Sin Mangas Maiz 12M\r\n', '2.00', '1.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 123, 12),
(503, '0540591007122', 'Pañalero Basico Sin Mangas Maiz 06M', 'Pañalero Basico Sin Mangas Maiz 06M\r\n', '4.00', '1.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 123, 10),
(504, '0540591006122', 'Pañalero Basico Sin Mangas Maiz 03M', 'Pañalero Basico Sin Mangas Maiz 03M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 123, 9),
(505, '0540591010123', 'Pañalero Basico Sin Mangas Lila 18M', 'Pañalero Basico Sin Mangas Lila 18M\r\n', '2.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 124, 13),
(506, '0540591008123', 'Pañalero Basico Sin Mangas Lila 09M', 'Pañalero Basico Sin Mangas Lila 09M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 124, 11),
(507, '0540591006123', 'Pañalero Basico Sin Mangas Lila 03M', 'Pañalero Basico Sin Mangas Lila 03M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 52, 6, 124, 9),
(508, '0540591110126', 'Pañalero Basico Sin Mangas Cafe 18M', 'Pañalero Basico Sin Mangas Cafe 18M\r\n', '3.00', '1.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 3, 127, 13),
(509, '0540591109126', 'Pañalero Basico Sin Mangas Cafe 12M', 'Pañalero Basico Sin Mangas Cafe 12M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 127, 12),
(510, '0540591107126', 'Pañalero Basico Sin Mangas Cafe 06M', 'Pañalero Basico Sin Mangas Cafe 06M\r\n', '2.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 127, 10),
(511, '0540591106126', 'Pañalero Basico Sin Mangas Cafe 03M', 'Pañalero Basico Sin Mangas Cafe 03M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 127, 9),
(512, '0540591010117', 'Pañalero Basico Sin Mangas Amarillo 18M', 'Pañalero Básico Sin Mangas Amarillo 18M\r\n', '2.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 118, 13),
(513, '0540591008117', 'Pañalero Basico Sin Mangas Amarillo 09M', 'Pañalero Básico Sin Mangas Amarillo 09M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 118, 11),
(514, '0540591210118', 'Pañalero Basico Sin Mangas Rosa 18M', 'Pañalero Basico Sin Mangas Rosa 18M\r\n', '1.00', '0.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 119, 13),
(515, '0540591208118', 'Pañalero Basico Sin Mangas Rosa 09M', 'Pañalero Basico Sin Mangas Rosa 09', '1.00', '1.00', '69.00', '149.00', '80.00', 'ACTIVO', '', 59, 6, 119, 11),
(516, '0540591206118', 'Pañalero Basico Sin Mangas Rosa 03M', 'Pañalero Basico Sin Mangas Rosa 03M\r\n', '1.00', '1.00', '69.00', '129.00', '60.00', 'ACTIVO', '', 59, 6, 119, 9),
(517, '0540521111129', 'Pañalero Basico Manga Larga Verde Aqua 24M', 'Pañalero Basico Manga Larga Verde Aqua 24m\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 130, 14),
(518, '0540521110129', 'Pañalero Basico Manga Larga Verde Aqua 18M', 'Pañalero Basico Manga Larga Verde Aqua 18M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 130, 13),
(519, '0540521109129', 'Pañalero Basico Manga Larga Verde Aqua 12M', 'Pañalero Basico Manga Larga Verde Aqua 12M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 130, 12),
(520, '0540521108129', 'Pañalero Basico Manga Larga Verde Aqua 09M', 'Pañalero Basico Manga Larga Verde Aqua 09M', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 130, 11),
(521, '0540521107129', 'Pañalero Basico Manga Larga Verde Aqua 06M', 'Pañalero Basico Manga Larga Verde Aqua 06M', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 130, 10),
(522, '0540521106129', 'Pañalero Basico Manga Larga Verde Aqua 03M', 'Pañalero Basico Manga Larga Verde Aqua 03M', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 130, 9),
(523, '0540521105129', 'Pañalero Basico Manga Larga Verde Aqua 00M', 'Pañalero Basico Manga Larga Verde Aqua 00M', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 130, 8),
(524, '0540521211118', 'Pañalero Basico Manga Larga Rosa 24M', 'Pañalero Basico Manga Larga Rosa 24M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 130, 14),
(525, '0540521210118', 'Pañalero Basico Manga Larga Rosa 18M', 'Pañalero Basico Manga Larga Rosa 18M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 130, 13),
(526, '0540521209118', 'Pañalero Basico Manga Larga Rosa 12M', 'Pañalero Basico Manga Larga Rosa 12M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 130, 12),
(527, '0540521208118', 'Pañalero Basico Manga Larga Rosa 09M', 'Pañalero Basico Manga Larga Rosa 09M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 130, 11),
(528, '0540521207118', 'Pañalero Basico Manga Larga Rosa 06M', 'Pañalero Basico Manga Larga Rosa 06M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 130, 10),
(529, '0540521206118', 'Pañalero Basico Manga Larga Rosa 03M', 'Pañalero Basico Manga Larga Rosa 03M\r\n', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 119, 9),
(530, '0540521205118', 'Pañalero Basico Manga Larga Rosa 00M', 'Pañalero Basico Manga Larga Rosa 00M\r\n', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 119, 8),
(531, '0540521011121', 'Pañalero Basico Manga Larga Menta 24M', 'Pañalero Basico Manga Larga Menta 24M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 122, 14),
(532, '0540521010121', 'Pañalero Basico Manga Larga Menta 18M', 'Pañalero Basico Manga Larga Menta 18M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 122, 13),
(533, '0540521009121', 'Pañalero Basico Manga Larga Menta 12M', 'Pañalero Basico Manga Larga Menta 12M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 3, 122, 12),
(534, '0540521008121', 'Pañalero Basico Manga Larga Menta 09M', 'Pañalero Basico Manga Larga Menta 09M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 122, 11),
(535, '0540521007121', 'Pañalero Basico Manga Larga Menta 06M', 'Pañalero Basico Manga Larga Menta 06M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 122, 10),
(536, '0540521006121', 'Pañalero Basico Manga Larga Menta 03M', 'Pañalero Basico Manga Larga Menta 03M\r\n', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 122, 9),
(537, '0540521005121', 'Pañalero Basico Manga Larga Menta 00M', 'Pañalero Basico Manga Larga Menta 00M\r\n', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 122, 8),
(538, '0540521211123', 'Pañalero Basico Manga Larga Lila 24M', 'Pañalero Basico Manga Larga Lila 24M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 124, 14),
(539, '0540521210123', 'Pañalero Basico Manga Larga Lila 18M', 'Pañalero Basico Manga Larga Lila 18M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 124, 13),
(540, '0540521209123', 'Pañalero Basico Manga Larga Lila 12M', 'Pañalero Basico Manga Larga Lila 12M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 73, 6, 124, 12),
(541, '0540521208123', 'Pañalero Basico Manga Larga Lila 09M', 'Pañalero Basico Manga Larga Lila 09M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 124, 11),
(542, '0540521207123', 'Pañalero Basico Manga Larga Lila 06M', 'Pañalero Basico Manga Larga Lila 06M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 3, 124, 10),
(543, '0540521206123', 'Pañalero Basico Manga Larga Lila 03M', 'Pañalero Basico Manga Larga Lila 03M\r\n', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 124, 9),
(544, '0540521205123', 'Pañalero Basico Manga Larga Lila 00M', 'Pañalero Basico Manga Larga Lila 00M\r\n', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 124, 8),
(545, '0540521211124', 'Pañalero Basico Manga Larga Fucsia 24M', 'Pañalero Basico Manga Larga Fucsia 24M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 125, 14),
(546, '0540521210124', 'Pañalero Basico Manga Larga Fucsia 18M', 'Pañalero Basico Manga Larga Fucsia 18M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 125, 13),
(547, '0540521209124', 'Pañalero Basico Manga Larga Fucsia 12M', 'Pañalero Basico Manga Larga Fucsia 12M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 125, 12),
(548, '0540521208124', 'Pañalero Basico Manga Larga Fucsia 09M', 'Pañalero Basico Manga Larga Fucsia 09M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 125, 11),
(549, '0540521207124', 'Pañalero Basico Manga Larga Fucsia 06M', 'Pañalero Basico Manga Larga Fucsia 06M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 3, 125, 10),
(550, '0540521206124', 'Pañalero Basico Manga Larga Fucsia 03M', 'Pañalero Basico Manga Larga Fucsia 03M\r\n', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 125, 9),
(551, '0540521205124', 'Pañalero Basico Manga Larga Fucsia 00M', 'Pañalero Basico Manga Larga Fucsia 00M\r\n', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 125, 8),
(552, '0540521211125', 'Pañalero Basico Manga Larga Coral 24M', 'Pañalero Basico Manga Larga Coral 24M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 126, 14),
(553, '0540521210125', 'Pañalero Basico Manga Larga Coral 18M', 'Pañalero Basico Manga Larga Coral 18M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 126, 13),
(554, '0540521209125', 'Pañalero Basico Manga Larga Coral 12M', 'Pañalero Basico Manga Larga Coral 12M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 126, 12),
(555, '0540521208125', 'Pañalero Basico Manga Larga Coral 09M', 'Pañalero Basico Manga Larga Coral 09M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 126, 11),
(556, '0540521207125', 'pañalero básico manga larga fucsia 6m', 'pañalero básico manga larga 6m', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 126, 10),
(557, '0540521206125', 'pañalero básico manga larga fucsia 3m', 'pañalero básico manga larga', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 126, 9),
(558, '0540521205125', 'pañalero básico manga larga fucsia 0m', 'pañalero básico manga larga fucsia 0m', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 126, 8),
(559, '0540521111119', 'pañalero básico manga larga celeste 24m', 'pañalero básico manga larga 24m', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 120, 14),
(560, '0540521110119', 'Pañalero Basico Manga Larga Celeste 18M', 'Pañalero Basico Manga Larga Celeste 18M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 120, 13),
(561, '0540521109119', 'Pañalero Basico Manga Larga Celeste 12M', 'Pañalero Basico Manga Larga Celeste 12M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 120, 12),
(562, '0540521108119', 'Pañalero Basico Manga Larga Celeste 09M', 'Pañalero Basico Manga Larga Celeste 09M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 120, 11),
(563, '0540521107119', 'Pañalero Basico Manga Larga Celeste 06M', 'Pañalero Basico Manga Larga Celeste 06M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 120, 10),
(564, '0540521106119', 'Pañalero Basico Manga Larga Celeste 03M', 'Pañalero Basico Manga Larga Celeste 03M\r\n', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 3, 120, 9),
(565, '0540521105119', 'Pañalero Basico Manga Larga Celeste 00M', 'Pañalero Basico Manga Larga Celeste 00M\r\n', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 3, 120, 8),
(566, '0540521011117', 'Pañalero Basico Manga Larga Amarillo 24M', 'Pañalero Basico Manga Larga Amarillo 24M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 120, 14),
(567, '0540521010117', 'Pañalero Basico Manga Larga Amarillo 18M', 'Pañalero Basico Manga Larga Amarillo 18M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 118, 13),
(568, '0540521009117', 'Pañalero Basico Manga Larga Amarillo 12M', 'Pañalero Basico Manga Larga Amarillo 12M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 118, 12),
(569, '0540521008117', 'Pañalero Basico Manga Larga Amarillo 09M', 'Pañalero Basico Manga Larga Amarillo 09M\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 118, 11),
(570, '0540521007117', 'Pañalero Basico Manga Larga Amarillo 06M', 'Pañalero Basico Manga Larga Amarillo 06\r\n', '1.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 118, 10),
(571, '0540521006117', 'Pañalero Basico Manga Larga Amarillo 03M', 'Pañalero Basico Manga Larga Amarillo 03M\r\n', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 118, 9),
(572, '0540521005117', 'Pañalero Basico Manga Larga Amarillo 00M', 'Pañalero Basico Manga Larga Amarillo 00M\r\n', '2.00', '1.00', '69.00', '169.00', '100.00', 'ACTIVO', '', 52, 6, 118, 8),
(573, '0540731111129', 'Pañalero Basico Manga Corta Verde Agua 24M', 'Pañalero Basico Manga Corta Verde Agua 24M', '2.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 52, 6, 130, 14),
(574, '0540731110129', 'Pañalero Basico Manga Corta Verde Agua 18M', 'Pañalero Basico Manga Corta Verde Agua 18M', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 130, 13),
(575, '0540731109129', 'Pañalero Basico Manga Corta Verde Agua 12M', 'Pañalero Basico Manga Corta Verde Agua 12M', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 52, 6, 130, 12),
(576, '0540731108129', 'Pañalero Basico Manga Corta Verde Agua 09M		', 'Pañalero Basico Manga Corta Verde Agua 09M\r\n', '4.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 130, 11),
(577, '0540731107129', 'Pañalero Basico Manga Corta Verde Agua 06M', 'Pañalero Basico Manga Corta Verde Agua 06M\r\n', '4.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 130, 10),
(578, '0540731106129', 'Pañalero Basico Manga Corta Verde Agua 03M', 'Pañalero Basico Manga Corta Verde Agua 03M\r\n', '2.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 130, 9),
(579, '0540731105129', 'Pañalero Basico Manga Corta Verde Agua 00M', 'Pañalero Basico Manga Corta Verde Agua 00M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 130, 8),
(580, '0540731211118', 'Pañalero Basico Manga Corta Rosa 24M', 'Pañalero Basico Manga Corta Rosa 24M\r\n', '2.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 119, 14),
(581, '0540731210118', 'Pañalero Basico Manga Corta Rosa 18M', 'Pañalero Basico Manga Corta Rosa 18M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 119, 13),
(582, '0540731209118', 'Pañalero Basico Manga Corta Rosa 12M', 'Pañalero Basico Manga Corta Rosa 12M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 119, 12);
INSERT INTO `producto` (`IdProducto`, `Codigo`, `Nombre`, `Descripcion`, `Stock`, `StockMin`, `PrecioCosto`, `PrecioVenta`, `Utilidad`, `Estado`, `Imagen`, `IdCategoria`, `IdProveedor`, `IdColor`, `IdTalla`) VALUES
(583, '0540731208118', 'Pañalero Basico Manga Corta Rosa 09M', 'Pañalero Basico Manga Corta Rosa 09M\r\n', '4.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 119, 11),
(584, '0540731206118', 'Pañalero Basico Manga Corta Rosa 03M', 'Pañalero Basico Manga Corta Rosa 03M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 119, 9),
(585, '0540731205118', 'Pañalero Basico Manga Corta Rosa 00M', 'Pañalero Basico Manga Corta Rosa 00M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 119, 8),
(586, '0540731011121', 'Pañalero Basico Manga Corta Menta 24M', 'Pañalero Basico Manga Corta Menta 24M\r\n', '2.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 122, 14),
(587, '0540731010121', 'Pañalero Basico Manga Corta Menta 18M', 'Pañalero Basico Manga Corta Menta 18M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 122, 13),
(588, '0540731009121', 'Pañalero Basico Manga Corta Menta 12M', 'Pañalero Basico Manga Corta Menta 12M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 122, 12),
(589, '0540731008121', 'Pañalero Basico Manga Corta Menta 09M', 'Pañalero Basico Manga Corta Menta 09M\r\n', '4.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 122, 11),
(590, '0540731007121', 'Pañalero Basico Manga Corta Menta 06M', 'Pañalero Basico Manga Corta Menta 06M\r\n', '1.00', '0.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 122, 10),
(591, '0540731006121', 'Pañalero Basico Manga Corta Menta 03M', 'Pañalero Basico Manga Corta Menta 03M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 122, 9),
(592, '0540731005121', 'Pañalero Basico Manga Corta Menta 00M', 'Pañalero Basico Manga Corta Menta 00M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 122, 8),
(593, '0540731011122', 'Pañalero Basico Manga Corta Maiz 24M', 'Pañalero Basico Manga Corta Maiz 24M\r\n', '2.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 123, 14),
(594, '0540731010122', 'Pañalero Basico Manga Corta Maiz 18M', 'Pañalero Basico Manga Corta Maiz 18M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 123, 13),
(595, '0540731009122', 'Pañalero Basico Manga Corta Maiz 12M', 'Pañalero Basico Manga Corta Maiz 12M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 123, 12),
(596, '0540731008122', 'Pañalero Basico Manga Corta Maiz 09M', 'Pañalero Basico Manga Corta Maiz 09M\r\n', '4.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 123, 11),
(597, '0540731007122', 'Pañalero Basico Manga Corta Maiz 06M', 'Pañalero Basico Manga Corta Maiz 06M\r\n', '2.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 123, 10),
(598, '0540731006122', 'Pañalero Basico Manga Corta Maiz 03M', 'Pañalero Basico Manga Corta Maiz 03M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 123, 9),
(599, '0540731005122', 'Pañalero Basico Manga Corta Maiz 00M', 'Pañalero Basico Manga Corta Maiz 00M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 123, 8),
(600, '0540731211123', 'Pañalero Basico Manga Corta Lila 24M', 'Pañalero Basico Manga Corta Lila 24M\r\n', '2.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 124, 14),
(601, '0540731210123', 'Pañalero Basico Manga Corta Lila 18M', 'Pañalero Basico Manga Corta Lila 18M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 124, 13),
(602, '0540731209123', 'Pañalero Basico Manga Corta Lila 12M', 'Pañalero Basico Manga Corta Lila 12M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 124, 12),
(603, '0540731208123', 'Pañalero Basico Manga Corta Lila 09M', 'Pañalero Basico Manga Corta Lila 09M\r\n', '4.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 124, 11),
(604, '0540731207123', 'Pañalero Basico Manga Corta Lila 06M', 'Pañalero Basico Manga Corta Lila 06M\r\n', '4.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 3, 5, 10),
(605, '0540731206123', 'Pañalero Basico Manga Corta Lila 03M', 'Pañalero Basico Manga Corta Lila 03M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 5, 9),
(606, '0540731205123', 'Pañalero Basico Manga Corta Lila 00M', 'Pañalero Basico Manga Corta Lila 00M\r\n', '3.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 124, 8),
(607, '0540731210124', 'Pañalero Basico Manga Corta Fucsia 24M', 'Pañalero Basico Manga Corta Fucsia 24M\r\n', '2.00', '1.00', '69.00', '159.00', '90.00', 'ACTIVO', '', 73, 6, 125, 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promocion`
--

CREATE TABLE `promocion` (
  `IdPromocion` int(11) NOT NULL,
  `Codigo` varchar(50) NOT NULL,
  `Descuento` int(11) NOT NULL,
  `Estado` varchar(30) DEFAULT 'ACTIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(1, 'SIN PROVEEDOR', '', '', '', '', '', '', '', '', 'ACTIVO', ''),
(2, 'BOTANICUS', 'BOT04012339', '', '', '9982461689', '', 'RIVIERAMAYA@BOTANICUS.COM.MX', '', '', 'ACTIVO', 'GABRIELA GONZALEZ ZURUTUZA'),
(3, 'NAP', '', '', '', '', '', '', '', '', 'ACTIVO', ''),
(4, 'BE BAMBOO', '', '', '', '', '', '', '', '', 'ACTIVO', ''),
(5, 'VEO VEO', '', '', '', '', '', '', '', '', 'ACTIVO', ''),
(6, 'NEEK', '', '', '', '', '', '', '', '', 'ACTIVO', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `talla`
--

CREATE TABLE `talla` (
  `IdTalla` int(11) NOT NULL,
  `Descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `talla`
--

INSERT INTO `talla` (`IdTalla`, `Descripcion`) VALUES
(1, 'SIN TALLA'),
(2, 'Unitalla'),
(3, 'Cama Cuna'),
(4, 'Grande'),
(5, 'Chica'),
(6, 'Mediana'),
(7, 'Moises/Colecho'),
(8, '0 Meses'),
(9, '3 Meses'),
(10, '6 Meses'),
(11, '9 Meses'),
(12, '12 Meses'),
(13, '18 Meses'),
(14, '24 Meses'),
(15, '3 Años'),
(16, '4 Años'),
(17, '5 Años'),
(18, '6 Años'),
(19, '6 Años +'),
(20, 'Cuna');

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
  `Promo` varchar(50) DEFAULT 'NO APLICA',
  `Descuento` decimal(8,2) DEFAULT '0.00',
  `Referencia` varchar(30) DEFAULT 'NO APLICA',
  `TTotal` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`IdVenta`, `IdTipoDocumento`, `IdCliente`, `IdEmpleado`, `Serie`, `Numero`, `Fecha`, `TotalVenta`, `Igv`, `TotalPagar`, `Estado`, `Pago`, `Promo`, `Descuento`, `Referencia`, `TTotal`) VALUES
(3, 1, 1, 7, '001', 'C0000000003', '2018-11-28', '137.07', '21.93', '159.00', 'ANULAR', 'TARJETA', '', '0.00', '001', '159.00'),
(4, 1, 1, 7, '001', 'C0000000004', '2018-11-28', '1187.93', '190.07', '1378.00', 'EMITIDO', 'TARJETA', '', '0.00', '050000', '1378.00');

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
-- Indices de la tabla `color`
--
ALTER TABLE `color`
  ADD PRIMARY KEY (`IdColor`);

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
  ADD KEY `fk_Producto_Categoria_idx` (`IdCategoria`),
  ADD KEY `fk_Producto_Proveedor_idx` (`IdProveedor`),
  ADD KEY `fk_Producto_Color_idx` (`IdColor`),
  ADD KEY `fk_Producto_Talla_idx` (`IdTalla`);

--
-- Indices de la tabla `promocion`
--
ALTER TABLE `promocion`
  ADD PRIMARY KEY (`IdPromocion`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`IdProveedor`);

--
-- Indices de la tabla `talla`
--
ALTER TABLE `talla`
  ADD PRIMARY KEY (`IdTalla`);

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
  MODIFY `IdCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `IdCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `color`
--
ALTER TABLE `color`
  MODIFY `IdColor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;
--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `IdCompra` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `IdEmpleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `IdPedido` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `IdProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=608;
--
-- AUTO_INCREMENT de la tabla `promocion`
--
ALTER TABLE `promocion`
  MODIFY `IdPromocion` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `IdProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `talla`
--
ALTER TABLE `talla`
  MODIFY `IdTalla` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT de la tabla `tipocambio`
--
ALTER TABLE `tipocambio`
  MODIFY `IdTipoCambio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  MODIFY `IdTipoUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `IdVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
