<cfsilent>
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfset CopyToScope("${event.proposal},${event.proposalStatuses},${event.comments},${event.userVotes}") />
</cfsilent>
<cfoutput>
<div id="fblikediv">
	<fb:like href="#getProperty('siteURL')##BuildCurrentURL()#" show_faces="false"></fb:like>
</div>

<h3>#proposal.getTitle()#</h3>

<h4>SPEAKER: #proposal.getSpeakerName()#</h4>

<cfif event.isArgDefined('message')>
	<cfset message = event.getArg('message') />
	<div id="message" class="#message.class#">
		#message.text#
	</div>
</cfif>

<cfif StructKeyExists(session, "user") && session.user.getIsAdmin()>
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
</cfif>

<h4>Session Type</h4>

<p>#proposal.getSessionType()#</p>

<h4>Skill Level</h4>

<p>#proposal.getSkillLevel()#</p>

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

<h4>Submitted On</h4>

<p>#DateFormat(proposal.getDtCreated(), 'm/d/yyyy')# #TimeFormat(proposal.getDtCreated(), 'h:mm TT')#</p>

<cfif StructKeyExists(session, "user") && (session.user.getUserID() == proposal.getUserID() 
		|| (session.user.getIsAdmin() && proposal.getNoteToOrganizers() != ""))>
	<h4>Private Note to Organizers</h4>

	<p>#proposal.getNoteToOrganizers()#</p>
</cfif>

<table border="0">
	<tr>
	<cfif StructKeyExists(session, "user")>
		<td>
			<cfif !ListFind(userVotes, proposal.getProposalID())>
				<a href="#BuildUrl('voteForProposal', 'proposalID=#proposal.getProposalID()#|userID=#session.user.getUserID()#')#"><img src="/images/icons/thumb_up.png" border="0" width="16" height="16" alt="Vote for Proposal" title="Vote for Proposal" /></a>&nbsp;
				<a href="#BuildUrl('voteForProposal', 'proposalID=#proposal.getProposalID()#|userID=#session.user.getUserID()#')#">Vote for This Proposal</a>
			<cfelse>
				<a href="#BuildUrl('removeProposalVote', 'proposalID=#proposal.getProposalID()#|userID=#session.user.getUserID()#')#"><img src="/images/icons/tick.png" border="0" width="16" height="16" alt="You voted for this proposal. Click to remove your vote." title="You voted for this proposal. Click to remove your vote." /></a>&nbsp;
				<a href="#BuildUrl('removeProposalVote', 'proposalID=#proposal.getProposalID()#|userID=#session.user.getUserID()#')#">You voted for this proposal (click to remove)</a>
			</cfif>
		</td>
	</cfif>
	<cfif StructKeyExists(session, "user") && (session.user.getUserID() == proposal.getUserID() || session.user.getIsAdmin())>
		<td>
			<a href="#BuildUrl('proposalForm', 'proposalID=#proposal.getProposalID()#')#"><img src="/images/icons/page_edit.png" border="0" width="16" height="16" alt="Edit Proposal" title="Edit Proposal" /></a>&nbsp;
			<a href="#BuildUrl('proposalForm', 'proposalID=#proposal.getProposalID()#')#">Edit Proposal</a>
		</td>
		<td>
			<a href="#BuildUrl('deleteProposal', 'proposalID=#proposal.getProposalID()#')#"><img src="/images/icons/delete.png" border="0" width="16" height="16" alt="Destroy Proposal" title="Destroy Proposal" /></a>&nbsp;
			<a href="#BuildUrl('deleteProposal', 'proposalID=#proposal.getProposalID()#')#">Destroy Proposal</a>
		</td>
	</cfif>
		<td>
			<a href="#BuildUrl('proposals')#"><img src="/images/icons/arrow_turn_left.png" border="0" width="16" height="16" alt="Proposals" title="Proposals" /></a>&nbsp;
			<a href="#BuildUrl('proposals')#">Back to Proposals</a>
		</td>
	</tr>
</table>

<cfif StructKeyExists(session, "user")>
#event.getArg('commentForm', '')#
</cfif>

<cfif comments.RecordCount gt 0>
	<h4>Comments</h4>
	
	<cfloop query="comments">
		<p><strong><a href="#comments.commenter_profile_link#">#comments.commenter_name#</a> said ...</strong>&nbsp;
		(#DateFormat(comments.dt_created, 'm/d/yyyy')# #TimeFormat(comments.dt_created, 'h:mm TT')#)</p>
		<p>#comments.comment#</p>
		<hr noshade="true" />
	</cfloop>
</cfif>
</cfoutput>
