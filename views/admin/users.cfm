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
	<table id="usersTable" class="tablesorter" border="0" cellpadding="0" cellspacing="1">
		<thead>
			<tr>
				<th>Email</th>
				<th>Last Name</th>
				<th>First Name</th>
				<th>OAuth Provider</th>
				<th>Admin</th>
				<th>Active</th>
			</tr>
		</thead>
		<tbody>
		<cfloop query="users">
			<tr>
				<td>
					<a href="#BuildUrl('userForm', 'userID=#users.user_id#')#">#users.email#</a>
				</td>
				<td>#users.last_name#</td>
				<td>#users.first_name#</td>
				<td>
					<cfswitch expression="#LCase(users.oauth_provider)#">
						<cfcase value="facebook">
							<img src="images/facebook_icon_small.jpg" width="16" height="16" alt="Facebook" title="Facebook" />
						</cfcase>
						
						<cfcase value="google">
							<img src="images/google_account_icon.jpg" width="16" height="16" alt="Google" title="Google" />
						</cfcase>
						
						<cfcase value="twitter">
							<img src="images/twitter_logo_small.png" width="16" height="16" alt="Twitter" title="Twitter" />
						</cfcase>
						
						<cfdefaultcase>
							<em>none (local account)</em>
						</cfdefaultcase>
					</cfswitch>
				</td>
				<td>#YesNoFormat(users.is_admin)#</td>
				<td>#YesNoFormat(users.active)#</td>
			</tr>
		</cfloop>
		</tbody>
	</table>
</cfif>

<p>
	<a href="#BuildUrl('userForm')#"><img src="images/icons/add.png" border="0" width="16" height="16" alt="Add User" title="Add User" /></a>&nbsp;
	<a href="#BuildUrl('userForm')#">Add User</a>
</p>
</cfoutput>