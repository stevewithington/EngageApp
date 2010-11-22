<cfsilent>
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfset CopyToScope("${event.topicSuggestion},${event.userVotes},${event.comments}") />
</cfsilent>
<cfoutput>

<div id="fblikediv">
	<fb:like href="#getProperty('siteURL')##BuildCurrentURL()#" show_faces="false"></fb:like>
</div>

<h3>#topicSuggestion.getTopic()#</h3>

<h4>SUGGESTED BY: #topicSuggestion.getSuggestedBy()#</h4>

<cfif event.isArgDefined('message')>
	<cfset message = event.getArg('message') />
	<div id="message" class="#message.class#">
		#message.text#
	</div>
</cfif>

<h4>Description</h4>

<p>#topicSuggestion.getDescription()#</p>

<h4>Suggested Speaker</h4>

<p>#topicSuggestion.getSuggestedSpeaker()#</p>

<h4>Submitted On</h4>

<p>#DateFormat(topicSuggestion.getDtCreated(), "mm/dd/yyyy")# #TimeFormat(topicSuggestion.getDtCreated(), "hh:mm TT")#</p>

<h4>Votes</h4>

<p>#topicSuggestion.getVotes()#</p>

<table border="0">
	<tr>
	<cfif StructKeyExists(session, "user")>
		<td>
			<cfif !ListFind(userVotes, topicSuggestion.getTopicSuggestionID())>
				<a href="#BuildUrl('voteForTopicSuggestion', 'topicSuggestionID=#topicSuggestion.getTopicSuggestionID()#|userID=#session.user.getUserID()#')#"><img src="/images/icons/thumb_up.png" border="0" width="16" height="16" alt="Vote for Topic Suggestion" title="Vote for Topic Suggestion" /></a>&nbsp;
				<a href="#BuildUrl('voteForTopicSuggestion', 'topicSuggestionID=#topicSuggestion.getTopicSuggestionID()#|userID=#session.user.getUserID()#')#">Vote for This Topic Suggestion</a>
			<cfelse>
				<a href="#BuildUrl('removeTopicSuggestionVote', 'topicSuggestionID=#topicSuggestion.getTopicSuggestionID()#|userID=#session.user.getUserID()#')#"><img src="/images/icons/tick.png" border="0" width="16" height="16" alt="You voted for this topic. Click to remove your vote." title="You voted for this topic. Click to remove your vote." /></a>&nbsp;
				<a href="#BuildUrl('removeTopicSuggestionVote', 'topicSuggestionID=#topicSuggestion.getTopicSuggestionID()#|userID=#session.user.getUserID()#')#">You voted for this topic (click to remove vote)</a>
			</cfif>
		</td>
	</cfif>
	<cfif StructKeyExists(session, "user") && (session.user.getUserID() eq topicSuggestion.getCreatedBy() || session.user.getIsAdmin())>
		<td>
			<a href="#BuildUrl('topicSuggestionForm', 'topicSuggestionID=#topicSuggestion.getTopicSuggestionID()#')#"><img src="/images/icons/page_edit.png" border="0" width="16" height="16" alt="Edit Topic Suggestion" title="Edit Topic Suggestion" /></a>&nbsp;
			<a href="#BuildUrl('topicSuggestionForm', 'topicSuggestionID=#topicSuggestion.getTopicSuggestionID()#')#">Edit Topic Suggestion</a>
		</td>
		<td>
			<a href="#BuildUrl('deleteTopicSuggestion', 'topicSuggestionID=#topicSuggestion.getTopicSuggestionID()#')#"><img src="/images/icons/delete.png" border="0" width="16" height="16" alt="Destroy Topic Suggestion" title="Destroy Topic Suggestion" /></a>&nbsp;
			<a href="#BuildUrl('deleteTopicSuggestion', 'topicSuggestionID=#topicSuggestion.getTopicSuggestionID()#')#">Destroy Topic Suggestion</a>
		</td>
	</cfif>
		<td>
			<a href="#BuildUrl('topicSuggestions')#"><img src="/images/icons/arrow_turn_left.png" border="0" width="16" height="16" alt="Topic Suggestions" title="Topic Suggestions" /></a>&nbsp;
			<a href="#BuildUrl('topicSuggestions')#">Back to Topic Suggestions</a>
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