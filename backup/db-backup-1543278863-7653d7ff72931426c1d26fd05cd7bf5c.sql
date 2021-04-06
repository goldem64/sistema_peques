DROP TABLE categoria;nnCREATE TABLE `categoria` (
  `IdCategoria` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`IdCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;nnINSERT INTO categoria VALUES("1","GENERAL" ) ; nINSERT INTO categoria VALUES("2","ROPA" ) ; nnnnDROP TABLE cliente;nnCREATE TABLE `cliente` (
  `IdCliente` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Ruc` varchar(11) DEFAULT NULL,
  `Dni` varchar(8) DEFAULT NULL,
  `Direccion` varchar(50) DEFAULT NULL,
  `Telefono` varchar(15) DEFAULT NULL,
  `Obsv` text,
  `Usuario` varchar(30) DEFAULT NULL,
  `Contrasena` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`IdCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;nnINSERT INTO cliente VALUES("1","PUBLICO GENERAL","20477157771","47715777","Chiclayo","455630","aaa","cliente","123" ) ; nnnnDROP TABLE color;nnCREATE TABLE `color` (
  `IdColor` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`IdColor`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;nnINSERT INTO color VALUES("1","SIN COLOR" ) ; nINSERT INTO color VALUES("2","VERDE" ) ; nnnnDROP TABLE compra;nnCREATE TABLE `compra` (
  `IdCompra` int(11) NOT NULL AUTO_INCREMENT,
  `IdTipoDocumento` int(11) NOT NULL,
  `IdProveedor` int(11) NOT NULL,
  `IdEmpleado` int(11) NOT NULL,
  `Numero` varchar(20) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `SubTotal` decimal(8,2) DEFAULT NULL,
  `Igv` decimal(8,2) DEFAULT NULL,
  `Total` decimal(8,2) DEFAULT NULL,
  `Estado` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`IdCompra`),
  KEY `fk_Compra_Proveedor1_idx` (`IdProveedor`),
  KEY `fk_Compra_Empleado1_idx` (`IdEmpleado`),
  KEY `fk_Compra_TipoDocumento1_idx` (`IdTipoDocumento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;nnnnnDROP TABLE detallecompra;nnCREATE TABLE `detallecompra` (
  `IdCompra` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `Cantidad` decimal(8,2) NOT NULL,
  `Precio` decimal(8,2) NOT NULL,
  `Total` decimal(8,2) NOT NULL,
  KEY `fk_DetalleCompra_Compra1_idx` (`IdCompra`),
  KEY `fk_DetalleCompra_Producto1_idx` (`IdProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;nnnnnDROP TABLE detallepedido;nnCREATE TABLE `detallepedido` (
  `IdPedido` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `Cantidad` decimal(8,2) DEFAULT NULL,
  `Precio` decimal(8,2) DEFAULT NULL,
  `Total` decimal(8,2) DEFAULT NULL,
  KEY `fk_DetallePedido_Pedido1` (`IdPedido`),
  KEY `fk_DetallePedido_Producto1` (`IdProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;nnnnnDROP TABLE detalleventa;nnCREATE TABLE `detalleventa` (
  `IdVenta` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `Cantidad` decimal(8,2) NOT NULL,
  `Costo` decimal(8,2) NOT NULL,
  `Precio` decimal(8,2) NOT NULL,
  `Descuento` decimal(8,2) DEFAULT '0.00',
  `Total` decimal(8,2) NOT NULL,
  KEY `fk_DetalleVenta_Producto1_idx` (`IdProducto`),
  KEY `fk_DetalleVenta_Venta1_idx` (`IdVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;nnINSERT INTO detalleventa VALUES("1","1","1.00","5400.00","7000.00","0.00","7000.00" ) ; nnnnDROP TABLE empleado;nnCREATE TABLE `empleado` (
  `IdEmpleado` int(11) NOT NULL AUTO_INCREMENT,
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
  `IdTipoUsuario` int(11) NOT NULL,
  PRIMARY KEY (`IdEmpleado`),
  KEY `fk_Empleado_TipoUsuario1_idx` (`IdTipoUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;nnINSERT INTO empleado VALUES("1","Gustavo","Rosas","M","1987-04-27","","","9981113869","goldem64@yahoo.com.mx","","2018-10-01","25000.00","ACTIVO","goldem64","c3581516868fb3b71746931cac66390e","1" ) ; nnnnDROP TABLE pedido;nnCREATE TABLE `pedido` (
  `IdPedido` int(11) NOT NULL AUTO_INCREMENT,
  `IdCliente` int(11) NOT NULL,
  `Fecha_solicitud` datetime DEFAULT NULL,
  `Fecha_entrega` datetime DEFAULT NULL,
  `Total` decimal(8,2) DEFAULT NULL,
  `Estado` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`IdPedido`),
  KEY `fk_Pedido_Cliente1` (`IdCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;nnnnnDROP TABLE producto;nnCREATE TABLE `producto` (
  `IdProducto` int(11) NOT NULL AUTO_INCREMENT,
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
  `IdTalla` int(11) DEFAULT '1',
  PRIMARY KEY (`IdProducto`),
  KEY `fk_Producto_Categoria_idx` (`IdCategoria`),
  KEY `fk_Producto_Proveedor_idx` (`IdProveedor`),
  KEY `fk_Producto_Color_idx` (`IdColor`),
  KEY `fk_Producto_Talla_idx` (`IdTalla`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;nnINSERT INTO producto VALUES("1","5435435345","PANTALON BRINCA CHARCOS NEEK","PANTALON BRINCA CHARCOS NEEK","9.00","1.00","5400.00","7000.00","1600.00","ACTIVO","","2","1","2","2" ) ; nnnnDROP TABLE promocion;nnCREATE TABLE `promocion` (
  `IdPromocion` int(11) NOT NULL AUTO_INCREMENT,
  `Codigo` varchar(50) NOT NULL,
  `Descuento` int(11) NOT NULL,
  `Estado` varchar(30) DEFAULT 'ACTIVO',
  PRIMARY KEY (`IdPromocion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;nnINSERT INTO promocion VALUES("3","PRM90","90","ACTIVO" ) ; nnnnDROP TABLE proveedor;nnCREATE TABLE `proveedor` (
  `IdProveedor` int(11) NOT NULL AUTO_INCREMENT,
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
  `Obsv` text,
  PRIMARY KEY (`IdProveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;nnINSERT INTO proveedor VALUES("1","SIN PROVEEDOR","","","","","","","","","ACTIVO","" ) ; nnnnDROP TABLE talla;nnCREATE TABLE `talla` (
  `IdTalla` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`IdTalla`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;nnINSERT INTO talla VALUES("1","SIN TALLA" ) ; nINSERT INTO talla VALUES("2","3 MESES" ) ; nnnnDROP TABLE tipocambio;nnCREATE TABLE `tipocambio` (
  `IdTipoCambio` int(11) NOT NULL AUTO_INCREMENT,
  `TipoCambio` decimal(4,2) NOT NULL,
  PRIMARY KEY (`IdTipoCambio`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;nnINSERT INTO tipocambio VALUES("1","19.02" ) ; nnnnDROP TABLE tipodocumento;nnCREATE TABLE `tipodocumento` (
  `IdTipoDocumento` int(11) NOT NULL,
  `Descripcion` varchar(80) NOT NULL,
  PRIMARY KEY (`IdTipoDocumento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;nnINSERT INTO tipodocumento VALUES("1","TICKET" ) ; nnnnDROP TABLE tipousuario;nnCREATE TABLE `tipousuario` (
  `IdTipoUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`IdTipoUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;nnINSERT INTO tipousuario VALUES("1","ADMINISTRADOR" ) ; nINSERT INTO tipousuario VALUES("2","CAJERO" ) ; nnnnDROP TABLE venta;nnCREATE TABLE `venta` (
  `IdVenta` int(11) NOT NULL AUTO_INCREMENT,
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
  `TTotal` decimal(8,2) NOT NULL,
  PRIMARY KEY (`IdVenta`),
  KEY `fk_Venta_TipoDocumento1_idx` (`IdTipoDocumento`),
  KEY `fk_Venta_Cliente1_idx` (`IdCliente`),
  KEY `fk_Venta_Empleado1_idx` (`IdEmpleado`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;nnINSERT INTO venta VALUES("1","1","1","1","001","C0000000001","2018-11-25","6034.48","965.52","7000.00","EMITIDO","TARJETA","PRM90","90.00","0001","700.00" ) ; nnnn