<cfcomponent 
		displayname="SocialListener" 
		output="false" 
		extends="MachII.framework.Listener" 
		depends="socialService">

	<cffunction name="configure" access="public" output="false" returntype="void">
	</cffunction>
	
	<cffunction name="tweet" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfscript>
			var message = StructNew();
			var errors = StructNew();
			
			message.text = "Your tweet was tweeted!";
			message.class = "success";
			
			try {
				getSocialService().tweet(getProperty('twitterKeys').consumerKey, 
											getProperty('twitterKeys').consumerSecret, 
											session.user.getUserInfo().accessToken, 
											arguments.event.getArg('tweetText'));
				arguments.event.setArg("message", message);
			} catch (Any e) {
				errors.systemError = e.Message & " - " & e.Detail;
				message.text = "A system error occurred:";
				message.class = "error";
				arguments.event.setArg("errors", errors);
				arguments.event.setArg("message", message);
			}
			
			redirectEvent(arguments.event.getArg('nextEvent'), '', true);
		</cfscript>
	</cffunction>
	
	<cffunction name="postToFacebookWall" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfscript>
			var message = StructNew();
			var errors = StructNew();
			
			message.text = "Your message was posted to your wall!";
			message.class = "success";
			
			try {
				getSocialService().postToFacebookWall(session.user.getUserInfo().id, 
														session.user.getUserInfo().accessToken, 
														arguments.event.getArg('tweetText'));
				arguments.event.setArg("message", message);
			} catch (Any e) {
				errors.systemError = e.Message & " - " & e.Detail;
				message.text = "A system error occurred:";
				message.class = "error";
				arguments.event.setArg("errors", errors);
				arguments.event.setArg("message", message);
			}
			
			redirectEvent(arguments.event.getArg('nextEvent'), '', true);
		</cfscript>
	</cffunction>

</cfcomponent>