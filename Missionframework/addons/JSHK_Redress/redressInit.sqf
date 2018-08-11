/*////////////////////////////////////

Author: J.Shock

Script File: redressInit.sqf

Parameters:
	1- Side (EAST, WEST, CIV, GUER) ~ default: EAST
	2- Use of special units (true/false) ~ default: true
	3- Check for spawned units (true/false) ~ default: false

Description: Initializes all variables needed for redressing process.
			 Also excludes the units that need not be redressed, as
			 defined by the user in: _indvUnitExclude and _grpUnitExculde.
			 Contains the gear/loadout arrays to be defined by user.

Return: None

**DISCLAIMER**
Do not remove the header from this file. Any reproduced portions of this code
must include credits to the author (J.Shock).

*////////////////////////////////////


_sideToRedress = [_this, 0, EAST, [EAST]] call BIS_fnc_param;
_specialUnits = [_this, 1, true, [true]] call BIS_fnc_param;
_continuous = [_this, 2, false, [true]] call BIS_fnc_param;


//Need to exclude certain units/groups, fill out the below arrays!
//-----------------------------
_indvUnitExclude = [];//<<Put individual unit's variable names here.
_grpUnitExculde = [];//<<Put the group leader's variable names here.
_factionExclusion = [];//<<Put faction classnames here
//-----------------------------


//Gear classes names go below!
//-----------------------------
JSHK_weaponArr = ["LMG_Zafir_F","arifle_Mk20_F"];
JSHK_uniformArr = ["U_IG_Guerilla3_1","U_IG_Guerilla3_2","U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_leader", "U_I_C_Soldier_Bandit_3_F", "U_IG_Guerrilla_6_1", "U_I_C_Soldier_Para_1_F", "U_I_C_Soldier_Camo_F"];
JSHK_vestArr = ["V_BandollierB_khk", "Vest_V_BandollierB_rgr", "Vest_V_Chestrig_rgr", "V_TacChestrig_cbr_F", "V_Chestrig_khk", "V_Chestrig_blk", "V_Chestrig_oli", "V_HarnessO_brn", "V_HarnessO_gry", "V_HarnessOSpec_brn", "V_HarnessOSpec_gry", "V_PlateCarrier1_rgr_noflag_F", "V_PlateCarrier2_rgr_noflag_F", "V_Pocketed_olive_F", "V_Pocketed_coyote_F", "V_Pocketed_black_F", "V_LegStrapBag_black_F", "V_LegStrapBag_coyote_F", "V_LegStrapBag_olive_F"];
JSHK_headArr = ["H_Shemag_olive","H_ShemagOpen_khk","H_ShemagOpen_tan", "H_PASGT_basic_blue_F", "H_PASGT_basic_olive_F", "H_PASGT_basic_black_F", "H_HeadBandage_stained_F", "H_HeadBandage_clean_F", "H_HeadBandage_bloody_F", "H_Bandanna_khk", "H_Bandanna_cbr"];
JSHK_goggleArr = ["nogoggle", "nogoggle", "nogoggle", "nogoggle", ""];
JSHK_backpackArr = ["B_FieldPack_cbr","B_OutdoorPack_tan", "O_Mortar_01_weapon_F", "nopack", "nopack", "nopack", "O_HMG_01_weapon_F", "O_AA_01_weapon_F", "nopack", "nopack", "nopack", "nopack"];
JSHK_voiceArr = ["regularvoice","Male01PER","Male02PER","Male03PER"];
JSHK_SLArr = ["Headgear_H_Beret_blk", "Headgear_H_Watchcap_blk", "Headgear_H_MilCap_ghex_F", "Headgear_H_Bandanna_camo"];
JSHK_SNArr = ["U_O_GhillieSuit", "U_O_FullGhillie_lsh"];
//-----------------------------


//Special Units Classnames
//-----------------------------
JSHK_ATunits = ["O_Soldier_AT_F","I_Soldier_AT_F","B_Soldier_AT_F"];
JSHK_Medicalunits = ["O_medic_F","I_medic_F","B_medic_F"];
JSHK_AAunits = ["O_Soldier_AA_F","I_Soldier_AA_F","B_Soldier_AA_F"];
JSHK_SLunits = ["O_officer_F", "O_Soldier_SL_F", "O_Soldier_TL_F"];
JSHK_SNunits = ["O_sniper_F", "O_spotter_F"];
//-----------------------------



/////***************\\\\\


// Leave the rest ALONE! \\


/////***************\\\\\

_units = [];

{
	_currentUnit = _x;
	if ((side _currentUnit isEqualTo _sideToRedress) &&
	   {({_currentUnit in (units group _x)}count _grpUnitExculde isEqualTo 0)} &&
	   {!(_currentUnit in _indvUnitExclude)} &&
	   {!(_currentUnit getVariable ["JSHK_doneRedress",false])}) then
	{
		_units set [count _units, _currentUnit];
	}
	else
	{
		if (({_currentUnit in (units group _x)}count _grpUnitExculde > 0) || (_currentUnit in _indvUnitExclude) || ((faction _currentUnit) in _factionExclusion)) then
		{
			_currentUnit setVariable ["JSHK_doneRedress",true];
		};
	};
}forEach allUnits;

[_units,_specialUnits,_sideToRedress,_continuous,_factionExclusion] call JSHK_fnc_Redress;

diag_log "Shock's Redressing Script Initialized.";
