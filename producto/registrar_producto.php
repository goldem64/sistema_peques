<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../css/general.css" rel="stylesheet" type="text/css">
<link href="../css/Imagenes.css" rel="stylesheet" type="text/css">
<link href="../css/box.css" rel="stylesheet" type="text/css">
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

<?php
include_once("../clases/clsCategoria.php");
include_once("../clases/clsProveedor.php");
include_once("../clases/clsColor.php");
include_once("../clases/clsTalla.php");
$objcategoria=new clsCategoria;
$objproveedor=new clsProveedor;
$objcolor=new clsColor;
$objtalla=new clsTalla;
$result=$objcategoria->consultarCategoria();
$result2=$objproveedor->consultarProveedor();
$result3=$objcolor->consultarColor();
$result4=$objtalla->consultarTalla();

?>
<div class="wrapper">
<form name="form_producto" action="guardar_producto.php" method="post" enctype="multipart/form-data">
<div class="block">
    <div class="block_head"> 
    <div class="imagen_head"><img src="../img/header/producto.png" width="46" height="43"></div>
    <div class="titulo_head">REGISTRAR PRODUCTO</div>
        <div class="toolbar" id="toolbar">
            <table class="toolbar">
            	<tbody>
                	<tr>
					<td>
            		<button type="submit" class="button">
                   <span class="Guardar" title="Guardar">
                        </span>
                        Guardar
          			</button>
       
                    </td>                                 
                    <td>
                        <a href="index.php" class="toolbar">
                        <span class="Cancelar" title="Cancelar">
                        </span>
                        Cancelar
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


    <fieldset class="adminform">
    <legend>Registro del Producto</legend>
    <table class="admintable">
    <tr>
        <td width="100" class="key">Código de Barras:</td>
        <td colspan="2"><input type="text" name="codigobarras" size="25"></td>
    </tr>
    <tr>
        <td width="100" class="key">Nombre:</td>
        <td colspan="2"><input type="text" name="nombre" size="40" title="Se necesita un nombre de producto"  required></td>
    </tr>
    <tr>
        <td width="100" class="key">Descripción:</td>
        <td colspan="2"><textarea name="descripcion" id="textarea" cols="40" rows="2"></textarea></td>
    </tr>
    <tr>
        <td width="100" class="key">Stock:</td>
        <td colspan="2"><input type="text" name="stock" size="25"></td>
    </tr>        
    <tr>
        <td width="100" class="key">Stock Mínimo:</td>
        <td colspan="2"><input type="text" name="stockmin" size="25"></td>
    </tr>
    <tr>
        <td width="100" class="key">Precio Costo:</td>
        <td colspan="2"><input type="text" name="preciocosto" size="25"></td>
    </tr>
    <tr>
        <td width="100" class="key">Precio Venta:</td>
        <td colspan="2"><input type="text" name="precioventa" size="25"></td>
    </tr>
    <tr>
        <td width="100" class="key">Utilidad:</td>
        <td colspan="2"><input name="utilidad" type="text" disabled size="25"></td>
    </tr>
    <tr>
        <td width="100" class="key">Estado:</td>
        <td colspan="2"><p>
          <label>
            <input name="estado" type="radio" id="estado_0" value="ACTIVO" checked="CHECKED">
            ACTIVO</label>

          <label>
            <input type="radio" name="estado" value="INACTIVO" id="estado_1">
            INACTIVO</label>
          <br>
        </td>
    </tr>
    <tr>
        <td width="100" class="key">Categoría:</td>
        <td colspan="2">
        
          <select name="idcategoria" required>
          			<option value="">- Seleccione una Categoría -</option>
                    <option value="1">GENERAL</option>
          <?php
		while($row=mysql_fetch_array($result)){
                if($row['IdCategoria'] == 1){
                    continue;
                }
            ?>

            <option value="<?php echo $row['IdCategoria']?>"><?php echo $row['Descripcion']?></option>
	<?php } ?>
        </select>

        </td>
    </tr>

    <!-- Nuevos                          -->
    <tr>
        <td width="100" class="key">Proveedor:</td>
        <td colspan="2">
        
          <select name="idproveedor" required>
                    <option value="">- Seleccione un proveedor -</option>
                    <option value="1">SIN PROVEEDOR</option>
          <?php
        while($row2=mysql_fetch_array($result2)){
                if($row2['IdProveedor'] == 1){
                    continue;
                }
            ?>

            <option value="<?php echo $row2['IdProveedor']?>"><?php echo $row2['Nombre']?></option>
    <?php } ?>
        </select>

        </td>
    </tr>


    <tr>
        <td width="100" class="key">Color:</td>
        <td colspan="2">
        
          <select name="idcolor" required>
                    <option value="">- Seleccione un color -</option>
                    <option value="1">SIN COLOR</option>
                    
          <?php
        while($row3=mysql_fetch_array($result3)){
             if($row3['IdColor'] == 1){
                    continue;
                }

            ?>

            <option value="<?php echo $row3['IdColor']?>"><?php echo $row3['Descripcion']?></option>
    <?php } ?>
        </select>

        </td>
    </tr>

    <tr>
        <td width="100" class="key">Talla:</td>
        <td colspan="2">
        
          <select name="idtalla" required>
                    <option value="">- Seleccione una talla -</option>
                    <option value="1">SIN TALLA</option>

          <?php
        while($row4=mysql_fetch_array($result4)){
             if($row4['IdTalla'] == 1){
                    continue;
                }

            ?>

            <option value="<?php echo $row4['IdTalla']?>"><?php echo $row4['Descripcion']?></option>
    <?php } ?>
        </select>

        </td>
    </tr>






    <!-- --------------Fin    Nuevos                  -->
    <tr>
        <td width="100" class="key">Imagen:</td>
        <td><input type="file" size="44" name="imagen" accept="image/jpeg"><input id="accion" name="accion" value="guardar" type="hidden">
        
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