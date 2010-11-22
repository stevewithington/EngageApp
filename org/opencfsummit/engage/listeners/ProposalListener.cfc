<cfcomponent 
		displayname="ProposalListener" 
		output="false" 
		extends="MachII.framework.Listener" 
		depends="proposalService,userService">

	<cffunction name="configure" access="public" output="false" returntype="void">
	</cffunction>
	
	<cffunction name="getProposals" access="public" output="false" returntype="query">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var userID = 0 />
		
		<cfif arguments.event.getArg('userID', 0) != 0>
			<cfset userID = session.user.getUserID() />
		</cfif>
		
		<cfreturn getProposalService().getProposals(arguments.event.getArg('eventID'), userID) />
	</cffunction>
	
	<cffunction name="getProposalFavorites" access="public" output="false" returntype="query">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getProposalService().getProposalFavorites(arguments.event.getArg('eventID'), session.user.getUserID()) />
	</cffunction>
	
	<cffunction name="voteForProposal" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = StructNew() />
		<cfset var errors = StructNew() />

		<!--- make sure the user is voting using their user ID --->
		<cfif arguments.event.getArg('userID') != session.user.getUserID()>
			<cfset redirectEvent("fail", "", true) />
		</cfif>
		
		<cfset message.text = "Your vote was recorded!" />
		<cfset message.class = "success" />
		
		<cftry>
			<cfset getProposalService().addVote(arguments.event.getArg("proposalID"), 
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
	
	<cffunction name="removeProposalVote" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = StructNew() />
		<cfset var errors = StructNew() />

		<!--- make sure the user is removing the vote using their user ID --->
		<cfif arguments.event.getArg('userID') != session.user.getUserID()>
			<cfset redirectEvent("fail", "", true) />
		</cfif>
		
		<cfset message.text = "Your vote was removed." />
		<cfset message.class = "success" />
		
		<cftry>
			<cfset getProposalService().removeVote(arguments.event.getArg("proposalID"), 
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
	
	<cffunction name="getUserVotes" access="public" output="false" returntype="string">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var userVotes = "" />
		
		<cfif StructKeyExists(session, "user")>
			<cfset userVotes = getProposalService().getUserVotes(session.user.getUserID()) />
		</cfif>
		
		<cfreturn userVotes />
	</cffunction>
		
	<cffunction name="processProposalForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var proposal = arguments.event.getArg('proposal') />
		<cfset var errors = StructNew() />
		<cfset var message = StructNew() />
		<cfset var uploadResults = 0 />
		
		<cfif arguments.event.isArgDefined('agreedToTerms') && arguments.event.getArg('agreedToTerms') != "">
			<cfset proposal.setAgreedToTerms(true) />
		<cfelse>
			<cfset proposal.setAgreedToTerms(false) />
		</cfif>
		
		<cfif proposal.getUserID() == 0>
			<cfset proposal.setUserID(session.user.getUserID()) />
		</cfif>
		
		<cfif proposal.getProposalID() == 0>
			<cfset proposal.setCreatedBy(session.user.getUserID()) />
		<cfelse>
			<cfset proposal.setUpdatedBy(session.user.getUserID()) />
		</cfif>
		
		<cfif session.user.getEmail() == "">
			<cfset session.user.setEmail(proposal.getContactEmail()) />
			<cfset getUserService().saveUser(session.user) />
		</cfif>
		
		<cfset errors = proposal.validate() />
		
		<cfset message.text = "The proposal was saved." />
		<cfset message.class = "success" />
		
		<cfif !StructIsEmpty(errors)>
			<cfset message.text = "Please correct the following errors:" />
			<cfset message.class = "error" />
			<cfset arguments.event.setArg("errors", errors) />
			<cfset arguments.event.setArg("message", message) />
			<cfset redirectEvent("fail", "", true) />
		<cfelse>
			<cftry>
				<cfset getProposalService().saveProposal(proposal) />
				<cfset arguments.event.setArg("message", message) />
				<cfset arguments.event.setArg("proposalID", proposal.getProposalID()) />
				<cfset getProposalService().updateRSSFeed(arguments.event.getArg('eventID'), getProperty('siteURL')) />
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
	
	<cffunction name="deleteProposal" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = StructNew() />
		<cfset var errors = StructNew() />
		
		<cfset message.text = "The proposal was deleted." />
		<cfset message.class = "success" />
		
		<cftry>
			<cfset getProposalService().deleteProposal(arguments.event.getArg('proposal')) />
			<cfset getProposalService().updateRSSFeed(arguments.event.getArg('eventID'), getProperty('siteURL')) />
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
	
	<cffunction name="updateProposalStatus" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = StructNew() />
		<cfset var errors = StructNew() />
		
		<cfset message.text = "The proposal status was updated." />
		<cfset message.class = "success" />
		
		<cftry>
			<cfset getProposalService().updateProposalStatus(arguments.event.getArg('proposalID'), arguments.event.getArg('statusID')) />
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