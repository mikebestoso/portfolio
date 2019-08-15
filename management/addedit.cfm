<cftry>
	<cfparam name="book" default="" />
	<cfparam name="qterm" default="" />

	<cfset processForms()>
		
		<script>
			function toggleNewISBNForm(){
				var newISBNArea=document.getElementById('newisbn13area');
				if(newISBNArea.style.display=='none'){
					newISBNArea.style.display='inline';
				}
				else{
					newISBNArea.style.display='none';
				}
			}	
		</script> 
			
	<div id="main" class="col-lg-8 col-lg-push-3">
		<cfoutput>#mainForm()#</cfoutput>
	</div>
	<div id="leftgutter" class="col-lg-3 col-lg-pull-8">
 		<cfoutput>#sideNav()#</cfoutput>
	</div>
	<cfcatch type="any">
	</cfcatch>
</cftry>

<cffunction name="mainForm">
	<cftry>
	<cfif book neq ''>
	<cfquery name="thisbook" datasource="#application.dsource#">
		select * from books where ISBN13='#book#'
	</cfquery>
	<cfquery name="allpublishers" datasource="#application.dsource#">
		select * from publishers order by name
	</cfquery>
	<cfquery name="allgenres" datasource="#application.dsource#">
        select * from genres order by genrename
    </cfquery>
	<cfquery name="bookgenres" datasource="#application.dsource#">
        select * from genrestobooks where bookid='#book#'
    </cfquery>	
	<cfset isbnfield="none">
	<cfset isbndisplay="inline">
	<cfset req=''>
	<cfif thisbook.ISBN13[1] eq ''>
		<cfset isbnfield='inline'>
		<cfset isbndisplay='none'>
		<cfset req="required">
	</cfif>
		
	<cfoutput>
		<form action="#cgi.script_name#?tool=addedit" method="post" class="form-horizontal" enctype="multipart/form-data">
			<input type="hidden" name="qterm" value="#qterm#" />
			<div class="form-group">
 				<label for="ISBN13" class="col-lg-3 control-label"> ISBN13</label>
 				<div class="col-lg-8">
					<span id="newisbn13area" style="display:#isbnfield#">
 						<input type="text" class="form-control" id="newISBN13" name="ISBN13" value="#thisbook.ISBN13[1]#" placeholder="ISBN13" required pattern=".{13}" title="Please enter 13 Characters only. No dashes"/>
					</span>
					<span style="display:#isbndisplay#">
						#thisbook.ISBN13[1]# 
						<cfif session.user.isadmin>
							<button type="button" onClick="toggleNewISBNForm()" class="btn btn-warning btn-xs">Edit ISBN</button>
						</cfif>
						<input type="hidden" class="form-control" id="ISBN13" name="ISBN13" placeholder="ISBN13" value="#thisbook.ISBN13[1]#"/>
					</span>
 				</div>
			</div>
			
			<div class="form-group">
 				<label for="title" class="col-lg-3 control-label"> title</label>
 				<div class="col-lg-8">
 					<input type="text" id="title" name="title" value="#thisbook.title[1]#" placeholder="title" class="form-control" required maxlength="45" />
 				</div>
			</div>
			<div class="form-group">
 				<label for="weight" class="col-lg-3 control-label"> weight</label>
 				<div class="col-lg-8">
 					<input type="text" id="weight" name="weight" value="#thisbook.weight[1]#" placeholder="weight" class="form-control" />
				</div>
			</div>
			<div class="form-group">
 				<label for="isbn" class="col-lg-3 control-label"> isbn</label>
 				<div class="col-lg-8">
 					<input type="text" id="isbn" name="isbn" value="#thisbook.isbn[1]#" placeholder="isbn" class="form-control" />
				</div>
			</div>
			<div class="form-group">
 				<label for="binding" class="col-lg-3 control-label"> binding</label>
 				<div class="col-lg-8">
 					<input type="text" id="binding" name="binding" value="#thisbook.binding[1]#" placeholder="binding" class="form-control" />
				</div>
			</div>
			<div class="form-group">
 				<label for="pages" class="col-lg-3 control-label"> pages</label>
 				<div class="col-lg-8">
 					<input type="text" id="pages" name="pages" value="#thisbook.pages[1]#" placeholder="pages" class="form-control" />
				</div>
			</div>
			<div class="form-group">
 				<label for="year" class="col-lg-3 control-label"> year</label>
 				<div class="col-lg-8">
 					<input type="text" id="year" name="year" value="#thisbook.year[1]#" placeholder="year" class="form-control" />
				</div>
			</div>
			<div class="form-group">
 				<label for="publisher" class="col-lg-3 control-label"> publisher</label>
 				<div class="col-lg-8">
					<select name="publisher" id="publisher" class="form-control">
						<option value=""></option>
						<cfloop query="allpublishers">
							<cfset sel=''>
							<cfif thisbook.publisher[1] eq allPublishers.id[currentrow]>
								<cfset sel="selected">
							</cfif>
							<option value="#ID#" #sel#>#name#</option>
						</cfloop>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="pages" class="col-lg-3 control-label"> cover</label>
				<div class="col-lg-8">
					
					<input type="file" class="form-control" id="uploadimage" name="uploadimage" placeholder="Cover Image" />
				</div>
			</div>
			<div class="form-group">
				<label for="bookdesc" class="col-lg-11 control-label">Description</label>
				<div class="col-lg-11">
					<textarea id="bookdesc" name="description">#trim(thisbook.description[1])#</textarea>
					<script>
						CKEDITOR.replace('bookdesc');
					</script>
				</div>
			</div>
					
			<div class="form-group">
                 <label class="col-lg-11 control-label" style="text-align: left">Genres</label>
            <div class="col-lg-11">
            	<cfloop query="allgenres">
                	<input id="genre#genreid#" type="checkbox" name="genre" value="#genreid#">#genrename# <br/>
                </cfloop>
                <cfloop query="bookgenres">
                     <script>document.getElementById('genre#genreid#').checked=true;</script>
                </cfloop>
            </div>
            </div>
			<div class="form-group">
				<label clas="col-lg-3 control-label">&nbsp;</label>
				<div class="col-lg-8">
					<button type="submit" class="btn btn-primary">Save Book</button>
				</div>
			</div>
	</form>
	</cfoutput> 
	<cfelse>
		Please choose a book from the left hand side.
	</cfif>
		<cfcatch type="any">
        </cfcatch>
	</cftry>			
