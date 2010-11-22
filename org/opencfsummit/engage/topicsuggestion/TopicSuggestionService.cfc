<cfcomponent 
		displayname="TopicSuggestionService" 
		output="false">

	<cffunction name="init" access="public" output="false" returntype="TopicSuggestionService">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setTopicSuggestionGateway" access="public" output="false" returntype="void">
		<cfargument name="topicSuggestionGateway" type="TopicSuggestionGateway" required="true" />
		<cfset variables.topicSuggestionGateway = arguments.topicSuggestionGateway />
	</cffunction>
	<cffunction name="getTopicSuggestionGateway" access="public" output="false" returntype="TopicSuggestionGateway">
		<cfreturn variables.topicSuggestionGateway />
	</cffunction>

	<cffunction name="getTopicSuggestionBean" access="public" output="false" returntype="TopicSuggestion">
		<cfreturn CreateObject("component", "TopicSuggestion").init() />
	</cffunction>
	
	<cffunction name="getTopicSuggestions" access="public" output="false" returntype="query">
		<cfargument name="eventID" type="numeric" required="true" />
		<cfargument name="userID" type="numeric" required="false" default="0" />
		
		<cfreturn getTopicSuggestionGateway().getTopicSuggestions(arguments.eventID, arguments.userID) />
	</cffunction>
		
	<cffunction name="getTopicSuggestion" access="public" output="false" returntype="TopicSuggestion">
		<cfargument name="topicSuggestionID" type="numeric" required="false" default="0" />
		
		<cfset var topicSuggestion = getTopicSuggestionBean() />
		
		<cfif IsNumeric(arguments.topicSuggestionID)>
			<cfset topicSuggestion.setTopicSuggestionID(arguments.topicSuggestionID) />
			<cfset getTopicSuggestionGateway().fetch(topicSuggestion) />
		</cfif>
		
		<cfreturn topicSuggestion />
	</cffunction>
	
	<cffunction name="getUserVotes" access="public" output="false" returntype="string">
		<cfargument name="userID" type="numeric" required="true" />
		
		<cfset var votes = getTopicSuggestionGateway().getUserVotes(arguments.userID) />
		<cfset var votesList = "" />
		
		<cfif votes.RecordCount gt 0>
			<cfset votesList = ValueList(votes.topic_suggestion_id) />
		</cfif>
		
		<cfreturn votesList />
	</cffunction>
	
	<cffunction name="addVote" access="public" output="false" returntype="void">
		<cfargument name="topicSuggestionID" type="numeric" required="true" />
		<cfargument name="userID" type="numeric" required="true" />
		
		<cfset getTopicSuggestionGateway().addVote(arguments.topicSuggestionID, arguments.userID) />
	</cffunction>
	
	<cffunction name="removeVote" access="public" output="false" returntype="void">
		<cfargument name="topicSuggestionID" type="numeric" required="true" />
		<cfargument name="userID" type="numeric" required="true" />
		
		<cfset getTopicSuggestionGateway().removeVote(arguments.topicSuggestionID, arguments.userID) />
	</cffunction>
	
	<cffunction name="saveTopicSuggestion" access="public" output="false" returntype="void">
		<cfargument name="topicSuggestion" type="TopicSuggestion" required="true" />
		
		<cfset getTopicSuggestionGateway().save(arguments.topicSuggestion) />
	</cffunction>
	
	<cffunction name="deleteTopicSuggestion" access="public" output="false" returntype="void">
		<cfargument name="topicSuggestion" type="TopicSuggestion" required="true" />
		
		<cfset getTopicSuggestionGateway().delete(arguments.topicSuggestion) />
	</cffunction>
	
	<cffunction name="updateRSSFeed" access="public" output="false" returntype="void">
		<cfargument name="eventID" type="numeric" required="true" />
		<cfargument name="siteURL" type="string" required="true" />
		
		<cfscript>
			var topics = getTopicSuggestions(arguments.eventID);
			var items = ArrayNew(1);
			var item = StructNew();
			var feed = StructNew();
			var i = 0;
			
			for (i = 1; i <= topics.RecordCount; i++) {
				item = StructNew();
				
				item.title = XmlFormat(topics['topic'][i]);
				item.description = StructNew();
				item.description.value = XmlFormat(topics['description'][i]);
				item.guid = StructNew();
				item.guid.isPermaLink = "yes";
				item.guid.value = "#arguments.siteURL#/index.cfm/topicSuggestion/topicSuggestionID/#topics['topic_suggestion_id'][i]#";
				item.pubdate = topics['dt_created'][i];
				
				ArrayAppend(items, item);
			}
			
			feed.link = "#arguments.siteURL#/topicsuggestions.rss";
			feed.title = "OpenCF Summit Topic Suggestions";
			feed.description = "Topic suggestions submitted to OpenCF Summit";
			feed.pubdate = Now();
			feed.version = "rss_2.0";
			feed.item = items;
		</cfscript>
		
		<cffeed action="create" name="#feed#" outputfile="#ExpandPath('./topicsuggestions.rss')#" overwrite="true" />
	</cffunction>
	
</cfcomponent>