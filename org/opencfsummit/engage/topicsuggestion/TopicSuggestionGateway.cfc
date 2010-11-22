<cfcomponent 
		displayname="TopicSuggestionGateway" 
		output="false">

	<cffunction name="init" access="public" output="false" returntype="TopicSuggestionGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setDSN" access="public" output="false" returntype="void">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables.dsn = arguments.dsn />
	</cffunction>
	<cffunction name="getDSN" access="public" output="false" returntype="string">
		<cfreturn variables.dsn />
	</cffunction>
	
	<cffunction name="getTopicSuggestions" access="public" output="false" returntype="query">
		<cfargument name="eventID" type="numeric" required="true" />
		<cfargument name="userID" type="numeric" required="false" default="0" />
		
		<cfset var suggestions = 0 />
		
		<cfquery name="suggestions" datasource="#getDSN()#">
			SELECT 	ts.topic_suggestion_id, ts.event_id, ts.topic, ts.description, 
					ts.suggested_speaker, ts.dt_created, 
					IFNULL(tsv.votes, 0) AS votes, 
					u.name AS suggested_by 
			FROM	topic_suggestion ts 
			LEFT JOIN (
				SELECT topic_suggestion_id, COUNT(*) AS votes 
				FROM topic_suggestion_vote 
				GROUP BY topic_suggestion_id 
			) tsv 
				ON ts.topic_suggestion_id = tsv.topic_suggestion_id 
			INNER JOIN user u 
				ON ts.created_by = u.user_id 
			WHERE 	ts.event_id = <cfqueryparam value="#arguments.eventID#" cfsqltype="cf_sql_integer" /> 
			<cfif arguments.userID != 0>
				AND 	ts.created_by = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" /> 
			</cfif>
			ORDER BY ts.dt_created DESC
		</cfquery>
		
		<cfreturn suggestions />
	</cffunction>
	
	<cffunction name="addVote" access="public" output="false" returntype="void">
		<cfargument name="topicSuggestionID" type="numeric" required="true" />
		<cfargument name="userID" type="numeric" required="true" />
		
		<cfset var addVote = 0 />
		
		<cfquery name="addVote" datasource="#getDSN()#">
			INSERT INTO topic_suggestion_vote (topic_suggestion_id, user_id) 
			VALUES (<cfqueryparam value="#arguments.topicSuggestionID#" cfsqltype="cf_sql_integer" />, 
					<cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" />)
		</cfquery>
	</cffunction>
	
	<cffunction name="removeVote" access="public" output="false" returntype="void">
		<cfargument name="topicSuggestionID" type="numeric" required="true" />
		<cfargument name="userID" type="numeric" required="true" />
		
		<cfset var removeVote = 0 />
		
		<cfquery name="removeVote" datasource="#getDSN()#">
			DELETE FROM topic_suggestion_vote 
			WHERE 	topic_suggestion_id = <cfqueryparam value="#arguments.topicSuggestionID#" cfsqltype="cf_sql_integer" /> 
			AND 	user_id = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cffunction>
	
	<cffunction name="getUserVotes" access="public" output="false" returntype="query">
		<cfargument name="userID" type="numeric" required="true" />
		
		<cfset var votes = 0 />
		
		<cfquery name="votes" datasource="#getDSN()#">
			SELECT topic_suggestion_id 
			FROM topic_suggestion_vote 
			WHERE user_id = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfreturn votes />
	</cffunction>

	<!--- CRUD --->
	<cffunction name="fetch" access="public" output="false" returntype="void">
		<cfargument name="topicSuggestion" type="TopicSuggestion" required="true" />
		
		<cfset var getTopicSuggestion = 0 />
		<cfset var dtUpdated = CreateDateTime(1900,1,1,0,0,0) />
		<cfset var updatedBy = 0 />
		
		<cfif arguments.topicSuggestion.getTopicSuggestionID() neq 0>
			<cfquery name="getVotes" datasource="#getDSN()#">
				SELECT 	COUNT(*) AS num_votes 
				FROM 	topic_suggestion_vote 
				WHERE 	topic_suggestion_id = <cfqueryparam value="#arguments.topicSuggestion.getTopicSuggestionID()#" 
															cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="getTopicSuggestion" datasource="#getDSN()#">
				SELECT 	ts.topic_suggestion_id, ts.event_id, ts.topic, ts.description, 
						ts.suggested_speaker, ts.dt_created, ts.dt_updated,
						ts.created_by, ts.updated_by, 
						IFNULL(tsv.votes, 0) AS votes, 
						u.name AS suggested_by 
				FROM	topic_suggestion ts 
				LEFT JOIN (
					SELECT topic_suggestion_id, COUNT(*) AS votes 
					FROM topic_suggestion_vote 
					GROUP BY topic_suggestion_id 
				) tsv 
					ON ts.topic_suggestion_id = tsv.topic_suggestion_id 
				INNER JOIN user u 
					ON ts.created_by = u.user_id 
				WHERE 	ts.topic_suggestion_id = <cfqueryparam value="#arguments.topicSuggestion.getTopicSuggestionID()#" 
																cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfif getTopicSuggestion.RecordCount gt 0>
				<cfif getTopicSuggestion.dt_updated neq "">
					<cfset dtUpdated = getTopicSuggestion.dt_updated />
				</cfif>
				
				<cfif getTopicSuggestion.updated_by neq "">
					<cfset updatedBy = getTopicSuggestion.updated_by />
				</cfif>
				
				<cfset arguments.topicSuggestion.init(getTopicSuggestion.topic_suggestion_id, getTopicSuggestion.event_id, 
														getTopicSuggestion.topic, ArrayNew(1), getTopicSuggestion.description, 
														getTopicSuggestion.suggested_speaker, getTopicSuggestion.suggested_by, 
														getTopicSuggestion.votes, getTopicSuggestion.dt_created, dtUpdated, 
														getTopicSuggestion.created_by, updatedBy) />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void">
		<cfargument name="topicSuggestion" type="TopicSuggestion" required="true" />
		
		<cfset var saveTopicSuggestion = 0 />
		
		<cfif arguments.topicSuggestion.getTopicSuggestionID() eq 0>
			<cfquery name="saveTopicSuggestion" datasource="#getDSN()#">
				INSERT INTO topic_suggestion (
					event_id, topic, description, suggested_speaker, 
					dt_created, created_by
				) VALUES (
					<cfqueryparam value="#arguments.topicSuggestion.getEventID()#" cfsqltype="cf_sql_integer" />, 
					<cfqueryparam value="#arguments.topicSuggestion.getTopic()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
					<cfqueryparam value="#arguments.topicSuggestion.getDescription()#" cfsqltype="cf_sql_longvarchar" />, 
					<cfqueryparam value="#arguments.topicSuggestion.getSuggestedSpeaker()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
					<cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp" />, 
					<cfqueryparam value="#arguments.topicSuggestion.getCreatedBy()#" cfsqltype="cf_sql_tinyint" />
				)
			</cfquery>
		<cfelse>
			<cfquery name="saveTopicSuggestion" datasource="#getDSN()#">
				UPDATE 	topic_suggestion 
				SET 	event_id = <cfqueryparam value="#arguments.topicSuggestion.getEventID()#" cfsqltype="cf_sql_integer" />, 
						topic = <cfqueryparam value="#arguments.topicSuggestion.getTopic()#" cfsqltype="cf_sql_varchar" maxlength="500" />, 
						description = <cfqueryparam value="#arguments.topicSuggestion.getDescription()#" cfsqltype="cf_sql_longvarchar" />, 
						suggested_speaker = <cfqueryparam value="#arguments.topicSuggestion.getSuggestedSpeaker()#" 
															cfsqltype="cf_sql_varchar" maxlength="500" />, 
						dt_updated = <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp" />, 
						updated_by = <cfqueryparam value="#arguments.topicSuggestion.getUpdatedBy()#" cfsqltype="cf_sql_tinyint" />
				WHERE 	topic_suggestion_id = <cfqueryparam value="#arguments.topicSuggestion.getTopicSuggestionID()#" cfsqltype="cf_sql_integer" />
			</cfquery>
		</cfif>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void">
		<cfargument name="topicSuggestion" type="TopicSuggestion" required="true" />
		
		<cfset var deleteTopicSuggestionCategories = 0 />
		<cfset var deleteVotes = 0 />
		<cfset var deleteTopicSuggestion = 0 />
		
		<cftransaction>
			<cfquery name="deleteTopicSuggestionCategories" datasource="#getDSN()#">
				DELETE FROM topic_suggestion_category 
				WHERE topic_suggestion_id = <cfqueryparam value="#arguments.topicSuggestion.getTopicSuggestionID()#" 
															cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="deleteVotes" datasource="#getDSN()#">
				DELETE FROM topic_suggestion_vote 
				WHERE topic_suggestion_id = <cfqueryparam value="#arguments.topicSuggestion.getTopicSuggestionID()#" 
															cfsqltype="cf_sql_integer" />
			</cfquery>
						
			<cfquery name="deleteTopicSuggestion" datasource="#getDSN()#">
				DELETE FROM topic_suggestion 
				WHERE topic_suggestion_id = <cfqueryparam value="#arguments.topicSuggestion.getTopicSuggestionID()#" 
															cfsqltype="cf_sql_integer" />
			</cfquery>
		</cftransaction>
	</cffunction>

</cfcomponent>