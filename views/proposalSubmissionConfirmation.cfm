<cfsilent>
	<cfset CopyToScope("${event.theEvent}")>
</cfsilent>
<cfoutput>
<h2>Thank You!</h2>

<p style="font-weight:bold;">
	Thanks for submitting <a href="#BuildUrl('proposal', 'proposalID=#event.getArg('proposalID')#')#">your proposal</a> 
	to #theEvent.getTitle()#!
</p>

<h3>Next Steps</h3>

<p>
	You'll hear back from us after #DateFormat(theEvent.getProposalDeadline(), "mmmm d")#, when proposal submissions close.
</p>

<h4>Register!</h4>

<p>Make sure to register for OpenCF Summit, and tell all your friends and colleagues to do the same!</p>

<h4>Get to Garland</h4>

<p>Check out the <a href="http://www.opencfsummit.org/index.cfm/attend">attend page</a> for useful travel information.</p>

<h4>Web Badges</h4>

<p>
	Share your submission! Help us get the word out about the conference with these handy badges. Just copy the HTML code 
	associated with the image you want below and paste it on your website. Grab one now, or check out the 
	<a href="#BuildUrl('webBadges')#">web badges page</a> any time.
</p>

<h1>WEB BADGE IMAGE AND COPY/PASTE HTML HERE</h1>

</cfoutput>