// Setup Ammo Box

if (!isServer) exitWith {};
params ["_type", "_pos", "_locked"]; 
private ["_box"];

_box = createVehicle [_type, _pos, [], 5, "None"];
_box setDir random 360;
_box addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

if (_type in  [ammobox_o_typename, ammobox_b_typename]) then {
	[_box, [ "<t color='#FFFF00'>" + "-- REWARD" + "</t> <img size='2' image='res\ui_recycle.paa'/>",
			"scripts\client\actions\do_recycle.sqf", "", -900, true, true, "", "
			(alive _target) && 
			(_target distance lhd > 1000) && 
			(_target distance ([] call F_getNearestFob) < GRLIB_fob_range) && 
			(_this distance _target < 7) && 
			!(_target getVariable 'R3F_LOG_disabled') &&
			!([player, 4] call fetch_permission )"]] remoteExec ["addAction", -2, true];
	//_box allowDamage false; 
};
if (isNil "_locked") then { _locked = false};

if (_locked) then {
	_box setVariable ["R3F_LOG_disabled", true, true];
} else {
	_box setVariable ["R3F_LOG_disabled", false, true];
};
_box;
