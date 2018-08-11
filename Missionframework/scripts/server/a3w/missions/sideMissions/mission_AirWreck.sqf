// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_AirWreck.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_wreckPos", "_wreck", "_box1", "_box2", "_box3"];

_setupVars =
{
	_missionType = "Aircraft Wreck";
	_locationsArray = [ForestMissionMarkers, MissionSpawnMarkers] select (ForestMissionMarkers isEqualTo []);
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_wreckPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);

	// Class, Position, Fuel, Ammo, Damage, Special
	_wreck = createVehicle ["Land_Wreck_Heli_Attack_01_F", _wreckPos, [], 0, "NONE"];
	_box1 = ["Box_NATO_AmmoVeh_F", _missionPos, true] call boxSetup;
	_box2 = ["Box_NATO_WpsSpecial_F", _missionPos, true] call boxSetup;
	[_box2, "mission_USSpecial"] call fn_refillbox;
	_box3 = ["Box_NATO_AmmoVeh_F", _missionPos, true] call boxSetup;

	_aiGroup = createGroup GRLIB_side_enemy;
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroup;

	_missionPicture = "\A3\Air_F\Heli_Light_02\Data\UI\Heli_Light_02_CA.paa";
	_missionHintText = "A helicopter has come down under enemy fire!";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _box3, _wreck];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];
	deleteVehicle _wreck;
	_successHintMessage = "The airwreck supplies have been collected, well done.";
};

_this call sideMissionProcessor;
