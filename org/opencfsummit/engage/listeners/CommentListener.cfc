<cfcomponent 
		displayname="CommentListener" 
		output="false" 
		extends="MachII.framework.Listener" 
		depends="commentService">

	<cffunction name="configure" access="public" output="false" returntype="void">
	</cffunction>
	
	<cffunction name="getComments" access="public" output="false" returntype="query">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var itemID = 0 />
		<cfset var itemType = "" />
		
		<cfif arguments.event.isArgDefined("proposalID")>
			<cfset itemID = arguments.event.getArg("proposalID") />
			<cfset itemType = "Proposal" />
		<cfelseif arguments.event.isArgDefined("topicSuggestionID")>
			<cfset itemID = arguments.event.getArg("topicSuggestionID") />
			<cfset itemType = "Topic Suggestion" />
		</cfif>
		
		<cfreturn getCommentService().getComments(itemID, itemType) />
	</cffunction>
	
	<cffunction name="processCommentForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var comment = arguments.event.getArg('comment') />
		<cfset var errors = StructNew() />
		<cfset var message = StructNew() />
		<cfset var successEvent = "" />
		<cfset var failEvent = "" />
		
		<cfset comment.setCreatedBy(session.user.getUserID()) />
		
		<cfset errors = comment.validate() />
		
		<cfset message.text = "The comment was saved." />
		<cfset message.class = "success" />
		
		<cfif arguments.event.getArg("itemType") eq "Proposal">
			<cfset successEvent = "proposal" />
			<cfset failEvent = "proposal" />
			<cfset arguments.event.setArg("proposalID", arguments.event.getArg("itemID")) />
		<cfelseif arguments.event.getArg("itemType") eq "Topic Suggestion">
			<cfset successEvent = "topicSuggestion" />
			<cfset failEvent = "topicSuggestion" />
			<cfset arguments.event.setArg("topicSuggestionID", arguments.event.getArg("itemID")) />
		</cfif>
		
		<cfif !StructIsEmpty(errors)>
			<cfset message.text = "Please correct the following errors:" />
			<cfset message.class = "error" />
			<cfset arguments.event.setArg("errors", errors) />
			<cfset arguments.event.setArg("message", message) />
			<cfset redirectEvent(failEvent, "", true) />
		<cfelse>
			<cftry>
				<cfset getCommentService().saveComment(comment) />
				<cfset arguments.event.setArg("message", message) />
				<cfset arguments.event.setArg("commentID", comment.getCommentID()) />
				<cfset arguments.event.removeArg("comment") />
				
				<cfif arguments.event.getArg("itemType") eq "Proposal">
					<cfset redirectEvent(successEvent, "proposalID", true) />
				<cfelseif arguments.event.getArg("itemType") eq "Topic Suggestion">
					<cfset redirectEvent(successEvent, "topicSuggestionID", true) />
				</cfif>
				
				<cfcatch type="any">
					<cfset errors.systemError = CFCATCH.Message & " - " & CFCATCH.Detail />
					<cfset message.text = "A system error occurred:" />
					<cfset message.class = "error" />
					<cfset arguments.event.setArg("errors", errors) />
					<cfset arguments.event.setArg("message", message) />
					<cfset redirectEvent(failEvent, "", true) />
				</cfcatch>
			</cftry>
		</cfif>
	</cffunction>
	
</cfcomponent>