<?xml version="1.0" encoding="UTF-8"?>
<!-- <cfsetting enablecfoutputonly="true" /> -->
<!DOCTYPE mach-ii PUBLIC "-//Mach-II//DTD Mach-II Configuration 1.9.0//EN"
	"http://www.mach-ii.com/dtds/mach-ii_1_9_0.dtd" >

<mach-ii version="1.9">
	<properties>
		<!-- datasource -->
		<property name="dsn" value="engage" />
		<!-- site URL -->
		<property name="siteURL" value="http://engage.local" />
		<!-- public events -->
		<property name="publicEvents" value="login,postLogin,twitterLoginCallback,main,logout,proposals,proposal,topicSuggestions,topicSuggestion,bugs" />
		<!-- social media app ids -->
		<property name="facebookKeys">
			<struct>
				<key name="applicationID" value="" />
				<key name="apiKey" value="" />
				<key name="applicationSecret" value="" />
			</struct>
		</property>
		<property name="twitterKeys">
			<struct>
				<key name="apiKey" value="" />
				<key name="consumerKey" value="" />
				<key name="consumerSecret" value="" />
				<key name="requestTokenURL" value="https://api.twitter.com/oauth/request_token" />
				<key name="accessTokenURL" value="https://api.twitter.com/oauth/access_token" />
				<key name="authorizeURL" value="https://api.twitter.com/oauth/authorize" />
				<key name="oauthCallbackURL" value="http://engage.local/index.cfm?event=twitterLoginCallback" />
			</struct>
		</property>
	</properties>
</mach-ii>
