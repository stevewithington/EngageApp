<cfsilent>
	<cfparam name="loggedIn" default="false" type="boolean" />
</cfsilent>
<cfoutput>
<html>
	<head>
		<title>OpenCF Summit - "Engage"</title>
		<link type="text/css" href="/css/main.css"  rel="stylesheet" media="screen" />
		<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
		<link type="text/css" href="/css/smoothness/jquery-ui-1.8.5.custom.css" rel="stylesheet" />
		<script type="text/javascript" src="/js/jquery-ui-1.8.5.custom.min.js"></script>
	<cfif event.getArg("includeTimePicker", false)>
		<script type="text/javascript" src="/js/timepicker.mod.js"></script>
	</cfif>
	<cfif event.getArg("includeTableSorter", false)>
		<link type="text/css" href="/css/blue/style.css" rel="stylesheet" />
		<script type="text/javascript" src="/js/jquery.tablesorter.min.js"></script>
		<script type="text/javascript" src="/js/jquery.tablesorter.pager.js"></script>
	</cfif>
	<cfif event.getArg("includeCKEditor", false)>
		<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
	</cfif>
	<cfif event.getArg("includeColorPicker", false)>
		<link type="text/css" href="/css/colorpicker.css" rel="stylesheet" />
		<script type="text/javascript" src="/js/jquery.js"></script>
		<script type="text/javascript" src="/js/colorpicker.js"></script>
		<script type="text/javascript" src="/js/eye.js"></script>
		<script type="text/javascript" src="/js/utils.js"></script>
	</cfif>
	</head>
	<body>
		<div id="masthead">
			<h2>OpenCF Summit - "Engage"</h2>
		</div>
		
		<div id="leftnav">
			<cfif StructKeyExists(session, "user")>
				<cfif session.user.getOauthProvider() == "Facebook">
					<img src="#session.user.getUserInfo().picture#" /><br />
					<span class="smaller">
						<a href="#session.user.getOauthProfileLink()#" target="_blank">#session.user.getUserInfo().name#</a><br />
						<a href="#BuildUrl('profile')#">Edit Profile</a>&nbsp;|&nbsp;<a href="#BuildUrl('logout', 'facebookLogout=true')#">Logout</a>
					</span>
				<cfelseif session.user.getOauthProvider() == "Twitter">
					<img src="#session.user.getUserInfo().profile_image_url#" /><br />
					<span class="smaller">
						#session.user.getUserInfo().name#<br />
						(<a href="#session.user.getOauthProfileLink()#" target="_blank">@#session.user.getUserInfo().screen_name#</a>)<br />
						<a href="#BuildUrl('profile')#">Edit Profile</a>&nbsp;|&nbsp;<a href="#BuildUrl('logout')#">Logout</a>
					</span>
				</cfif>
			<cfelse>
				<fb:login-button perms="publish_stream,create_event,rsvp_event,offline_access,user_hometown,user_location,user_online_presence,user_status,user_website,email" autologoutlink="true"></fb:login-button>
				<div id="fb-root"></div>
				<script>
					window.fbAsyncInit = function() {
						FB.init({appId: '#getProperty('facebookKeys').applicationID#', 
									status: true, cookie: true, xfbml: true});
						FB.Event.subscribe('auth.sessionChange', function(response) {
							if (response.session) {
								// user logged in
								window.location.replace('/index.cfm/postLogin');
							} else {
								// user logged out
								window.location.replace('/index.cfm/login');
							}
						});
					<cfif !StructKeyExists(session, "user")>
						FB.logout(function(response){});
					</cfif>
					};
				  	(function() {
						var e = document.createElement('script');
						e.type = 'text/javascript';
						e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
						e.async = true;
						document.getElementById('fb-root').appendChild(e);
					}());
				</script>
				<br />
				<cfif !StructKeyExists(session, "user") || session.user.getOauthProvider() != "Twitter">
					<a href="#BuildUrl('postLogin', 'loginMethod=Twitter')#"><img src="/images/twitter_login.png" width="146" height="23" border="0" alt="Login With Twitter" title="Login With Twitter" /></a>
				<cfelse>
					<a href="#BuildUrl('logout')#"><img src="/images/twitter_logout.png" width="136" height="23" border="0" alt="Logout From Twitter" title="Logout From Twitter" /></a>
				</cfif>
			</cfif>
			
			<p><strong><a href="#BuildUrl('proposals')#">Proposals</a></strong></p>
			<cfif StructKeyExists(session, "user")>
				<ul>
					<li><a href="#BuildUrl('proposalForm')#">Submit a Proposal</a></li>
					<li><a href="#BuildUrl('proposals', 'userID=#session.user.getUserID()#')#">My Proposals</a></li>
				</ul>
			<cfelse>
				<ul>
					<li><a href="#BuildUrl('login')#">Login to submit, comment on, and vote on proposals!</a></li>
				</ul>
			</cfif>
			
			<p><strong><a href="#BuildUrl('topicSuggestions')#">Topic Suggestions</strong></p>
			<cfif StructKeyExists(session, "user")>
				<ul>
					<li><a href="#BuildUrl('topicSuggestionForm')#">Submit a Topic Suggestion</a></li>
					<li><a href="#BuildUrl('topicSuggestions', 'userID=#session.user.getUserID()#')#">My Topic Suggestions</a></li>
				</ul>
			<cfelse>
				<ul>
					<li><a href="#BuildUrl('login')#">Login to submit, comment on, and vote on topic suggestions!</a></li>
				</ul>
			</cfif>
		<cfif StructKeyExists(session, "user") && session.user.getIsAdmin()>
			<p><strong>Administer</strong></p>
			<ul>
				<li><a href="#BuildUrl('admin.events')#">Events</a></li>
			<cfif event.getArg('eventID', 0) != 0>
				<li><a href="#BuildUrl('admin.event', 'id=#event.getArg('eventID')#')#">This Event</li>
				<ul>
					<li><a href="#BuildUrl('admin.sessions')#">Sessions</a></li>
					<li>
						<a href="#BuildUrl('proposals')#">Proposals</a><br />
						<span style="font-size:10px;">[ <a href="">bulk edit</a> | <a href="">export csv</a> ]</span>
					</li>
					<li><a href="#BuildUrl('admin.tracks')#">Tracks</a></li>
					<li><a href="#BuildUrl('admin.sessionTypes')#">Session Types</a></li>
					<li><a href="#BuildUrl('admin.rooms')#">Rooms</a></li>
					<li><a href="#BuildUrl('admin.scheduleItems')#">Schedule Items</a></li>
				</ul>
			</cfif>
				<li><a href="#BuildUrl('admin.users')#">Users</a></li>
				<li><a href="#BuildUrl('admin.snippets')#">Snippets</a></li>
				<li><a href="#BuildUrl('admin.comments')#">Comments</a></li>
			</ul>
		</cfif>
		</div>
		
		<div id="content">
			#event.getArg('content')#
		</div>

	</body>
</html>
</cfoutput>