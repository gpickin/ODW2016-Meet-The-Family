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

	function preHandler( event, rc, prc, action, eventArguments ){
		logBox = getController().getLogBox().getLogger('logfile');
	}

	/**
	IMPLICIT FUNCTIONS: Uncomment to use

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
    * Note: May use caching since our content is static
    */
    function login( event, rc, prc ) cache="true"{
		event.setView( "login/login" );
	}	

	/**
    * doLogin  
    * Note: May use caching since our cache key is comprised of form/URL values
    */
    function dologin( event, rc, prc ) cache="true"{

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
    			// Calling dependency injection

    			logger.Info('Successfully logged in. Welcome back #qryRes.getResult().name#', '#qryRes.getResult()#');
    			
    			session.userid = qryRes.getResult().id;
    			session.username = qryRes.getResult().name;
    			session.emailaddress = qryRes.getResult().email;
    			loggedIn = true;
				message = "Successfully logged in. Welcome back #qryRes.getResult().name#";
    		} else {
    			loggedIn = false;

    			// Another way to call logbox valid in handlers, views and interceptors
	   			logBox.Info('Username password combination invalid. #rc.email#', '#qryRes.getResult()#');
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
