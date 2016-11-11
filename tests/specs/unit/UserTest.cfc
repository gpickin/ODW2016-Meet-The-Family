/**
* The base model test case will use the 'model' annotation as the instantiation path
* and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
* responsibility to update the model annotation instantiation path and init your model.
*/
component extends="coldbox.system.testing.BaseModelTest" model="models.User"{
	
	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		// setup the model
		super.setup();		
		
		// init the model object
		model.init();
	}

	function afterAll(){
	}

	/*********************************** BDD SUITES ***********************************/
	
	function run(){

		describe( "models.User Suite", function(){
			
			describe( "login", function(){
				it( "returns a query with no records if the login information is incorrect", function() {
					var actual = model.login( "eric@ortussolutions.com", "eric" );

					expect( actual.getResult() ).toBeEmpty( "Expected no records to be returned" );
				} );

				it( "returns a query with at least one record if the login information is correct", function() {
					var actual = model.login( "gavin@ortussolutions.com", "gavin" );

					expect( actual.getResult() ).notToBeEmpty( "Expected at least one record to be returned" );
					expect( actual.getResult().email ).toBe( "gavin@ortussolutions.com" );
				} );
			});

			describe( "getByID", function(){
                it( "returns a query with no records if the id is incorrect", function() {
					var actual = model.getById( 918406 );

					expect( actual.getResult() ).toBeEmpty( "Expected no records to be returned" );
				} );

				it( "returns a query with at least one record if the id is correct", function() {
					var actual = model.getById( 1 );

					expect( actual.getResult() ).notToBeEmpty( "Expected at least one record to be returned" );
					expect( actual.getResult().id ).toBe( 1 );
				} );
			});


		});

	}

}
