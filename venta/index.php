<?php ob_start();error_reporting(0);?>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../css/general.css" rel="stylesheet" type="text/css">
<link href="../css/Imagenes.css" rel="stylesheet" type="text/css">
<link href="../css/box.css" rel="stylesheet" type="text/css">
<link href="../css/venta.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="css/style_v.css" /> 
<style>
/* Estilo por defecto para validacion */  
input:required:invalid {  border: 1px solid red;  }  input:required:valid {  border: 1px solid green;  }
</style>

<script type="text/javascript" src="js/ajax.js"></script> 
<script type="text/javascript" src="js/jquery.min.js"></script> 
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script> 
<script type="text/javascript"> 
	$(function() {
    	$('a[rel*=leanModal]').leanModal({ top : 133, closeButton: ".modal_close" });		
	});
</script> 
<script> 
function enviar_formulario_directo(){
  var referencia_tarjeta = document.tarjeta.txtReferencia.value;
	var serie_venta = document.datos.txtSerie.value;
  var descuento = document.tarjeta.tdespromo.value;
  var promo = document.tarjeta.tcodigopromo.value;
	var idtipodoc_venta=document.datos.idtipodocumento.value;
	var idclie_venta=document.datos.txtIdCliente.value;
  var opcion = confirm("¿Desea realizar la venta?");
  if (opcion == true){
    window.location.href="index.php?action=guardar_directo&serie="+serie_venta+"&idtipodoc="+idtipodoc_venta+"&idcliente="+idclie_venta+"&referencia="+referencia_tarjeta+"&promo="+promo+"&descuento="+descuento;; 
}
  
  	

}
function enviar_formulario(){
	var pago_venta = document.contado.txtPago.value;
  var descuento = document.contado.despromo.value;
  var promo = document.contado.codigopromo.value;
	var serie_venta = document.datos.txtSerie.value;
	var idtipodoc_venta=document.datos.idtipodocumento.value;
	var idclie_venta=document.datos.txtIdCliente.value;
   var opcion = confirm("¿Desea realizar la venta?");
  if (opcion == true){
	window.location.href="index.php?action=guardar&pago="+pago_venta+"&serie="+serie_venta+"&idtipodoc="+idtipodoc_venta+"&idcliente="+idclie_venta+"&promo="+promo+"&descuento="+descuento; 
}
} 

</script>  

<script type="text/javascript">
    function number_format (number, decimals, dec_point, thousands_sep) {
    // Strip all characters but numerical ones.
    number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
    var n = !isFinite(+number) ? 0 : +number,
        prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
        sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
        dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
        s = '',
        toFixedFix = function (n, prec) {
            var k = Math.pow(10, prec);
            return '' + Math.round(n * k) / k;
        };
    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3) {
        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec) {
        s[1] = s[1] || '';
        s[1] += new Array(prec - s[1].length + 1).join('0');
    }
    return s.join(dec);
}



</script>

<script type="text/javascript">
  function descuento(pago){
   
    if (pago !="NO APLICA"){
      var seleccion=document.getElementById('cpromocion');
      var descuento = seleccion.options[seleccion.selectedIndex].value;
      dinero = pago - (pago * (descuento / 100));
      document.getElementById("pagarc").innerHTML = "$ "+number_format(dinero,2,".",",");
      document.contado.despromo.value=descuento;
      document.contado.codigopromo.value=seleccion.options[seleccion.selectedIndex].text;
    }
    else
    {
      document.getElementById("pagarc").innerHTML = "$ "+ number_format(pago,2,".",",");
    }
    
    

   

}

  

</script>

