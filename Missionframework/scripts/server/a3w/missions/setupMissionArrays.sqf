// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: setupMissionArrays.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

SideMissions = []; 	// Mission filename, weight

if (count ([(call cityList)] call checkSpawn) <= 1) then {
	SideMissions append [["mission_TownInvasion", 1]];
} else {
	SideMissions append [["mission_HostileHelicopter", 1]];
};

MissionSpawnMarkers = (allMapMarkers select {["Mission_", _x] call fn_startsWith;}) apply {[_x, false]};
ForestMissionMarkers = (allMapMarkers select {["ForestMission_", _x] call fn_startsWith;}) apply {[_x, false]};
//SunkenMissionMarkers = (allMapMarkers select {["SunkenMission_", _x] call fn_startsWith}) apply {[_x, false]};

// Filters BLU sectors
MissionSpawnMarkers = [MissionSpawnMarkers] call checkSpawn;
ForestMissionMarkers = [ForestMissionMarkers] call checkSpawn;
// LIBERATION SF
// LIBERATION uses a new system that doesn't need manual markers, only Altis_SF is set up to support the old system. New system: _spawn_marker = [2000,999999,false] call F_findOpforSpawnPoint;

if !(ForestMissionMarkers isEqualTo []) then {
	SideMissions append
	[
		["mission_AirWreck", 1],
		["mission_WepCache", 1],
		["mission_MedCache", 1]
	];
};

{ _x set [2, false] } forEach SideMissions;
