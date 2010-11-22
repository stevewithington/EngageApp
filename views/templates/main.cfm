<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<cfoutput>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>OpenCF Summit - Engage</title>
		<link rel="stylesheet" type="text/css" href="/library/css/base.css">
		<link rel="stylesheet" type="text/css" href="/library/css/siteStyle.css">
		<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
		<link type="text/css" href="/css/smoothness/jquery-ui-1.8.5.custom.css" rel="stylesheet" />
		<script type="text/javascript" src="/js/jquery-ui-1.8.5.custom.min.js"></script>
		<script type="text/javascript" src="http://connect.facebook.net/en_US/all.js##xfbml=1"></script>
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
		<div id="fixed960">
			<div id="header">
				<div id="mainnav">
				  	<div id="socialLinks">
						<a href="http://identi.ca/opencfsummit" target="_blank" title="Follow us on Identi.ca"><img src="/library/img/icon_identica.png" border="0" width="16" height="16" alt="Follow us on Identi.ca" /></a>	
						<a href="http://twitter.com/opencfsummit" target="_blank" title="Follow our tweets"><img src="/library/img/icon_twitter.png" border="0" width="16" height="16" alt="Follow our tweets" /></a>
						<a href="http://www.facebook.com/group.php?gid=133404713351556" target="_blank" title="Be social and 'Like' our Facebook page"><img src="/library/img/icon_facebook.png" border="0" width="16" height="16" alt="Be social and 'Like' our Facebook page" /></a>
						<a href="http://feeds.feedburner.com/OpenCfSummit" target="_blank" title="Grab our blog's RSS feed"><img src="/library/img/icon_rss-feed.png" border="0" width="16" height="16" alt="Grab our blog's RSS feed" /></a>
					</div> <!-- /socialLinks -->
				    <ul>
						<li><p><a href="http://opencfsummit.org/index.cfm/attend/" target="_blank">Attend</a></p></li>
						<li><p><a href="http://opencfsummit.org/index.cfm/schedule/" target="_blank">Schedule</a></p></li>
						<li><p><a href="http://opencfsummit.org/index.cfm/speakers/" target="_blank">Speakers</a></p></li>
						<li><p><a href="http://opencfsummit.org/index.cfm/partners/" target="_blank">Partners</a></p></li>
						<li><p><a href="http://opencfsummit.org/index.cfm/promote/" target="_blank">Promote</a></p></li>
						<li><p><a href="http://blog.opencfsummit.org" target="_blank">Blog</a></p></li>
						<li><p id="noBorder"><a href="http://opencfsummit.org/index.cfm/contact/" target="_blank">Contact</a></p></li>
				    </ul>
				</div> <!-- /mainnav -->
				<div id="logo"><h5><a href="http://opencfsummit.org">openCF Summit : Open development using ColdFusion (CFML)</a></h5></div>
			</div> <!-- /header -->
			<div id="banner"><!--- rotating banner image --->
				<p>February 21-23, 2011<br/>Dallas, TX</p>
			</div> <!-- /banner -->
			<div id="content">
				<div id="copy"><!--- main content section --->
					#event.getArg('content')#
				</div> <!-- /copy -->
				<div id="leftcol"><!--- left column --->
					<div id="userinfo">
					<cfif StructKeyExists(session, "user")>
						<cfif session.user.getOauthProvider() eq "Facebook">
							<img src="#session.user.getUserInfo().picture#" /><img src="/images/facebook_icon_small.jpg" width="16" height="16" /><br />
							<span class="smaller">
								<a href="#session.user.getOauthProfileLink()#" target="_blank">#session.user.getUserInfo().name#</a><br />
								<!---<a href="#BuildUrl('profile')#">Edit Profile</a>&nbsp;|&nbsp;---><a href="#BuildUrl('logout', 'facebookLogout=true')#">Logout</a>
							</span>
						<cfelseif session.user.getOauthProvider() eq "Twitter">
							<img src="#session.user.getUserInfo().profile_image_url#" /><img src="/images/twitter_logo_small.png" width="16" height="16" /><br />
							<span class="smaller">
								#session.user.getUserInfo().name#<br />
								(<a href="#session.user.getOauthProfileLink()#" target="_blank">@#session.user.getUserInfo().screen_name#</a>)<br />
								<!---<a href="#BuildUrl('profile')#">Edit Profile</a>&nbsp;|&nbsp;---><a href="#BuildUrl('logout')#">Logout</a>
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
						<cfif !StructKeyExists(session, "user") || session.user.getOauthProvider() neq "Twitter">
							<a href="#BuildUrl('postLogin', 'loginMethod=Twitter')#"><img src="/images/twitter_login.png" width="146" height="23" border="0" alt="Login With Twitter" title="Login With Twitter" /></a>
						<cfelse>
							<a href="#BuildUrl('logout')#"><img src="/images/twitter_logout.png" width="136" height="23" border="0" alt="Logout From Twitter" title="Logout From Twitter" /></a>
						</cfif>
					</cfif>
					</div>
					
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
						<cfif event.getArg('eventID', 0) neq 0>
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
					<script src="http://widgets.twimg.com/j/2/widget.js"></script>
					<script>
						new TWTR.Widget({
						  version: 2,
						  type: 'search',
						  search: '#getProperty("twitterWidgetSettings").searchTerm#',
						  interval: 6000,
						  title: '#getProperty("twitterWidgetSettings").title#',
						  subject: '#getProperty("twitterWidgetSettings").subject#',
						  width: #getProperty('twitterWidgetSettings').width#,
						  height: #getProperty('twitterWidgetSettings').height#,
						  theme: {
						    shell: {
						      background: '##8ec1da',
						      color: '##ffffff'
						    },
						    tweets: {
						      background: '##ffffff',
						      color: '##444444',
						      links: '##1985b5'
						    }
						  },
						  features: {
						    scrollbar: false,
						    loop: true,
						    live: true,
						    hashtags: true,
						    timestamp: true,
						    avatars: true,
						    toptweets: true,
						    behavior: 'default'
						  }
						}).render().start();
					</script>
					<br />
					<fb:activity width="184" height="240" recommendations="false"></fb:activity>
				</div> <!-- /leftcol -->
			</div> <!-- /content -->
			<div id="footer">
				&copy; #Year(Now())# OpenCF Summit
			</div> <!-- /footer -->
		</div> <!-- /fixed960 -->
	</body>
</html>
</cfoutput>