<script type="text/javascript">
  function descuento2(pago){
   
    if (pago !="NO APLICA"){
      var seleccion=document.getElementById('tpromocion');
      var descuento = seleccion.options[seleccion.selectedIndex].value;
      dinero = pago - (pago * (descuento / 100));
      document.getElementById("pagart").innerHTML = "$ "+number_format(dinero,2,".",",");
      document.tarjeta.tdespromo.value=descuento;
      document.tarjeta.tcodigopromo.value=seleccion.options[seleccion.selectedIndex].text;
    }
    else
    {
      document.getElementById("pagart").innerHTML = "$ "+ number_format(pago,2,".",",");
    }
    
    

   

}

  

</script>


</head>
<body>
<div id="pruebas"></div>
<div class="wrapper">

<div class="block">
    <div class="block_head"> 
    <div class="imagen_head"><img src="../img/header/venta_h.png" width="48" height="48"></div>
    <div class="titulo_head">REGISTRO DE VENTAS</div>
        <div class="toolbar" id="toolbar">
            <table class="toolbar">
            	<tbody>
                	<tr>
                    <td id="toolbar-new">
                        <a href="#signup2" id="go" rel="leanModal" name="signup" class="toolbar">
                        <span class="GenerarVenta" title="Tarjeta">
                        </span>
                        Tarjeta
                        </a>
                    </td>                    
                              
                    <td id="toolbar-new">
                        <a href="#signup" id="go" rel="leanModal" name="signup" class="toolbar">
                        <span class="Importe" title="Importe">
                        </span>
                        Contado
                        </a>
                    </td>  
            
                  <td id="toolbar-new">
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

<p>

<?php
include_once("../clases/clsCarritoVenta.php");
include_once("../clases/clsVenta.php");
include_once("../clases/clsTipoDocumento.php");
include_once("../clases/clsTipoCambio.php");
include_once("../clases/clsCliente.php");
include_once("../clases/clsProducto.php");
include_once("../clases/clsPromocion.php");
session_start();

$objVenta = new clsVenta;
$objTipoCambio = new clsTipoCambio;
$tipocambio = $objTipoCambio->consultarTipoCambio();
$num_venta=$objVenta->generarNumVenta();

 



$objTipoDoc=new clsTipoDocumento;
$result_td=$objTipoDoc->consultarTipoDocumento();

$objPromocion=new clsPromocion;
$result_td2=$objPromocion->consultarPromocion();

$objPromocion2=new clsPromocion;
$result_td3=$objPromocion2->consultarPromocion();


if(isset ($_GET['IdCliente'])){
	$id_cliente=$_GET["IdCliente"];
}else{
	$id_cliente=1;
}



$objCliente=new clsCliente;
$result_clie=$objCliente->consultarClientePorParametro('id',$id_cliente,'');

while($row_clie=@mysql_fetch_array($result_clie)){
	$idcliente=$row_clie['IdCliente'];
	$nomcliente=$row_clie['Nombre'];
}



//Llenar cesta
session_start();


//Creamos al objeto carrito vacio
$carrito = new Carrito(session_id());

//Recupero el objeto carrito de la sesion en caso exista
if(isset($_SESSION['carrito'])) $carrito = $_SESSION['carrito'];

