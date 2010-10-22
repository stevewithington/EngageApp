<cfoutput>
<html>
	<head>
		<title>OpenCF Summit - "Engage"</title>
		<link type="text/css" href="css/main.css"  rel="stylesheet" media="screen" />
	<cfif event.getArg("includejQuery", false)>
		<link type="text/css" href="css/smoothness/jquery-ui-1.8.5.custom.css" rel="stylesheet" />
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui-1.8.5.custom.min.js"></script>
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
			<p>Welcome User!<br />
			<span style="font-size:10px;"><a href="#BuildUrl('user.profile')#">Edit profile</a> | <a href="#BuildUrl('logout')#">Logout</a></span></p>
			
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
		
		<div id="content">
			#event.getArg('content')#
		</div>
	</body>
</html>
</cfoutput>