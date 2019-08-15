

	
	<cfquery name="searchquery" datasource="#application.dsource#">
			select * from Books where ISBN13=#isbn13#
	</cfquery>

    <div>
        <cfoutput>
			<center><img src="#searchquery.coverimage[1]#"></center></br></br>
			<span><strong>Title:</strong> #searchquery.title[1]#</span></br>
            <span>#searchquery.description[1]#</span>
        </cfoutput>
    </div>