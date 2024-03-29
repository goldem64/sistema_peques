<?php
ob_start();
require_once("../../lib/pdf/class.ezpdf.php");
include_once("../../clases/clsVenta.php");

$fechaini=$_GET["fechaini"];
$fechafin=$_GET["fechafin"];


$pdf =& new Cezpdf('a4');
$pdf->selectFont('../../lib/pdf/fonts/Helvetica.afm');
$pdf->ezSetCmMargins(1,1,1.5,1.5);

$objVenta=new clsVenta;
if($fechaini==""&&$fechafin==""){
	$hoy = getdate();
	$f = $hoy['year'] . "-" . $hoy['mon'] . "-" . $hoy['mday'];
	$result=$objVenta->consultarVentaPorFecha('consultar',$f,$f,'');
}else{
	$result=$objVenta->consultarVentaPorFecha('consultar',$fechaini,$fechafin,'');	
}

$ixx = 0;
while($datatmp = mysql_fetch_assoc($result)) { 
	$ixx = $ixx+1;
	$data[] = array_merge($datatmp, array('num'=>$ixx));
}
$titles = array(
				'num'=>'<b>#</b>',
				'Cliente'=>'<b>CLIENTE</b>',
				'Fecha'=>'<b>FECHA</b>',
				'Empleado'=>'<b>EMPLEADO</b>',
				'TipoDocumento'=>'<b>DOCUMENTO</b>',	
				'Numero'=>'<b>NUMERO</b>',	
				'Estado'=>'<b>ESTADO</b>',					
				'Pago'=>'<b>PAGO</b>',
				'Referencia'=>'<b>#Ref.</b>',
				'Promo'=>'<b>Promo</b>',
				'TotalPagar'=>'<b>SUBTOTAL</b>',
				'Descuento'=>'<b>DESCUENTO</b>'
				
														
				
			);
$options = array(
				'shadeCol'=>array(0.9,0.9,0.9),
				'xOrientation'=>'center',
				'width'=>510,
				'fontSize'=>'7',
				'cols'=>array('num'=>array('justification'=>'center', 'width'=>30), 'Cliente'=>array('justification'=>'left', 'width'=>80), 'Fecha'=>array('justification'=>'center', 'width'=>60),'Empleado'=>array('justification'=>'left', 'width'=>60), 'TipoDocumento'=>array('justification'=>'center', 'width'=>60), 'Numero'=>array('justification'=>'center', 'width'=>60), 'Estado'=>array('justification'=>'center', 'width'=>40),'Pago'=>array('justification'=>'center', 'width'=>60), 'Referencia'=>array('justification'=>'center', 'width'=>60),'TotalPagar'=>array('justification'=>'center', 'width'=>40),'IdVenta'=>array('justification'=>'center','width'=>30))
				);
$txttit="<b>SISTEMA DE VENTAS</b>";
$txtsubtit="Reporte general de ventas\n";

$pdf->addJpegFromFile("../../img/icon/logo_casita_jpg.jpg", 475, 760, 70,50);


date_default_timezone_set('America/Cancun');
$pdf->ezText($txttit,16);
$pdf->ezText($txtsubtit,12);
$pdf->ezText("<b>Fecha: </b> ". date('d/m/Y'), 10);
$pdf->ezText("<b>Hora: </b> ". date('H:i:s'). "\n\n", 10);
$pdf->ezTable($data, $titles, '', $options);
$pdf->ezText("\n\n\n", 9);
ob_end_clean();
$pdf->ezStream();
b_end_flush();
?>
