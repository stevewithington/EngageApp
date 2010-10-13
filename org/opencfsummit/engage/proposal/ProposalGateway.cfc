<cfcomponent 
		displayname="ProposalGateway" 
		output="false">

	<cffunction name="init" access="public" output="false" returntype="ProposalGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setDSN" access="public" output="false" returntype="void">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables.dsn = arguments.dsn />
	</cffunction>
	<cffunction name="getDSN" access="public" output="false" returntype="string">
		<cfreturn variables.dsn />
	</cffunction>
	
	<cffunction name="getProposals" access="public" output="false" returntype="query">
		<cfargument name="eventID" type="numeric" required="true" />
		
		<cfset var proposals = 0 />
		
		<cfquery name="proposals" datasource="#getDSN()#">
			SELECT 	p.proposal_id, p.event_id, p.track_id, p.session_type_id, p.status_id, p.title, p.excerpt, 
					p.description, p.note_to_organizers, p.agreed_to_terms, p.dt_created, 
					p.dt_updated, p.created_by, p.updated_by, p.active, 
					t.title AS track_title, t.color AS track_color, 
					st.title AS session_type, s.status 
			FROM 	proposal p 
			LEFT OUTER JOIN track t 
				ON p.track_id = t.track_id 
			INNER JOIN session_type st 
				ON p.session_type_id = st.session_type_id 
			INNER JOIN proposal_status s 
				ON p.status_id = s.status_id 
			WHERE 	p.event_id = <cfqueryparam value="#arguments.eventID#" cfsqltype="cf_sql_integer" /> 
			ORDER BY p.dt_created DESC
		</cfquery>
		
		<cfreturn proposals />
	</cffunction>
	
	<cffunction name="getComments" access="public" output="false" returntype="query">
		<cfargument name="proposalID" type="numeric" required="true" />
		
		<cfset var comments = 0 />
		
		<!--- TODO: need to get users here when user functionality is done --->
		<cfquery name="comments" datasource="#getDSN()#">
			SELECT 	c.comment_id, c.proposal_id, c.comment, c.is_private, c.dt_created, 
					c.dt_updated, c.created_by, c.updated_by, c.active 
			FROM 	proposal_comment c 
			WHERE 	proposal_id = <cfqueryparam value="#arguments.proposalID#" cfsqltype="cf_sql_integer" /> 
			ORDER BY c.dt_created ASC
		</cfquery>
		
		<cfreturn comments />
	</cffunction>
	
	<cffunction name="getProposalStatuses" access="public" output="false" returntype="query">
		<cfset var proposalStatuses = 0 />
		
		<cfquery name="proposalStatuses" datasource="#getDSN()#">
			SELECT status_id, status 
			FROM proposal_status
		</cfquery>
		
		<cfreturn proposalStatuses />
	</cffunction>
	
	<cffunction name="updateProposalStatus" access="public" output="false" returntype="void">
		<cfargument name="proposalID" type="numeric" required="true" />
		<cfargument name="statusID" type="numeric" required="true" />
		
		<cfset var updateStatus = 0 />
		
		<cfquery name="updateStatus" datasource="#getDSN()#">
			UPDATE 	proposal 
			SET 	status_id = <cfqueryparam value="#arguments.statusID#" cfsqltype="cf_sql_integer" /> 
			WHERE 	proposal_id = <cfqueryparam value="#arguments.proposalID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cffunction>
	
	<!--- CRUD --->
	<cffunction name="fetch" access="public" output="false" returntype="void">
		<cfargument name="proposal" type="Proposal" required="true" />
		
		<cfset var getProposal = 0 />
		<cfset var getTags = 0 />
		<cfset var tags = "" />
		<cfset var dtUpdated = CreateDateTime(1900,1,1,0,0,0) />
		<cfset var updatedBy = 0 />
		
		<cfif arguments.proposal.getProposalID() neq 0>
			<cfquery name="getProposal" datasource="#getDSN()#">
				SELECT 	p.proposal_id, p.event_id, p.track_id, p.session_type_id, p.status_id, p.title, p.excerpt, 
						p.description, p.note_to_organizers, p.agreed_to_terms, p.dt_created, 
						p.dt_updated, p.created_by, p.updated_by, p.active, 
						t.title AS track_title, t.color AS track_color, 
						st.title AS session_type, s.status 
				FROM 	proposal p 
				LEFT OUTER JOIN track t 
					ON p.track_id = t.track_id 
				INNER JOIN session_type st 
					ON p.session_type_id = st.session_type_id 
				INNER JOIN proposal_status s 
					ON p.status_id = s.status_id 
				WHERE 	proposal_id = <cfqueryparam value="#arguments.proposal.getProposalID()#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="getTags" datasource="#getDSN()#">
				SELECT 	tag_id, tag  
				FROM 	proposal_tag 
				WHERE 	proposal_id = <cfqueryparam value="#arguments.proposal.getProposalID()#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfif getTags.RecordCount gt 0>
				<cfset tags = QueryColumnList(getTags, "tag", ",") />
			</cfif>
			
			<cfif getProposal.RecordCount gt 0>
				<cfif getProposal.dt_updated neq "">
					<cfset dtUpdated = getProposal.dt_updated />
				</cfif>
				
				<cfif getProposal.updated_by neq "">
					<cfset updatedBy = getProposal.updated_by />
				</cfif>
				
				<cfset arguments.proposal.init(getProposal.proposal_id, getProposal.event_id, getProposal.track_id, 
												getProposal.track_title, getProposal.track_color, 
												getProposal.session_type_id, getProposal.session_type, 
												getProposal.status_id, getProposal.status, ArrayNew(1), getProposal.title, 
												getProposal.excerpt, getProposal.description, tags, getProposal.note_to_organizers, 
												getProposal.agreed_to_terms, getProposal.dt_created, dtUpdated, 
												getProposal.created_by, updatedBy, getProposal.active) />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void">
		<cfargument name="proposal" type="Proposal" required="true" />
		
		<cfset var saveProposal = 0 />
		<cfset var getNewID = 0 />
		<cfset var saveTags = 0 />
		<cfset var deleteTags = 0 />
		<cfset var tag = 0 />
		
		<cfif arguments.proposal.getStatusID() eq 0>
			<cfset arguments.proposal.setStatusID(1) />
		</cfif>
		
		<cfif arguments.proposal.getProposalID() eq 0>
			<cftransaction>
				<cfquery name="saveProposal" datasource="#getDSN()#">
					INSERT INTO proposal (
						event_id, track_id, session_type_id, status_id, title, excerpt, description, 
						note_to_organizers, agreed_to_terms, dt_created, created_by, 
						active
					) VALUES (
						<cfqueryparam value="#arguments.proposal.getEventID()#" cfsqltype="cf_sql_integer" />, 
						<cfqueryparam value="#arguments.proposal.getTrackID()#" cfsqltype="cf_sql_integer" />, 
						<cfqueryparam value="#arguments.proposal.getSessionTypeID()#" cfsqltype="cf_sql_integer" />, 
						<cfqueryparam value="#arguments.proposal.getStatusID()#" cfsqltype="cf_sql_integer" />, 
						<cfqueryparam value="#arguments.proposal.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="255" />, 
						<cfqueryparam value="#arguments.proposal.getExcerpt()#" cfsqltype="cf_sql_varchar" maxlength="1000" 
										null="#Not Len(Trim(arguments.proposal.getExcerpt()))#" />, 
						<cfqueryparam value="#arguments.proposal.getDescription()#" cfsqltype="cf_sql_longvarchar" />, 
						<cfqueryparam value="#arguments.proposal.getNoteToOrganizers()#" cfsqltype="cf_sql_varchar" 
										maxlength="1000" null="#Not Len(Trim(arguments.proposal.getNoteToOrganizers()))#" />, 
						<cfqueryparam value="#arguments.proposal.getAgreedToTerms()#" cfsqltype="cf_sql_tinyint" />, 
						<cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp" />, 
						<cfqueryparam value="#arguments.proposal.getCreatedBy()#" cfsqltype="cf_sql_integer" />, 
						<cfqueryparam value="#arguments.proposal.getIsActive()#" cfsqltype="cf_sql_tinyint" />
					)
				</cfquery>
				
				<cfif arguments.proposal.getTags() neq "">
					<cfquery name="getNewID" datasource="#getDSN()#">
						SELECT last_insert_id() AS new_id
					</cfquery>
					
					<cfloop list="#arguments.proposal.getTags()#" index="tag" delimiters=",">
						<cfquery name="saveTags" datasource="#getDSN()#">
							INSERT INTO proposal_tag (
								proposal_id, tag
							) VALUES (
								<cfqueryparam value="#getNewID.new_id#" cfsqltype="cf_sql_integer" />, 
								<cfqueryparam value="#tag#" cfsqltype="cf_sql_varchar" maxlength="255" />
							)
						</cfquery>
					</cfloop>
				</cfif>
			</cftransaction>
		<cfelse>
			<cftransaction>
				<cfquery name="saveProposal" datasource="#getDSN()#">
					UPDATE 	proposal 
					SET 	event_id = <cfqueryparam value="#arguments.proposal.getEventID()#" cfsqltype="cf_sql_integer" />, 
							track_id = <cfqueryparam value="#arguments.proposal.getTrackID()#" cfsqltype="cf_sql_integer" />, 
							session_type_id = <cfqueryparam value="#arguments.proposal.getSessionTypeID()#" cfsqltype="cf_sql_integer" />, 
							status_id = <cfqueryparam value="#arguments.proposal.getStatusID()#" cfsqltype="cf_sql_integer" />, 
							title = <cfqueryparam value="#arguments.proposal.getTitle()#" cfsqltype="cf_sql_varchar" maxlength="255" />, 
							excerpt = <cfqueryparam value="#arguments.proposal.getExcerpt()#" cfsqltype="cf_sql_varchar" maxlength="1000" 
													null="#Not Len(Trim(arguments.proposal.getExcerpt()))#" />, 
							description = <cfqueryparam value="#arguments.proposal.getDescription()#" cfsqltype="cf_sql_longvarchar" />, 
							note_to_organizers = <cfqueryparam value="#arguments.proposal.getNoteToOrganizers()#" cfsqltype="cf_sql_varchar" 
													maxlength="1000" null="#Not Len(Trim(arguments.proposal.getNoteToOrganizers()))#" />, 
							agreed_to_terms = <cfqueryparam value="#arguments.proposal.getAgreedToTerms()#" cfsqltype="cf_sql_tinyint" />, 
							dt_updated = <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp" />, 
							updated_by = <cfqueryparam value="#arguments.proposal.getUpdatedBy()#" cfsqltype="cf_sql_integer" />, 
							active = <cfqueryparam value="#arguments.proposal.getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
					WHERE 	proposal_id = <cfqueryparam value="#arguments.proposal.getProposalID()#" cfsqltype="cf_sql_integer" />
				</cfquery>
				
				<cfquery name="deleteTags" datasource="#getDSN()#">
					DELETE FROM proposal_tag 
					WHERE proposal_id = <cfqueryparam value="#arguments.proposal.getProposalID()#" cfsqltype="cf_sql_integer" />
				</cfquery>
				
				<cfif arguments.proposal.getTags() neq "">
					<cfloop list="#arguments.proposal.getTags()#" index="tag" delimiters=",">
						<cfquery name="saveTags" datasource="#getDSN()#">
							INSERT INTO proposal_tag (
								proposal_id, tag
							) VALUES (
								<cfqueryparam value="#arguments.proposal.getProposalID()#" cfsqltype="cf_sql_integer" />, 
								<cfqueryparam value="#tag#" cfsqltype="cf_sql_varchar" maxlength="255" />
							)
						</cfquery>
					</cfloop>
				</cfif>
			</cftransaction>
		</cfif>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void">
		<cfargument name="proposal" type="Proposal" required="true" />
		
		<cfset var deleteProposal = 0 />
		<cfset var deleteTags = 0 />
		<cfset var deleteComments = 0 />
		<cfset var deleteSpeakers = 0 />
		
		<cftransaction>
			<cfquery name="deleteProposal" datasource="#getDSN()#">
				DELETE FROM proposal 
				WHERE proposal_id = <cfqueryparam value="#arguments.proposal.getProposalID()#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="deleteTags" datasource="#getDSN()#">
				DELETE FROM proposal_tag 
				WHERE proposal_id = <cfqueryparam value="#arguments.proposal.getProposalID()#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="deleteComments" datasource="#getDSN()#">
				DELETE FROM proposal_comment 
				WHERE proposal_id = <cfqueryparam value="#arguments.proposal.getProposalID()#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="deleteSpeakers" datasource="#getDSN()#">
				DELETE FROM proposal_speaker 
				WHERE proposal_id = <cfqueryparam value="#arguments.proposal.getProposalID()#" cfsqltype="cf_sql_integer" />
			</cfquery>
		</cftransaction>
	</cffunction>

</cfcomponent>