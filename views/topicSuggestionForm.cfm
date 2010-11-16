<cfsilent>
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfset CopyToScope("${event.topicSuggestion}") />
</cfsilent>
<cfoutput>
<cfif topicSuggestion.getTopicSuggestionID() eq 0>
<h3>New Topic Suggestion</h3>
<cfelse>
<h3>Edit Topic Suggestion - #topicSuggestion.getTopic()#</h3>
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

<form:form actionEvent="processTopicSuggestionForm" bind="topicSuggestion">
<h4>About this presentation</h4>
<table width="100%" border="0">
	<tr>
		<td align="right">Topic</td>
		<td><form:input path="topic" size="50" maxlength="500" /></td>
	</tr>
	<tr>
		<td colspan="2">Description</td>
	</tr>
	<tr>
		<td colspan="2">
			<form:textarea class="ckeditor" path="description" cols="80" rows="10" />
		</td>
	</tr>
	<cfif session.user.getIsAdmin()>
	<tr>
		<td align="right" valign="top">Categories</td>
		<td>category select here
		</td>
	</tr>
	</cfif>
	<tr>
		<td align="right">Suggested Speaker</td>
		<td><form:input path="suggestedSpeaker" size="50" maxlength="500" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><form:button name="submit" value="Submit" /></td>
	</tr>
</table>
	<form:hidden path="topicSuggestionID" />
</form:form>
</cfoutput>