if(isset ($_GET['action'])){
    switch ($_GET['action']){
        case 'agregar':	
			$idprod=$_GET['idProducto'];
			if($idprod!=""){
				$productoDAO = new clsVenta;
				$producto = $productoDAO->consultarProductoPorCodigo($idprod);
				$carrito->agregarProducto($producto);
			}
			
        break;

        case 'vacear':
            $carrito = new Carrito(session_id());
        break;

        case 'eliminar':
            $carrito->eliminarProducto($_GET['idProducto']);
            break;

        case 'actualizar': 
		foreach($_GET as $codigo => $cantidad){
			if($codigo > 0 && (int)$cantidad > 0){
				//Actualizamos la cantidad para un mismo producto
				$carrito->actualizarCantidadIngresada($codigo, $cantidad);
			}
		}          
        break;
		case 'guardar_directo':

			if($carrito->calcularTotalPagar()>0){
			
      $descuentopromo = $_GET['descuento'];
      $pagorefinado = ($carrito->calcularTotalPagar() - ($carrito->calcularTotalPagar() * ($descuentopromo/100)));
			$id_tipodoc=$_GET['idtipodoc'];
      $nref=$_GET['referencia'];
			$id_clie=$_GET['idcliente'];
//			$id_emp=$_GET['txtIdEmp'];
			$serie_fact=$_GET['serie'];

			$id_emp=$_SESSION['id'];
			$estado="EMITIDO";
			$Tpago="TARJETA";
      $codigopromo = $_GET['promo'];

       		$productoDAO = new clsVenta();
			$facnum = $productoDAO->guardarFactura($carrito->productos,$id_tipodoc,$id_clie,$id_emp,$serie_fact,$num_venta,$carrito->calcularValorVenta(),$carrito->calcularIgv(),$carrito->calcularTotalPagar(),$estado,$Tpago,$codigopromo,$descuentopromo,$nref,$pagorefinado);

				header("Location: verificar_venta.php?estado=efectuado&total_pago=".$pagorefinado."&pago=".$pagorefinado);
			}else{
				header('Location: verificar_venta.php?estado=pendiente');
			}
			exit();
		break;
        case 'guardar':
		$pago=$_GET["pago"];
    $descuentopromo = $_GET['descuento'];
    $pagorefinado = ($carrito->calcularTotalPagar() - ($carrito->calcularTotalPagar() * ($descuentopromo/100)));
    //echo "    pago   ".$pagorefinado;
    
		if($pago>=$pagorefinado&&$carrito->calcularTotalPagar()>0){
			// agrege un =

			$id_tipodoc=$_GET['idtipodoc'];
			$id_clie=$_GET['idcliente'];
//			$id_emp=$_GET['txtIdEmp'];
			$serie_fact=$_GET['serie'];
      $descuentopromo = $_GET['descuento'];
      $codigopromo = $_GET['promo'];
			
			$id_emp=$_SESSION['id'];
			$estado="EMITIDO";
      $Tpago ="EFECTIVO";
      $referencia = "NO APLICA";
			
       		$productoDAO = new clsVenta();
$facnum = $productoDAO->guardarFactura($carrito->productos,$id_tipodoc,$id_clie,$id_emp,$serie_fact,$num_venta,$carrito->calcularValorVenta(),$carrito->calcularIgv(),$carrito->calcularTotalPagar(),$estado,$Tpago,$codigopromo,$descuentopromo,$referencia,$pagorefinado);

				header("Location: verificar_venta.php?estado=efectuado&total_pago=".$pagorefinado."&pago=".$pago."&tpago=efectivo");
			}else{
				header('Location: verificar_venta.php?estado=pendiente');
			}
			exit();
		break;
    }
    
//Guardo nuevamente el carrito de la session
$_SESSION['carrito'] = $carrito;
header('Location: index.php');
exit(); //Paramos el script
}
?>

 
  
  
<?php
error_reporting(0);
$cod=$_GET["txtCodigo"];
$objProducto = new clsVenta;
$producto= $objProducto->consultarProductoPorCodigo($cod);

$id=$producto->idpro;
$cod=$producto->codpro;
$nom=$producto->nompro;
$stock=$producto->stockpro;
$cost=$producto->costpro;
$pre=$producto->prepro;


if(isset($_POST['Buscar_codigo'])){
$cod=$_POST["txtCodigo"];
$objProducto = new clsVenta;
$producto= $objProducto->consultarProductoPorCodigo($cod);

$id=$producto->idpro;
$cod=$producto->codpro;
$nom=$producto->nompro;
$stock=$producto->stockpro;
$cost=$producto->costpro;
$pre=$producto->prepro;
}


?>


