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
	
	

</cfcomponent>