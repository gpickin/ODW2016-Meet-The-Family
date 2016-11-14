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
    * Note:  Cannot use caching for events since values are set by session variables
    */
    function myaccount( event, rc, prc ) cache="false"{
    	param name="session.userid", default="";
		param name="session.username", default="";
		
		var user = getInstance( "user" );
		var userDetails = user.getByID( session.userID );
		
		rc.userName = userDetails.getResult().name;
		rc.userEmail = userDetails.getResult().email;
		
		event.setView( "user/myaccount" );
	}

	/**
	* Note:  May use caching for events since values are set provided in URL route
	**/
    function account( event, rc, prc ) cache="true"{
		var user = getInstance( "user" );
		var userDetails = user.getByID( event.getValue( "id", 0 ) );
		
		rc.userName = userDetails.getResult().name;
		rc.userEmail = userDetails.getResult().email;
		
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
