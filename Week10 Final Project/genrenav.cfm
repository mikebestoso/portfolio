<!doctype html>
<html>
<head>
 <meta charset="utf-8">
 <title>Untitled Document</title>
</head>

<cfquery name="allgenres" datasource="#application.dsource#">
    select distinct genres.genreid,genres.genrename from genrestobooks
    inner join genres on genres.genreid = genrestobooks.genreid
    order by genres.genrename
</cfquery>
	
<ul class="nav nav-stacked">
	<cfoutput query="allgenres">
		<li><a href="#cgi.script_name#?p=details&genre=#genreid#">#genrename#</a></li>
	</cfoutput>
<!--  	<li role="presentation" class="active"><a href="#">History</a></li>
  	<li role="presentation"><a href="#">Philosophy</a></li>
  	<li role="presentation"><a href="#">Fiction</a></li>
  	<li role="presentation"><a href="#">Science Fiction</a></li>
	<li role="presentation"><a href="#">Non Fiction</a></li>
	<li role="presentation"><a href="#">Political Satire</a></li>-->
</ul>


</html>
