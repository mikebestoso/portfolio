<!doctype html>
<html>
<head>
 <meta charset="utf-8">
 <title>Untitled Document</title>
</head>
	
<cfparam name="qterm" default="" />
<body>
	<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#maincontent" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <img src="../../includes/classimages/giphy.gif">
    </div>

    <div class="collapse navbar-collapse" id="maincontent">
      <ul class="nav navbar-nav">
        <li class="active"><a href="../../myWebSite/Week9/index.cfm">Home </a></li>
        <li><a href="../../myWebSite/Week10finalproject/index.cfm?p=info">Store Information</a></li>
		  <li><a href="../../myWebSite/Week10finalproject/index.cfm?p=events">Weekly Events</a>
		<li><a href="../../myWebSite/Week10finalproject/index.cfm?p=bio">Yoshi's Bio</a>
      </ul>
	<cfoutput>
		<ul class="nav navbar-nav navbar-right">
		  <cfif session.isLoggedIn>
			<li><a>Welcome #session.user.firstname#</a></li>
			<cfif session.user.isadmin>
				<li><a href="../management/index.cfm">Management</a></li>  
			</cfif>
			<li><a href="?p=logoff">Logout</a></li>
		<cfelse>
			<li><a href="?p=Login">Login</a></li>	
		</cfif>
		</ul>
	</cfoutput>
	
	
		<cfoutput>
		<input type="hidden" name="qterm" value="#qterm#" />
   		<form action="#cgi.SCRIPT_NAME#?p=bar" method="post" class="navbar-form navbar-right">
        <div class="form-group">
        	<input type="text" class="form-control" id="qterm" name="qterm" value="#qterm#">
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
		</form>

		</cfoutput>
		

			

    </div>
  </div>
</nav>
</body>
</html> 