<div class="zona_producto"><form name="form2" method="post" action="index.php">
  <fieldset class="adminform">
    <legend>Datos del Producto</legend>  
  <table width="100%" border="0" class="admintable">
    <tr>
      <td class="key">
        <input type="hidden" name="txtId" value="<?php echo $id ?>">
        Código de Barras:  </td>
      <td align="20%"><input name="txtCodigo" type="text" value="<?php echo $cod ?>" size="17">
        <input type="submit" name="Buscar_codigo"  class="button_p" value="" id="boton_buscar" title="Buscar">&nbsp;&nbsp;&nbsp;<a href="#myprod" rel="leanModal" name="signup" class="button_p" title="Buscar producto" style="paddin-top:10px"><img src="../img/Iconfinder/page_edit.png"></a></td>
      <td class="key"><span class="key">
        <input type="hidden" name="txtId2" value="<?php echo $cost ?>">
        Precio:</span></td>
      <td align="20%"><input name="textfield2" type="text" disabled id="textfield2" value="<?php echo $pre ?>" size="8" style="text-align:center"></td>
      </tr>
    <tr>
      <td  class="key">Nombre: </td>
      <td align="20%"><input name="textfield" type="text" disabled id="textfield" value="<?php echo $nom ?>" size="35"></td>
      <td align="20%" class="key">Stock:</td>
      <td align="20%"><input name="textfield3" type="text" disabled id="textfield3" value="<?php echo $stock ?>" size="8" style="text-align:center"></td>
      </tr>
    <tr>
      <td>&nbsp;</td>
      <td align="20%">&nbsp;</td>
      <td align="20%">&nbsp;</td>
      <td align="center"><a href="javascript:void(0);" onClick="window.location='index.php?action=agregar&idProducto=<?php echo $producto->codpro ;?>';"  class="button_p" id="boton_agregar" ><img src="../img/Iconfinder/agregar_venta.png"></a></td>
      </tr>
    
  </table>
  </fieldset>
</form>

<form name="detalle" action="index.php" method="get">

<?php

  $total = 0;
  if(count($carrito->productos)>0){
?>

  
  <table class="adminlist">
    <thead>
    <tr>
        <th>#</th>
        <th><a href="#">Cant.</a></th>
        <th><a href="#">C&oacute;digo</a></th>
        <th><a href="#">Nombre</a></th>
        <th><a href="#">Precio unit.</a></th>
        <th><a href="#">Total</a></th>
        <th>&nbsp;</th>
  </tr>
    </thead>
    <tbody class="adminlist">
  <?php
  $i=0;
    foreach($carrito->productos as $producto){
  $i++;
    if ($c==1){
  echo "<tr class='row1'>";
    $c=2;
  }else{
        echo "<tr class='row0'>";
    $c=1;
  }
    ?>
       
            <td width="10"><?php echo $i ?></td>
            <td width="30" align="center"><input type="text" name="<?php echo $producto->codpro ;?>" value="<?php echo $producto->cantidad ;?>" maxlength="3" size="4" style="text-align: center" /></td>
            <td align="center"><?php echo $producto->codpro ;?></td>
            <td align="left"><?php echo $producto->nompro ;?></td>                  
            <td width="25" align="center">$<?php echo $producto->prepro ;?></td>
            <td width="25"align="center">$<?php echo $producto->precioTotal() ;?></td>
            <td width="5%" align="center"><a href="javascript:void(0);" onClick="window.location='index.php?action=eliminar&idProducto=<?php echo $producto->codpro ;?>';"><img src="../img/icon/eliminar.png" title="Eliminar producto"></a></td>
        </tr>
  <?php
    }
    ?>
    </tbody>
    <tfoot>
      <tr>
        <td colspan="13">&nbsp;</td>
      </tr>
  </tfoot>
  </table>
  <br>
<center><input type="button" value="Limpiar Cesta" class="btn_operaciones" style="width:130px;" onClick="parent:location='index.php?action=vacear'"/>
<input type="hidden" name="action" value="actualizar"  style="width:130px;"/>
<input type="submit" value="Actualizar" class="btn_operaciones"  style="width:130px;" ></center>
<!--<input type="button" value="Grabar" class="btn_operaciones" style="width: 130px" onClick="parent:location='index.php?action=guardar';">-->
     <?php
     }else
      echo "<div class='box-info'>No tiene ningun producto en la cesta</div>";
     ?>



