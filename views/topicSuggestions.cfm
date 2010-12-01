<cfsilent>
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
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

<cfif event.isArgDefined("topicSuggestion") or 
		(event.isArgDefined('message') and message.text contains "vote was recorded")>
	<cfif session.user.getOauthProvider() eq "Twitter">
		<cfset buttonLabel = "Tweet It!" />
		<cfset postEvent = "tweet" />
	<cfelse>
		<cfset buttonLabel = "Add a Wall Post!" />
		<cfset postEvent = "postToFacebookWall" />
	</cfif>
	<cfif event.isArgDefined("topicSuggestion")>
		<cfset tweetText = "I just suggested [] for #getProperty('eventName')# #getProperty('eventYear')#. #getProperty('shortSiteURL')#" />
		<cfset shortTopic = event.getArg('topicSuggestion').getTopic() />
		<cfif session.user.getOauthProvider() eq "Twitter">
			<cfset label = "Why not Tweet it?" />
			<cfset shortTopic = left(event.getArg('topicSuggestion').getTopic(),142 - len(tweetText)) />
		<cfelse>
			<cfset label = "Why not add a wall post?" />
			<cfset tweetText = replace(tweetText,getProperty('shortSiteURL'),getProperty('siteURL')) />
			<cfset shortTopic = """" & shortTopic & """" />
		</cfif>
		<cfset tweetText = replace(tweetText,"[]",shortTopic) />
	<cfelse>						
		<cfset tweetText = "I just voted for my favorite topics for #getProperty('eventName')# #getProperty('eventYear')#. Why not cast your votes now? #getProperty('siteURL')#" />
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
		<a href="#BuildUrl('topicSuggestionForm')#"><img src="/images/icons/add.png" border="0" width="16" height="16" alt="Suggest a Topic" title="Suggest a Topic" /></a>&nbsp;
		<a href="#BuildUrl('topicSuggestionForm')#">Suggest a Topic</a>
	</p>
<cfelse>
	<p><em>Log in to submit suggestions, comment, and vote!</em></p>
</cfif>

<cfif topicSuggestions.RecordCount eq 0>
	<p><strong>No topic suggestions!</strong></p>
<cfelse>
	<table id="topicSuggestionsTable" class="tablesorter" border="0" cellpadding="0" cellspacing="1" style="width:730px">
		<thead>
			<tr>
				<th>Topic</th>
				<th width="130">Suggested Speaker</th>
				<th width="120">Suggested By</th>
				<th width="120">Suggested On</th>
				<th width="60">Votes</th>
			<cfif StructKeyExists(session, "user")>
				<th width="50">Vote</th>
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
					<td>#topicSuggestions.suggested_speaker#</td>
					<td>#topicSuggestions.suggested_by#</td>
					<td>#DateFormat(topicSuggestions.dt_created, "mm/dd/yyyy")# #TimeFormat(topicSuggestions.dt_created, "hh:mm TT")#</td>
					<td>#topicSuggestions.votes#</td>
				<cfif StructKeyExists(session, "user")>
					<td>
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