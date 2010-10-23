<cfsilent>
	<cfparam name="loggedIn" default="false" type="boolean" />
</cfsilent>
<cfoutput>
<html>
	<head>
		<title>OpenCF Summit - "Engage"</title>
		<link type="text/css" href="css/main.css"  rel="stylesheet" media="screen" />
		<script src="http://platform.twitter.com/anywhere.js?id=#getProperty('twitterKeys').apiKey#&v=1" type="text/javascript"></script>
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<link type="text/css" href="css/smoothness/jquery-ui-1.8.5.custom.css" rel="stylesheet" />
		<script type="text/javascript" src="js/jquery-ui-1.8.5.custom.min.js"></script>
	<cfif event.getArg("includeTimePicker", false)>
		<script type="text/javascript" src="js/timepicker.mod.js"></script>
	</cfif>
	<cfif event.getArg("includeTableSorter", false)>
		<link type="text/css" href="css/blue/style.css" rel="stylesheet" />
		<script type="text/javascript" src="js/jquery.tablesorter.min.js"></script>
		<script type="text/javascript" src="js/jquery.tablesorter.pager.js"></script>
	</cfif>
	<cfif event.getArg("includeCKEditor", false)>
		<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
	</cfif>
	<cfif event.getArg("includeColorPicker", false)>
		<link type="text/css" href="css/colorpicker.css" rel="stylesheet" />
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="js/colorpicker.js"></script>
		<script type="text/javascript" src="js/eye.js"></script>
		<script type="text/javascript" src="js/utils.js"></script>
	</cfif>
	</head>
	<body>
		<div id="masthead">
			<h2>OpenCF Summit - "Engage"</h2>
		</div>
		
		<div id="leftnav">
			<cfif StructKeyExists(cookie, "twitter_anywhere_identity")>
				<cfset loggedIn = true />
				<script type="text/javascript">
					twttr.anywhere(function (T) {
						var currentUser,
								screenName,
								profileImage,
								profileImageTag;
				
						if (T.isConnected()) {
							currentUser = T.currentUser;
							screenName = currentUser.data('screen_name');
							profileImage = currentUser.data('profile_image_url');
							profileImageTag = "<img src='" + profileImage + "'/>";
							$('##userinfo').append('<br />' + profileImageTag + '<br />Welcome ' + screenName + '!<br /><span id="signout" style="font-size:10px;"><a href="">Logout of Twitter</a></span>');
							$("##signout").bind("click", function () {
								twttr.anywhere.signOut();
							});
						} else {
							T("##userinfo").connectButton();
						};
					});
				</script>
			<cfelseif StructKeyExists(cookie, "fbs_#getProperty('facebookKeys').applicationID#")>
				<cfset loggedIn = true />
			</cfif>
			
			<cfif loggedIn>
				<span id="userinfo"></span>
			</cfif>
			
			<p><strong><a href="#BuildUrl('proposals')#">Proposals</a></strong></p>
			<ul>
				<li><a href="#BuildUrl('user.favorites')#">My Favorites</a></li>
				<li><a href="#BuildUrl('user.proposals')#">My Proposals</a></li>
				<li><a href="#BuildUrl('proposalForm')#">Submit a Proposal</a></li>
			</ul>
			
			<p><strong>Administer</strong></p>
			<ul>
				<li><a href="#BuildUrl('admin.events')#">Events</a></li>
			<cfif event.getArg('eventID', 0) neq 0>
				<li><a href="#BuildUrl('admin.event', 'id=#event.getArg('eventID')#')#">This Event</li>
				<ul>
					<li><a href="#BuildUrl('admin.sessions')#">Sessions</a></li>
					<li>
						<a href="#BuildUrl('admin.proposals')#">Proposals</a><br />
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
		</div>
		
	<!--- if a user is logged in, show the user bar --->
	
	<cfif loggedIn>
		<div id="userBar">
		</div>
	</cfif>
		
		<div id="content">
			#event.getArg('content')#
		</div>
	</body>
</html>
</cfoutput>