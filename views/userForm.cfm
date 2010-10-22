<cfsilent>
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfset CopyToScope('${event.user}') />
	<cfset oauthProviders = ['Facebook','Google','Twitter'] />
</cfsilent>
<cfoutput>
<cfif user.getUserID() eq 0>
<h3>Create User</h3>
<cfelse>
<h3>Update User</h3>
</cfif>
<cfif event.isArgDefined('message')>
	<cfset message = event.getArg('message') />
	<cfset errors = event.getArg('errors') />
	<div id="message" class="#message.class#">
		<h4>#message.text#</h4>
		<ul>
		<cfloop collection="#errors#" item="error">
			<li>#errors[error]#</li>
		</cfloop>
		</ul>
	</div>
</cfif>
<form:form actionEvent="processUserForm" bind="user">
<table border="0">
	<tr>
		<td>Email</td>
		<td><form:input path="email" size="60" maxlength="255" /></td>
	</tr>
	<tr>
		<td>Password</td>
		<td>
			<form:password name="password" id="password" size="20" /><br />
			<span style="font-size:10px;font-style:italic">Leave password blank unless you wish to update</span>
		</td>
	</tr>
	<tr>
		<td>Confirm Password</td>
		<td>
			<form:password name="confirmPassword" id="confirmPassword" size="20" />
		</td>
	</tr>
	<tr>
		<td>First Name</td>
		<td><form:input path="firstName" size="60" maxlength="255" /></td>
	</tr>
	<tr>
		<td>Last Name</td>
		<td><form:input path="lastName" size="60" maxlength="255" /></td>
	</tr>
	<tr>
		<td>OAuth Provider</td>
		<td>
			<form:select path="oauthProvider">
				<form:option value="0" label="- select -" />
				<form:options items="#oauthProviders#" />
			</form:select>
		</td>
	</tr>
	<tr>
		<td>OAuth User ID</td>
		<td><form:input path="oauthUID" size="60" /></td>
	</tr>
	<tr>
		<td>Is Admin</td>
		<td><form:checkbox path="isAdmin" value="1" /></td>
	</tr>
	<tr>
		<td>Is Active</td>
		<td><form:checkbox path="isActive" value="1" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><form:button name="submit" id="submit" value="Submit" /></td>
	</tr>
</table>
	<form:hidden path="userID" />
</form:form>
</cfoutput>