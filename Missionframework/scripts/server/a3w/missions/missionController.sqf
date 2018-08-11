// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: missionController.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

private ["_controllerNum", "_tempController", "_controllerSuffix", "_missionsFolder", "_missionDelay", "_availableMissions", "_missionsList", "_nextMission"];

_controllerNum = param [0, 1, [0]];
_tempController = param [1, false, [false]];
_controllerSuffix = "";

if (_controllerNum > 1) then
{
	_controllerSuffix = format [" %1", _controllerNum];
};

diag_log format ["Started %1 Mission%2 Controller", MISSION_CTRL_TYPE_NAME, _controllerSuffix];

_missionsFolder = MISSION_CTRL_FOLDER;
[MISSION_CTRL_PVAR_LIST, MISSION_CTRL_FOLDER] call attemptCompileMissions;

//_missionDelay = MISSION_CTRL_DELAY;

while {true} do
{
	_nextMission = nil;
	
	while {isNil "_nextMission"} do
	{
		_availableMissions = [MISSION_CTRL_PVAR_LIST, { !(_x select 2) }] call BIS_fnc_conditionalSelect;
		// _availableMissions = MISSION_CTRL_PVAR_LIST; // If you want to allow multiple missions of the same type running along, uncomment this line and comment the one above

		if (count _availableMissions > 0) then {
			_missionsList = _availableMissions call generateMissionWeights;

			// Disable HostileHelicopter if no more city
			_opfor_city = count ([(call cityList)] call checkSpawn);
			if (_opfor_city <= 1) then {	
				_missionsList = [true, "mission_HostileHelicopter", _missionsList] call updateMissionsList;
				// Limit Town capture
				_opfor_sectors = (count sectors_allSectors) - (count blufor_sectors);
				if (_opfor_sectors >= 10) then {
						_missionsList = [true, "mission_TownInvasion", _missionsList] call updateMissionsList;
				} else {
					_missionsList = [false, "mission_TownInvasion", _missionsList] call updateMissionsList;
				};
			} else {
				_missionsList = [true, "mission_TownInvasion", _missionsList] call updateMissionsList;
				_missionsList = [false, "mission_HostileHelicopter", _missionsList] call updateMissionsList;
			};
			_nextMission = _missionsList call fn_selectRandomWeighted;
		};
		uiSleep 60;
	};

	_missionDelay =  (floor random [10,15,20] * 60) ;
	[MISSION_CTRL_PVAR_LIST, _nextMission, true] call setMissionState;
	diag_log format ["%1 Mission%2 waiting to run: %3", MISSION_CTRL_TYPE_NAME, _controllerSuffix, _nextMission];
	
	_msg = format
			[
				"<t color='%1' shadow='2' size='1.75'>%2 Objective%3</t><br/>" +
				"<t color='%1'>------------------------------</t><br/>" +
				"<t color='%4' size='1.0'>Starting in %5 minutes</t>",
				MISSION_CTRL_COLOR_DEFINE,
				MISSION_CTRL_TYPE_NAME,
				_controllerSuffix,
				subTextColor,
				_missionDelay / 60
			];
	[_msg, 0, 0, 3, 0, -1, 90]  remoteExec ["BIS_fnc_dynamicText",  -2];
	uiSleep _missionDelay;

	// these should be defined in the mission script
	private ["_setupVars", "_setupObjects", "_waitUntilMarkerPos", "_waitUntilExec", "_waitUntilCondition", "_waitUntilSuccessCondition", "_ignoreAiDeaths", "_failedExec", "_successExec"];

	[_controllerSuffix] call compile preprocessFileLineNumbers format ["scripts\server\a3w\missions\%1\%2.sqf", MISSION_CTRL_FOLDER, _nextMission];

	[MISSION_CTRL_PVAR_LIST, _nextMission, false] call setMissionState;

	if (_tempController) exitWith {};
	uiSleep 5;
};
