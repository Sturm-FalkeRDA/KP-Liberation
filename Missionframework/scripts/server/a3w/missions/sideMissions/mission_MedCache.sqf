// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_MedCache.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, Sturm-Falke101
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_box3"];

_setupVars =
{
	_missionType = "Medical Cache";
	_locationsArray = [ForestMissionMarkers, MissionSpawnMarkers] select (ForestMissionMarkers isEqualTo []);
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_box1 = ["ACE_medicalSupplyCrate_advanced", _missionPos, true] call boxSetup;
	_box2 = ["ACE_medicalSupplyCrate", _missionPos, true] call boxSetup;
	[_box2, "mission_ACEMedical"] call fn_refillbox;
	_box3 = ["ACE_Box_Misc", _missionPos, true] call boxSetup;

	_aiGroup = createGroup GRLIB_side_enemy;
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroup;

	_missionPicture = "\A3\Static_f_gamma\data\ui\gear_StaticTurret_GMG_CA.paa";
	_missionHintText = "A medical cache has been spotted near the marker.";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _box3];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];
	_successHintMessage = "The supplies have been collected, well done.";
};

_this call sideMissionProcessor;
