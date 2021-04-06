<?php error_reporting (0);?>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body>
<?php
include_once("../clases/clsVenta.php");
include_once("../clases/clsDetalleVenta.php");

$objVenta = new clsVenta;
$result_v=$objVenta->consultarVentaUltimoId();

while($row_venta=mysql_fetch_array($result_v)){
	$idventa=$row_venta['id'];
}

$result_vd=$objVenta->consultarVentaPorParametro('id',$idventa);
while($row_ventad=mysql_fetch_array($result_vd)){
	$tipo_doc=$row_ventad['TipoDocumento'];
	$cliente=$row_ventad['Cliente'];
	$empleado=$row_ventad['Empleado'];
	$serie=$row_ventad['Serie'];
	$numero=$row_ventad['Numero'];
	$fecha_ven=$row_ventad['Fecha'];
	$total_ven=$row_ventad['TotalVenta'];
	$igv_ven=$row_ventad['Igv'];
	$totalpago_ven=$row_ventad['TotalPagar'];
    $descuento_ven=$row_ventad['Descuento'];				
}

date_default_timezone_set('America/Cancun');
?>
<?php
$objDetalle = new clsDetalleVenta;
$result_det=$objDetalle->consultarDetalleVentaPorParametro('id',$idventa);


?>
<div class="zona_impresion">
        <!-- codigo imprimir -->
<br>
<center><img src="../img/icon/logo_casita_jpg.jpg" width="124px" height="124px" /></center>
<table  border="0" align="center" width="300px">
	<tr>
    	<td align="center">
        .::<font size="5"><strong>Peque's Closet</strong></font>::.
		
        <br>
        Jose Salvador Romo Balcazar<br>
        Cel. 0000000000 -  Tel. 0000000  R.F.C.: ROBS530403S17
		
		</td>
	</tr>
    <tr>
        <td align="center"><?php echo "Fecha/Hora: ".date("Y-m-d H:i:s"); ?></td>
    </tr>
    <tr>
      <td align="center"></td>
    </tr>
    <tr>
        <td><font size="2">Cliente: <?php echo $cliente; ?></font></td>
    </tr>
    <tr>
    	<td><font size="2">Cajero: <?php echo $empleado; ?></font></td>
    </tr>
    <tr>
    	<td><font size="2">Nº de venta: <?php echo $serie." - ".$numero ; ?></font></td>
    </tr>    
</table>
<br>
<table border="0" align="center" width="300px">
    <tr>
    	<font size="3">
    	<td>CANT.</td>
    	<td>DESCRIPCIÓN</td>
    	<td align="right">IMPORTE</td>

    </tr>
    <tr>
      <td colspan="3">==========================================</td>
    </tr>
    
    <?php
    while($row_detalle=mysql_fetch_array($result_det)){
		echo "<tr>";
		echo "<td>".$row_detalle['Cantidad']."</td>";
		echo "<td>".$row_detalle['Nombre']."</td>";
		echo "<td align='right'>$ ".$row_detalle['Total']."</td>";
		echo "</tr>";
		$cantidad+=$row_detalle['Cantidad'];
	}
	?>
    <tr>
      <td colspan="3">==========================================</td>
    </tr>
    <tr>
    </font>
    <td>&nbsp;</td>


    <td align="right"><b>SUBTOTAL:</b></td>
    <td align="right"><b>$ <?php echo $totalpago_ven  ?></b></td>
    </tr>
    <tr>
    <td>&nbsp;</td>
    <td align="right"><b>DESCUENTO:</b></td>
    <?$des=($totalpago_ven *($descuento_ven/100)); /*$descuento_ven*/?>
    <td align="right"><b>$<?php echo number_format($des,2,".",",");?></b></td>
    </tr>
    <tr>
    <td>&nbsp;</td>
    <td align="right"><b>TOTAL:</b></td>
    <?$tventa = ($totalpago_ven - ($totalpago_ven *($descuento_ven/100)));?>
    <td align="right"><b>$ <?echo number_format($tventa,2,".",",")?></b></td>
    </tr>
    <tr>
      <td colspan="3">Nº de artículos: <?php echo $cantidad ?></td>
    </tr>
    <tr>
      <td colspan="3">&nbsp;</td>
    </tr>      
    <tr>
      <td colspan="3" align="center">¡Gracias por su compra!</td>
    </tr>
    <tr>
      <td colspan="3" align="center">www.pequescloset.com</td>
    </tr>
    <tr>
      <td colspan="3" align="center">Cancun - Mexico</td>
    </tr>
    
</table>
<br>
</div>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>




  
  <div style="margin-left:245px;"><a href="#" onClick="window.print();return false;"><img src="../img/header/printer.png" border="0" style="cursor:pointer" title="Imprimir"></a></div>
</body>
</html>