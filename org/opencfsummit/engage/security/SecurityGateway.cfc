<cfcomponent 
		displayname="SecurityGateway" 
		output="false">

	<cffunction name="init" access="public" output="false" returntype="SecurityGateway">
		<cfreturn this />
	</cffunction>

	<cffunction name="setDSN" access="public" output="false" returntype="void">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables.dsn = arguments.dsn />
	</cffunction>
	<cffunction name="getDSN" access="public" output="false" returntype="string">
		<cfreturn variables.dsn />
	</cffunction>
	
	<cffunction name="authenticateUser" access="public" output="false" returntype="numeric">
		<cfargument name="email" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />
		
		<cfset var getPasswordSalt = 0 />
		<cfset var getUserID = 0 />
		<cfset var userID = 0 />
		
		<cfquery name="getPasswordSalt" datasource="#getDSN()#">
			SELECT 	password_salt 
			FROM 	user 
			WHERE 	email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar" 
											maxlength="255" />
		</cfquery>
		
		<cfif getPasswordSalt.RecordCount gt 0>
			<cfquery name="getUserID" datasource="#getDSN()#">
				SELECT 	user_id 
				FROM 	user 
				WHERE 	email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar" 
												maxlength="255" /> 
				AND 	password = <cfqueryparam value="#Hash(arguments.password & getPasswordSalt.password_salt, 'SHA-256')#" 
												cfsqltype="cf_sql_char" maxlength="64" />
			</cfquery>
			
			<cfif getUserID.RecordCount eq 1 and getUserID.user_id neq "">
				<cfset userID = getUserID.user_id />
			</cfif>
		</cfif>
		
		<cfreturn userID />
	</cffunction>

</cfcomponent>