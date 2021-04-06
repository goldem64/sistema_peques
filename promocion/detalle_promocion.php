<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../css/general.css" rel="stylesheet" type="text/css">
<link href="../css/icon.css" rel="stylesheet" type="text/css">
</head>
<?php error_reporting (0);?>
<body>
<?php
    session_start();
    if(isset($_SESSION["usuario"])){
?>
<?php
include_once("../clases/clsPromocion.php");

$idpromo=$_GET['idpromocion'];
echo "promocion: " + $idpromo;


$objpromocion = new clsPromocion;
$resultado=$objpromocion->consultarPromocionPorParametro('id',$idpromo,'');

while($row=@mysql_fetch_array($resultado)){
		$idpromocion=$row["IdPromocion"];
        echo "idpromocion :" + $idpromocion;
		$codigo=$row["Codigo"];
        $descuento=$row["Descuento"];
}


?>
<div class="wrapper">
<div class="block">

    <div class="block_head"> 
    	<div class="imagen_head"><img src="../img/header/categoria.png" width="48" height="48"></div>
    	<div class="titulo_head">GESTOR DE PROMOCIONES</div>
		
        
 <div class="toolbar" id="toolbar">
            <table class="toolbar">
            	<tbody>
                	<tr>
                    <td>
                    <?php
                        echo "<a class='toolbar' href=editar_promocion.php?idpromocion=".$idpromocion."><span class='icon-32-editar' title='Editar'>
                        </span>Editar</a>"; ?>
     
                    </td>                        
                    <td>
                        <a href="registrar_promocion.php" class="toolbar">
                        <span class="icon-32-nuevo" title="Nuevo">
                        </span>
                        Nuevo
                        </a>
                    </td>
                    <td>
                        <a href="index.php" class="toolbar">
                        <span class="icon-32-cancelar" title="Cerrar">
                        </span>
                        Cerrar
                        </a>
                    </td>                                    
                    <td>
                        <a href="#" class="toolbar">
                        <span class="icon-32-ayuda" title="Ayuda">
                        </span>
                        Ayuda
                        </a>
                    </td>                   
                    </tr>
            	</tbody>
            </table>
        
        </div><!--Cierra toolbar-->                
    </div><!--Cierra block_head-->
    
    <div class="block_content">
    <fieldset class="adminform">
    <legend>Detalle del tipo de documento</legend>


<table class="admintable">
	<tr>
		<td width="100" class="key">ID:</td>
		<td><?php echo $idpromocion?></td>
	</tr>
    <tr>
		<td class="key">Codigo:</td>
		<td><?php echo $codigo?></td>
	</tr>

     <tr>
        <td class="key">Descuento:</td>
        <td><?php echo $descuento?></td>
    </tr>


</table>
</fieldset>
    </div><!--Cierra block_content-->
</div><!--Cierra block-->
</div><!--Cierra Wrapper-->
<?php 

    } else {
        header("Location:../index.php");
    }

?>
</body>
</html>