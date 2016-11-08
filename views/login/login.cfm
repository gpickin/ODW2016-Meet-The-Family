<cfoutput>
<h1>All of time and space, everything that ever happened or ever will - where do you want to start?</h1>

#getInstance( "messagebox@cbmessagebox" ).renderIt()#

<div class="row">
	<div class="col-md-5">
      <form action="/login/doLogin" method="post" class="form-signin" role="form">

        <h2 class="form-signin-heading">
    
            Please sign in
    
        </h2>
        <input class="form-control" type="text" name="email" id="email" autofocus="" placeholder="Email address"></input>
        <input class="form-control" type="password" name="password" id="password" placeholder="Password"></input>
        <label class="checkbox">
            <input type="checkbox" value="remember-me"></input>
    
             Remember me
                    
    
        </label>
        <button class="btn btn-lg btn-primary btn-block" type="submit" id="btn_login">
    
            Sign in
    
        </button>

    </form>
      
    </div>
</div>    
</cfoutput>