</form> <!--Cierra form detalle-->
              
           		
 
                


</div>

<div class="zona_datos">
<form name="datos" action="index.php" method="get">
<table width="100%" border="0">
  <tr>
    <td width="20%"><div class="total_venta" style="font-size:30px"><center><?php echo '$ '.number_format($carrito->calcularTotalPagar(), 2, '.', ','); ?></center></div></td>
  </tr>

  <tr>
    <td>
      <div class="box_1">
        <table width="100%" border="0">
          <tr>
            <td align="center"><b>SERIE</b></td>
            <td align="center"><b>Nº DE VENTA</b></td>
            </tr>
          <tr>
            <td align="center"><input name="txtSerie" type="text" id="textfield4" value="001" size="10" style="text-align:center"></td>
            <td align="center">
              <input name="textfield4" type="text" disabled id="textfield4" value="<?php echo $num_venta ?>" size="30" style="text-align:center">
              </td>
            </tr>
          </table>
        </div>
      <br>
      <div class="box_1">
        <table width="100%" border="0">
          <tr>
            <td>Nombre del cliente (Opcional): </td>
            </tr>
          <tr>
            <td><input type="hidden" name="txtIdCliente" value="<?php echo $idcliente ?>"><input name="txtNomClie" type="text" disabled id="txtCliente2" size="35" value="<?php echo $nomcliente ?>">&nbsp;&nbsp;&nbsp;<a href="#myclie" rel="leanModal" name="signup" class="button_p" title="Buscar cliente"><img src="../img/icon/buscar_detalle.png"></a></td>
            </tr>
          <tr>
            <td>Tipo de documento: <select name="idtipodocumento">
              <?php
		while($row=mysql_fetch_array($result_td)){?>
              
              <option value="<?php echo $row['IdTipoDocumento']?>"><?php echo $row['Descripcion']?></option>
              <?php } ?>
              </select>  </td>
            </tr>
          
          </table>
        </div>
      <br>
      <div class="box_1">
        
        <table width="100%" border="0">

          <tr>
            <td class="txt_box">Cantidad de Productos:</td>
            <td align="right"><?php echo $carrito->calcularCantidad(); ?>&nbsp;&nbsp;&nbsp;</td>
            </tr>
          <tr>
            <td class="txt_box">Valor Venta:</td>
            <td align="right"><?php echo "$ ".$carrito->calcularValorVenta(); ?>&nbsp;&nbsp;&nbsp;</td>
            </tr>

          <tr>
            <td sclass="txt_box">I.V.A %: </td>
            <td align="right"><?php echo "$ ".$carrito->calcularIgv(); ?>&nbsp;&nbsp;&nbsp;</td>
            </tr>
          <tr>
            <td sclass="txt_box">Tipo de Cambio: </td>
            <td align="right"><?php echo "$ ".$tipocambio[0];?>&nbsp;&nbsp;&nbsp;</td>
            </tr>
          <tr>
            <td sclass="txt_box">Dolares: </td>
            <td align="right"><?php echo "$ ".number_format(($carrito->calcularTotalPagar()/$tipocambio[0]), 2, '.', '');?>&nbsp;&nbsp;&nbsp;</td>
            </tr>
          </table>
        <br>
        <div class="box_1_1">
          <table width="100%" border="0">
            <tr>
              <td class="txt_box_bottom">Total a Pagar:</td>
              <td class="txt_box_bottom" align="right"><?php echo "$ ". $carrito->calcularTotalPagar(); ?></td>
              </tr>
            </table>
          </div>
      </div></td>
  </tr>
</table>
</form><!-- form datos -->

</div>

<?php


$v_cliente="12345";




?>

