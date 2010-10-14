<cfcomponent 
		displayname="UserService" 
		output="false">

	<cffunction name="init" access="public" output="false" returntype="UserService">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setUserGateway" access="public" output="false" returntype="void">
		<cfargument name="userGateway" type="UserGateway" required="true" />
		<cfset variables.userGateway = arguments.userGateway />
	</cffunction>
	<cffunction name="getUserGateway" access="public" output="false" returntype="UserGateway">
		<cfreturn variables.userGateway />
	</cffunction>
	
	<cffunction name="getUserBean" access="public" output="false" returntype="User">
		<cfreturn CreateObject("component", "User").init() />
	</cffunction>
	
	<cffunction name="getUsers" access="public" output="false" returntype="query">
		<cfreturn getUserGateway().getUsers() />
	</cffunction>
	
	<cffunction name="getUser" access="public" output="false" returntype="User">
		<cfargument name="userID" type="numeric" required="false" default="0" />
		
		<cfset var user = getUserBean() />
		
		<cfset user.setUserID(arguments.userID) />
		<cfset getUserGateway().fetch(user) />
		
		<cfreturn user />
	</cffunction>

</cfcomponent>