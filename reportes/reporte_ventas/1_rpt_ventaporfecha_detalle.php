<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../../css/general.css" rel="stylesheet" type="text/css">
<link href="../../css/icon.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
    function cancelarventa($id){

        var idventa = $id;
        var opcion = confirm("¿Realmente desea cancelar la venta?");
        if (opcion == true){
        window.location.href="1_rpt_ventaporfecha_detalle.php?idv="+idventa;
        }

       

    }


</script>
</head>
<?php error_reporting (0);?>
<body>
<?php
    session_start();
    if(isset($_SESSION["usuario"])){
?>
<?php
include_once("../../clases/clsVenta.php");


$idventa=$_GET['idventa'];

$objVenta = new clsVenta;

if (isset($_GET['idv'])){
    $idve = $_GET['idv'];
    $objVenta->cancelarventa($idve,'ANULAR');
    header("location: 1_rpt_ventaporfecha.php");
}

$result=$objVenta->consultarVentaPorParametro('id',$idventa);

while($row=@mysql_fetch_array($result)){
		$tipodoc=$row["TipoDocumento"];
		$cliente=$row["Cliente"];
		$empleado=$row["Empleado"];
		$serie=$row["Serie"];
		$numero=$row["Numero"];
		$fecha=$row["Fecha"];
		$totalventa=$row["TotalVenta"];
		$igv=$row["Igv"];
		$totalpagar=$row["TotalPagar"];
		$estado=$row["Estado"];
}

?>
<div class="wrapper">
<div class="block">

    <div class="block_head"> 
    	<div class="imagen_head"><img src="../../img/header/rpt_venta_fecha.png" width="48" height="48"></div>
       
    	<div class="titulo_head">INFORME DE VENTAS</div>
		
        
 <div class="toolbar" id="toolbar">
            <table class="toolbar">
            	<tbody>
                	<tr>     

                    <td>
                       <button type="submit" class="button" onClick="cancelarventa(<?echo $idventa;?>);">
              
                   <span class="icon-32-cancelar" title="Cerrar">
                    </span>
                        Cancelar Venta
                    </button>
                    </td>                       

                    <td>
                        <a href="1_rpt_ventaporfecha.php" class="toolbar">
                        <span class="icon-32-regresar" title="Cerrar">
                        </span>
                        Cerrar
                        </a>
                    </td>                                    
                                 
                    </tr>
            	</tbody>
            </table>
        
        </div><!--Cierra toolbar-->                
    </div><!--Cierra block_head-->
    
    <div class="block_content">
        <fieldset class="adminform">
        <legend>Datos de la venta</legend>
      
        <table class="admintable">
            <tr>
                <td width="100" class="key">Nº de venta:</td>
                <td><?php echo $serie." - ".$numero?></td>
            </tr>
            <tr>
                <td class="key">Fecha:</td>
                <td><?php echo $fecha?></td>
            </tr>
            <tr>
                <td class="key">Documento:</td>
                <td><?php echo $tipodoc?></td>
            </tr>
            <tr>
                <td class="key">Cliente:</td>
                <td><?php echo $cliente?></td>
            </tr>
            <tr>
                <td class="key">Empleado:</td>
                <td><?php echo $empleado?></td>
            </tr>
            <tr>
                <td class="key">Valor venta:</td>
                <td><?php echo "$ ".$totalventa?></td>
            </tr>
            <tr>
                <td class="key">IVA:</td>
                <td><?php echo "$ ".$igv?></td>
            </tr>
            <tr>
                <td class="key">Total:</td>
                <td><?php echo "<b>$ ".$totalpagar."</b>"?></td>
            </tr>
        </table>
        </fieldset>

</fieldset>
<fieldset class="adminform">
<legend>Detalle de la venta</legend>
<table class="adminlist" cellspacing="1">
<thead>
<tr>
	<th>#</th>
	<th><a href="#">Código</a></th>
   	<th><a href="#">Nombre</a></th>
   	<th><a href="#">Descripción</a></th>
	<th><a href="#">Cantidad</a></th>    
	<th><a href="#">Precio Unit.</a></th>
	<th><a href="#">Total</a></th> 
	<th><a href="#">ID</a></th>
</tr>
</thead>

<tbody class="adminlist">

<?php
include_once("../../clases/clsDetalleVenta.php");
$objDetalle = new clsDetalleVenta;
$result_det=$objDetalle->consultarDetalleVentaPorParametro('id',$idventa);



$c=0;
$i=0;

while($row=mysql_fetch_array($result_det)){
	$i=$i+1;
	if ($c==1){
	echo "<tr class='row1'>";
		$c=2;
	}else{
	    	echo "<tr class='row0'>";
		$c=1;
	}

	echo "<td width='10'>".$i."</td>";
	echo "<td align='center'>".$row['Codigo']."</td>";
	echo "<td>".$row['Nombre']."</td>";
	echo "<td>".$row['Descripcion']."</td>";
	echo "<td align='center'>".$row['Cantidad']."</td>";
	echo "<td align='center'>"."$ ".$row['Precio']."</td>";
	echo "<td align='center'>"."$ ".$row['Total']."</td>";
	echo "<td align='center'>".$row['IdVenta']."</td>";
	echo "</tr>";
}

?>
</tbody>
		<tfoot>
			<tr>
				<td colspan="13">
               <div align="left" style="padding:4px 0px 4px 4px;"><?php echo "Se cargaron ".$i." productos" ?></div>
                
                </td>
			</tr>
		</tfoot>
</table>
</fieldset>
</div><!--Cierra block_content-->
</div><!--Cierra block-->
</div><!--Cierra Wrapper-->
<?php 

    } else {
        header("Location:../../index.php");
    }

?>
</body>
</html>