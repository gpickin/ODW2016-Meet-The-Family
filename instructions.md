## Install TestBox

**All commands run in `box`**

```bash
install testbox
```

## Scaffold out first integration test

```bash
coldbox create integration-test handler=login actions=doLogin
```

```js
function run(){

    describe( "login Suite", function(){

        beforeEach(function( currentSpec ){
            // Setup as a new ColdBox request for this suite, VERY IMPORTANT. ELSE EVERYTHING LOOKS LIKE THE SAME REQUEST.
            setup();
        });

        it( "logins with correct credentials", function(){
            getRequestContext().setValue( "email", "gavin@ortussolutions.com" );
            getRequestContext().setValue( "password", "gavin" );
            var event = execute( event="login.doLogin", renderResults=true );
            debug(var = event.getCollection());
            expect( event.getValue( "setNextEvent_event" ) ).toBe( "user/myaccount" );
        });

        it( "does not login in with incorrect credentials", function() {
            getRequestContext().setValue( "email", "eric@ortussolutions.com" );
            getRequestContext().setValue( "password", "eric" );
            var event = execute( event="login.doLogin", renderResults=true );
            debug(var = event.getCollection());
            expect( event.getValue( "setNextEvent_event" ) ).toBe( "login/login" );
        } );

    
    });

}
```

## Scaffold out Unit test

```bash
coldbox create model-test path=models.User methods=login,getById
```

```js
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
```

## Integrated Spec 😎

```bash
install integrated
install integrated-commands
integrated create LoginSpec
```

*Set up Integrated (already done on this branch)*

```js
function run() {
    describe( "it tests the entire login flow", function() {
        given( "a user has an account", function() {
            when( "a user visits the log in page and fills out the form correctly", function() {
                then( "they should be logged in", function() {
                    this.visit( "/login/login" )
                        .type( "gavin@ortussolutions.com", "email" )
                        .type( "gavin", "password" )
                        .press( "Sign in" )
                        .seePageIs( "/user/myaccount" )
                        .see( "Successfully logged in. Welcome back Gavin Pickin" );
                } );
            } );    
        } );
    } );
}
```