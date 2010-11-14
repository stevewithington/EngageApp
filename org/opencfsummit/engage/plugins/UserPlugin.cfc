<cfcomponent 
		displayname="UserPlugin" 
		output="false" 
		extends="MachII.framework.Plugin" 
		depends="userService">

	<cffunction name="configure" access="public" output="false" returntype="void">
	</cffunction>

	<cffunction name="preProcess" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		
		<cfscript>
			var nextEvent = arguments.eventContext.getNextEvent();
			
			if (StructKeyExists(session, "user") && (IsStruct(session.user.getUserInfo()) && StructIsEmpty(session.user.getUserInfo()))) {
				StructDelete(session, 'user', false);
			}
			
			if ((!StructKeyExists(session, "user") || (IsStruct(session.user.getUserInfo()) && StructIsEmpty(session.user.getUserInfo()))) && 
					ListFind(getProperty("publicEvents"), nextEvent.getName()) == 0) {
				StructDelete(session, "user", false);
				arguments.eventContext.clearEventQueue();
				arguments.eventContext.redirectEvent('login');
			}
		</cfscript>
	</cffunction>

</cfcomponent>