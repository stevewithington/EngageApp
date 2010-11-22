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
		<cfargument name="userID" type="numeric" required="false" default="0" />
		
		<cfreturn getProposalGateway().getProposals(arguments.eventID, arguments.userID) />
	</cffunction>
	
	<cffunction name="getProposalFavorites" access="public" output="false" returntype="query">
		<cfargument name="eventID" type="numeric" required="true" />
		<cfargument name="userID" type="numeric" required="false" default="0" />
		
		<cfreturn getProposalGateway().getProposalFavorites(arguments.eventID, arguments.userID) />
	</cffunction>
	
	<cffunction name="getProposalStatuses" access="public" output="false" returntype="query">
		<cfreturn getProposalGateway().getProposalStatuses() />
	</cffunction>
	
	<cffunction name="getUserVotes" access="public" output="false" returntype="string">
		<cfargument name="userID" type="numeric" required="true" />
		
		<cfset var votes = getProposalGateway().getUserVotes(arguments.userID) />
		<cfset var votesList = "" />
		
		<cfif votes.RecordCount gt 0>
			<cfset votesList = QueryColumnList(votes, "proposal_id") />
		</cfif>
		
		<cfreturn votesList />
	</cffunction>	

	<cffunction name="addVote" access="public" output="false" returntype="void">
		<cfargument name="proposalID" type="numeric" required="true" />
		<cfargument name="userID" type="numeric" required="true" />
		
		<cfset getProposalGateway().addVote(arguments.proposalID, arguments.userID) />
	</cffunction>
		
	<cffunction name="removeVote" access="public" output="false" returntype="void">
		<cfargument name="proposalID" type="numeric" required="true" />
		<cfargument name="userID" type="numeric" required="true" />
		
		<cfset getProposalGateway().removeVote(arguments.proposalID, arguments.userID) />
	</cffunction>
		
	<cffunction name="getProposalUserID" access="public" output="false" returntype="numeric">
		<cfargument name="proposalID" type="numeric" required="true" />
		
		<cfreturn getProposalGateway().getProposalUserID(arguments.proposalID) />
	</cffunction>
			
	<cffunction name="getProposal" access="public" output="false" returntype="Proposal">
		<cfargument name="proposalID" type="numeric" required="false" default="0" />
		
		<cfset var proposal = getProposalBean() />
		
		<cfif IsNumeric(arguments.proposalID)>
			<cfset proposal.setProposalID(arguments.proposalID) />
			<cfset getProposalGateway().fetch(proposal) />
		</cfif>
		
		<cfreturn proposal />
	</cffunction>
	
	<cffunction name="saveProposal" access="public" output="false" returntype="void">
		<cfargument name="proposal" type="Proposal" required="true" />
		
		<cfset getProposalGateway().save(arguments.proposal) />
	</cffunction>
	
	<cffunction name="deleteProposal" access="public" output="false" returntype="void">
		<cfargument name="proposal" type="Proposal" required="true" />
		
		<cfset getProposalGateway().delete(arguments.proposal) />
	</cffunction>
	
	<cffunction name="updateProposalStatus" access="public" output="false" returntype="void">
		<cfargument name="proposalID" type="numeric" required="true" />
		<cfargument name="statusID" type="numeric" required="true" />
		
		<cfset getProposalGateway().updateProposalStatus(arguments.proposalID, arguments.statusID) />
	</cffunction>

	<cffunction name="updateRSSFeed" access="public" output="false" returntype="void">
		<cfargument name="eventID" type="numeric" required="true" />
		<cfargument name="siteURL" type="string" required="true" />
				
		<cfscript>
			var proposals = getProposals(arguments.eventID);
			var items = ArrayNew(1);
			var item = StructNew();
			var feed = StructNew();
			var i = 0;
			
			for (i = 1; i <= proposals.RecordCount; i++) {
				item = StructNew();
				
				item.title = XmlFormat(proposals['title'][i]);
				item.description = StructNew();
				item.description.value = XmlFormat(proposals['excerpt'][i]);
				item.guid = StructNew();
				item.guid.isPermaLink = "yes";
				item.guid.value = "#arguments.siteURL#/index.cfm/proposal/proposalID/#proposals['proposal_id'][i]#";
				item.pubdate = proposals['dt_created'][i];
				
				ArrayAppend(items, item);
			}
			
			feed.link = "#arguments.siteURL#/proposals.rss";
			feed.title = "OpenCF Summit Proposals";
			feed.description = "Proposals submitted for OpenCF Summit";
			feed.pubdate = Now();
			feed.version = "rss_2.0";
			feed.item = items;
		</cfscript>
		
		<cffeed action="create" name="#feed#" outputfile="#ExpandPath('./proposals.rss')#" overwrite="true" />
	</cffunction>
	
</cfcomponent>