<cfcomponent
	displayname="Category"
	output="false"
	hint="A bean which models the Category form.">

<!--- This bean was generated by the Rooibos Generator with the following template:
Bean Name: Category
Path to Bean: Category
Extends: 
Call super.init(): false
Create cfproperties: false
Bean Template:
	categoryID numeric 0
	eventID numeric 0
	category string 
	dtCreated date #CreateDateTime(1900, 1, 1, 0, 0, 0)#
	dtUpdated date #CreateDateTime(1900, 1, 1, 0, 0, 0)#
	createdBy numeric 0
	updatedBy numeric 0
Create getMemento method: false
Create setMemento method: false
Create setStepInstance method: false
Create validate method: true
Create validate interior: false
Date Format: 
--->

	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Category" output="false">
		<cfargument name="categoryID" type="numeric" required="false" default="0" />
		<cfargument name="eventID" type="numeric" required="false" default="0" />
		<cfargument name="category" type="string" required="false" default="" />
		<cfargument name="dtCreated" type="date" required="false" default="#CreateDateTime(1900, 1, 1, 0, 0, 0)#" />
		<cfargument name="dtUpdated" type="date" required="false" default="#CreateDateTime(1900, 1, 1, 0, 0, 0)#" />
		<cfargument name="createdBy" type="numeric" required="false" default="0" />
		<cfargument name="updatedBy" type="numeric" required="false" default="0" />

		<!--- run setters --->
		<cfset setCategoryID(arguments.categoryID) />
		<cfset setEventID(arguments.eventID) />
		<cfset setCategory(arguments.category) />
		<cfset setDtCreated(arguments.dtCreated) />
		<cfset setDtUpdated(arguments.dtUpdated) />
		<cfset setCreatedBy(arguments.createdBy) />
		<cfset setUpdatedBy(arguments.updatedBy) />

		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="validate" access="public" returntype="errorHandler" output="false">
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setCategoryID" access="public" returntype="void" output="false">
		<cfargument name="categoryID" type="numeric" required="true" />
		<cfset variables.instance.categoryID = arguments.categoryID />
	</cffunction>
	<cffunction name="getCategoryID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.categoryID />
	</cffunction>

	<cffunction name="setEventID" access="public" returntype="void" output="false">
		<cfargument name="eventID" type="numeric" required="true" />
		<cfset variables.instance.eventID = arguments.eventID />
	</cffunction>
	<cffunction name="getEventID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.eventID />
	</cffunction>

	<cffunction name="setCategory" access="public" returntype="void" output="false">
		<cfargument name="category" type="string" required="true" />
		<cfset variables.instance.category = trim(arguments.category) />
	</cffunction>
	<cffunction name="getCategory" access="public" returntype="string" output="false">
		<cfreturn variables.instance.category />
	</cffunction>

	<cffunction name="setDtCreated" access="public" returntype="void" output="false">
		<cfargument name="dtCreated" type="date" required="true" />
		<cfset variables.instance.dtCreated = arguments.dtCreated />
	</cffunction>
	<cffunction name="getDtCreated" access="public" returntype="date" output="false">
		<cfreturn variables.instance.dtCreated />
	</cffunction>

	<cffunction name="setDtUpdated" access="public" returntype="void" output="false">
		<cfargument name="dtUpdated" type="date" required="true" />
		<cfset variables.instance.dtUpdated = arguments.dtUpdated />
	</cffunction>
	<cffunction name="getDtUpdated" access="public" returntype="date" output="false">
		<cfreturn variables.instance.dtUpdated />
	</cffunction>

	<cffunction name="setCreatedBy" access="public" returntype="void" output="false">
		<cfargument name="createdBy" type="numeric" required="true" />
		<cfset variables.instance.createdBy = arguments.createdBy />
	</cffunction>
	<cffunction name="getCreatedBy" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.createdBy />
	</cffunction>

	<cffunction name="setUpdatedBy" access="public" returntype="void" output="false">
		<cfargument name="updatedBy" type="numeric" required="true" />
		<cfset variables.instance.updatedBy = arguments.updatedBy />
	</cffunction>
	<cffunction name="getUpdatedBy" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.updatedBy />
	</cffunction>

	<!---
	DUMP
	--->
	<cffunction name="dump" access="public" output="true" return="void">
	<cfargument name="abort" type="boolean" default="FALSE" />
		<cfdump var="#variables.instance#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>
</cfcomponent>