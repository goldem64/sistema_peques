<?php 
//referenciamos la clase clsConexion
include_once("clsConexion.php");

//implementamos la clase empleado
class clsPromocion{
 //constructor	
 function clsPromocion(){
 }	
 

 //inserta un nuevo empleado en la base de datos
 function agregarPromocion($codigo,$descuento,$estado){
   $con = new clsConexion;
   if($con->conectarse()==true){
     $query = "CALL SP_I_Promocion('$codigo','$descuento','$estado')";
     $result = @mysql_query($query);
     if (!$result)
	   return false;
     else
       return true;
   }
 }
 //Modificar empleado en la base de datos
 function modificarPromocion($idpromocion,$codigo,$descuento,$estado){
   $con = new clsConexion;
   if($con->conectarse()==true){
     $query = "CALL SP_U_Promocion('$idpromocion','$codigo','$descuento','$estado')";
     $result = @mysql_query($query);
     if (!$result)
	   return false;
     else
       return true;
   }
 }
 function consultarPromocion(){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_Promocion()";
	 $result = @mysql_query($query);
   
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
function consultarPromocionIdMaximo(){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_PromocionIdMaximo()";
	 $result = @mysql_query($query);
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
function consultarTotalPromocions(){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_PromocionCantidadTotal()";
	 $result = @mysql_query($query);
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
function consultarPromocionPorParametro($criterio,$busqueda,$limite){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_PromocionPorParametro('$criterio','$busqueda','$limite')";
	 $result = @mysql_query($query);
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
 
}
?>
