<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../css/general.css" rel="stylesheet" type="text/css">
<link href="../css/Imagenes.css" rel="stylesheet" type="text/css">
<link href="../css/box.css" rel="stylesheet" type="text/css">
</head>
<?php error_reporting (0);?>
<body>
<?php
    session_start();
    if(isset($_SESSION["usuario"])){
?>

<?php
include_once("../clases/clsPromocion.php");
$objtipodoc=new clsPromocion;

$accion=$_POST["accion"];
$idcod =$_POST["idcod"];
$codigo=$_POST["codigo"];
$descuento=$_POST["descuento"];
$estado=$_POST["estado"];

if ($accion=="guardar") {

	if ($objtipodoc->agregarPromocion($codigo,$descuento,$estado)==true)
	{
		$result=$objtipodoc->consultarPromocionIdMaximo();
		$mensaje="Registro grabado correctamente";
	}else{
		$mensaje="Error de grabacion";
	}
	
	while($row=mysql_fetch_array($result))
	{
		$cod=$row['Maximo'];
	}
}

if ($accion=="modificar") 
{
   

	$cod=$_POST["idcod"];
	$codigo=$_POST["codigo"];
    $descuento=$_POST["descuento"];
    $estado=$_POST["estado"];
   

	$objtipodoc=new clsPromocion;
	if ($objtipodoc->modificarPromocion($idcod,$codigo,$descuento,$estado)==true)
	{
		$mensaje="Registro actualizado correctamente";
	}else{
		$mensaje="Error de grabacion";
	}
}
?>      
     
<div class="wrapper">
<div class="block">
	<div class="block_head"> 
    <div class="imagen_head"><img src="../img/Iconfinder/archiver-32.png" width="48" height="48"></div>
    <div class="titulo_head">GESTOR DEL TIPO DE DOCUMENTO</div>    
		<div class="toolbar" id="toolbar">
            <table class="toolbar">
            	<tbody>
                	<tr>       
                    <td>
                        <a href="registrar_promocion.php" class="toolbar">
                        <span class="Nuevo" title="Nuevo">
                        </span>
                        Nuevo
                        </a>
                    </td>
                    <td>
                        <a href="index.php" class="toolbar">
                        <span class="Cancelar" title="Cerrar">
                        </span>
                        Cerrar
                        </a>
                    </td>                                    
                    <td>
                        <a href="#" class="toolbar">
                        <span class="Ayuda" title="Ayuda">
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
    <div class="box-info"><?php echo $mensaje ?></div>

    <fieldset class="adminform">
    <legend>Detalles de la promocion</legend>
    <table class="admintable">
        <tr>
            <td class="key">ID:</td>
            <td><?php echo $cod?></td>
        </tr>
        <tr>
            <td class="key">Codigo:</td>
            <td><?php echo $codigo?></td>
        </tr>

         <tr>
            <td class="key">Descuento:</td>
            <td><?php echo $descuento?></td>
        </tr>
        <tr>
            <td class="key">Estado:</td>
            <td><?php echo $estado?></td>
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