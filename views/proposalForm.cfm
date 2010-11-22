<cfsilent>
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfset CopyToScope("${event.proposal},${event.tracks},${event.proposalStatuses},${event.sessionTypes},${event.skillLevels}") />
	
	<cfset agreedToTermsChecked = proposal.getAgreedToTerms() />
	
	<cfif proposal.getProposalID() == 0>
		<cfset proposal.setContactEmail(session.user.getEmail()) />
	</cfif>
</cfsilent>
<cfoutput>
<cfif proposal.getProposalID() == 0>
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

<form:form actionEvent="processProposalForm" bind="proposal">
<h4>About this presentation</h4>
<table width="680" border="0">
	<cfif session.user.getIsAdmin()>
	<tr>
		<td align="right">Status</td>
		<td>
			<form:select path="statusID">
				<form:option value="0" label="- select -" />
				<form:options items="#proposalStatuses#" valueCol="status_id" labelCol="status" />
			</form:select>
		</td>
	</tr>
	</cfif>
	<tr>
		<td align="right">Contact Email</td>
		<td><form:input path="contactEmail" size="50" maxlength="255" /></td>
	</tr>
	<tr>
		<td align="right">Title</td>
		<td><form:input path="title" size="50" maxlength="255" /></td>
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
		<td align="right">Skill Level</td>
		<td>
			<form:select path="skillLevelID">
				<form:option value="0" label="- select -" />
				<form:options items="#skillLevels#" valueCol="skill_level_id" labelCol="skill_level" />
			</form:select>
		</td>
	</tr>
	<tr>
		<td colspan="2">Excerpt</td>
	</tr>
	<tr>
		<td colspan="2">
			<form:textarea class="ckeditor" path="excerpt" cols="40" rows="10" />
		</td>
	</tr>
	<tr>
		<td colspan="2">Description</td>
	</tr>
	<tr>
		<td colspan="2">
			<form:textarea class="ckeditor" path="description" cols="40" rows="10" />
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">Tags</td>
		<td valign="top">
			<form:input path="tags" size="50" /><br />
			<span style="font-size:9px;">(comma separated)</span>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			Note to Organizers (Optional, kept private)
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<form:textarea class="ckeditor" path="noteToOrganizers" cols="80" rows="10" />
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">Agreement</td>
		<td valign="top">
			<form:checkbox name="agreedToTerms" id="agreedToTerms" value="true" checked="#agreedToTermsChecked#" /> I understand that 
			upon submission my proposal will be seen immediately in the OpenCF Summit proposal RSS feed and that other users who log 
			into the OpenCF Summit web site may comment on my proposal, and that these comments can be seen by anonymous users on the 
			interwebz. I also understand that, if accepted, my presentation may be recorded and posted online for the whole world to 
			see. I know that OpenCF Summit is not the appropriate place for commercial promotion ("spam") of a product, service, or 
			solution, and that this type of material is not welcomed by the audience.
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