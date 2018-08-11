// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: missionHint.sqf
//	@file Author: AgentRev
//	@file Created: 09/01/2014 20:30

private ["_title", "_subTitle", "_picture", "_text", "_titleColor", "_msg"];

_title = param [0, "?"];
_subtitle = param [1, ""];
_picture = param [2, "", [""]];
_text = param [3, ""];
_titleColor = param [4, "", [""]];

_msg = format
	[
		"<t color='%5' shadow='2' size='1.75'>%1</t><br/>" +
		"<t color='%5'>--------------------------------</t><br/>" +
		(if (_subtitle != "") then { "<t size='1.25'>%2</t><br/>" } else { "" }) +
		(if (_picture != "") then { "<img size='5' image='%3'/><br/>" } else { "" }) +
		"%4",
		_title,
		_subtitle,
		_picture,
		_text,
		_titleColor
	];
//[_msg, 0, 0, 5, 0, -1, 90]  remoteExec ["BIS_fnc_dynamicText",  -2];
["New notification", _msg, [0, 0, 0, 1], [1, 1, 0, 1]] remoteExec ["Haz_fnc_createNotification",  -2];
uiSleep 10;
//["New notification", "This is a notification!", [0, 0, 0, 1], [1, 1, 0, 1]] spawn Haz_fnc_createNotification;
//["<img size='1' align='right' color='#ffffff' image='\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa'/> New notification", "This is a notification!"] spawn Haz_fnc_createNotification;
