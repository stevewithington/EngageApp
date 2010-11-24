<cfcomponent 
		displayname="TopicSuggestionListener" 
		output="false" 
		extends="MachII.framework.Listener" 
		depends="topicSuggestionService">

	<cffunction name="configure" access="public" output="false" returntype="void">
	</cffunction>
	
	<cffunction name="getUserVotes" access="public" output="false" returntype="string">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var userVotes = "" />
		
		<cfif StructKeyExists(session, "user")>
			<cfset userVotes = getTopicSuggestionService().getUserVotes(session.user.getUserID()) />
		</cfif>
		
		<cfreturn userVotes />
	</cffunction>
	
	<cffunction name="voteForTopicSuggestion" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = StructNew() />
		<cfset var errors = StructNew() />

		<!--- make sure the user is voting using their user ID --->
		<cfif arguments.event.getArg('userID') neq session.user.getUserID()>
			<cfset redirectEvent("fail", "", true) />
		</cfif>
		
		<cfset message.text = "Your vote was recorded!" />
		<cfset message.class = "success" />
		
		<cftry>
			<cfset getTopicSuggestionService().addVote(arguments.event.getArg("topicSuggestionID"), 
														session.user.getUserID()) />
			<cfset arguments.event.setArg("message", message) />
			<cfset redirectEvent("success", "", true) />
			
			<cfcatch type="any">
				<cfset errors.systemError = CFCATCH.Message & " - " & CFCATCH.Detail />
				<cfset message.text = "A system error occurred:" />
				<cfset message.class = "error" />
				<cfset arguments.event.setArg("errors", errors) />
				<cfset arguments.event.setArg("message", message) />
				<cfset redirectEvent("fail", "", true) />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="removeTopicSuggestionVote" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = StructNew() />
		<cfset var errors = StructNew() />

		<!--- make sure the removing vote using their user ID --->
		<cfif arguments.event.getArg('userID') neq session.user.getUserID()>
			<cfset redirectEvent("fail", "", true) />
		</cfif>
		
		<cfset message.text = "Your vote was removed." />
		<cfset message.class = "success" />
		
		<cftry>
			<cfset getTopicSuggestionService().removeVote(arguments.event.getArg("topicSuggestionID"), 
															session.user.getUserID()) />
			<cfset arguments.event.setArg("message", message) />
			<cfset redirectEvent("success", "", true) />
			
			<cfcatch type="any">
				<cfset errors.systemError = CFCATCH.Message & " - " & CFCATCH.Detail />
				<cfset message.text = "A system error occurred:" />
				<cfset message.class = "error" />
				<cfset arguments.event.setArg("errors", errors) />
				<cfset arguments.event.setArg("message", message) />
				<cfset redirectEvent("fail", "", true) />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="processTopicSuggestionForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var topicSuggestion = arguments.event.getArg('topicSuggestion') />
		<cfset var errors = topicSuggestion.validate() />
		<cfset var message = StructNew() />
		
		<cfset topicSuggestion.setCreatedBy(session.user.getUserID()) />
		
		<cfset message.text = "The topic suggestion was saved." />
		<cfset message.class = "success" />
		
		<cfif not StructIsEmpty(errors)>
			<cfset message.text = "Please correct the following errors:" />
			<cfset message.class = "error" />
			<cfset arguments.event.setArg("errors", errors) />
			<cfset arguments.event.setArg("message", message) />
			<cfset redirectEvent("fail", "", true) />
		<cfelse>
			<cftry>
				<cfset getTopicSuggestionService().saveTopicSuggestion(topicSuggestion) />
				<cfset arguments.event.setArg("message", message) />
				<cfset getTopicSuggestionService().updateRSSFeed(arguments.event.getArg('eventID'), getProperty('siteURL')) />
				<cfset redirectEvent("success", "", true) />
				
				<cfcatch type="any">
					<cfset errors.systemError = CFCATCH.Message & " - " & CFCATCH.Detail />
					<cfset message.text = "A system error occurred:" />
					<cfset message.class = "error" />
					<cfset arguments.event.setArg("errors", errors) />
					<cfset arguments.event.setArg("message", message) />
					<cfset redirectEvent("fail", "", true) />
				</cfcatch>
			</cftry>
		</cfif>
	</cffunction>
	
	<cffunction name="deleteTopicSuggestion" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = StructNew() />
		<cfset var errors = StructNew() />
		
		<cfset message.text = "The topic suggestion was deleted." />
		<cfset message.class = "success" />
		
		<cftry>
			<cfset getTopicSuggestionService().deleteTopicSuggestion(arguments.event.getArg('topicSuggestion')) />
			<cfset getTopicSuggestionService().updateRSSFeed(arguments.event.getArg('eventID'), getProperty('siteURL')) />
			<cfset arguments.event.setArg("message", message) />
			<cfset redirectEvent("success", "", true) />
			
			<cfcatch type="any">
				<cfset errors.systemError = CFCATCH.Message & " - " & CFCATCH.Detail />
				<cfset message.text = "A system error occurred:" />
				<cfset message.class = "error" />
				<cfset arguments.event.setArg("errors", errors) />
				<cfset arguments.event.setArg("message", message) />
				<cfset redirectEvent("fail", "", true) />
			</cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>