DROP TABLE categoria;nnCREATE TABLE `categoria` (
  `IdCategoria` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`IdCategoria`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;nnINSERT INTO categoria VALUES("1","Tecnología" ) ; nINSERT INTO categoria VALUES("2","Fármacos" ) ; nINSERT INTO categoria VALUES("3","Bebidas" ) ; nINSERT INTO categoria VALUES("4","Cereales" ) ; nINSERT INTO categoria VALUES("5","Software" ) ; nINSERT INTO categoria VALUES("6","Regalos" ) ; nINSERT INTO categoria VALUES("7","Útiles Escolares" ) ; nnnnDROP TABLE cliente;nnCREATE TABLE `cliente` (
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;nnINSERT INTO cliente VALUES("1","PUBLICO GENERAL","20477157771","47715777","Chiclayo","455630","aaa","cliente","123" ) ; nINSERT INTO cliente VALUES("2","Luis Arcila Díaz","","74653987","José Gálvez - Chiclayo","979026684","","","" ) ; nnnnDROP TABLE compra;nnCREATE TABLE `compra` (
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;nnINSERT INTO compra VALUES("1","1","1","1","C0000000001","2015-04-20","273.37","49.21","322.58","EMITIDO" ) ; nINSERT INTO compra VALUES("2","1","1","1","C0000000002","2015-04-20","21.19","3.81","25.00","EMITIDO" ) ; nINSERT INTO compra VALUES("3","1","1","1","C0000000003","2015-04-20","1366.86","246.03","1612.90","EMITIDO" ) ; nINSERT INTO compra VALUES("4","2","1","1","C0000000004","2015-04-23","379.31","68.28","447.58","EMITIDO" ) ; nINSERT INTO compra VALUES("5","1","2","1","C0000000005","2015-05-06","487.29","87.71","575.00","EMITIDO" ) ; nnnnDROP TABLE detallecompra;nnCREATE TABLE `detallecompra` (
  `IdCompra` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `Cantidad` decimal(8,2) NOT NULL,
  `Precio` decimal(8,2) NOT NULL,
  `Total` decimal(8,2) NOT NULL,
  KEY `fk_DetalleCompra_Compra1_idx` (`IdCompra`),
  KEY `fk_DetalleCompra_Producto1_idx` (`IdProducto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;nnINSERT INTO detallecompra VALUES("1","3","1.00","322.58","322.58" ) ; nINSERT INTO detallecompra VALUES("2","2","1.00","25.00","25.00" ) ; nINSERT INTO detallecompra VALUES("3","3","5.00","322.58","1612.90" ) ; nINSERT INTO detallecompra VALUES("4","3","1.00","322.58","322.58" ) ; nINSERT INTO detallecompra VALUES("4","2","5.00","25.00","125.00" ) ; nINSERT INTO detallecompra VALUES("5","8","50.00","1.50","75.00" ) ; nINSERT INTO detallecompra VALUES("5","7","50.00","10.00","500.00" ) ; nnnnDROP TABLE detallepedido;nnCREATE TABLE `detallepedido` (
  `IdPedido` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `Cantidad` decimal(8,2) DEFAULT NULL,
  `Precio` decimal(8,2) DEFAULT NULL,
  `Total` decimal(8,2) DEFAULT NULL,
  KEY `fk_DetallePedido_Pedido1` (`IdPedido`),
  KEY `fk_DetallePedido_Producto1` (`IdProducto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;nnnnnDROP TABLE detalleventa;nnCREATE TABLE `detalleventa` (
  `IdVenta` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `Cantidad` decimal(8,2) NOT NULL,
  `Costo` decimal(8,2) NOT NULL,
  `Precio` decimal(8,2) NOT NULL,
  `Total` decimal(8,2) NOT NULL,
  KEY `fk_DetalleVenta_Producto1_idx` (`IdProducto`),
  KEY `fk_DetalleVenta_Venta1_idx` (`IdVenta`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;nnINSERT INTO detalleventa VALUES("1","3","3.00","322.58","482.24","1446.72" ) ; nINSERT INTO detalleventa VALUES("1","2","5.00","25.00","45.00","225.00" ) ; nINSERT INTO detalleventa VALUES("2","4","1.00","40.00","40.00","40.00" ) ; nINSERT INTO detalleventa VALUES("3","2","1.00","25.00","45.00","45.00" ) ; nINSERT INTO detalleventa VALUES("4","2","1.00","25.00","45.00","45.00" ) ; nINSERT INTO detalleventa VALUES("5","3","3.00","322.58","482.24","1446.72" ) ; nINSERT INTO detalleventa VALUES("5","2","1.00","25.00","45.00","45.00" ) ; nINSERT INTO detalleventa VALUES("6","2","1.00","25.00","45.00","45.00" ) ; nINSERT INTO detalleventa VALUES("7","4","3.00","40.00","40.00","120.00" ) ; nINSERT INTO detalleventa VALUES("7","5","1.00","2.00","2.00","2.00" ) ; nINSERT INTO detalleventa VALUES("8","2","2.00","25.00","45.00","90.00" ) ; nINSERT INTO detalleventa VALUES("9","2","2.00","25.00","50.00","100.00" ) ; nINSERT INTO detalleventa VALUES("9","3","3.00","328.58","482.24","1446.72" ) ; nINSERT INTO detalleventa VALUES("10","2","3.00","25.00","45.00","135.00" ) ; nINSERT INTO detalleventa VALUES("11","2","2.00","25.00","45.00","90.00" ) ; nINSERT INTO detalleventa VALUES("12","2","2.00","25.00","45.00","90.00" ) ; nINSERT INTO detalleventa VALUES("13","2","4.00","25.00","45.00","180.00" ) ; nINSERT INTO detalleventa VALUES("14","5","1.00","2.00","2.00","2.00" ) ; nINSERT INTO detalleventa VALUES("15","7","10.00","10.00","20.00","200.00" ) ; nINSERT INTO detalleventa VALUES("15","8","10.00","1.50","2.00","20.00" ) ; nnnnDROP TABLE empleado;nnCREATE TABLE `empleado` (
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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;nnINSERT INTO empleado VALUES("1","Juan Carlos","Arcila Díaz","M","2013-06-15","Chiclayo - Perú","455630","979026684","jcarlos.ad7@gmail.com","47715777","2013-06-15","2500.00","ACTIVO","admin","21232f297a57a5a743894a0e4a801fc3","1" ) ; nnnnDROP TABLE pedido;nnCREATE TABLE `pedido` (
  `IdPedido` int(11) NOT NULL AUTO_INCREMENT,
  `IdCliente` int(11) NOT NULL,
  `Fecha_solicitud` datetime DEFAULT NULL,
  `Fecha_entrega` datetime DEFAULT NULL,
  `Total` decimal(8,2) DEFAULT NULL,
  `Estado` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`IdPedido`),
  KEY `fk_Pedido_Cliente1` (`IdCliente`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;nnnnnDROP TABLE producto;nnCREATE TABLE `producto` (
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
  PRIMARY KEY (`IdProducto`),
  KEY `fk_Producto_Categoria_idx` (`IdCategoria`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;nnINSERT INTO producto VALUES("1","11","Monitor","monitor LCD pantalla de retina liquida","10.00","2.00","80.00","100.00","20.00","ACTIVO","","1" ) ; nINSERT INTO producto VALUES("2","22","Teclado Multifuncional","Teclado ergonomico","-4.00","3.00","25.00","45.00","20.00","ACTIVO","","1" ) ; nINSERT INTO producto VALUES("3","33","CPU","Unidad Central de Procesamiento","11.00","5.00","322.58","482.24","159.66","ACTIVO","","1" ) ; nINSERT INTO producto VALUES("4","123567","Mouse Inalambrico","Inalambrico","46.00","50.00","40.00","40.00","0.00","ACTIVO","mouse.jpg","1" ) ; nINSERT INTO producto VALUES("5","823824723","amoxicilina","","118.00","120.00","2.00","2.00","0.00","ACTIVO","","2" ) ; nINSERT INTO producto VALUES("7","13698","Flores Aromatizadas","Flores artificiales adornos","140.00","10.00","10.00","20.00","10.00","ACTIVO","1430921601-flores_aromatizadas.jpg","6" ) ; nINSERT INTO producto VALUES("8","400638157","Marcador para pizarra","marcador para pizarra de diferentes colores","140.00","10.00","1.50","2.00","0.50","ACTIVO","1430921643-Marcador.jpg","7" ) ; nnnnDROP TABLE proveedor;nnCREATE TABLE `proveedor` (
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;nnINSERT INTO proveedor VALUES("1","SIN PROVEEDOR","","","","","","","","","ACTIVO","" ) ; nINSERT INTO proveedor VALUES("2","Inversiones Santa Catalina S.A.C.","2047715777","47715777","Bolivar 1534 - Chiclayo","455630","979026684","","","","ACTIVO","" ) ; nnnnDROP TABLE tipodocumento;nnCREATE TABLE `tipodocumento` (
  `IdTipoDocumento` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(80) NOT NULL,
  PRIMARY KEY (`IdTipoDocumento`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;nnINSERT INTO tipodocumento VALUES("1","BOLETA" ) ; nINSERT INTO tipodocumento VALUES("2","FACTURA" ) ; nINSERT INTO tipodocumento VALUES("3","TICKET" ) ; nnnnDROP TABLE tipousuario;nnCREATE TABLE `tipousuario` (
  `IdTipoUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`IdTipoUsuario`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;nnINSERT INTO tipousuario VALUES("1","ADMINISTRADOR" ) ; nINSERT INTO tipousuario VALUES("2","CAJERO" ) ; nnnnDROP TABLE venta;nnCREATE TABLE `venta` (
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
  PRIMARY KEY (`IdVenta`),
  KEY `fk_Venta_TipoDocumento1_idx` (`IdTipoDocumento`),
  KEY `fk_Venta_Cliente1_idx` (`IdCliente`),
  KEY `fk_Venta_Empleado1_idx` (`IdEmpleado`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;nnINSERT INTO venta VALUES("1","1","1","1","001","C0000000001","2015-04-20","1416.71","255.01","1671.72","EMITIDO" ) ; nINSERT INTO venta VALUES("2","1","1","1","001","C0000000002","2015-04-20","33.90","6.10","40.00","EMITIDO" ) ; nINSERT INTO venta VALUES("3","1","1","1","001","C0000000003","2015-04-20","38.14","6.87","45.00","EMITIDO" ) ; nINSERT INTO venta VALUES("4","1","1","1","001","C0000000004","2015-04-20","38.14","6.87","45.00","EMITIDO" ) ; nINSERT INTO venta VALUES("5","1","1","1","001","C0000000005","2015-04-20","1264.17","227.55","1491.72","EMITIDO" ) ; nINSERT INTO venta VALUES("6","1","1","1","001","C0000000006","2015-04-20","38.14","6.87","45.00","EMITIDO" ) ; nINSERT INTO venta VALUES("7","1","1","1","001","C0000000007","2015-04-21","103.39","18.61","122.00","EMITIDO" ) ; nINSERT INTO venta VALUES("8","1","1","1","001","C0000000008","2015-04-22","76.27","13.73","90.00","EMITIDO" ) ; nINSERT INTO venta VALUES("9","1","1","1","C0000","C0000000008","2015-05-12","68.50","18.50","70.00","EMITIDO" ) ; nINSERT INTO venta VALUES("10","2","1","1","001","C0000000010","2015-04-23","114.41","20.59","135.00","EMITIDO" ) ; nINSERT INTO venta VALUES("11","1","1","1","001","C0000000011","2015-04-23","76.27","13.73","90.00","EMITIDO" ) ; nINSERT INTO venta VALUES("12","1","1","1","001","C0000000012","2015-04-23","76.27","13.73","90.00","EMITIDO" ) ; nINSERT INTO venta VALUES("13","1","1","1","001","C0000000013","2015-04-23","152.54","27.46","180.00","EMITIDO" ) ; nINSERT INTO venta VALUES("14","1","1","1","001","C0000000014","2015-04-26","1.69","0.30","2.00","EMITIDO" ) ; nINSERT INTO venta VALUES("15","1","2","1","001","C0000000015","2015-05-06","186.44","33.56","220.00","EMITIDO" ) ; nnnn