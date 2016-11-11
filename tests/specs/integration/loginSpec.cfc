component extends="Integrated.BaseSpecs.ColdBoxBaseSpec" {

    function beforeAll() {
        super.beforeAll();
    }

    function afterAll() {
        super.afterAll();
    }
    
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

}
