<cfsilent>
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfset CopyToScope("${event.proposals},${event.userVotes}") />
</cfsilent>
<cfoutput>
<script type="text/javascript">
	$(function() { 
		$("##proposalsTable").tablesorter({widgets:['zebra']}); 
	});	
</script>

<div id="fblikediv">
	<fb:like href="#getProperty('siteURL')##BuildCurrentURL()#" show_faces="false"></fb:like>
</div>

<h3>Proposals</h3>

<cfif event.isArgDefined('message')>
	<cfset message = event.getArg('message') />
	<div id="message" class="#message.class#">
		#message.text#
	</div>
</cfif>

<cfif event.isArgDefined("proposal") or 
		(event.isArgDefined('message') and message.text contains "vote was recorded")>
	<cfif session.user.getOauthProvider() eq "Twitter">
		<cfset buttonLabel = "Tweet It!" />
		<cfset postEvent = "tweet" />
	<cfelse>
		<cfset buttonLabel = "Add a Wall Post!" />
		<cfset postEvent = "postToFacebookWall" />
	</cfif>
	<cfif event.isArgDefined("proposal")>
		<cfset tweetText = "I just submitted [] for #getProperty('eventName')# #getProperty('eventYear')#. #getProperty('shortSiteURL')#" />
		<cfset shortTopic = event.getArg('proposal').getTitle() />
		<cfif session.user.getOauthProvider() eq "Twitter">
			<cfset label = "Why not Tweet it?" />
			<cfset shortTopic = left(event.getArg('proposal').getTitle(),142 - len(tweetText)) />
		<cfelse>
			<cfset label = "Why not add a wall post?" />
			<cfset tweetText = replace(tweetText,getProperty('shortSiteURL'),getProperty('siteURL')) />
			<cfset shortTopic = """" & shortTopic & """" />
		</cfif>
		<cfset tweetText = replace(tweetText,"[]",shortTopic) />
	<cfelse>						
		<cfset tweetText = "I just voted for my favorite session proposals for #getProperty('eventName')# #getProperty('eventYear')#. Why not cast your votes now? #getProperty('siteURL')#" />
		<cfif session.user.getOauthProvider() eq "Twitter">
			<cfset label = "Why not Tweet about it and encourage others to vote too?" />
		<cfelse>
			<cfset label = "Why not add a wall post and encourage others to vote too?" />
		</cfif>
	</cfif>
	<form:form actionEvent="#postEvent#">
		<br />
		#label#<br />
		<form:textarea name="tweetText" rows="3" cols="70" value="#tweetText#" /><br />
		<form:button name="submit" value="#buttonLabel#" />
		<form:hidden name="nextEvent" value="#event.getName()#" />
	</form:form>
</cfif>

<cfif StructKeyExists(session, "user")>
	<p>
		<a href="#BuildUrl('proposalForm')#"><img src="/images/icons/add.png" border="0" width="16" height="16" alt="Add Proposal" title="Add Proposal" /></a>&nbsp;
		<a href="#BuildUrl('proposalForm')#">Add Proposal</a>
	</p>
<cfelse>
	<p><em>Log in to submit suggestions, comment, and vote!</em></p>
</cfif>

<cfif proposals.RecordCount eq 0>
	<p><strong>No proposals!</strong></p>
<cfelse>
	<table id="proposalsTable" class="tablesorter" border="0" cellpadding="0" cellspacing="1" style="width:730px">
		<thead>
			<tr>
				<th>Title</th>
				<th width="60">Status</th>
				<th width="80">Track</th>
				<th width="120">Submitted</th>
				<th width="120">Speaker</th>
				<th width="60">Votes</th>
			<cfif StructKeyExists(session, "user")>
				<th width="50">Vote</th>
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
					<td>#proposals.votes#</td>
				<cfif StructKeyExists(session, "user")>
					<td>
						<cfif !ListFind(userVotes, proposals.proposal_id)>
							<a href="#BuildURL('voteForProposal', 'proposalID=#proposals.proposal_id#|userID=#session.user.getUserID()#')#">
								<img src="/images/icons/thumb_up.png" border="0" width="16" height="16" alt="Vote For This Proposal!" title="Vote For This Proposal!" />
							</a>
						<cfelse>
							<a href="#BuildUrl('removeProposalVote', 'proposalID=#proposals.proposal_id#|userID=#session.user.getUserID()#')#"><img src="/images/icons/tick.png" border="0" width="16" height="16" alt="You voted for this proposal. Click to remove your vote." title="You voted for this proposal. Click to remove your vote." /></a>
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