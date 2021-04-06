<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    
    <title>AdVentas - Sistema Ventas www.pequescloset.com</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->

    <!-- Custom CSS -->
    <link href="css/sb-admin.css" rel="stylesheet">

    <!-- Custom Fonts -->

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Bienvenido</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" name="frmUsuario" method="post" action="empleado/Ingresar.php">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="User" name="txtUsuario" id="txtUsuario" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Password" name="txtPassword" id="txtPassword" type="password">
                                </div>
                                <!--<div class="form-group">
                                    <select name="tipousuario" class="form-control">
                                    	<option>Administrador</option>
                                    	<option>Cajero</option>
                                    </select>
                                </div>-->
                                <!-- Change this to a button or input when using this as a form -->
                                <button type="submit" class="btn btn-lg btn-success btn-block">Ingresar</button>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    

</body>

</html>
