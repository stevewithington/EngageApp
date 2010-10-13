<cfsilent>
	<cfset CopyToScope("${event.proposals}") />
</cfsilent>
<cfoutput>
<script type="text/javascript">
	$(function() { 
		$("##proposalsTable").tablesorter({widgets:['zebra']}); 
	});	
</script>

<h3>Proposals</h3>

<cfif event.isArgDefined('message')>
	<cfset message = event.getArg('message') />
	<div id="message" class="#message.class#">
		#message.text#
	</div>
</cfif>

<cfif proposals.RecordCount eq 0>
	<p><strong>No proposals!</strong></p>
<cfelse>
	<table id="proposalsTable" class="tablesorter" border="0" cellpadding="0" cellspacing="1">
		<thead>
			<tr>
				<th>Title</th>
				<th>Status</th>
				<th>Track</th>
				<th>Submitted</th>
				<th>Speakers</th>
			</tr>
		</thead>
		<tbody>
			<cfloop query="proposals">
				<tr>
					<td><a href="#BuildUrl('admin.proposal', 'proposalID=#proposals.proposal_id#')#">#proposals.title#</a></td>
					<td>#proposals.status#</td>
					<td>#proposals.track_title#</td>
					<td>#DateFormat(proposals.dt_created, "mm/dd/yyyy")# #TimeFormat(proposals.dt_created, "hh:mm TT")#</td>
					<td>&nbsp;</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</cfif>

<p>
	<a href="#BuildUrl('admin.proposalForm')#"><img src="images/icons/add.png" border="0" width="16" height="16" alt="Add Proposal" title="Add Proposal" /></a>&nbsp;
	<a href="#BuildUrl('admin.proposalForm')#">Add Proposal</a>
</p>

</cfoutput>