</cffunction>

<cffunction name="sideNav">
	<cfoutput>
		<form action="#cgi.SCRIPT_NAME#?tool=addedit" method="post" class="forminline">
			<div class="form-group">
				<input type="text" class="form-control" id="qterm" name="qterm" value="#qterm#">
				<button type="submit" class="btn btn-xs btn-primary">Search</button>
			</div>
		</form>
	</cfoutput>
	
	<cfif qterm neq ''>
		<cfquery name="allbooks" datasource="#application.dsource#">
			select * from Books where title like '%#qterm#%' order by title
		</cfquery> 
	</cfif>
	<div>
 		Book List
 	</div>
	<cfoutput>
		<ul class="nav nav-stacked">
			<li><a href="#cgi.SCRIPT_NAME#?tool=addedit&book=new">Add a Book</a></li>
			<cfif isdefined('allbooks')>	
				<cfloop query="allbooks">
					<li><a href="#cgi.SCRIPT_NAME#?tool=addedit&book=#ISBN13#&qterm=#qterm#">#trim(title)#</a></li>
				</cfloop>
				<cfelse>
					No Search Term Entered (Try "heart")
			</cfif>
		</ul>
	</cfoutput>
</cffunction>
	
<cffunction name="processForms">
	<cftry>
 	<cfif isdefined('form.ISBN13')>
			<!--<cfif isdefined('form.uploadimage') and form.uploadimage neq ''>
				<cffile action="upload" filefield="uploadimage" destination="#expandpath('/')#mbest37301\includes\classimages" nameconflict="makeunique" /> 
			</cfif>-->
			<cfif isdefined('form.newISBN13')>
				<cfquery name="updateisbn13" datasource="#application.dsource#">
					UPDATE Books set ISBN13='#form.newISBN13#' where ISBN13='#form.ISBN13#'
				</cfquery>	
				<cfset form.ISBN13=form.newISBN13>
			</cfif>
			<cfquery name="adddata" datasource="#application.dsource#">
				if not exists(select * from Books where ISBN13='#form.ISBN13#')
				INSERT into Books (ISBN13,title,weight,isbn,binding,pages,year) VALUES ('#form.ISBN13#','#form.title#','#form.weight#','#form.isbn#','#form.binding#','#form.pages#','#form.year#')
				update Books set
				title='#form.title#',
				weight='#form.weight#',
				isbn='#form.isbn#',
				binding='#form.binding#',
				pages='#form.pages#',
				year='#form.year#',
				publisher='#form.publisher#',
				description='#form.description#'
				where ISBN13='#form.ISBN13#'
			</cfquery>
			<cfquery datasource="#application.dsource#">
                delete from genrestobooks where bookid='#form.ISBN13#'
            </cfquery>
			<cfoutput>
				<cfloop list="#form.genre#" index="i">
					<cfquery name="putingenres" datasource="#application.dsource#">
						insert into genrestobooks (bookid,genreid) values ('#form.ISBN13#','#i#')
					</cfquery>
				</cfloop>	
			</cfoutput>
		
	</cfif> 
	<cfcatch type="any">
		
	</cfcatch>
	</cftry>
</cffunction> 