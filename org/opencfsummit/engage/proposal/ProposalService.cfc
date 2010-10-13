<cfcomponent 
		displayname="ProposalService" 
		output="false">

	<cffunction name="init" access="public" output="false" returntype="ProposalService">
		<cfreturn this />
	</cffunction>

	<cffunction name="setProposalGateway" access="public" output="false" returntype="void">
		<cfargument name="proposalGateway" type="ProposalGateway" required="true" />
		<cfset variables.proposalGateway = arguments.proposalGateway />
	</cffunction>
	<cffunction name="getProposalGateway" access="public" output="false" returntype="ProposalGateway">
		<cfreturn variables.proposalGateway />
	</cffunction>
	
	<cffunction name="getProposalBean" access="public" output="false" returntype="Proposal">
		<cfreturn CreateObject("component", "Proposal").init() />
	</cffunction>
	
	<cffunction name="getProposals" access="public" output="false" returntype="query">
		<cfargument name="eventID" type="numeric" required="true" />
		
		<cfreturn getProposalGateway().getProposals(arguments.eventID) />
	</cffunction>
	
	<cffunction name="getProposalStatuses" access="public" output="false" returntype="query">
		<cfreturn getProposalGateway().getProposalStatuses() />
	</cffunction>
	
	<cffunction name="getProposalComments" access="public" output="false" returntype="query">
		<cfargument name="proposalID" type="numeric" required="true" />
		
		<cfreturn getProposalGateway().getComments(arguments.proposalID) />
	</cffunction>
	
	<cffunction name="getProposal" access="public" output="false" returntype="Proposal">
		<cfargument name="proposalID" type="numeric" required="false" default="0" />
		
		<cfset var proposal = getProposalBean() />
		
		<!--- TODO: need to get speakers here --->
		
		<cfset proposal.setProposalID(arguments.proposalID) />
		<cfset getProposalGateway().fetch(proposal) />
		
		<cfreturn proposal />
	</cffunction>
	
	<cffunction name="saveProposal" access="public" output="false" returntype="void">
		<cfargument name="proposal" type="Proposal" required="true" />
		
		<cfset getProposalGateway().save(proposal) />
	</cffunction>
	
	<cffunction name="deleteProposal" access="public" output="false" returntype="void">
		<cfargument name="proposal" type="Proposal" required="true" />
		
		<cfset getProposalGateway().delete(proposal) />
	</cffunction>
	
	<cffunction name="updateProposalStatus" access="public" output="false" returntype="void">
		<cfargument name="proposalID" type="numeric" required="true" />
		<cfargument name="statusID" type="numeric" required="true" />
		
		<cfset getProposalGateway().updateProposalStatus(arguments.proposalID, arguments.statusID) />
	</cffunction>

</cfcomponent>