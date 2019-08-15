<cfparam name="AccountMessage" default="">
<cfparam name="LoginMessage" default="">


<script>
	function validateNewAccount(){
		var originalPassword=document.getElementById('newaccountpassword').value;
		var confirmPassword=document.getElementById('newaccountpasswordconfirm').value;
		console.dir(originalPassword);
		console.dir(confirmPassword);
		if(originalPassword===confirmPassword && originalPassword!==''){
			document.getElementById('submitnewaccountform').click();
			document.getElementById('newAccountMessage').innerHTML="";
		}
		else{
			document.getElementById('newAccountMessage').innerHTML="The Two passwords do not match";
		}
	}
</script>

<cfset preProcess()>
	
<div class="col-lg-6">
	<cfoutput>
		#newUserForm()#
	</cfoutput>	
</div>
<div class="col-lg-6">
	<cfoutput>
		#loginForm()#
	</cfoutput>	
</div>
	
<cffunction name="preProcess">
	<cfif isdefined('form.newpersonid')>
		<cfset newid=createuuid()>
		<cfquery name="getEmail" datasource="#application.dsource#">
			select * from People where email='#form.email#'	
		</cfquery>
		<cfif getEmail.recordcount eq 0>
			<cfquery name="putin" datasource="#application.dsource#">
				insert into People (personID,firstname,lastname,email, isadmin) values ('#newid#','#form.firstname#','#form.lastname#','#form.email#','0')
			</cfquery>
			<cfquery name="pass" datasource="#application.dsource#">
				insert into passwords (personID,password) values ('#newid#','#hash(form.password,"SHA-256")#')
			</cfquery>
		<cfelse>
			<cfset AccountMessage="That Email Account is Already in Our System. Please Login">
		</cfif>
	</cfif>
</cffunction>

<cffunction name="newUserForm">
    <cfoutput>
        <legend>New User</legend>
        <div id="newAccountMessage">#AccountMessage#</div>
        <form action="#cgi.script_name#?p=login" class="form-horizontal" method="post">
            <input type="hidden" name="newPersonId" value="">
            <div class="form-group">
                <label class="col-lg-3 control-label">First Name*</label>
                <div class="col-lg-8">
                    <input type="text" class="form-control" name="firstname" required />
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-3 control-label">Last Name*</label>
                <div class="col-lg-8">
                    <input type="text" class="form-control" name="lastname" required/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-3 control-label">Email</label>
                <div class="col-lg-8">
                    <input type="email" class="form-control" name="email" required/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-3 control-label">Password</label>
                <div class="col-lg-8">
                    <input type="text" class="form-control" name="password" id="newaccountpassword" required/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-3 control-label">Confirm Password</label>
                <div class="col-lg-8">
                    <input type="text" class="form-control" id="newaccountpasswordconfirm" required/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-3 control-label">&nbsp;</label>
                <div class="col-lg-8">
                    <button type="button" id="newAccountButton" class="btn btn-warning" onclick="validateNewAccount()">Make Account</button>
                    <input type="submit" id="submitnewaccountform" style="display:none" />
                </div>
            </div>
        </form>
    </cfoutput>
</cffunction>

<cffunction name="loginForm">
    <cfoutput>
        <div id="loginmessage">#loginmessage#</div>
        <form action="#cgi.script_name#?p=login" method="post" class="form-horizontal">
            <legend>Login</legend>
            <div class="form-group">
                <label class="col-lg-3 control-label">
                    Username:
                </label>
                <div class="col-lg-8">
                    <input type="text" name="loginemail" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-3 control-label">
                    Password:
                </label>
                <div class="col-lg-8">
                    <input type="password" name="loginpass" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-3 control-label">
                    &nbsp;
                </label>
                <div class="col-lg-8">
                    <button class="btn btn-primary" type="submit">Login</button>
                </div>
				<div class ="col-lg-8">
					<br>
					<a href="#cgi.script_name#?p=forgotPassword">Forgot Password?</a>
				</div>
            </div>
        </form>
    </cfoutput>
</cffunction> 