<cfoutput>
<h1>user.myaccount - Welcome #session.username#</h1>

#getInstance( "messagebox@cbmessagebox" ).renderIt()#

<ul>
	<li><a href="/user/logout">Logout</a>
</ul>
</cfoutput>