<cfsilent>
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfset CopyToScope("${event.proposal},${event.tracks},${event.proposalStatuses},${event.sessionTypes}") />
	
	<cfset agreedToTermsChecked = proposal.getAgreedToTerms() />
</cfsilent>
<cfoutput>
<cfif proposal.getProposalID() eq 0>
<h3>Create New Proposal</h3>
<cfelse>
<h3>Edit Proposal - #proposal.getTitle()#</h3>
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

<form:form actionEvent="admin.processProposalForm" bind="proposal">
<h1>SPEAKER STUFF HERE</h1>

<h4>About this presentation</h4>
<table width="100%" border="0">
	<tr>
		<td align="right">Status</td>
		<td>
			<form:select path="statusID">
				<form:option value="0" label="- select -" />
				<form:options items="#proposalStatuses#" valueCol="status_id" labelCol="status" />
			</form:select>
		</td>
	</tr>
	<tr>
		<td align="right">Title</td>
		<td><form:input path="title" size="60" maxlength="255" /></td>
	</tr>
	<tr>
		<td align="right">Session Type</td>
		<td>
			<form:select path="sessionTypeID">
				<form:option value="0" label="- select -" />
				<form:options items="#sessionTypes#" valueCol="session_type_id" labelCol="title" />
			</form:select>
		</td>
	</tr>
	<tr>
		<td align="right">Track</td>
		<td>
			<form:select path="trackID">
				<form:option value="0" label="- select -" />
				<form:options items="#tracks#" valueCol="track_id" labelCol="title" />
			</form:select>
		</td>
	</tr>
	<tr>
		<td colspan="2">Excerpt</td>
	</tr>
	<tr>
		<td colspan="2">
			<form:textarea class="ckeditor" path="excerpt" cols="80" rows="10" />
		</td>
	</tr>
	<tr>
		<td colspan="2">Description</td>
	</tr>
	<tr>
		<td colspan="2">
			<form:textarea class="ckeditor" path="description" cols="80" rows="10" />
		</td>
	</tr>
	<tr>
		<td align="right">Tags</td>
		<td>
			<form:input path="tags" size="60" /><br />
			<span style="font-size:9px;">(comma separated)</span>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">
			Note to Organizers<br />
			(Optional, kept private)
		</td>
		<td valign="top">
			<form:textarea path="noteToOrganizers" cols="80" rows="10" />
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">Agreement</td>
		<td valign="top">
			<form:checkbox name="agreedToTerms" id="agreedToTerms" value="true" checked="#agreedToTermsChecked#" /> I understand that, 
			if accepted, my presentation may be recorded and posted online for the whole world to see. I know that OpenCF Summit is 
			not the appropriate place for commercial promotion ("spam") of a product, service, or solution and this is not welcomed 
			by the audience.
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><form:button name="submit" value="Submit" /></td>
	</tr>
</table>
	<form:hidden path="proposalID" />
</form:form>
</cfoutput>