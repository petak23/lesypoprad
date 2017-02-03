/*
Copyright (c) 2011, Ing. Peter VOJTECH ml. 
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	config.language = 'sk';
	// config.uiColor = '#AADC6E';
	// originál toolbaru je uložený v ..\ckeditor\_source\plugins\toolbar\plugin.js
	//config.toolbar = 'MyToolbar';
	config.toolbar_AdminToolbar =
[
	['Source','-','Templates'],
	['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
	['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
	'/',
	['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
	['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	['Link','Unlink','Anchor'],
	['Image','Table','HorizontalRule','Smiley','SpecialChar'],
	'/',
	['Format','-','TextColor','BGColor','ShowBlocks']
];
    config.toolbar_UserToolbar =
[
        ['Source'],
	['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
	['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
	'/',
	['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
	['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	['Link','Unlink','Anchor'],
	['Image','Table','HorizontalRule','Smiley','SpecialChar'],
	'/',
	['Format','-','TextColor','BGColor','About']
];
    config.toolbar_UserToolbarSmall =
[
	['Bold','Italic','Underline','Strike','-','Subscript','Superscript','-','NumberedList','BulletedList'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	['Link','Image','Table','HorizontalRule','Smiley','SpecialChar'],
	'/',
	['Format','-','TextColor','BGColor','-','Cut','Copy','Paste','PasteText','SpellChecker','-','Undo','Redo']
];
	config.format_tags = 'p;h2;h3;h4';
	config.skin = 'kama';
};
