<cfcomponent 
		displayname="SocialService" 
		output="false">

	<cffunction name="init" access="public" output="false" returntype="SocialService">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="tweet" access="public" output="false" returntype="void">
		<cfargument name="consumerKey" type="string" required="true" />
		<cfargument name="consumerSecret" type="string" required="true" />
		<cfargument name="accessToken" type="any" required="true" />
		<cfargument name="tweetText" type="string" required="true" />
		
		<cfscript>
			var message = StructNew();
			var twitter = CreateObject("java", "twitter4j.Twitter").init();
			
			twitter.setOAuthConsumer(arguments.consumerKey, arguments.consumerSecret);
			twitter.setOAuthAccessToken(arguments.accessToken);
			
			if (Len(arguments.tweetText) gt 0) {
				twitter.updateStatus(tweetText);
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="postToFacebookWall" access="public" output="false" returntype="void">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="accessToken" type="string" required="true" />
		<cfargument name="wallPostText" type="string" required="true" />
		
		<cfset var result = 0 />
		
		<cfhttp url="https://graph.facebook.com/#arguments.userID#/feed" method="post" result="result">
			<cfhttpparam type="formField" name="access_token" value="#arguments.accessToken#" />
			<cfhttpparam type="formField" name="message" value="#arguments.wallPostText#" />
		</cfhttp>
	</cffunction>

</cfcomponent>