<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>addedit.cfm</title>
		<link href="../../includes/bootstrap/css/bootstrap.css" rel="stylesheet" />
		<link href="../../includes/css/mycss.css" rel="stylesheet" />
		<script src="../../includes/ckeditor/ckeditor/ckeditor.js" type="text/javascript"></script>

	</head>
	<cffunction name="makeCleanUser">
	<cfset session.isLoggedIn=false>
	<cfset session.user={firstName:'',lastname:'',acctnumber:'',email:'',isAdmin:0}>
</cffunction>
		
<cfif not isdefined('session.user')>
	    <cfset makeCleanUser()>

</cfif>

<cfparam name="tool" default="addedit" />
	
 <cfif not session.user.isadmin>
        <cflocation url="../Week9/index.cfm" />
 </cfif>
	<body>
        <div class="container">
            <div class=row>
				<cfinclude template="managementnav.cfm">	
			</div>
            <div class="col-lg-12 row">
                <cfinclude template="#tool#.cfm">
            </div>
        </div>
    </body>
</html>
