/**
* I am a new handler
*/
component{

	property name="messagebox"		inject="id:messagebox@cbmessagebox";
	property name="logger" inject="logBox:logger:logfile";
	
	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";		
	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};
	
	/**
	IMPLICIT FUNCTIONS: Uncomment to use
	function preHandler( event, rc, prc, action, eventArguments ){
	}
	function postHandler( event, rc, prc, action, eventArguments ){
	}
	function aroundHandler( event, rc, prc, targetAction, eventArguments ){
		// executed targeted action
		arguments.targetAction( event );
	}
	function onMissingAction( event, rc, prc, missingAction, eventArguments ){
	}
	function onError( event, rc, prc, faultAction, exception, eventArguments ){
	}
	function onInvalidHTTPMethod( event, rc, prc, faultAction, eventArguments ){
	}
	*/
		
	/**
    * login  
    */
    function login( event, rc, prc ){
		event.setView( "login/login" );
	}	

	/**
    * doLogin  
    */
    function dologin( event, rc, prc ){

		var loggedIn = false;
		if ( len( rc.email ) < 5 ){
			loggedIn = false;
			message = "Invalid Email - Thats not a real email, try again Darlek";
		} else if( find( '@', rc.email ) == 0 ){
			loggedIn = false;
			message = "Invalid Email - Where are you @... obviously not from around here with an email with no @, try again PUNY HUMAN";
		} else if( right( rc.email, 1 ) == '.' ){
			loggedIn = false;
			message = "Invalid Email - TARDIS requires a full stop, but this is not the end of the line, try again time traveler";
		} else if( find( '.', rc.email, find( '@', rc.email ) ) == 0 ){
			loggedIn = false;
			message = "Invalid Email - TARDIS requires a full stop, especially in this domain, try again time traveler";
		} else if( len( rc.password ) < 1 ){
			loggedIn = false;
			message = "Invalid password - Thats not a real password, you need at least 1 character, try again Cyberman";
		} else {
			
			// No DI library, doing things old school
			//var user = CreateObject( "component", "models.User" ).init();			
			
			// Manually creating a WireBox instance and then using it in the app
			//var injector = CreateObject( "component", "coldbox.system.ioc.injector" ).init();
			//var user = injector.getInstance( "User" );
			
			// WireBox, baked into ColdBox
			var user = getInstance( "User" );			
			
			var qryRes = user.login( rc.email, rc.password );
			
    		if( qryRes.getResult().recordcount == 1){
    			logger.Info("Successfully logged in. Welcome back #qryRes.getResult().name#");
    			session.userid = qryRes.getResult().id;
    			session.username = qryRes.getResult().name;
    			session.emailaddress = qryRes.getResult().email;
    			loggedIn = true;
				message = "Successfully logged in. Welcome back #qryRes.getResult().name#";
    		} else {
    			loggedIn = false;
    			logger.Info("Username password combination invalid. #rc.email#");
				message = "Username password combination invalid. Please try again.";
    		}
			
		}

		//writeDump( loggedIn );
		//writeDump( message );
		//abort;
		
		if( loggedIn ){
			messagebox.info( message );
			setNextEvent( 'user/myaccount' );
		} else {
			messagebox.error( message );
			setNextEvent( 'login/login' );
		}

	}	

	
}
