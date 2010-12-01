<cfsilent>
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfset CopyToScope("${event.theEvent}")>
</cfsilent>
<cfoutput>
<h2>Thank You!</h2>

<p style="font-weight:bold;">
	Thanks for submitting <a href="#BuildUrl('proposal', 'proposalID=#event.getArg('proposalID')#')#">your proposal</a> 
	to #theEvent.getTitle()#!
</p>

<cfif session.user.getOauthProvider() eq "Twitter">
	<cfset buttonLabel = "Tweet It!" />
	<cfset postEvent = "tweet" />
<cfelse>
	<cfset buttonLabel = "Add a Wall Post!" />
	<cfset postEvent = "postToFacebookWall" />
</cfif>
<cfif event.isArgDefined("proposal")>
	<cfset tweetText = "I just submitted [] for #getProperty('eventName')# #getProperty('eventYear')#. #getProperty('shortSiteURL')#" />
	<cfset shortTopic = event.getArg('proposal').getTitle() />
	<cfif session.user.getOauthProvider() eq "Twitter">
		<cfset label = "Why not Tweet it?" />
		<cfset shortTopic = left(event.getArg('proposal').getTitle(),142 - len(tweetText)) />
	<cfelse>
		<cfset label = "Why not add a wall post?" />
		<cfset tweetText = replace(tweetText,getProperty('shortSiteURL'),getProperty('siteURL')) />
		<cfset shortTopic = """" & shortTopic & """" />
	</cfif>
	<cfset tweetText = replace(tweetText,"[]",shortTopic) />
<cfelse>						
	<cfset tweetText = "I just voted for my favorite session proposals for #getProperty('eventName')# #getProperty('eventYear')#. Why not cast your votes now? #getProperty('siteURL')#" />
	<cfif session.user.getOauthProvider() eq "Twitter">
		<cfset label = "Why not Tweet about it and encourage others to vote too?" />
	<cfelse>
		<cfset label = "Why not add a wall post and encourage others to vote too?" />
	</cfif>
</cfif>
<form:form actionEvent="#postEvent#">
	<br />
	#label#<br />
	<form:textarea name="tweetText" rows="3" cols="70" value="#tweetText#" /><br />
	<form:button name="submit" value="#buttonLabel#" />
	<form:hidden name="nextEvent" value="proposals" />
</form:form>

<h3>Next Steps</h3>

<p>
	You'll hear back from us no later than #DateFormat(theEvent.getProposalDeadline(), "mmmm d")#, when proposal submissions close.
</p>

<h4>Register!</h4>

<p>Make sure to <a href="http://www.brownpapertickets.com/event/137534" target="_blank">register for OpenCF Summit</a>, and tell all your friends and colleagues to do the same!</p>

<h4>Get to Dallas</h4>

<p>Check out the <a href="http://www.opencfsummit.org/index.cfm/attend" target="_blank">attend page</a> for useful travel information.</p>

<!---
<h4>Web Badges</h4>

<p>
	Share your submission! Help us get the word out about the conference with these handy badges. Just copy the HTML code 
	associated with the image you want below and paste it on your website. Grab one now, or check out the 
	<a href="#BuildUrl('webBadges')#">web badges page</a> any time.
</p>
--->
</cfoutput>