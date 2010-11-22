<cfsilent>
	<cfset CopyToScope("${event.users}") />
</cfsilent>
<cfoutput>
<script type="text/javascript">
	$(function() { 
		$("##usersTable").tablesorter({widgets:['zebra']}); 
	});	
</script>

<h3>Users</h3>

<cfif event.isArgDefined('message')>
	<cfset message = event.getArg('message') />
	<div id="message" class="#message.class#">
		#message.text#
	</div>
</cfif>

<cfif users.RecordCount eq 0>
	<p><strong>No users!</strong></p>
<cfelse>
	<table id="usersTable" class="tablesorter" width="600">
		<thead>
			<tr>
				<th>Email</th>
				<th>Name</th>
				<th>OAuth Provider</th>
				<th>Admin</th>
				<th>Active</th>
			</tr>
		</thead>
		<tbody>
		<cfloop query="users">
			<tr>
				<td>
					<cfif users.email neq "">
						<a href="#BuildUrl('userForm', 'userID=#users.user_id#')#">#users.email#</a>
					<cfelse>
						<a href="#BuildUrl('userForm', 'userID=#users.user_id#')#">(twitter user)</a>
					</cfif>
				</td>
				<td>#users.name#</td>
				<td>
					<cfswitch expression="#LCase(users.oauth_provider)#">
						<cfcase value="facebook">
							<img src="/images/facebook_icon_small.jpg" width="16" height="16" alt="Facebook" title="Facebook" />
						</cfcase>
						
						<cfcase value="twitter">
							<img src="/images/twitter_logo_small.png" width="16" height="16" alt="Twitter" title="Twitter" />
						</cfcase>
					</cfswitch>
				</td>
				<td>#YesNoFormat(users.is_admin)#</td>
				<td>#YesNoFormat(users.active)#</td>
			</tr>
		</cfloop>
		</tbody>
	</table>
</cfif>
</cfoutput>