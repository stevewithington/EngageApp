<cfcomponent 
		displayname="SecurityListener" 
		output="false" 
		extends="MachII.framework.Listener" 
		depends="userService">

	<cffunction name="configure" access="public" output="false" returntype="void">
	</cffunction>
	
	<cffunction name="processLoginForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var user = getSecurityService().login(arguments.event.getArg('email'), arguments.event.getArg('password')) />
		<cfset var message = StructNew() />
		
		<cfset message.text = "Your login failed. Please try again." />
		<cfset message.class = "error" />
		
		<cfif user.getUserID() neq 0>
			<cfset session.user = user />
			
			<cfif user.getIsAdmin()>
				<cfset redirectEvent('admin.home') />
			<cfelse>
				<cfset redirectEvent('home') />
			</cfif>
		<cfelse>
			<cfset arguments.event.setArg('message', message) />
			<cfset redirectEvent('login') />
		</cfif>
	</cffunction>

</cfcomponent>