<cfparam name="showauthenticateform" default="show" />
<cfparam name="authenticateError" default="" />
<cfparam name="identification" default="" />
<cfparam name="ErrorMessage" default=""/>

<cfset showauthenticateform=preProcess()>

	
<script>
	function validatePassword(){
		var originalPassword=document.getElementById('newpassword').value;
		var confirmPassword=document.getElementById('newpasswordconfirm').value;
		console.dir(originalPassword);
		console.dir(confirmPassword);
		if(originalPassword===confirmPassword && originalPassword!==''){
			document.getElementById('submitnewpasswordform').click();
			document.getElementById('ErrorMessage').innerHTML="";
		}
		else{
			document.getElementById('ErrorMessage').innerHTML="The Two passwords do not match";
		}
	}
</script>

<cfoutput>
	    <div id="ErrorMessage">&nbsp;#ErrorMessage#</div>

	<cfif showauthenticateform eq 'noshow'>
		#newPasswordForm()#
	<cfelse>
		#authenticateForm()#
	</cfif>
		
</cfoutput>	


<cffunction name="preProcess">
	<cfif isdefined('form.lastname')>
		<cfquery name="authentification" datasource="#application.dsource#">
			select * from People where lastname='#form.lastname#' and email='#form.email#'	
		</cfquery>

		<cfif authentification.recordcount gt 0>
			<cfset identification=#authentification.personID[1]#>
			<cfreturn "noshow">
		<cfelse>
			<cfset ErrorMessage="The name and email do not match">

			<cfreturn "show">
		</cfif>

	</cfif>
		
	<cfif isdefined('form.newpassword')>

		<cfquery name="passwordification" datasource="#application.dsource#">
			UPDATE Passwords
			SET password='#hash(form.newpassword,"SHA-256")#'
			WHERE personID='#identification#'
		</cfquery>
	   	
		 <cflocation url="../Week9/index.cfm" />
	<cfelse>
		
	</cfif>
			<cfreturn "show">

</cffunction>


<cffunction name="authenticateForm">
    <cfoutput>
        <legend>Authenticate User</legend>
        <form action="#cgi.script_name#?p=forgotPassword" class="form-horizontal" method="post">
            <input type="hidden" name="lastName" value="">
            <div class="form-group">
                <label class="col-lg-3 control-label">Last Name*</label>
                <div class="col-lg-8">
                    <input type="text" class="form-control" name="lastname" id="lastname" required />
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-3 control-label">Email*</label>
                <div class="col-lg-8">
                    <input type="text" class="form-control" name="email" id="email" required/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-3 control-label">&nbsp;</label>
                <div class="col-lg-8">
                    <input type="submit" id="authenticateaccountform" />
                </div>
            </div>
        </form>
    </cfoutput>
</cffunction>

<cffunction name="newPasswordForm">
    <cfoutput>
        <form action="#cgi.script_name#?p=forgotPassword" method="post" class="form-horizontal">
            <legend>New Password</legend>
			
            <div class="form-group">
                <label class="col-lg-3 control-label">
                    New Password*
                </label>
                <div class="col-lg-8">
                    <input type="text" name="newpassword" id="newpassword" />
                </div>
            </div>
			
            <div class="form-group">
                <label class="col-lg-3 control-label">
                    Confirm Password*
                </label>
                <div class="col-lg-8">
                    <input type="text" class=form-control" name="newpasswordconfirm" id="newpasswordconfirm" required/>
                </div>
            </div>
			
            <div class="form-group">
                <label class="col-lg-3 control-label">&nbsp;</label>
                <div class="col-lg-8">
                     <button type="button" id="validatePasswordButton" class="btn btn-warning" onclick="validatePassword()">Change Password</button>

                    <input type="submit" id="submitnewpasswordform" style="display:none" />
                </div>
            </div>
        </form>
    </cfoutput>
</cffunction> 