<cfcomponent 
		displayname="SecurityService" 
		output="false">

	<cffunction name="init" access="public" output="false" returntype="SecurityService">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setSecurityGateway" access="public" output="false" returntype="void">
		<cfargument name="securityGateway" type="SecurityGateway" required="true" />
		<cfset variables.securityGateway = arguments.securityGateway />
	</cffunction>
	<cffunction name="getSecurityGateway" access="public" output="false" returntype="SecurityGateway">
		<cfreturn variables.securityGateway />
	</cffunction>
	
	<cffunction name="authenticateUser" access="public" output="false" returntype="numeric">
		<cfargument name="email" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />
		
		<cfreturn getSecurityGateway().authenticateUser(arguments.email, 
														arguments.password) />
	</cffunction>
</cfcomponent>