<div id="signup2">


<div class="modal-header">    
    <div class="txt-title">COBRO CON TARJETA</div>
    <a class="modal_close" href="#" title="Cerrar"></a> 
</div><!-- modal-header -->

<div class="modal-body">
      <p align="center" class="txt-info"><strong>Total a Cobrar</strong></p>
      <pre style="font-size:30px"><center><div id="pagart"><?php echo '$ '.number_format($carrito->calcularTotalPagar(), 2, '.', ','); ?></div></center></pre>
      <p align="center" class="txt-info"><strong>Forma de Pago "Tarjeta"</strong></p>
        <div align="center">
                <p align="center" class="txt-info-1">Numero de referencia</p>
                <form name="tarjeta" action="" onSubmit="enviar_formulario_directo(); return false">
                   <input type="hidden" name="tcodigopromo" id="tcodigopromo" value="">
                 <input type="hidden" name="tdespromo" id="tdespromo" value="">
                
                <div class="input-prepend input-append">
                    <span class="add-on"></span>
                    <input type="text" name="txtReferencia" autocomplete="on" required />
                </div>

                <p align="center" class="txt-info-1">Promocion</p>
                 <div class="input-prepend input-append">
                    <span class="add-on"></span>
                    <select id="tpromocion" name="tpromocion" onChange="descuento2(<?php echo $carrito->calcularTotalPagar(); ?>)">  
                    <option value="0">NO APLICA</option>  
                      <?php 
                    while($rowprot=mysql_fetch_array($result_td2)){
                        if ($rowprot['Estado'] == "INACTIVO"){
                          continue;
                        }

                      ?>
              
              <option value="<?php echo $rowprot['Descuento']?>" ><?php echo $rowprot['Codigo']?></option>
              <?php } ?>

                    </select>
                </div>
        <input type="hidden" name="action" value="guardar" style="width:130px;"/>
                </i>
                      
    </div>
</div><!-- moda-body -->

<div class="modal-footer">
<input type="submit" value="Registrar Venta" class="btn btn-success"><i class=" icon-shopping-cart">

</div><!-- moda-footer -->
</form>    
</div><!-- signup -->

<!------------------------------Modal -- myContado --------------------------->
<div id="signup">


<div class="modal-header">    
    <div class="txt-title">COBRO AL CONTADO</div>
    <a class="modal_close" href="#" title="Cerrar"></a> 
</div><!-- modal-header -->

<div class="modal-body">
    	<p align="center" class="txt-info"><strong>Total a Cobrar</strong></p>
    	<pre style="font-size:30px"><center><div id="pagarc"><?php echo '$ '.number_format($carrito->calcularTotalPagar(), 2, '.', ','); ?></div></center></pre>
   		<p align="center" class="txt-info"><strong>Forma de Pago "Contado"</strong></p>
        <div align="center">
                <p align="center" class="txt-info-1">Dinero Recibido</p>
                <form name="contado" action="" onSubmit="enviar_formulario(); return false">
                <input type="hidden" name="tpagar" id="tpagar" value="<?php echo $carrito->calcularTotalPagar(); ?>">
                 <input type="hidden" name="codigopromo" id="codigopromo" value="">
                 <input type="hidden" name="despromo" id="despromo" value="">
                <div class="input-prepend input-append">
                    <span class="add-on"><b>$</b></span>
                    <input type="number" name="txtPago" autocomplete="on" required />
                </div>

                <p align="center" class="txt-info-1">Promocion</p>
                <div class="input-prepend input-append">
                    <span class="add-on"></span>
                    <select id="cpromocion" name="cpromocion" onChange="descuento(<?php echo $carrito->calcularTotalPagar(); ?>)">
                    <option value="0">NO APLICA</option>  
                      <?php

                    while($rowprot=mysql_fetch_array($result_td3)){
                        if ($rowprot['Estado'] == "INACTIVO"){
                          continue;
                        }
                      ?>
              
              <option value="<?php echo $rowprot['Descuento']?>" ><?php echo $rowprot['Codigo']?></option>
              <?php } ?>

                    </select>
                </div>
				<input type="hidden" name="action" value="guardar" style="width:130px;"/>
                </i>
                      
		</div>
