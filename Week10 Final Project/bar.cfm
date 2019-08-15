<cfparam name="searchbar" default="">
<cffunction name="bar">
		
	<cfquery name="searchbooks" datasource="#application.dsource#">
			select * from Books where title like '%#qterm#%' order by title
	</cfquery>
	<cfoutput>
		<ul class="nav nav-stacked">
			<cfif qterm neq ''>	
				<cfloop query="searchbooks">
					<li><a href="#cgi.SCRIPT_NAME#?p=searchbar&isbn13=#searchbooks.ISBN13#">#trim(title)#</a></li>
				</cfloop>
			<cfelse>
					No Search Term Entered (Try "heart")
			</cfif>
		</ul>
	</cfoutput>
</cffunction>

<cfset bar()>