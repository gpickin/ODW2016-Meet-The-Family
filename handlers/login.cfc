/**
* I am a new handler
*/
component{

	property name="messagebox"		inject="id:messagebox@cbmessagebox";
	
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
		
		var usersQuery = queryNew(
							"id,email,password,name",
							"numeric,varchar,varchar,varchar",
							[
								{
									id: "1",
									email: "gavin@ortussolutions.com",
									password: "gavin",
									name: "Gavin Pickin"
								},
								{
									id: "2",
									email: "brad@ortussolutions.com",
									password: "wood",
									name: "Brad Wood"
								},
								{
									id: "3",
									email: "lmajano@ortussolutions.com",
									password: "secreto",
									name: "Luis Majano"
								}
							]);

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
			
			var myQry = new Query(); // new query object     
    		myQry.setdbtype( 'query');
    		myQry.setAttributes( usersQuery=usersQuery );
    		myQry.setSQL("select * from usersQuery where email = :email and password = :password"); //set query
    		myQry.addParam(name="email",value="#rc.email#",CFSQLTYPE="CF_SQL_VARCHAR"); // add query param
    		myQry.addParam(name="password",value="#rc.password#",CFSQLTYPE="CF_SQL_VARCHAR"); // add query param
    		var qryRes = myQry.execute(); // execute query
    		//writeDump( qryRes.getResult() );	

    		if( qryRes.getResult().recordcount == 1){
    			session.userid = qryRes.getResult().id;
    			session.username = qryRes.getResult().name;
    			loggedIn = true;
				message = "Successfully logged in. Welcome back #qryRes.getResult().name#";
    		} else {
    			loggedIn = false;
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
