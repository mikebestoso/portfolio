<cfparam name="searchme" default="">
<cfparam name="genre" default="">
<cfparam name="publisher" default="">

	<cfset bookinfo=makeQuery()>
	
<cfoutput>
    <legend>#bookinfo.label#</legend>
    <cfif bookinfo.booksQuery.recordcount eq 0>
        #noResults()#
    <cfelseif bookinfo.booksQuery.recordcount eq 1>
        #oneResult(bookinfo.booksQuery)#
    <cfelse>
        #manyResults(bookinfo.booksQuery)#
    </cfif>
</cfoutput>


<cffunction name="makeQuery">
    <cfset bookInfo={booksQuery:queryNew("title")}>
    <cfif genre neq ''>
        <cfquery name="whatGenre" datasource="#application.dsource#">
            select * from genres where genreid='#genre#'
        </cfquery>
        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from books
            inner join publishers on books.publisher = publishers.id
            inner join genrestobooks on books.ISBN13 = genrestobooks.bookid
            where genreid='#genre#'
        </cfquery>
        <cfset bookinfo.label="Genre:#whatGenre.genrename[1]#">
    <cfelseif searchme neq ''>
        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from books
            inner join publishers on books.publisher = publishers.id
            where title like '%#trim(searchme)#%' or isbn13='#searchme#'
        </cfquery>
        <cfset bookinfo.label="Keyword:#searchme#">
    <cfelseif publisher neq ''>
        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from books
            inner join publishers on books.publisher = publishers.id
            where publishers.ID ='#publisher#'
		</cfquery>
        <cfset bookinfo.label="Publisher:#booksQuery.name#">
    </cfif>
    <cfset bookinfo.booksQuery=booksquery>
    <cfreturn bookinfo>
</cffunction>

<cffunction name="noResults">
    We did not find anything with that term. Please Try Again.
</cffunction>

<cffunction name="oneResult">
    <div>
        <cfoutput>
			<center><img src="#booksQuery.coverimage[1]#"></center></br></br>
			<span><strong>Title:</strong> #booksQuery.title[1]#</span></br>
		<span><strong>Publisher:</strong> #booksQuery.name[1]#</span></br></br>
            <span>#booksQuery.description[1]#</span>
        </cfoutput>
    </div>
</cffunction>

<cffunction name="manyResults">
    <ol class="nav nav-stacked">
        <cfoutput query="booksQuery">
        <li><a href="#cgi.script_name#?p=details&searchme=#trim(isbn13)#">#trim(title)#</a></li>
        </cfoutput>
    </ol>
</cffunction> 
