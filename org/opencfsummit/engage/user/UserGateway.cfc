<cfcomponent 
		displayname="UserGateway" 
		output="false">

	<cffunction name="init" access="public" output="false" returntype="UserGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setDSN" access="public" output="false" returntype="void">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables.dsn = arguments.dsn />
	</cffunction>
	<cffunction name="getDSN" access="public" output="false" returntype="string">
		<cfreturn variables.dsn />
	</cffunction>
	
	<cffunction name="getUsers" access="public" output="false" returntype="query">
		<cfset var users = 0 />
		
		<cfquery name="users" datasource="#getDSN()#">
			SELECT 	user_id, email, password, password_salt, 
					first_name, last_name, oauth_provider, oauth_uid, is_admin, 
					dt_created, dt_updated, created_by, updated_by, active 
			FROM 	user 
			ORDER BY last_name, first_name ASC
		</cfquery>
		
		<cfreturn users />
	</cffunction>
	
	<!--- CRUD --->
	<cffunction name="fetch" access="public" output="false" returntype="void">
		<cfargument name="user" type="User" required="true" />
		
		<cfset var getUser = 0 />
		<cfset var dtUpdated = CreateDateTime(1900,1,1,0,0,0) />
		<cfset var updatedBy = 0 />
		
		<cfif arguments.user.getUserID() neq 0>
			<cfquery name="getUser" datasource="#getDSN()#">
				SELECT 	user_id, email, password, password_salt, 
						first_name, last_name, oauth_provider, oauth_uid, 
						is_admin, dt_created, dt_updated, created_by, updated_by, active 
				FROM 	user 
				WHERE 	user_id = <cfqueryparam value="#arguments.user.getUserID()#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfif getUser.RecordCount neq 0>
				<cfif getUser.dt_updated neq "">
					<cfset dtUpdated = getUser.dt_updated />
				</cfif>
				
				<cfif getUser.updated_by neq 0>
					<cfset updatedBy = getUser.updated_by />
				</cfif>
				
				<cfset arguments.user.init(getUser.user_id, getUser.email, getUser.password, getUser.password_salt, 
											getUser.first_name, getUser.last_name, getUser.oauth_provider, 
											getUser.oauth_uid, getUser.is_admin, getUser.dt_created, dtUpdated, 
											getUser.created_by, updatedBy, getUser.active) />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void">
		<cfargument name="user" type="User" required="true" />
		
		<cfset var saveUser = 0 />
		<cfset var uuid = CreateUUID() />
		
		<cfif arguments.user.getUserID() eq 0>
			<cfquery name="saveUser" datasource="#getDSN()#">
				INSERT INTO user (
					email, password, password_salt, first_name, last_name, 
					oauth_provider, oauth_uid, is_admin, dt_created,  
					created_by, active
				) VALUES (
					<cfqueryparam value="#arguments.user.getEmail()#" cfsqltype="cf_sql_varchar" />, 
					<cfqueryparam value="#Hash(arguments.user.getPassword() & uuid, 'SHA-256')#" 
									cfsqltype="cf_sql_char" maxlength="64" 
									null="#Not Len(arguments.user.getPassword())#" />, 
					<cfqueryparam value="#uuid#" cfsqltype="cf_sql_char" maxlength="35" />, 
					<cfqueryparam value="#arguments.user.getFirstName()#" cfsqltype="cf_sql_varchar" 
									maxlength="100" null="#Not Len(arguments.user.getFirstName())#" />, 
					<cfqueryparam value="#arguments.user.getLastName()#" cfsqltype="cf_sql_varchar" 
									maxlength="100" null="#Not Len(arguments.user.getLastName())#" />, 
					<cfqueryparam value="#arguments.user.getOauthProvider()#" cfsqltype="cf_sql_varchar" 
									maxlength="10" null="#Not Len(arguments.user.getOauthProvider())#" />, 
					<cfqueryparam value="#arguments.user.getOauthUID()#" cfsqltype="cf_sql_longvarchar" 
									null="#Not Len(arguments.user.getOauthUID())#" />, 
					<cfqueryparam value="#arguments.user.getIsAdmin()#" cfsqltype="cf_sql_tinyint" />, 
					<cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp" />, 
					<cfqueryparam value="#arguments.user.getCreatedBy()#" cfsqltype="cf_sql_integer" />, 
					<cfqueryparam value="#arguments.user.getIsActive()#" cfsqltype="cf_sql_tinyint" />
				)
			</cfquery>
		<cfelse>
			<cfquery name="saveUser" datasource="#getDSN()#">
				UPDATE 	user 
				SET 	email = <cfqueryparam value="#arguments.user.getEmail()#" cfsqltype="cf_sql_varchar" 
											maxlength="255" />, 
					<cfif arguments.user.getPassword() neq "">
						password = <cfqueryparam value="#Hash(arguments.user.getPassword() & uuid, 'SHA-256')#" 
												cfsqltype="cf_sql_char" maxlength="64" />, 
						password_salt = <cfqueryparam value="#uuid#" cfsqltype="cf_sql_char" maxlength="35" />, 
					</cfif>
						first_name = <cfqueryparam value="#arguments.user.getFirstName()#" cfsqltype="cf_sql_varchar" 
											maxlength="100" null="#Not Len(arguments.user.getFirstName())#" />, 					
						last_name = <cfqueryparam value="#arguments.user.getLastName()#" cfsqltype="cf_sql_varchar" 
												maxlength="100" null="#Not Len(arguments.user.getLastName())#" />,
						oauth_provider = <cfqueryparam value="#arguments.user.getOauthProvider()#" cfsqltype="cf_sql_varchar" 
													maxlength="10" null="#Not Len(arguments.user.getOauthProvider())#" />, 
						oauth_uid = <cfqueryparam value="#arguments.user.getOauthUID()#" cfsqltype="cf_sql_longvarchar" 
													null="#Not Len(arguments.user.getOauthUID())#" />, 
						is_admin = <cfqueryparam value="#arguments.user.getIsAdmin()#" cfsqltype="cf_sql_tinyint" />, 
						dt_updated = <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp" />, 
						updated_by = <cfqueryparam value="#arguments.user.getUpdatedBy()#" cfsqltype="cf_sql_integer" />, 
						active = <cfqueryparam value="#arguments.user.getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
				WHERE 	user_id = <cfqueryparam value="#arguments.user.getUserID()#" 
											cfsqltype="cf_sql_integer" />
			</cfquery>
		</cfif>
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="void">
		<cfargument name="user" type="User" required="true" />
		
		<cfset var deleteUser = 0 />
		
		<cfquery name="deleteUser" datasource="#getDSN()#">
			DELETE FROM user 
			WHERE user_id = <cfqueryparam value="#arguments.user.getUserID()#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cffunction>

</cfcomponent>