<cfsilent>
	<cfset CopyToScope("${event.topicSuggestions},${event.userVotes}") />
</cfsilent>
<cfoutput>
<script type="text/javascript">
	$(function() { 
		$("##topicSuggestionsTable").tablesorter({widgets:['zebra']}); 
	});	
</script>

<div id="fblikediv">
	<fb:like href="#getProperty('siteURL')##BuildCurrentURL()#" show_faces="false"></fb:like>
</div>

<h3>Topic Suggestions</h3>

<cfif event.isArgDefined('message')>
	<cfset message = event.getArg('message') />
	<cfset errors = event.getArg('errors', StructNew()) />
	<div id="message" class="#message.class#">
		<h4>#message.text#</h4>
		<cfif !StructIsEmpty(errors)>
			<ul>
			<cfloop collection="#errors#" item="error">
				<li>#errors[error]#</li>
			</cfloop>
			</ul>
		</cfif>
	</div>
</cfif>

<cfif topicSuggestions.RecordCount eq 0>
	<p><strong>No topic suggestions!</strong></p>
<cfelse>
	<cfif !StructKeyExists(session, "user")>
	<p><em><a href="#BuildUrl('login')#">Log in</a> to submit suggestions, comment, and vote!</em></p>
	</cfif>
	<table id="topicSuggestionsTable" class="tablesorter" border="0" cellpadding="0" cellspacing="1">
		<thead>
			<tr>
				<th>Topic</th>
				<th>Description</th>
				<th>Suggested Speaker</th>
				<th>Suggested By</th>
				<th>Suggested On</th>
				<th>Votes</th>
			<cfif StructKeyExists(session, "user")>
				<th>Vote</th>
			</cfif>
			</tr>
		</thead>
		<tbody>
			<cfloop query="topicSuggestions">
				<tr>
					<td>
						<a href="#BuildUrl('topicSuggestion', 'topicSuggestionID=#topicSuggestions.topic_suggestion_id#')#">
							#topicSuggestions.topic#
						</a>
					</td>
					<td>#topicSuggestions.description#</td>
					<td>#topicSuggestions.suggested_speaker#</td>
					<td>#topicSuggestions.suggested_by#</td>
					<td>#DateFormat(topicSuggestions.dt_created, "mm/dd/yyyy")# #TimeFormat(topicSuggestions.dt_created, "hh:mm TT")#</td>
					<td width="50">#topicSuggestions.votes#</td>
				<cfif StructKeyExists(session, "user")>
					<td width="40">
						<cfif !ListFind(userVotes, topicSuggestions.topic_suggestion_id)>
							<a href="#BuildURL('voteForTopicSuggestion', 'topicSuggestionID=#topicSuggestions.topic_suggestion_id#|userID=#session.user.getUserID()#')#">
								<img src="/images/icons/thumb_up.png" border="0" width="16" height="16" alt="Vote For This Topic!" title="Vote For This Topic!" />
							</a>
						<cfelse>
							<a href="#BuildURL('removeTopicSuggestionVote', 'topicSuggestionID=#topicSuggestions.topic_suggestion_id#|userID=#session.user.getUserID()#')#">
								<img src="/images/icons/tick.png" width="16" height="16" border="0" alt="You voted for this topic. Click to remove your vote." title="You voted for this topic. Click to remove your vote." />
							</a>
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
	<a href="#BuildUrl('topicSuggestionForm')#"><img src="/images/icons/add.png" border="0" width="16" height="16" alt="Suggest a Topic" title="Suggest a Topic" /></a>&nbsp;
	<a href="#BuildUrl('topicSuggestionForm')#">Suggest a Topic</a>
</p>
</cfif>
</cfoutput>