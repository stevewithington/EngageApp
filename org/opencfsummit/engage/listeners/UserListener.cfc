<cfcomponent 
		displayname="UserListener" 
		output="false" 
		extends="MachII.framework.Listener" 
		depends="userService">

	<cffunction name="configure" access="public" output="false" returntype="void">
	</cffunction>
	
	<cffunction name="login" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfscript>
			var cookiePairs = 0;
			var cookieVals = 0;
			var temp = 0;
			var userInfo = 0;
			var facebookInfo = 0;
			var facebookPicture = 0;
			var user = getUserService().getUserBean();
			var requestString = 0;
			var twitter = 0;
			var requestToken = 0;
			var accessToken = 0;
			var nextEventArgs = StructNew();
		</cfscript>
		
		<cfif StructKeyExists(cookie, "fbs_#getProperty('facebookKeys').applicationID#")>
			<!--- grab the user info, check to see if we have in the db --->
			<cfset cookiePairs = ListToArray(cookie["fbs_#getProperty('facebookKeys').applicationID#"], "&") />
			<cfset cookieVals = StructNew() />
			
			<cfloop array="#cookiePairs#" index="temp">
				<cfset cookieVals[ListFirst(temp, "=")] = ListLast(temp, "=") />
			</cfloop>
			
			<cfhttp url="https://graph.facebook.com/me" result="facebookInfo">
				<cfhttpparam type="url" name="access_token" value="#cookieVals['access_token']#" />
				<cfhttpparam type="header" name="mimetype" value="text/javascript" />
			</cfhttp>
			
			<cfset userInfo = DeserializeJSON(facebookInfo.FileContent) />
			
			<cfhttp url="https://graph.facebook.com/#ListLast(userInfo.link, '/')#?fields=picture" result="facebookPicture">
				<cfhttpparam type="url" name="access_token" value="#cookieVals['access_token']#" />
				<cfhttpparam type="header" name="mimetype" value="text/javascript" />
			</cfhttp>
			
			<cfcookie name="userInfo" value="Facebook|#userInfo.id#">
			
			<cfscript>
				userInfo.picture = DeserializeJSON(facebookPicture.FileContent).picture;
				user.setOauthProvider("Facebook");
				user.setOauthUID(userInfo.id);
				user.setOauthProfileLink(userInfo.link);
				user.setEmail(userInfo.email);
				user.setName(userInfo.name);
				
				if (!getUserService().userExists(userInfo.id, "Facebook")) {
					getUserService().saveUser(user);
				} else {
					getUserService().getUser(user);
				}
				
				user.setUserInfo(userInfo);
				
				session.user = user;
				
				redirectEvent('main');
			</cfscript>
		<cfelseif arguments.event.getArg("loginMethod", "") eq "Twitter">
			<cfscript>
				twitter = CreateObject("java", "twitter4j.Twitter").init();
				twitter.setOAuthConsumer(getProperty('twitterKeys').consumerKey, getProperty('twitterKeys').consumerSecret);
				requestToken = twitter.getOAuthRequestToken(getProperty('twitterKeys').oauthCallbackURL);
				
				getPageContext().getRequest().getSession().setAttribute("twitter", twitter);
				getPageContext().getRequest().getSession().setAttribute("requestToken", requestToken);
				
				getPageContext().getResponse().sendRedirect(requestToken.getAuthenticationURL());
			</cfscript>
		</cfif>
	</cffunction>
	
	<cffunction name="twitterLoginCallback" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfscript>
			var twitter = getPageContext().getRequest().getSession().getAttribute("twitter");
			var requestToken = getPageContext().getRequest().getSession().getAttribute("requestToken");
			var verifier = arguments.event.getArg("oauth_verifier");
			var accessToken = twitter.getOAuthAccessToken(requestToken, verifier);
			var user = getUserService().getUserBean();
			var userInfo = 0;
		</cfscript>
		
		<cfhttp url="https://api.twitter.com/1/users/show.json?screen_name=#accessToken.getScreenName()#" method="get" />
		
		<cfset userInfo = DeserializeJSON(CFHTTP.FileContent) />
		
		<cfcookie name="userInfo" value="Twitter|#userInfo.screen_name#" />
		
		<cfscript>
			user.setOauthProvider('Twitter');
			user.setOauthUID(accessToken.getScreenName());
			user.setOauthProfileLink('http://www.twitter.com/#accessToken.getScreenName()#');
			user.setName(userInfo.name);
			
			if (!getUserService().userExists(accessToken.getScreenName(), "Twitter")) {
				getUserService().saveUser(user);
			} else {
				getUserService().getUser(user);
			}
			
			getPageContext().getRequest().removeAttribute("requestToken");
			
			user.setUserInfo(userInfo);
			
			session.user = user;
						
			redirectEvent('main');
		</cfscript>
	</cffunction>
	
	<cffunction name="logout" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset StructDelete(session, "user", false) />
		<cfcookie name="userInfo" expires="NOW" />
		
		<cfset redirectEvent('login', '', true) />
	</cffunction>
</cfcomponent>