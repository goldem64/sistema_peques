<?php 
//referenciamos la clase clsConexion
include_once("clsConexion.php");

//implementamos la clase empleado
class clsTipoCambio{
 //constructor	
 function clsTipoCambio(){
 }	
 

 //inserta un nuevo empleado en la base de datos
 function agregarTipoCambio($descripcion){
   $con = new clsConexion;
   if($con->conectarse()==true){
     $query = "CALL SP_I_TipoCambio('$descripcion')";
     $result = @mysql_query($query);
     if (!$result)
	   return false;
     else
       return true;
   }
 }
 //Modificar empleado en la base de datos
 function modificarTipoCambio($idtipocambio,$descripcion){
   $con = new clsConexion;
   if($con->conectarse()==true){
     $query = "CALL SP_U_TipoCambio('$idtipocambio','$descripcion')";
     $result = @mysql_query($query);
     if (!$result)
	   return false;
     else
       return true;
   }
 }
 function consultarTipoCambio(){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_TipoCambio()";
	 $result = @mysql_query($query);
   $fila = mysql_fetch_row($result);
	 if (!$result)
	   return false;
	 else
	   return $fila;
   }
 }
function consultarTipoCambioIdMaximo(){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_TipoCambioIdMaximo()";
	 $result = @mysql_query($query);
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
function consultarTotalTipoCambios(){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_TipoCambioCantidadTotal()";
	 $result = @mysql_query($query);
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
function consultarTipoCambioPorParametro($criterio,$busqueda,$limite){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_TipoCambioPorParametro('$criterio','$busqueda','$limite')";
	 $result = @mysql_query($query);
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
 
}
?>
