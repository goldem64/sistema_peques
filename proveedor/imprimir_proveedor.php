<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<?php error_reporting (0);?>
<body>
<?php
    session_start();
    if(isset($_SESSION["usuario"])){
?>
<?php
include_once("../clases/clsProveedor.php");
$criterio=$_GET["criterio"];
$busqueda=$_GET["busqueda"];

$objProveedor=new clsProveedor;
$result=$objProveedor->consultarProveedorPorParametro($criterio,$busqueda,'');
date_default_timezone_set('America/Lima');
?>
<H4>LA CASITA ARTESANAL</H4>
<center><B><H2>REPORTE DE PROVEEDORES</H2></B></center>
<?php 
echo "<b>Fecha: </b>".date('d/m/Y')."<br>";
echo "<b>Hora: </b>".date('H:i:s')."<br >";
?>
&nbsp;

<table class="adminlist" cellspacing="1">
  <thead>
<tr>
	<th>#</th>
	<th><a href="#">Nombre o Razón Social</a></th>
	<th><a href="#">RFC</a></th>
	<th><a href="#">INE</a></th>
	<th><a href="#">Dirección</a></th>
	<th><a href="#">Teléfono</a></th>  
	<th><a href="#">Estado</a></th>
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
	echo "<td width='40%'>".$row['Nombre']."</td>";
	echo "<td align='center'>".$row['Ruc']."</td>";
	echo "<td align='center'>".$row['Dni']."</td>";
	echo "<td align='center'>".$row['Direccion']."</td>";
	echo "<td align='center'>".$row['Telefono']."</td>";
	$estado=$row['Estado'];
	if($estado=="ACTIVO"){
	echo "<td align='center'><img src='../img/header/activo.png' title='Activo'></td>";
	}else{
	echo "<td align='center'><img src='../img/header/inactivo.png' title='Inactivo'></td>";
	}
	echo "<td width='1%'>".$row['IdProveedor']."</td>";
	echo "</tr>";
}

?>
</tbody>
		<tfoot>
			<tr>
				<td colspan="13">
                <a href="#" onClick="window.print();return false;"><img src="../img/header/printer.png" border="0" style="cursor:pointer" title="Imprimir"></a>
              </td>
			</tr>
		</tfoot>
</table>

<?php 

    } else {
        header("Location:../index.php");
    }

?>
</body>
</html>