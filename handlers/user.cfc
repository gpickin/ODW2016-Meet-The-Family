/**
* I am a new handler
*/
component{
	
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
		param name="session.userid", default="";

		if( session.userid == '' ){
			setNextEvent( 'login/login' );
		}
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
    * myaccount  
    */
    function myaccount( event, rc, prc ){
    	param name="session.userid", default="";
		param name="session.username", default="";
		event.setView( "user/myaccount" );
	}	

	/**
    * logout  
    */
    function logout( event, rc, prc ){
		session.userid = '';
		session.username = '';
    	setNextEvent( 'login/login' );
	}
	
}
