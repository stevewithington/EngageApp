<cfcomponent 
		displayname="UserListener" 
		output="false" 
		extends="MachII.framework.Listener" 
		depends="userService">

	<cffunction name="configure" access="public" output="false" returntype="void">
	</cffunction>
	
	<cffunction name="processUserForm" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var user = arguments.event.getArg('user') />
		<cfset var errors = StructNew() />
		<cfset var message = StructNew() />
		<cfset var uploadResults = 0 />

		<cfif arguments.event.getArg("isAdmin") eq "">
			<cfset user.setIsAdmin(false) />
		<cfelse>
			<cfset user.setIsAdmin(true) />
		</cfif>
		
		<cfif arguments.event.getArg("isActive") eq "">
			<cfset user.setIsActive(false) />
		<cfelse>
			<cfset user.setIsActive(true) />
		</cfif>
		
		<cfset errors = user.validate() />
		
		<cfif user.getPassword() neq arguments.event.getArg('confirmPassword')>
			<cfset errors.password = "The two passwords entered do not match" />
		</cfif>
		
		<cfset message.text = "The user was saved." />
		<cfset message.class = "success" />
		
		<cfif not StructIsEmpty(errors)>
			<cfset message.text = "Please correct the following errors:" />
			<cfset message.class = "error" />
			<cfset arguments.event.setArg("errors", errors) />
			<cfset arguments.event.setArg("message", message) />
			<cfset redirectEvent("fail", "", true) />
		<cfelse>
			<cftry>
				<cfset getUserService().saveUser(user) />
				<cfset arguments.event.setArg("message", message) />
				<cfset redirectEvent("success", "", true) />
				
				<cfcatch type="any">
					<cfset errors.systemError = CFCATCH.Message & " - " & CFCATCH.Detail />
					<cfset message.text = "A system error occurred:" />
					<cfset message.class = "error" />
					<cfset arguments.event.setArg("errors", errors) />
					<cfset arguments.event.setArg("message", message) />
					<cfset redirectEvent("fail", "", true) />
				</cfcatch>
			</cftry>
		</cfif>
	</cffunction>
	
	<cffunction name="deleteUser" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = StructNew() />
		<cfset var errors = StructNew() />
		
		<cfset message.text = "The user was deleted." />
		<cfset message.class = "success" />
		
		<cftry>
			<cfset getUserService().deleteUser(arguments.event.getArg('user')) />
			<cfset arguments.event.setArg("message", message) />
			<cfset redirectEvent("success", "", true) />
			
			<cfcatch type="any">
				<cfset errors.systemError = CFCATCH.Message & " - " & CFCATCH.Detail />
				<cfset message.text = "A system error occurred:" />
				<cfset message.class = "error" />
				<cfset arguments.event.setArg("errors", errors) />
				<cfset arguments.event.setArg("message", message) />
				<cfset redirectEvent("fail", "", true) />
			</cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>