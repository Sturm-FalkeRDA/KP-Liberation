// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileHelicopter.sqf
//	@file Author: JoSchaap, AgentRev

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_vehicleClass", "_vehicle", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_box1", "_box2"];

if (count ([(call cityList)] call checkSpawn) == 0) exitWith {};

_setupVars =
{
	_missionType = "Hostile Helicopter";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects =
{
//	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);
	_missionPos = markerPos ((([(call cityList)] call checkSpawn) call BIS_fnc_selectRandom) select 0);
	_vehicleClass = selectRandom ["B_Heli_Transport_03_F", "O_Heli_Attack_02_black_F", "O_Heli_Attack_02_dynamicLoadout_F", "O_Heli_Light_02_F", "O_Heli_Light_02_dynamicLoadout_F", "I_Heli_light_03_dynamicLoadout_F"];

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_variant", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_veh_array = [_position, _direction, _type, _aiGroup] call bis_fnc_spawnvehicle;
		_vehicle = _veh_array select 0;
		_vehicle flyInHeight 300;
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

/*
		// remove flares because it overpowers AI choppers
		if (_type isKindOf "Air") then
		{
			{
				if (["CMFlare", _x] call fn_findString != -1) then
				{
					_vehicle removeMagazinesTurret [_x, [-1]];
				};
			} forEach getArray (configFile >> "CfgVehicles" >> _type >> "magazines");
		};
*/
		//[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup GRLIB_side_enemy;
	//_aiGroup setCombatMode "WHITE"; // Defensive behaviour
	_aiGroup setCombatMode "RED"; // Agressive behaviour
	_aiGroup setBehaviour "AWARE";
	_aiGroup setFormation "STAG COLUMN";
	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };
	_aiGroup setSpeedMode _speedMode;

	_vehicle = [_vehicleClass, _missionPos, 0] call _createVehicle;
	_leader = effectiveCommander _vehicle;
	_aiGroup selectLeader _leader;

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "WHITE";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0,""]) >> "displayName");
	_missionHintText = format ["An armed <t color='%2'>%1</t> is patrolling the island. Intercept it and recover its cargo!", _vehicleName, sideMissionColor];
	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;
// _vehicle is automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed

	// wait until heli is down to spawn crates
	_vehicle spawn
	{
		_veh = _this;
		//Delete pilots
		{ deleteVehicle _x } forEach crew _veh;
		waitUntil
		{
			sleep 0.1;
			_pos = getPos _veh;
			(isTouchingGround _veh || _pos select 2 < 5) && {vectorMagnitude velocity _veh < [1,5] select surfaceIsWater _pos}
		};

		_wreckPos = (getPosATL _veh) vectorAdd ([[_veh call fn_vehSafeDistance, 0, 0], random 360] call BIS_fnc_rotateVector2D);
		_box1 = ["Box_East_AmmoVeh_F", _wreckPos, false] call boxSetup;
		_box2 = ["Box_East_AmmoVeh_F", _wreckPos, false] call boxSetup;
	};

	_successHintMessage = "The sky is clear again, the enemy patrol was taken out! Ammo crates have fallen near the wreck.";
};

_this call sideMissionProcessor;
