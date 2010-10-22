/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	config.toolbar = 'customToolbar';
	
	config.toolbar_customToolbar = 
	[
		['Cut','Copy','Paste','PasteText','PasteFromWord'],
		['Bold','Italic','Strike'],
		['NumberedList','BulletedList','-','Outdent','Indent'],
		['Link','Unlink']
	];
	
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
};
