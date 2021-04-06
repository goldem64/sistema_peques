<?php include_once "clases/clsVenta.php";
    session_start();
    error_reporting(0);
    if(isset($_SESSION["usuario"])){
?>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>AdVentas - Sistema Ventas www.incanatoit.com</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/sb-admin-2.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="css/plugins/morris.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
    <div id="wrapper">

        
        <div id="page-wrapper">
            <div class="row">
                
                <div class="col-lg-3 col-md-3">
                    <div class="panel panel-green">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-truck fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">

                                        <?php

                                            

                                            include_once "clases/clsProducto.php";

                                            $objProducto = new clsProducto();

                                            $result=$objProducto->CantidadProductos();

                                            while($row=mysql_fetch_array($result)){
                                                if(!is_null($row['cantidad_producto'])){
                                                    echo $row['cantidad_producto'];
                                                } else {
                                                    echo "0";
                                                }
                                            }
                                        ?>
                                    </div>
                                    <div>Productos</div>
                                </div>
                            </div>
                        </div>
                        <a href="producto/index.php" target="_self">
                            <div class="panel-footer">
                                <span class="pull-left">Ir a Productos</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-tasks fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">

                                        <?php

                                            

                                            $objVenta = new clsVenta();

                                            $result=$objVenta->CompraTotalDiaria();

                                            while($row=mysql_fetch_array($result)){
                                                if(!is_null($row['total_compras'])){
                                                    echo "$ ".$row['total_compras'];
                                                } else {
                                                    echo "$ 0.0";
                                                }
                                                
                                            }

                                        ?>
                                    </div>
                                    <div>Egresos Compras</div>
                                </div>
                            </div>
                        </div>
                        <a href="compra/index.php" target="_self">
                            <div class="panel-footer">
                                <span class="pull-left">Ir a Compras</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3">
                    <div class="panel panel-red">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-shopping-cart fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <?php

                                            

                                            $objVenta = new clsVenta();

                                            $result=$objVenta->VentaTotalDiaria();

                                            while($row=mysql_fetch_array($result)){
                                                if(!is_null($row['Total2'])){
                                                    echo "$ ".$row['Total2'];
                                                } else {
                                                    echo "$ 0.0";
                                                }
                                                
                                            }

                                        ?>

                                    </div>
                                    <div>Ingresos Ventas</div>
                                </div>
                            </div>
                        </div>
                        <a href="venta/index.php" target="_self">
                            <div class="panel-footer">
                                <span class="pull-left">Ir a Ventas</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="col-lg-3 col-md-3">
                    <div class="panel panel-yellow">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-users fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <?php

                                            
                                            include_once "clases/clsCliente.php";

                                            $objCliente = new clsCliente();

                                            $result=$objCliente->consultarTotalClientes();

                                            while($row=mysql_fetch_array($result)){
                                                if(!is_null($row['total'])){
                                                    echo $row['total'];
                                                } else {
                                                    echo "0";
                                                }
                                            }

                                        ?>

                                    </div>
                                    <div>Clientes</div>
                                </div>
                            </div>
                        </div>
                        <a href="cliente/index.php" target="_self">
                            <div class="panel-footer">
                                <span class="pull-left">Ir a Clientes</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Gráficos Estadísticos
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                        Acciones
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu pull-right" role="menu">
                                        <li><a href="#"  onclick="mostrartodo()">Utilidades, Compras, Ventas</a>
                                        </li>
                                        <li><a href="#" onclick="mostrarmes()">Ventas Últimos 12 Meses</a>
                                        </li>
                                        <li><a href="#"  onclick="mostrardia()">Ventas Últimos 15 días</a>
                                        </li>
                                        <li class="divider"></li>
                                        <li><a href="#">Otros</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div id="containertodo" style="width:90%; "></div>
                            <div id="containermes" style="width:90%; display:none;"></div>
                            <div id="containerdia" style="width:90%; display:none;"></div>
                        </div>
                        <!-- /.panel-body -->
                    
                
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="http://code.highcharts.com/modules/exporting.js"></script>

    <script type="text/javascript">
        $(function () {
            $('#containertodo').highcharts({
                 chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: 'Utilidades, Compras y Ventas del Mes Actual'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Mes',
            data: [
                ['Utilidades',   <?php 
                            

                            $objVenta = new clsVenta();

                            $result=$objVenta->MostrarGraficoTotal();

                            while($row=mysql_fetch_array($result)){
                                echo $row['total_utilidad'];
                            }
                        ?>],
                ['Compras',       <?php 
                            

                            $objVenta = new clsVenta();

                            $result=$objVenta->MostrarGraficoTotal();

                            while($row=mysql_fetch_array($result)){
                                echo $row['total_compra'];
                            }
                        ?>],
                ['Ventas',     <?php 
                            

                            $objVenta = new clsVenta();

                            $result=$objVenta->MostrarGraficoTotal();

                            while($row=mysql_fetch_array($result)){
                                echo $row['total_venta'];
                            }
                        ?>]
            ]
        }]
    });
});


    </script>

    <script type="text/javascript">
        $(function () {
            $('#containermes').highcharts({
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Últimos 12 Meses'
                },
                

                subtitle: {
                    text: 'Ventas Mensuales'
                },
                xAxis: {
                    categories: [

                        'Mes'
                    ],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Pesos ($)'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>S/. {point.y:.1f} </b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0
                    }
                },
                series: [
                

                    <?php 
                            

                            $objVenta = new clsVenta();

                            $result=$objVenta->MostrarGraficoMes();

                            while($row=mysql_fetch_array($result)){
                    ?>{

                    name: '<?php echo $row['mes'];?>',
                    data: [<?php echo $row['total_dia'];?>
                    ]},
                    <?php     
                            }
                            ?>
                    

                ]
            });
        });

    </script>

    <script type="text/javascript">
        $(function () {
            $('#containerdia').highcharts({
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Últimos 15 Días'
                },
                

                subtitle: {
                    text: 'Ventas Diarias'
                },
                xAxis: {
                    categories: [

                        'Día'
                    ],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Soles (S./)'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>S/. {point.y:.1f} </b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0
                    }
                },
                series: [
                

                    <?php 
                            

                            $objVenta = new clsVenta();

                            $result=$objVenta->MostrarGraficoDia();

                            while($row=mysql_fetch_array($result)){
                    ?>{

                    name: '<?php echo $row['mes'];?>',
                    data: [<?php echo $row['total_dia'];?>
                    ]},
                    <?php     
                            }
                            ?>
                    

                ]
            });
        });

    </script>


    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2.js"></script>
    <script type="text/javascript" src="js/script.js"></script>
<?php
    } else {
        header("Location:index.php");
    }
?>
</body>

</html>
