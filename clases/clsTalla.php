<?php 
//Referenciamos la clase clsConexion
include_once("clsConexion.php");

//Implementamos la clase talla
class clsTalla{
 //Constructor	
 function clsTalla(){
 }	
 
 //Funcion para agregar una nueva talla en la BD
 function agregarTalla($descripcion){
   $con = new clsConexion;
   if($con->conectarse()==true){
     $query = "CALL SP_I_Talla('$descripcion')";
     $result = @mysql_query($query);
     if (!$result)
	   return false;
     else
       return true;
   }
 }

 function CantidadTalla(){
   $con = new clsConexion;
   if($con->conectarse()==true){
     $query = "CALL SP_S_CANTIDAD_TALLAS()";
   $result = @mysql_query($query);
   if (!$result)
     return false;
   else
     return $result;
   }
}
 //Modificar empleado en la base de datos
 function modificarTalla($idtalla,$descripcion){
   $con = new clsConexion;
   if($con->conectarse()==true){
     $query = "CALL SP_U_Talla('$idtalla','$descripcion')";
     $result = @mysql_query($query);
     if (!$result)
	   return false;
     else
       return true;
   }
 }
 function consultarTalla(){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_Talla()";
	 $result = @mysql_query($query);
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
function consultarTotalTallas(){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_TallaCantidadTotal()";
	 $result = @mysql_query($query);
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
 function consultarTallaPorParametro($criterio,$busqueda,$limite){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){

     $query = "CALL SP_S_TallaPorParametro('$criterio','$busqueda','$limite')";
	 $result = @mysql_query($query);
	 if (!$result)

	   return false .mysql_error();

	 else
	   return $result;
   }
 } 
 function consultarTallaIdMaximo(){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_TallaIdMaximo()";
	 $result = @mysql_query($query);
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
 
 
}
?>
