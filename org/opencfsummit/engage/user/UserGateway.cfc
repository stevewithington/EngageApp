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
			SELECT 	user_id, email, name, 
					oauth_provider, oauth_uid, is_registered, is_admin, 
					dt_created, active 
			FROM 	user 
			ORDER BY name ASC
		</cfquery>
		
		<cfreturn users />
	</cffunction>
	
	<cffunction name="userExists" access="public" output="false" returntype="boolean">
		<cfargument name="oauthUID" type="string" required="true" />
		<cfargument name="oauthProvider" type="string" required="true" />
		
		<cfset var checkUser = 0 />
		
		<cfquery name="checkUser" datasource="#getDSN()#">
			SELECT 	user_id 
			FROM 	user 
			WHERE 	oauth_uid = <cfqueryparam value="#arguments.oauthUID#" cfsqltype="cf_sql_longvarchar" /> 
			AND 	oauth_provider = <cfqueryparam value="#arguments.oauthProvider#" cfsqltype="cf_sql_varchar" maxlength="10" />
		</cfquery>
		
		<cfif checkUser.RecordCount gt 0>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>
	
	<!--- CRUD --->
	<cffunction name="fetch" access="public" output="false" returntype="void">
		<cfargument name="user" type="User" required="true" />
		
		<cfset var getUser = 0 />

		<cfquery name="getUser" datasource="#getDSN()#">
			SELECT 	user_id, email, name, oauth_provider, oauth_uid, oauth_profile_link, 
					is_registered, is_admin, dt_created, active 
			FROM 	user
			<!--- assume we'll either have a user ID, or an oauth provider and uid ---> 
			<cfif arguments.user.getUserID() neq 0>
			WHERE 	user_id = <cfqueryparam value="#arguments.user.getUserID()#" cfsqltype="cf_sql_integer" />
			<cfelse>
			WHERE 	oauth_provider = <cfqueryparam value="#arguments.user.getOauthProvider()#" cfsqltype="cf_sql_varchar" maxlength="10" /> 
			AND 	oauth_uid = <cfqueryparam value="#arguments.user.getOauthUID()#" cfsqltype="cf_sql_longvarchar" />
			</cfif>
		</cfquery>
		
		<cfif getUser.RecordCount neq 0>
			<cfset arguments.user.init(getUser.user_id, getUser.email, getUser.name, 
										getUser.oauth_provider, getUser.oauth_uid, getUser.oauth_profile_link, 
										StructNew(), getUser.is_registered, getUser.is_admin, 
										getUser.dt_created, getUser.active) />
		</cfif>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="void">
		<cfargument name="user" type="User" required="true" />
		
		<cfset var saveUser = 0 />
		<cfset var getUserID = 0 />
		
		<cfif arguments.user.getUserID() eq 0>
			<cftransaction>
				<cfquery name="saveUser" datasource="#getDSN()#">
					INSERT INTO user (
						email, name, 
						oauth_provider, oauth_uid, oauth_profile_link, 
						is_registered, is_admin, 
						dt_created, active
					) VALUES (
						<cfqueryparam value="#arguments.user.getEmail()#" cfsqltype="cf_sql_varchar" maxlength="255" 
										null="#Not Len(arguments.user.getEmail())#" />, 
						<cfqueryparam value="#arguments.user.getName()#" cfsqltype="cf_sql_varchar" 
										maxlength="500" null="#Not Len(arguments.user.getName())#" />, 
						<cfqueryparam value="#arguments.user.getOauthProvider()#" cfsqltype="cf_sql_varchar" 
										maxlength="10" />, 
						<cfqueryparam value="#arguments.user.getOauthUID()#" cfsqltype="cf_sql_longvarchar" />, 
						<cfqueryparam value="#arguments.user.getOauthProfileLink()#" cfsqltype="cf_sql_varchar" 
										maxlength="500" />, 
						<cfqueryparam value="#arguments.user.getIsRegistered()#" cfsqltype="cf_sql_tinyint" />, 
						<cfqueryparam value="#arguments.user.getIsAdmin()#" cfsqltype="cf_sql_tinyint" />, 
						<cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp" />, 
						<cfqueryparam value="#arguments.user.getIsActive()#" cfsqltype="cf_sql_tinyint" />
					)
				</cfquery>
				
				<cfquery name="getUserID" datasource="#getDSN()#">
					SELECT last_insert_id() AS new_id 
					FROM user
				</cfquery>
			</cftransaction>
			
			<cfif getUserID.RecordCount gt 0>
				<cfset arguments.user.setUserID(getUserID.new_id) />
			</cfif>
		<cfelse>
			<cfquery name="saveUser" datasource="#getDSN()#">
				UPDATE 	user 
				SET 	email = <cfqueryparam value="#arguments.user.getEmail()#" cfsqltype="cf_sql_varchar" 
											maxlength="255" null="#Not Len(arguments.user.getEmail())#" />, 
						name = <cfqueryparam value="#arguments.user.getName()#" cfsqltype="cf_sql_varchar" 
												maxlength="500" null="#Not Len(arguments.user.getName())#" />,
						oauth_provider = <cfqueryparam value="#arguments.user.getOauthProvider()#" cfsqltype="cf_sql_varchar" 
													maxlength="10" null="#Not Len(arguments.user.getOauthProvider())#" />, 
						oauth_uid = <cfqueryparam value="#arguments.user.getOauthUID()#" cfsqltype="cf_sql_longvarchar" 
													null="#Not Len(arguments.user.getOauthUID())#" />, 
						is_registered = <cfqueryparam value="#arguments.user.getIsRegistered()#" cfsqltype="cf_sql_tinyint" />, 
						is_admin = <cfqueryparam value="#arguments.user.getIsAdmin()#" cfsqltype="cf_sql_tinyint" />, 
						active = <cfqueryparam value="#arguments.user.getIsActive()#" cfsqltype="cf_sql_tinyint" /> 
				WHERE 	user_id = <cfqueryparam value="#arguments.user.getUserID()#" cfsqltype="cf_sql_integer" />
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