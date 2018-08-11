/*////////////////////////////////////

Author: J.Shock

Function File: fn_Redress.sqf

Parameters:
	1- Units to be redress: (array)
	2- Use special units: (boolean)
	3- Side of units: (side)
	4- Loop through units: (boolean)

Description: The redressing process of the defined units.

Return: None

**DISCLAIMER**
Do not remove the header from this file. Any reproduced portions of this code
must include credits to the author (J.Shock).

*////////////////////////////////////

//if (isServer) then
//{
	private ["_units", "_unitSide", "_continuous", "_special", "_uniform", "_ATunits", "_Medunits", "_AAunits", "_weapon", "_goggle", "_head", "_vest", "_backpack", "_voice", "_sWeap", "_SLunits", "_slheadgear", "_SNunits", "_snghillie"];

	_units = (_this select 0);
	_special = (_this select 1);
	_unitSide = (_this select 2);
	_continuous = (_this select 3);
	_factionExclude = (_this select 4);

	if ((count _units) < 1) exitWith
	{
		if (_continuous) then
		{
			[_unitSide,_special,_factionExclude] spawn JSHK_fnc_countLoop;
		};
	};

	_ATunits = [];
	_Medunits = [];
	_AAunits = [];
	_SLunits = [];
	_SNunits = [];

	if (_special) then
	{
		{
			if (typeOf _x in JSHK_ATunits) then { _ATunits pushBack _x; };

			if (typeOf _x in JSHK_Medicalunits) then { _Medunits pushBack _x; };

			if (typeOf _x in JSHK_AAunits) then { _AAunits pushBack _x; };

			if (typeOf _x in JSHK_SLunits) then { _SLunits pushBack _x; };

			if (typeOf _x in JSHK_SNunits) then { _SNunits pushBack _x; };

		} foreach _units;
	};

//The redressing process...

	{
		_uniform = JSHK_uniformArr call BIS_fnc_selectRandom;
		//_weapon = JSHK_weaponArr call BIS_fnc_selectRandom;
		_weapon = primaryWeapon _x;
		_backpack = JSHK_backpackArr call BIS_fnc_selectRandom;
		_head = JSHK_headArr call BIS_fnc_selectRandom;
		_vest = JSHK_vestArr call BIS_fnc_selectRandom;
		_goggle = JSHK_goggleArr call BIS_fnc_selectRandom;
		_voice = JSHK_voiceArr call BIS_fnc_selectRandom;
		_slheadgear = JSHK_SLArr call BIS_fnc_selectRandom;
		_snghillie = JSHK_SNArr call BIS_fnc_selectRandom;
		_muzzles = getArray(configfile >> "cfgWeapons" >> (_weapon) >> "muzzles");
        _unit = _x;

		_x unassignItem "NVGoggles_OPFOR";
		_x unassignItem "NVGoggles";
		_x unassignItem "NVGoggles_INDEP";
		clearItemCargo _x;
		//clearWeaponCargo _x;
		//clearMagazineCargo _x;
		//removeallWeapons _x;
		removeAllHandgunItems _x;
		removeHeadgear _x;
		removeGoggles _x;
		removeUniform _x;
		removeBackpack _x;

		_x forceaddUniform _uniform;
		if (_backpack != "nopack") then {_x addBackpack _backpack;};
		_x addHeadgear _head;
		_x addVest _vest;
		if (_voice != "nogoggle") then {_x addGoggles _goggle;};
		//_x addGoggles _goggle;
		_x addMagazines ["HandGrenade", 2];
		_x addMagazines ["SmokeShell", 2];
		_x addMagazines ["1Rnd_HE_Grenade_shell", 2];
		if (_voice != "regularvoice") then {[_x, _voice] remoteExecCall ["setSpeaker", 0]};
		{
			if (_x=="this") then
			{
				_mags = getArray(configfile >> "cfgWeapons" >> (_weapon) >> "magazines");
				{
					_unit addMagazines [_x, 10];
				} forEach [_mags select 0];
			}
			else
			{
				_mags = getArray(configfile >> "cfgWeapons" >> (_weapon) >> _x >> "magazines");
				{
					_unit addMagazines [_x, 10];
				} forEach [_mags select 0];
			};
		} forEach _muzzles;

		_x addWeapon _weapon;
		_x setVariable ["JSHK_doneRedress",true];

	} foreach _units;

	if !(_special) exitWith
	{
		if (_continuous) then
		{
			[_unitSide,_special,_factionExclude] spawn JSHK_fnc_countLoop;
		};
	};

	if ((count _ATunits) > 0) then
	{
		{
			_sWeap = secondaryWeapon _x;
			_x removeWeapon (_sWeap);
			_x addWeapon "launch_RPG7_F";
			_x addBackpack "B_FieldPack_khk";
			_x addMagazine ["RPG7_F", 2];
		} foreach _ATunits;
	};

	if ((count _Medunits) > 0) then
	{
		{
			clearAllItemsFromBackpack _x;
			_x addItemToBackpack "Medikit";
			_x addItemToBackpack "FirstAidKit";
			_x addItemToBackpack "FirstAidKit";
			_x addItemToBackpack "FirstAidKit";
		} foreach _Medunits;
	};

	if ((count _AAunits) > 0) then
	{
		{
			_x addWeapon "launch_Titan_F";
			_x addBackpack "B_FieldPack_khk";
			_x addMagazine ["Titan_AA", 2];
		} foreach _AAunits;
	};

	if ((count _SLunits) > 0) then
	{
		{
			removeHeadgear _x;
			_x addHeadgear _slheadgear;
			_x addMagazines ["SmokeShell", 1];
			_x addItemToBackpack "FirstAidKit";
			_x addMagazines ["APERSBoundingMine_Range_Mag", 1];

		} foreach _SLunits;
	};

	if ((count _SNunits) > 0) then
	{
		{
			removeUniform _x;
			_x forceaddUniform _snghillie;
			_x assignItem "NVGoggles_OPFOR";
			_x addItemToBackpack "FirstAidKit";
			_x addMagazines ["APERSBoundingMine_Range_Mag", 1];

		} foreach _SNunits;
	};

	if (_continuous) then
	{
		[_unitSide,_special,_factionExclude] spawn JSHK_fnc_countLoop;
	};
//};
