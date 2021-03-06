<cfcomponent
	displayname="User"
	output="false"
	hint="A bean which models the User form.">

<!--- This bean was generated by the Rooibos Generator with the following template:
Bean Name: User
Path to Bean: User
Extends: 
Call super.init(): false
Create cfproperties: false
Bean Template:
	userID numeric 0
	email string 
	name string
	oauthProvider string 
	oauthUID string 
	oauthProfileLink string
	userInfo struct #StructNew()#
	isRegistered boolean false
	isAdmin boolean false
	dtCreated date #CreateDateTime(1900,1,1,0,0,0)#
	dtUpdated date #CreateDateTime(1900, 1, 1, 0, 0, 0)#
	createdBy numeric 0
	updatedBy numeric 0
	isActive boolean false
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
	<cffunction name="init" access="public" returntype="User" output="false">
		<cfargument name="userID" type="numeric" required="false" default="0" />
		<cfargument name="email" type="string" required="false" default="" />
		<cfargument name="name" type="string" required="false" default="" />
		<cfargument name="oauthProvider" type="string" required="false" default="" />
		<cfargument name="oauthUID" type="string" required="false" default="" />
		<cfargument name="oauthProfileLink" type="string" required="false" default="" />
		<cfargument name="userInfo" type="struct" required="false" default="#StructNew()#" />
		<cfargument name="isRegistered" type="boolean" required="false" default="false" />
		<cfargument name="isAdmin" type="boolean" required="false" default="false" />
		<cfargument name="dtCreated" type="date" required="false" default="#CreateDateTime(1900,1,1,0,0,0)#" />
		<cfargument name="dtUpdated" type="date" required="false" default="#CreateDateTime(1900,1,1,0,0,0)#" />
		<cfargument name="createdBy" type="numeric" required="false" default="0" />
		<cfargument name="updatedBy" type="numeric" required="false" default="0" />
		<cfargument name="isActive" type="boolean" required="false" default="false" />

		<!--- run setters --->
		<cfset setUserID(arguments.userID) />
		<cfset setEmail(arguments.email) />
		<cfset setName(arguments.name) />
		<cfset setOauthProvider(arguments.oauthProvider) />
		<cfset setOauthUID(arguments.oauthUID) />
		<cfset setOauthProfileLink(arguments.oauthProfileLink) />
		<cfset setUserInfo(arguments.userInfo) />
		<cfset setIsRegistered(arguments.isRegistered) />
		<cfset setIsAdmin(arguments.isAdmin) />
		<cfset setDtCreated(arguments.dtCreated) />
		<cfset setDtUpdated(arguments.dtUpdated) />
		<cfset setCreatedBy(arguments.createdBy) />
		<cfset setUpdatedBy(arguments.updatedBy) />
		<cfset setIsActive(arguments.isActive) />

		<cfreturn this />
 	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setUserID" access="public" returntype="void" output="false">
		<cfargument name="userID" type="numeric" required="true" />
		<cfset variables.instance.userID = arguments.userID />
	</cffunction>
	<cffunction name="getUserID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.userID />
	</cffunction>

	<cffunction name="setEmail" access="public" returntype="void" output="false">
		<cfargument name="email" type="string" required="true" />
		<cfset variables.instance.email = trim(arguments.email) />
	</cffunction>
	<cffunction name="getEmail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.email />
	</cffunction>

	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfset variables.instance.name = trim(arguments.name) />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.name />
	</cffunction>

	<cffunction name="setOauthProvider" access="public" returntype="void" output="false">
		<cfargument name="oauthProvider" type="string" required="true" />
		<cfset variables.instance.oauthProvider = trim(arguments.oauthProvider) />
	</cffunction>
	<cffunction name="getOauthProvider" access="public" returntype="string" output="false">
		<cfreturn variables.instance.oauthProvider />
	</cffunction>

	<cffunction name="setOauthUID" access="public" returntype="void" output="false">
		<cfargument name="oauthUID" type="string" required="true" />
		<cfset variables.instance.oauthUID = trim(arguments.oauthUID) />
	</cffunction>
	<cffunction name="getOauthUID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.oauthUID />
	</cffunction>

	<cffunction name="setOauthProfileLink" access="public" returntype="void" output="false">
		<cfargument name="oauthProfileLink" type="string" required="true" />
		<cfset variables.instance.oauthProfileLink = trim(arguments.oauthProfileLink) />
	</cffunction>
	<cffunction name="getOauthProfileLink" access="public" returntype="string" output="false">
		<cfreturn variables.instance.oauthProfileLink />
	</cffunction>

	<cffunction name="setUserInfo" access="public" returntype="void" output="false">
		<cfargument name="userInfo" type="struct" required="true" />
		<cfset variables.instance.userInfo = arguments.userInfo />
	</cffunction>
	<cffunction name="getUserInfo" access="public" returntype="struct" output="false">
		<cfreturn variables.instance.userInfo />
	</cffunction>

	<cffunction name="setIsRegistered" access="public" returntype="void" output="false">
		<cfargument name="isRegistered" type="boolean" required="true" />
		<cfset variables.instance.isRegistered = arguments.isRegistered />
	</cffunction>
	<cffunction name="getIsRegistered" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.isRegistered />
	</cffunction>

	<cffunction name="setIsAdmin" access="public" returntype="void" output="false">
		<cfargument name="isAdmin" type="boolean" required="true" />
		<cfset variables.instance.isAdmin = arguments.isAdmin />
	</cffunction>
	<cffunction name="getIsAdmin" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.isAdmin />
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

	<cffunction name="setIsActive" access="public" returntype="void" output="false">
		<cfargument name="isActive" type="boolean" required="true" />
		<cfset variables.instance.isActive = arguments.isActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.isActive />
	</cffunction>

	<cffunction name="validate" access="public" returntype="struct" output="false">
		<cfset var errors = StructNew() />
		
		<cfif Len(Trim(getOauthProvider())) eq 0>
			<cfset errors.oauthProvider = "An OAuth provider is required" />
		</cfif>
		
		<cfif Len(Trim(getOauthUID)) eq 0>
			<cfset errors.oauthUID = "An OAuth UID is required" />
		</cfif>
		
		<cfif Len(Trim(getOauthProfileLink)) eq 0>
			<cfset errors.oauthProfileLink = "An OAuth Profile Link is required" />
		</cfif>
		
		<cfreturn errors />
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