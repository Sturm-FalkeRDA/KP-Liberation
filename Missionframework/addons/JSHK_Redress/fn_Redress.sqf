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
	private ["_units", "_unitSide", "_continuous", "_special", "_uniform", "_ATunits", "_Medunits", "_AAunits", "_weapon", "_goggle", "_head", "_vest", "_backpack", "_voice", "_sWeap", "_SLunits", "_slheadgear", "_SNunits", "_snghillie", "_HGunits", "_MGunits", "_HGweapon", "_MGweapon", "_Mgammo", "_nvgs"];

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
	_MGunits = [];
	_HGunits = [];

	if (_special) then
	{
		{
			if (typeOf _x in JSHK_ATunits) then { _ATunits pushBack _x; };

			if (typeOf _x in JSHK_Medicalunits) then { _Medunits pushBack _x; };

			if (typeOf _x in JSHK_AAunits) then { _AAunits pushBack _x; };

			if (typeOf _x in JSHK_SLunits) then { _SLunits pushBack _x; };

			if (typeOf _x in JSHK_SNunits) then { _SNunits pushBack _x; };

			if (typeOf _x in JSHK_MGunits) then { _MGunits pushBack _x; };

			if (typeOf _x in JSHK_HGunits) then { _HGunits pushBack _x; };

		} foreach _units;
	};

//The redressing process...
// LIBERATION SF The engine solution selectRandomWeighted runs 50% slower than selectRandom in this instance. (0.0036 vs 0.0024) That being said, the original function ran at 0.0078ms.
// TODO Implement
	{
		_uniform = selectRandomWeighted JSHK_uniformArr;
		_weapon = selectRandomWeighted JSHK_weaponArr;
		//_weapon = primaryWeapon _x;
		_backpack = selectRandomWeighted JSHK_backpackArr;
		_head = selectRandomWeighted JSHK_headArr;
		_vest = selectRandomWeighted JSHK_vestArr;
		_goggle = selectRandomWeighted JSHK_goggleArr;
		//_voice = selectRandomWeighted JSHK_voiceArr;
		_slheadgear = selectRandomWeighted JSHK_SLArr;
		_snghillie = selectRandom JSHK_SNArr;
		_HGweapon = selectRandomWeighted JSHK_HGweaponArr;
		_MGweapon = selectRandomWeighted JSHK_MGweaponArr;
		_muzzles = getArray(configfile >> "cfgWeapons" >> (_weapon) >> "muzzles");
        _unit = _x;

		/*_nvgs = hmd _x;
		if !(_nvgs isEqualTo "") then {
		   _x unassignItem _nvgs;
			 _x removeItem _nvgs;
		};*/
		// I think these commands will silently fail and cost less time compared to an if statement, so test performance when you get the chance.
		// https://community.bistudio.com/wiki/unlinkItem
		_x unassignItem "NVGoggles_OPFOR";
		_x unassignItem "NVGoggles";
		_x unassignItem "NVGoggles_INDEP";
		clearItemCargo _x;
		clearWeaponCargo _x;
		clearMagazineCargo _x;
		removeallWeapons _x;
		removeAllHandgunItems _x;
		removeHeadgear _x;
		removeGoggles _x;
		removeUniform _x;
		removeBackpack _x;

		_x forceaddUniform _uniform;
		//if (_backpack != "nopack") then {_x addBackpack _backpack;};
		_x addBackpack _backpack;
		_x addHeadgear _head;
		_x addVest _vest;
		_x addGoggles _goggle;
		//_x addGoggles _goggle;
		_x addMagazines ["HandGrenade", 2];
		_x addMagazines ["SmokeShell", 2];
		_x addMagazines ["1Rnd_HE_Grenade_shell", 2];
		//if (_voice != "regularvoice") then {[_x, _voice] remoteExecCall ["setSpeaker", 0]};
		{
			if (_x=="this") then
			{
				_mags = getArray(configfile >> "cfgWeapons" >> (_weapon) >> "magazines");
				{
					_unit addMagazines [_x, 8];
				} forEach [_mags select 0];
			}
			else
			{

				{
					_unit addMagazines [_x, 8];
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
			removeBackpack _x;
			_x addWeapon "launch_Titan_F";
			_x addBackpack "B_FieldPack_khk";
			_x addMagazine ["Titan_AA", 2];
		} foreach _AAunits;
	};

	if ((count _SLunits) > 0) then
	{
		{
			removeHeadgear _x;
			removeBackpack _x;
			_x addHeadgear _slheadgear;
			_x addBackpack "B_FieldPack_khk";
			_x addMagazines ["SmokeShell", 1];
			_x addItemToBackpack "FirstAidKit";
			//_x addMagazines ["APERSBoundingMine_Range_Mag", 1];

		} foreach _SLunits;
	};

	if ((count _SNunits) > 0) then
	{
		{
			removeUniform _x;
			_x forceaddUniform _snghillie;
			//_x assignItem "NVGoggles_OPFOR";
			_x assignItem "ACE_NVG_Gen2";
			_x addBackpack "B_FieldPack_khk";
			_x addItemToBackpack "FirstAidKit";
			_x addMagazines ["APERSBoundingMine_Range_Mag", 1];

		} foreach _SNunits;
	};

	if ((count _HGunits) > 0) then
	{
		{
			clearMagazineCargo _x;
			removeBackpack _x;
			_x addWeapon _HGweapon;
			_x addBackpack "B_FieldPack_khk";
			_x addItemToBackpack "FirstAidKit";
			_x addMagazines ["150Rnd_93x64_Mag", 2];
			_x addItemToVest "150Rnd_93x64_Mag";
			//_x addMagazines ["APERSBoundingMine_Range_Mag", 1];

		} foreach _HGunits;
	};

	if ((count _MGunits) > 0) then
	{
		{

			removeBackpack _x;
			_x addBackpack "B_FieldPack_khk";
			_x addItemToBackpack "FirstAidKit";
			// This is silly. I should use arrays properly so I can retrieve the ammo directly from the _MGweapon array.
			_Mgammo = switch _MGweapon do {
			  	case "arifle_CTARS_hex_F": {"100Rnd_580x42_Mag_Tracer_F"};
			  	case "LMG_Zafir_F": {"150Rnd_762x54_Box_Tracer"};
			    case "arifle_SPAR_02_blk_F": {"30Rnd_762x39_Mag_Green_F"};
			  	default {"ACE_Banana"};
					
			};
			if (_MGweapon == "ACE_Banana") then {
			    diag_log format ["JSHK Redress returned something weird (%1) for LMG ammo.", _MGweapon]
			} else {
			    _x addMagazines [_Mgammo, 3];
			};
			//_x addMagazines ["APERSBoundingMine_Range_Mag", 2];

		} foreach _MGunits;
	};

	if (_continuous) then
	{
		[_unitSide,_special,_factionExclude] spawn JSHK_fnc_countLoop;
	};
//};
