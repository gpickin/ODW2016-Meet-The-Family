component name="user" accessors="true"
{	
	property name="Cache" inject="cachebox:user";

	public any function init()
	{
		// quickie "database" storage for the demo...
		variables.usersQuery = queryNew(
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
								},
								{
									id: "4",
									email: "nolan@ortussolutions.com",
									password: "nolan",
									name: "Nolan Erck"
								},
								{
									id: "5",
									email: "gmurphy@ortussolutions.com",
									password: "george",
									name: "George Murphy"
								},
                               	{
									id: "6",
									email: "jclausen@ortussolutions.com",
									password: "jon",
									name: "Jon Clausen"
								}
							]);

		return this;
	}
	
	public any function login( required string email, required string password )	
	{
		var myQry = new Query(); // new query object     
		myQry.setdbtype( 'query');
		
		myQry.setAttributes( usersQuery=variables.usersQuery );
		
		myQry.setSQL("select * from usersQuery where email = :email and password = :password"); //set query
		myQry.addParam(name="email",value="#arguments.email#",CFSQLTYPE="CF_SQL_VARCHAR"); // add query param
		myQry.addParam(name="password",value="#arguments.password#",CFSQLTYPE="CF_SQL_VARCHAR"); // add query param
		var qryRes = myQry.execute(); // execute query

		return qryRes;			
	}

	public any function getByID( required numeric userID )
	{
		var sql = "select * from usersQuery where id = :userID";
		var cacheKey = hash( arguments.userID & ':' & sql );

		var qUser = getCache().get( cacheKey );


		if( isNull( qUser ) ){
			var myQry = new Query(); // new query object     
			myQry.setdbtype( 'query');
			
			myQry.setAttributes( usersQuery=variables.usersQuery );
			myQry.setSQL(sql); //set query
			myQry.addParam(name="userID",value="#arguments.userID#",CFSQLTYPE="CF_SQL_INT"); // add query param
			var qUser = myQry.execute(); // execute query
			getCache().set( cacheKey, qUser );	
		}

		return qUser;			
	}
	
}
