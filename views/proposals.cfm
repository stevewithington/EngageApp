<cfsilent>
	<cfset CopyToScope("${event.proposals},${event.userVotes}") />
</cfsilent>
<cfoutput>
<script type="text/javascript">
	$(function() { 
		$("##proposalsTable").tablesorter({widgets:['zebra']}); 
	});	
</script>

<h3>Proposals</h3>

<cfif event.isArgDefined('message')>
	<cfset message = event.getArg('message') />
	<div id="message" class="#message.class#">
		#message.text#
	</div>
</cfif>

<cfif proposals.RecordCount eq 0>
	<p><strong>No proposals!</strong></p>
<cfelse>
	<cfif !StructKeyExists(session, "user")>
	<p><em><a href="#BuildUrl('login')#">Log in</a> to submit proposals, comment, and vote!</em></p>
	</cfif>
	<table id="proposalsTable" class="tablesorter" border="0" cellpadding="0" cellspacing="1">
		<thead>
			<tr>
				<th>Title</th>
				<th>Status</th>
				<th>Track</th>
				<th>Submitted</th>
				<th>Speaker</th>
				<th>Votes</th>
			<cfif StructKeyExists(session, "user")>
				<th>Vote</th>
			</cfif>
			</tr>
		</thead>
		<tbody>
			<cfloop query="proposals">
				<tr>
					<td><a href="#BuildUrl('proposal', 'proposalID=#proposals.proposal_id#')#">#proposals.title#</a></td>
					<td>#proposals.status#</td>
					<td>#proposals.track_title#</td>
					<td>#DateFormat(proposals.dt_created, "mm/dd/yyyy")# #TimeFormat(proposals.dt_created, "hh:mm TT")#</td>
					<td>
						<a href="#proposals.oauth_profile_link#" target="_blank">
							#proposals.speaker_name#
						</a>
					</td>
					<td width="50">#proposals.votes#</td>
				<cfif StructKeyExists(session, "user")>
					<td width="40">
						<cfif !ListFind(userVotes, proposals.proposal_id)>
							<a href="#BuildURL('voteForProposal', 'proposalID=#proposals.proposal_id#|userID=#session.user.getUserID()#')#">
								<img src="/images/icons/thumb_up.png" border="0" width="16" height="16" alt="Vote For This Proposal!" title="Vote For This Proposal!" />
							</a>
						<cfelse>
							<img src="/images/icons/tick.png" width="16" height="16" alt="You voted for this proposal" title="You voted for this proposal" />
						</cfif>
					</td>
				</cfif>
				</tr>
			</cfloop>
		</tbody>
	</table>
</cfif>

<cfif StructKeyExists(session, "user")>
<p>
	<a href="#BuildUrl('proposalForm')#"><img src="/images/icons/add.png" border="0" width="16" height="16" alt="Add Proposal" title="Add Proposal" /></a>&nbsp;
	<a href="#BuildUrl('proposalForm')#">Add Proposal</a>
</p>
</cfif>
</cfoutput>