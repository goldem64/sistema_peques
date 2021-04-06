<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../css/general.css" rel="stylesheet" type="text/css">
<link href="../css/icon.css" rel="stylesheet" type="text/css">
<link href="../css/box.css" rel="stylesheet" type="text/css">
<script> 
function enviar_formulario(){ 
   document.form1.submit(); 
} 
</script> 
<style>
/* Estilo por defecto para validacion */  
input:required:invalid {  border: 1px solid red;  }  input:required:valid {  border: 1px solid green;  }
</style>
</head>
<?php error_reporting (0);?>
<body>
<?php
    session_start();
    if(isset($_SESSION["usuario"])){
?>

<div class="wrapper">
<form name="form_tipodoc" method="post" action="guardar_promocion.php">
<div class="block">

    <div class="block_head"> 
    	<div class="imagen_head"><img src="../img/header/categoria.png" width="48" height="48"></div>
    <div class="titulo_head">EDITAR PROMOCION</div>
    
      <div class="toolbar" id="toolbar">
            <table class="toolbar">
            	<tbody>
                	<tr>     
                    <td>
                    
<button type="submit" class="button">
                   <span class="icon-32-guardar_editar" title="Guardar">
                        </span>
                        Guardar
          			</button>
                    </td>       
                    <td>
                        <a href="index.php" class="toolbar">
                        <span class="icon-32-cancelar" title="Nuevo">
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

<?php
include_once("../clases/clsPromocion.php");

$id_promo=$_GET["idpromocion"];
	
$objtipodoc=new clsPromocion;
$resultado=$objtipodoc->consultarPromocionPorParametro('id',$id_promo,'');
	
while($row=mysql_fetch_array($resultado)){
	$cod=$row["IdPromocion"];
	$idpromocion=$row["IdPromocion"];
	$codigo=$row["Codigo"];
    $descuento=$row["Descuento"];
    $estado=$row["Estado"];
}

?>


<input type="hidden" name="idcod" value="<?php echo $id_promo ?>">
<input id="accion" name="accion" value="modificar" type="hidden">
    <fieldset class="adminform">
    <legend>Detalles del tipo de cambio</legend>
    <table class="admintable">
        <tr>
            <td width="100" class="key">ID:</td>
            <td><?php echo $id_promo ?></td>
        </tr>
        <tr>
            <td class="key">Codigo:</td>
            <td><input type="text" name="codigo" value="<?php echo $codigo ?>" size="20" title="Codigo de promocion"  required></td>
        </tr>

        <tr>
            <td class="key">Descuento:</td>
            <td><input type="text" name="descuento" value="<?php echo $descuento ?>" size="20" title="Descuento de promocion"  required></td>
        </tr>

            <tr>
        <td class="key">Estado:</td>
        <td>
        <label><input type="radio" name="estado" value="ACTIVO" <?php if($estado=='ACTIVO') print "checked=true"?> />ACTIVO</label>
        <label><input type="radio" name="estado" value="INACTIVO" <?php if($estado=='INACTIVO') print "checked=true"?> />INACTIVO</label>
        </td>
    </tr>       
    </table>

	</fieldset>




	</div><!--Cierra Block_Content-->
</div><!--Cierra Wrapper-->
</form>
</div><!--Cierra Block-->
<?php 

    } else {
        header("Location:../index.php");
    }

?>
</body>
</html>