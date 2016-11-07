<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Who's Who - Social Media for Whovians</title>

    <!-- Bootstrap core CSS -->
    <link href="/includes/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap theme -->
    <link href="/includes/css/bootstrap-theme.min.css" rel="stylesheet">


	<link href="/includes/css/main.css" rel="stylesheet">


        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body role="document">

	<div id="logo_holder" class="container">
		<a href="##" title="Who's Who - Social Network for Whovians"><img src="/includes/img/logo.png" border="0" alt="Who's Who - Social Network for Whovians"></a>
	</div>	

     
    <div class="navbar navbar-custom" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <!--<a class="navbar-brand" href="#">Who's Who - Social Media for Whovians</a>-->
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
          	<li><a href="##">Home</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>




	
    <div class="bodycontainer container theme-showcase" role="main">
    	<cfoutput>
    		#renderView()#
    	</cfoutput>
    




	    <div class="footer">
	      &copy; Copyright 2016 - ODW2016 - Meet the Family - All Rights Reserved
	    </div>  
  
  	</div> <!-- /container -->

  
  

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="/includes/js/bootstrap.min.js"></script>



    <script>

        $(document).on('ready', function(){
              $('#btn_login').on('click', function(){
                    if ( $('#email').val().length < 5 ){
                        $('#status').show();
                        $('#status').html('Invalid Email - Thats not a real email, try again Darlek');
                        $('#status').addClass('alert');
                        $('#status').addClass('alert-danger');
                        $('#status').delay( 2000 ).hide( 1000 );
                    }
                    else if ( $('#email').val().indexOf('@') === -1 ){
                        $('#status').show();
                        $('#status').html('Invalid Email - Where are you @... obviously not from around here with an email with no @, try again PUNY HUMAN');
                        $('#status').addClass('alert');
                        $('#status').addClass('alert-danger');
                        $('#status').delay( 2000 ).hide( 1000 );
                    }
                    else if ( $('#email').val().indexOf('.', $('#email').val().indexOf('@')) === -1 ){
                        $('#status').show();
                        $('#status').html('Invalid Email - TARDIS requires a full stop, especially in this domain, try again time traveler');
                        $('#status').addClass('alert');
                        $('#status').addClass('alert-danger');
                        $('#status').delay( 2000 ).hide( 1000 );
                    }
                    else if ( $('#email').val().charAt($('#email').val().length - 1) === '.' ){
                        $('#status').show();
                        $('#status').html('Invalid Email - TARDIS requires a full stop, but this is not the end of the line, try again time traveler');
                        $('#status').addClass('alert');
                        $('#status').addClass('alert-danger');
                        $('#status').delay( 2000 ).hide( 1000 );
                    }
                    else if ( $('#password').val().length < 8 ){
                        $('#status').show();
                        $('#status').html('Invalid password - Thats not a real password, try again Cyberman');
                        $('#status').addClass('alert');
                        $('#status').addClass('alert-danger');
                        $('#status').delay( 2000 ).hide( 1000 );
                    }
                    else {
                        $.ajax({
                              type: "POST",
                              url: "http://devobj2015:8504/testablejavascript/cfcs/userServiceRemote.cfc?method=login",
                              data: ( { email: $('#email').val(), password: $('#password').val() } ),
                              cache: false,
                              dataType: "text"
                          })
                          .done( function( data ) {
                              var ajaxResponse = JSON.parse(data);
                              if ( ajaxResponse.RESULT == '200' ){
                                  $('#status').show();
                                  $('#status').html('TARDIS Access Granted - Please wait for the Doctor to take you for a spin');
                                  $('#status').addClass('alert');
                                  $('#status').addClass('alert-danger');
                                  $('#status').delay( 2000 ).hide( 1000 );
                              }
                              else {
                                  $('#status').show();
                                  $('#status').html('Did you lose your TARDIS key? Please try to login again.');
                                  $('#status').addClass('alert');
                                  $('#status').addClass('alert-danger');
                                  $('#status').delay( 2000 ).hide( 1000 );
                              }
                          })
                          .fail( function( data) {
                              //console.log( data );
                              $('#status').show();
                              $('#status').html('The TARDIS is lost in a timey whimey vortex - try back later.');
                              $('#status').addClass('alert');
                              $('#status').addClass('alert-danger');
                              $('#status').delay( 2000 ).hide( 1000 );
                          });
                    }
              });

              $('#btn_forgotPassword').on('click', function(){
                    if ( $('#forgotEmail').val().length < 5 ){
                        $('#status').show();
                        $('#status').html('Invalid Email - Thats not a real email, try again Darlek');
                        $('#status').addClass('alert');
                        $('#status').addClass('alert-danger');
                        $('#status').delay( 2000 ).hide( 1000 );
                    }
                    else if ( $('#forgotEmail').val().indexOf('@') <= 1 ){
                        $('#status').show();
                        $('#status').html('Invalid Email - Where are you @... obviously not from around here with an email with no @, try again PUNY HUMAN');
                        $('#status').addClass('alert');
                        $('#status').addClass('alert-danger');
                        $('#status').delay( 2000 ).hide( 1000 );
                    }
                    else if ( $('#forgotEmail').val().indexOf('.', $('#forgotEmail').val().indexOf('@')) === -1 ){
                        $('#status').show();
                        $('#status').html('Invalid Email - TARDIS requires a full stop, especially in this domain, try again time traveler');
                        $('#status').addClass('alert');
                        $('#status').addClass('alert-danger');
                        $('#status').delay( 2000 ).hide( 1000 );
                    }
                    else if ( $('#forgotEmail').val().charAt($('#forgotEmail').val().length - 1) === '.' ){
                        $('#status').show();
                        $('#status').html('Invalid Email - TARDIS requires a full stop, but this is not the end of the line, try again time traveler');
                        $('#status').addClass('alert');
                        $('#status').addClass('alert-danger');
                        $('#status').delay( 2000 ).hide( 1000 );
                    }
                    else {
                      $.ajax({
                            type: "POST",
                            url: "http://devobj2015:8504/testablejavascript/cfcs/userServiceRemote.cfc?method=resetPassword",
                            data: ( { email: $('#forgotEmail').val() } ),
                            cache: false,
                            dataType: "text"
                        })
                        .done( function( data ) {
                          var ajaxResponse = JSON.parse(data);
                          if ( ajaxResponse.RESULT == '200' ){
                              $('#status').show();
                              $('#status').html("TARDIS is resetting your password, please check email for your Notification");
                              $('#status').addClass('alert');
                              $('#status').addClass('alert-danger');
                              $('#status').delay( 2000 ).hide( 1000 );
                          }
                          else {
                              $('#status').show();
                              $('#status').html("That email address doesn't exist in this dimension");
                              $('#status').addClass('alert');
                              $('#status').addClass('alert-danger');
                              $('#status').delay( 2000 ).hide( 1000 );
                          }
                        })
                        .fail( function( data) {
                            //console.log( data );
                            $('#status').show();
                            $('#status').html('The TARDIS is lost in a timey whimey vortex - try back later.');
                            $('#status').addClass('alert');
                            $('#status').addClass('alert-danger');
                            $('#status').delay( 2000 ).hide( 1000 );
                        });
                    }
              });

        });

    </script>

  </body>
</html>

