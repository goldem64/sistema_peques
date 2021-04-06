<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../css/general.css" rel="stylesheet" type="text/css">
<link href="../css/icon.css" rel="stylesheet" type="text/css">
<link href="../css/box.css" rel="stylesheet" type="text/css">
</head>
<?php error_reporting (0);?>
<body>
<?php
    session_start();
    if(isset($_SESSION["usuario"])){
?>

<div class="wrapper">
<form name="form_producto" method="post" action="guardar_producto.php" enctype="multipart/form-data">
<div class="block">

    <div class="block_head"> 
    	<div class="imagen_head"><img src="../img/header/producto.png" width="46" height="43"></div>
    <div class="titulo_head">EDITAR PRODUCTO</div>
    
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
<?php error_reporting (0);?>
<?php
include_once("../clases/clsProducto.php");

include_once("../clases/clsCategoria.php");
include_once("../clases/clsProveedor.php");
include_once("../clases/clsColor.php");
include_once("../clases/clsTalla.php");
$objcategoria=new clsCategoria;
$objproveedor=new clsProveedor;
$objcolor=new clsColor;
$objtalla=new clsTalla;

$resultado_categ=$objcategoria->consultarCategoria();
$resultado_prov=$objproveedor->consultarProveedor();
$resultado_col=$objcolor->consultarColor();
$resultado_ta=$objtalla->consultarTalla();


	$id_prod=$_GET["idproducto"];
	
	$objproducto=new clsProducto;
	$resultado_prod=$objproducto->consultarProducto('id',$id_prod);

	
	while($row=mysql_fetch_array($resultado_prod)){
		$cod=$row["IdProducto"];
		$idproducto=$row["IdProducto"];
		$codigoba=$row["Codigo"];
		$nombre=$row["Nombre"];
		$descripcion=$row["Descripcion"];
		$stock=$row["Stock"];
		$stockmin=$row["StockMin"];
		$preciocosto=$row["PrecioCosto"];
		$precioventa=$row["PrecioVenta"];
		$utilidad=$row["Utilidad"];
		$estado=$row["Estado"];
		$imagen=$row["Imagen"];
		$idcategoria=$row["IdCategoria"];
		$idproveedor=$row["IdProveedor"];
		$idcolor=$row["IdColor"];
		$idtalla=$row["IdTalla"];
	}

?>


<input type="hidden" name="codigo" value="<?php echo $cod ?>">
<input id="accion" name="accion" value="modificar" type="hidden">
    <fieldset class="adminform">
    <legend>Detalles del Producto</legend>
<table class="admintable">
	<tr>
		<td width="100" class="key">ID:</td>
		<td><?php echo $id_prod ?></td>
	</tr>
	<tr>
		<td class="key">Código:</td>
		<td><input type="text" name="codigoba" value="<?php echo $codigoba ?>" size="20"></td>
	</tr>
    <tr>
		<td class="key">Nombre:</td>
		<td><input type="text" name="nombre" value="<?php echo $nombre ?>" size="40"></td>
	</tr>
    <tr>
		<td class="key">Descripción:</td>
		<td><textarea name="descripcion"  id="textarea" cols="40" rows="2"><?php print($descripcion); ?></textarea></td>
	</tr>
	<tr>
		<td class="key">Stock:</td>
		<td><input type="text" name="stock" value="<?php echo $stock ?>" size="20"></td>
	</tr>
	<tr>
		<td class="key">Stock Mínimo:</td>
		<td><input type="text" name="stockmin" value="<?php echo $stockmin ?>" size="20"></td>
	</tr>
	<tr>
		<td class="key">Precio Costo:</td>
		<td><input type="text" name="preciocosto" value="<?php echo $preciocosto ?>" size="20"></td>
	</tr>
	<tr>
		<td class="key">Precio Venta:</td>
		<td><input type="text" name="precioventa" value="<?php echo $precioventa ?>" size="20"></td>
	</tr>
	<tr>
		<td class="key">Utilidad:</td>
		<td><input type="text" name="utilidad" value="<?php echo $utilidad ?>" size="20"></td>
	</tr>

   	<tr>
		<td class="key">Estado:</td>
		<td>
        <label><input type="radio" name="estado" value="ACTIVO" <?php if($estado=='ACTIVO') print "checked=true"?> />ACTIVO</label>
		<label><input type="radio" name="estado" value="INACTIVO" <?php if($estado=='INACTIVO') print "checked=true"?> />INACTIVO</label>
        </td>
	</tr>       
    <tr>
		<td class="key">Categoría:</td>
		<td><select name="idcategoria">
          	<option value="0">Seleccione una categoría</option>
          <?php
		while($row=mysql_fetch_array($resultado_categ)){
			?>

            <?php 
				if($idcategoria==$row['IdCategoria']){?>
				 <option value="<?php echo $row['IdCategoria']?>" selected="selected"><?php echo $row['Descripcion']?></option>
				<?php } else { ?>		
				<option value="<?php echo $row['IdCategoria']?>"><?php echo $row['Descripcion']?></option>
				<?php }?>
            
          
            
	<?php } ?>
        </select></td>
	</tr>


	<!-- Nuevos   -------------------->

	<tr>
		<td class="key">Proveedor:</td>
		<td><select name="idproveedor">
          	<option value="0">Seleccione un proveedor</option>
          <?php
		while($row2=mysql_fetch_array($resultado_prov)){
			?>

            <?php 
				if($idproveedor==$row2['IdProveedor']){?>
				 <option value="<?php echo $row2['IdProveedor']?>" selected="selected"><?php echo $row2['Nombre']?></option>
				<?php } else { ?>		
				<option value="<?php echo $row2['IdProveedor']?>"><?php echo $row2['Nombre']?></option>
				<?php }?>
            
          
            
	<?php } ?>
        </select></td>
	</tr>


	<tr>
		<td class="key">Color:</td>
		<td><select name="idcolor">
          	<option value="0">Seleccione un Color</option>
          <?php
		while($row3=mysql_fetch_array($resultado_col)){
			?>

            <?php 
				if($idcolor==$row3['IdColor']){?>
				 <option value="<?php echo $row3['IdColor']?>" selected="selected"><?php echo $row3['Descripcion']?></option>
				<?php } else { ?>		
				<option value="<?php echo $row3['IdColor']?>"><?php echo $row['Descripcion']?></option>
				<?php }?>
            
          
            
	<?php } ?>
        </select></td>
	</tr>

	<tr>
		<td class="key">Talla:</td>
		<td><select name="idtalla">
          	<option value="0">Seleccione una Talla</option>
          <?php
		while($row4=mysql_fetch_array($resultado_ta)){
			?>

            <?php 
				if($idtalla==$row4['IdTalla']){?>
				 <option value="<?php echo $row4['IdTalla']?>" selected="selected"><?php echo $row4['Descripcion']?></option>
				<?php } else { ?>		
				<option value="<?php echo $row4['IdTalla']?>"><?php echo $row4['Descripcion']?></option>
				<?php }?>
            
          
            
	<?php } ?>
        </select></td>
	</tr>

	<!-- Fin Nuevos  --------------------->
    <tr>
      <td class="key">Imagen:</td>
      <td><input type="file" size="44" name="imagen" accept="image/jpeg"></td>
    </tr>
    <tr>
      <td class="key">&nbsp;</td>
      <td><img src="../producto/foto/<?php echo $imagen ?>" width="160px" height="140px" border="1"><input type="hidden" name="img_eliminar_1" value="<?php echo $imagen ?>"></td>
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