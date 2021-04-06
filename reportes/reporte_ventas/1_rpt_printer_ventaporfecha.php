<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../../css/general.css" rel="stylesheet" type="text/css">
</head>
<?php error_reporting (0);?>
<body>
<?php
    session_start();
    if(isset($_SESSION["usuario"])){
?>
<?php
include_once("../../clases/clsVenta.php");

$fechaini=$_GET["fechaini"];
$fechafin=$_GET["fechafin"];

$objVenta=new clsVenta;
if($fechaini==""&&$fechafin==""){
	$hoy = getdate();
	$f = $hoy['year'] . "-" . $hoy['mon'] . "-" . $hoy['mday'];
	$result=$objVenta->consultarVentaPorFecha('consultar',$f,$f,'');
}else{
	$result=$objVenta->consultarVentaPorFecha('consultar',$fechaini,$fechafin,'');	
}

date_default_timezone_set('America/Cancun');
?>
<H4>SISTEMA DE VENTAS</H4>
<center><B><H2>REPORTE GENERAL DE VENTAS</H2></B></center>
<?php 
echo "<b>Fecha: </b>".date('d/m/Y')."<br>";
echo "<b>Hora: </b>".date('H:i:s')."<br >";
?>
&nbsp;
<table class="adminlist" cellspacing="1">
  <thead>
<tr>
	<th>#</th>
	<th><a href="#">Cliente</a></th>
    <th><a href="#">Fecha</a></th>
   
    <th><a href="#">Documento</a></th>
    <th><a href="#">Número</a></th>
    <th><a href="#">Estado</a></th>
    <th><a href="#">Pago</a></th>
    <th><a href="#">#Ref.</a></th>
    <th><a href="#">Promo</a></th>
    <th><a href="#">Subtotal</a></th>
    <th><a href="#">Descuento</a></th>
    <th><a href="#">Total</a></th>
	<th><a href="#">ID</a></th>
</tr>
</thead>

<tbody class="adminlist">
<?php

$c=0;
$i=0;

while($row=mysql_fetch_array($result)){
	$i=$i+1;
	if ($c==1){
	echo "<tr class='row1'>";
		$c=2;
	}else{
	    	echo "<tr class='row0'>";
		$c=1;
	}

echo "<td width='10'>".$i."</td>";
	echo "<td>".$row['Cliente']."</td>";
	echo "<td align='center'>".$row['Fecha']."</td>";

	echo "<td align='center'>".$row['TipoDocumento']."</td>";
	echo "<td align='center'>".$row['Numero']."</td>";
	$estado=$row['Estado'];
	if($estado=="EMITIDO"){
	echo "<td align='center'><img src='../../img/header/emitido.png' title='Emitido'></td>";
	}else{
	echo "<td align='center'><img src='../../img/header/anulado.png' title='Anulado'></td>";
	}
	echo "<td align='center'>".$row['Pago']."</td>";
	if ($row['Referencia'] == "NO APLICA"){
		echo "<td align='center'></td>";
	}
	else{
		echo "<td align='center'>".$row['Referencia']."</td>";
	}
	echo "<td align='center'>".$row['Promo']."</td>";
	echo "<td align='center'>$ ".$row['TotalPagar']."</td>";
	echo "<td align='center'>".$row['Descuento']."%</td>";
	
	echo "<td align='center'>$ ".($row['TotalPagar'] -($row['TotalPagar'] * ($row['Descuento']/100)))."</td>";
	echo "<td width='1%' align='center'>".$row['IdVenta']."</td>";
	echo "</tr>";
}

?>
</tbody>
		<tfoot>
			<tr>
				<td colspan="13">
                <a href="#" onClick="window.print();return false;"><img src="../../img/header/printer.png" border="0" style="cursor:pointer" title="Imprimir"></a>
              </td>
			</tr>
		</tfoot>
</table>
<?php 

    } else {
        header("Location:../../index.php");
    }

?>

</body>
</html>