<cfif isdefined('url.p') and url.p eq 'logoff'>
	<cfset StructClear(session)>
	<cfset session.isLoggedIn=false>
	<cfset makeCleanUser()>
	<cfset p="carousel">
</cfif>

<cfif not isdefined('session.user')>
	    <cfset makeCleanUser()>

</cfif>

<cfif isdefined('form.loginemail')>
	<cfquery name="access" datasource="#application.dsource#">
		select * from People 
		inner join Passwords on People.personID = Passwords.personID 
		where email='#form.loginemail#' and password='#hash(form.loginpass,"SHA-256")#'
	</cfquery>

	<cfif access.recordcount gt 0>
		<cfset session.user.firstname=access.firstname[1]>
		<cfset session.user.lastname=access.lastname[1]>
		<cfset session.user.acctNumber=access.personID[1]>
		<cfset session.user.emial=access.email[1]>
 		<cfset session.isLoggedIn=true>
		<cfset p="carousel">
		<cfif access.isadmin[1] neq ''>
            <cfset session.user.isadmin=access.isadmin[1]>
        </cfif>
	<cfelse>
		<cfset loginmessage="Sorry, that does not match">
	</cfif>
</cfif>

<cffunction name="makeCleanUser">
	<cfset session.isLoggedIn=false>
	<cfset session.user={firstName:'',lastname:'',acctnumber:'',email:'',isAdmin:0}>
</cffunction>
			