</div><!-- moda-body -->

<div class="modal-footer">
<input type="submit" value="Cobrar dinero recibido" class="btn btn-success"><i class=" icon-shopping-cart">

</div><!-- moda-footer -->
</form>    
</div><!-- signup -->





<!-- Modal  myProducto -->
<div id="myprod">


<div class="modal-header">    
    <div class="txt-title">BUSCAR PRODUCTO</div>
    <a class="modal_close" href="#" title="Cerrar"></a> 
</div><!-- modal-header -->

<div class="modal-body">

<form name="form_producto" action="#" method="post" enctype="multipart/form-data">
Filtro:<input type="text" name="txtDato_producto" id="txtDato_producto">
<select name="cboCriterio_producto" id="cboCriterio_producto">
  <option>- Seleccione Criterio -</option>
  <option value="codigo">Código</option>
  <option value="nombre">Nombre</option>
  <option value="descripcion">Descripción</option>
  <option value="categoria">Categoría</option>
</select>
<input type="button" name="button" id="button" onClick="enviarParametrosProducto()" value="Buscar">


</form>
    	    
            
<table class="adminlist" cellspacing="1">
    <thead>
        <tr>
            <th>#</th>
            <th><a href="#">Código</a></th>
            <th><a href="#">Nombre</a></th>
            <th><a href="#">Descripción</a></th>
            <th><a href="#">Stock</a></th>
            <th><a href="#">Precio Venta</a></th>
            <th><a href="#">Estado</a></th>
            <th><a href="#">Categoría</a></th>
            <th><a href="#">ID</a></th>

		</tr>
	</thead>

	<tbody class="adminlist" id="table_body_producto">
 
		</tbody>
		<tfoot>
			<tr>
				<td colspan="13">                
                </td>
			</tr>
		</tfoot>
	</table>


</div><!-- moda-body -->
</div><!-- Cierra myProducto -->
<!------------------------------Modal -- myCliente --------------------------->
<div id="myclie">


<div class="modal-header">    
    <div class="txt-title">BUSCAR CLIENTE</div>
    <a class="modal_close" href="#" title="Cerrar"></a> 
</div><!-- modal-header -->

<div class="modal-body">

<form name="form_cliente" action="#" method="post" enctype="multipart/form-data" id="form_cliente">
Filtro:<input type="text" name="txtDato_cliente" id="txtDato_cliente">
<select name="cboCriterio_cliente" id="cboCriterio_cliente">
  <option>- Seleccione Criterio -</option>
  <option value="nombre">Nombre o Razón Social</option>
  <option value="ruc">RUC</option>
  <option value="dni">DNI</option>
</select>
<input type="button" name="button" id="button" onClick="enviarParametrosCliente()" value="Buscar">


</form>
    	    
            
<table class="adminlist" cellspacing="1">
    <thead>
        <tr>
            <th>#</th>
            <th><a href="#">Nombre</a></th>
            <th><a href="#">RFC</a></th>
            <th><a href="#">DNI</a></th>
            <th><a href="#">Dirección</a></th>
            <th><a href="#">Teléfono</a></th>
            <th><a href="#">ID</a></th>

		</tr>
	</thead>

	<tbody class="adminlist" id="table_body_cliente">
 
		</tbody>
		<tfoot>
			<tr>
				<td colspan="13">                
                </td>
			</tr>
		</tfoot>
	</table>


</div><!-- moda-body -->

</div><!-- Cierra myCliente -->




</div><!--Cierra Block_Content-->
</div><!--Cierra Wrapper-->

</div><!--Cierra Block-->

</body>
</html>
<? b_end_flush(); ?>