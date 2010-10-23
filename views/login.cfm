<cfsilent>
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
</cfsilent>
<cfoutput>
<h3>Login</h3>

<cfif event.isArgDefined('message')>
	<cfset message = event.getArg('message') />
	<cfset errors = event.getArg('errors') />
	<div id="message" class="#message.class#">
		<h4>#message.text#</h4>
		<ul>
		<cfloop collection="#errors#" item="error">
			<li>#errors[error]#</li>
		</cfloop>
		</ul>
	</div>
</cfif>

<h4>Log in to OpenCF Summit using your Facebook, Twitter, or Google account!</h4>

<table border="0">
	<tr>
		<td>
			<fb:login-button perms="publish_stream,create_event,rsvp_event,offline_access,user_hometown,user_location,user_online_presence,user_status,user_website,email" autologoutlink="true"></fb:login-button>
			<div id="fb-root"></div>
			<script>
				window.fbAsyncInit = function() {
					FB.init({appId: '#getProperty('facebookKeys').applicationID#', 
										status: true, cookie: true, xfbml: true});
			  };
			  (function() {
			  	var e = document.createElement('script');
			    e.type = 'text/javascript';
			    e.src = document.location.protocol + 
			    	'//connect.facebook.net/en_US/all.js';
			    e.async = true;
			     document.getElementById('fb-root').appendChild(e);
					}());
			</script>
		</td>
		<td>
			<span id="twitterLogin"></span>
			<script type="text/javascript">
				twttr.anywhere(function (T) {
					T("##twitterLogin").connectButton();
				});
			</script>
		</td>
		<td>Google</td>
	</tr>
</table>

<cfdump var="#cookie#" />

<!---
<h4>Create an Account on OpenCF Summit</h4>

<p>
	We strongly encourage you to use your Facebook, Twitter, or 
	Google account to interact with OpenCF Summit, but if you 
	prefer you may 
	<a href="#BuildUrl('userForm')#">create a local account on OpenCF Summit</a>.
</p>

<h4>Log in With Your OpenCF Summit Account</h4>
<form:form actionEvent="processLoginForm">
<table width="100%" border="0">
	<tr>
		<td align="right">Email</td>
		<td><form:input id="email" name="email" size="60" maxlength="255" /></td>
	</tr>
	<tr>
		<td align="right">Password</td>
		<td><form:password id="password" name="password" size="20" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><form:button id="submit" name="submit" value="Login" /></td>
	</tr>
</table>
</form:form>
--->

<cfif StructKeyExists(cookie, "fbs_#getProperty('facebookKeys').applicationID#")>
	<cfset cookieVal = cookie["fbs_#getProperty('facebookKeys').applicationID#"] />
	<cfdump var="#cookieVal#" />
</cfif>
</cfoutput>

<!---
URL TO GET USER PROFILE INFO:
https://graph.facebook.com/me?access_token={access token from cookie}
--->
