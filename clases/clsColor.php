<?php 
//Referenciamos la clase clsConexion
include_once("clsConexion.php");

//Implementamos la clase categoria
class clsColor{
 //Constructor	
 function clsColor(){
 }	
 
 //Funcion para agregar una nueva categoria en la BD
 function agregarColor($descripcion){
   $con = new clsConexion;
   if($con->conectarse()==true){
     $query = "CALL SP_I_Color('$descripcion')";
     $result = @mysql_query($query);
     if (!$result)
	   return false;
     else
       return true;
   }
 }

 function CantidadColor(){
   $con = new clsConexion;
   if($con->conectarse()==true){
     $query = "CALL SP_S_CANTIDAD_COLORES()";
   $result = @mysql_query($query);
   if (!$result)
     return false;
   else
     return $result;
   }
}
 //Modificar empleado en la base de datos
 function modificarColor($idcolor,$descripcion){
   $con = new clsConexion;
   if($con->conectarse()==true){
     $query = "CALL SP_U_Color('$idcolor','$descripcion')";
     $result = @mysql_query($query);
     if (!$result)
	   return false;
     else
       return true;
   }
 }
 function consultarColor(){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_Color()";
	 $result = @mysql_query($query);
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
function consultarTotalColors(){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_ColorCantidadTotal()";
	 $result = @mysql_query($query);
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
 function consultarColorPorParametro($criterio,$busqueda,$limite){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){

     $query = "CALL SP_S_ColorPorParametro('$criterio','$busqueda','$limite')";
	 $result = @mysql_query($query);
	 if (!$result)

	   return false .mysql_error();

	 else
	   return $result;
   }
 } 
 function consultarColorIdMaximo(){
   //creamos el objeto $con a partir de la clase clsConexion
   $con = new clsConexion;
   //usamos el metodo conectar para realizar la conexion
   if($con->conectarse()==true){
     $query = "CALL SP_S_ColorIdMaximo()";
	 $result = @mysql_query($query);
	 if (!$result)
	   return false;
	 else
	   return $result;
   }
 }
 
 
}
?>
