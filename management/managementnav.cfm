 <nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#Nav">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
			</button>
        </div>
        <cfoutput>
			<div class="collapse navbar-collapse" id="Nav">
                <ul class="nav navbar-nav">
					<li><a href="../../myWebSite/Week10finalproject/index.cfm">Home</a></li>
                    <li><a href="#cgi.script_name#?tool=addedit">Add Edit</a></li>
                    <li><a href="#cgi.script_name#?tool=createuuids">Create UUIDs</a></li>
                    <li><a href="#cgi.script_name#?tool=content">Content</a></li>

                </ul>
            </div>
        </cfoutput>
    </div>
</nav> 