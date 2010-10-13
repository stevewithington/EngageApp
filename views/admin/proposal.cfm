<cfsilent>
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfset CopyToScope("${event.proposal},${event.proposalStatuses},${event.proposalComments}") />
</cfsilent>
<cfoutput>
<h3>#proposal.getTitle()#</h3>

<cfif event.isArgDefined('message')>
	<cfset message = event.getArg('message') />
	<div id="message" class="#message.class#">
		#message.text#
	</div>
</cfif>

<form:form actionEvent="admin.updateProposalStatus" bind="proposal">
<div class="info">
	<p>
		<strong>CHANGE STATUS:</strong>&nbsp;
		<form:select path="statusID">
			<form:options items="#proposalStatuses#" valueCol="status_id" labelCol="status" />
		</form:select>&nbsp;
		<form:button name="submit" value="Update Status" /><br />
		<a href="">Email speaker(s) ...</a>
	</p>
</div>
	<form:hidden path="proposalID" />
</form:form>

<h4>Session Type</h4>

<p>#proposal.getSessionType()#</p>

<h4>Excerpt</h4>

<p>#proposal.getExcerpt()#</p>

<h4>Description</h4>

<p>#proposal.getDescription()#</p>

<h4>Tags</h4>

<p>
<cfif proposal.getTags() eq "">
	<em>- none -</em>
<cfelse>
	#proposal.getTags()#
</cfif>
</p>

<cfif proposal.getNoteToOrganizers() neq "">
	<h4>Private Note to Organizers</h4>

	<p>#proposal.getNoteToOrganizers()#</p>
</cfif>

<table border="0">
	<tr>
		<td>
			<a href="#BuildUrl('admin.proposalForm', 'proposalID=#proposal.getProposalID()#')#"><img src="images/icons/page_edit.png" border="0" width="16" height="16" alt="Edit Proposal" title="Edit Proposal" /></a>&nbsp;
			<a href="#BuildUrl('admin.proposalForm', 'proposalID=#proposal.getProposalID()#')#">Edit Proposal</a>
		</td>
		<td>
			<a href="#BuildUrl('admin.deleteProposal', 'proposalID=#proposal.getProposalID()#')#"><img src="images/icons/delete.png" border="0" width="16" height="16" alt="Destroy Proposal" title="Destroy Proposal" /></a>&nbsp;
			<a href="#BuildUrl('admin.deleteProposal', 'proposalID=#proposal.getProposalID()#')#">Destroy Proposal</a>
		</td>
		<td>
			<a href="#BuildUrl('admin.proposals')#"><img src="images/icons/arrow_turn_left.png" border="0" width="16" height="16" alt="Proposals" title="Proposals" /></a>&nbsp;
			<a href="#BuildUrl('admin.proposals')#">Back to Proposals</a>
		</td>
	</tr>
</table>
</cfoutput>