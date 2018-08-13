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
JSHK_weaponArr =
["arifle_AKM_F", 0.16,
"arifle_AKM_FL_F", 0.18,
"arifle_AKS_F", 0.23,
"arifle_AK12_F", 0.14,
"arifle_AK12_GL_F", 0.12,
"arifle_SPAR_01_khk_F", 0.08,
"arifle_SPAR_01_snd_F", 0.04,
"arifle_SPAR_01_blk_ERCO_Pointer_F", 0.05,
"arifle_SPAR_01_blk_ACO_Pointer_F", 0.05,
"SMG_05_F", 0.08,
"srifle_DMR_06_olive_F", 0.14,
"srifle_DMR_06_camo_F", 0.12];
//TODO Implement
JSHK_MGweaponARR =
["arifle_CTARS_hex_F", 0.16,
"LMG_Zafir_F", 0.23,
"arifle_SPAR_02_blk_F", 0.04,
"arifle_SPAR_02_blk_F", 0.04,
"arifle_SPAR_02_blk_F", 0.04];
//TODO Implement
JSHK_HGweaponARR =
["MMG_01_hex_F", 1,
"MMG_01_tan_F", 1];
JSHK_sidearmARR =
["hgun_Rook40_F"

];
//JSHK_uniformArr = ["U_IG_Guerilla3_1","U_IG_Guerilla3_2","U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_leader", "U_I_C_Soldier_Bandit_3_F", "U_IG_Guerrilla_6_1", "U_I_C_Soldier_Para_1_F", "U_I_C_Soldier_Camo_F"];
JSHK_uniformArr =
["U_O_officer_noInsignia_hex_F", 0.23,
"U_O_CombatUniform_ocamo", 0.08];
JSHK_vestArr =
["V_BandollierB_khk", 0.23,
"Vest_V_BandollierB_rgr", 0.23,
"Vest_V_Chestrig_rgr", 0.23,
"V_TacChestrig_cbr_F", 0.23,
"V_Chestrig_khk", 0.23,
"V_Chestrig_blk", 0.23,
"V_Chestrig_oli", 0.23,
"V_HarnessO_brn", 0.14,
"V_HarnessO_gry", 0.14,
"V_HarnessOSpec_brn", 0.18,
"V_HarnessOSpec_gry", 0.18,
"V_PlateCarrier1_rgr_noflag_F", 0.12,
"V_PlateCarrier2_rgr_noflag_F", 0.12,
"V_Pocketed_olive_F", 0.18,
"V_Pocketed_coyote_F", 0.18,
"V_Pocketed_black_F", 0.18,
"V_LegStrapBag_black_F", 0.12,
"V_LegStrapBag_coyote_F", 0.12,
"V_LegStrapBag_olive_F", 0.12,
"milgp_v_mmac_teamleader_belt_CB", 0.08,
"milgp_v_marciras_light_cb", 0.08];
JSHK_headArr =
["milgp_h_airframe_02_CB_hexagon", 0.12,
"H_Cap_brn_SPECOPS", 0.18,
"H_HelmetCrew_O", 0.14,
"H_HelmetB_light_black", 0.18,
"H_PASGT_basic_olive_F", 0.23,
 "H_PASGT_basic_black_F", 0.23,
 "H_HeadBandage_stained_F", 0.14,
 "H_HeadBandage_clean_F", 0.14,
 "H_HeadBandage_bloody_F", 0.12,
 "H_Bandanna_khk", 0.12,
 "H_Bandanna_cbr", 0.12];
JSHK_goggleArr =
["milgp_f_face_shield_shemagh_CB", 0.14,
"milgp_f_face_shield_shemagh_khk", 0.14,
"G_WirelessEarpiece_F", 0.8];
JSHK_backpackArr =
["milgp_bp_hydration_cb", 0.33,
"B_FieldPack_cbr", 0.23,
"B_OutdoorPack_tan", 0.23,
"O_Mortar_01_weapon_F", 0.18,
"O_HMG_01_weapon_F", 0.12,
"O_AA_01_weapon_F", 0.08];
//JSHK_voiceArr = ["regularvoice","Male01PER","Male02PER","Male03PER"];
JSHK_SLArr =
["Headgear_H_Beret_blk", 0.23,
"Headgear_H_Watchcap_blk", 0.12,
"Headgear_H_MilCap_ghex_F", 0.18,
"Headgear_H_Bandanna_camo", 0.14,
"milgp_h_airframe_02_CB_hexagon", 0.08];
JSHK_SNArr = ["U_O_GhillieSuit", "U_O_FullGhillie_lsh"];
//-----------------------------


//Special Units Classnames
//-----------------------------
JSHK_ATunits = ["O_Soldier_AT_F","I_Soldier_AT_F","B_Soldier_AT_F", "B_soldier_LAT_F", "B_recon_LAT_F"];
JSHK_Medicalunits = ["O_medic_F","I_medic_F","B_medic_F"];
JSHK_AAunits = ["O_Soldier_AA_F","I_Soldier_AA_F","B_Soldier_AA_F"];
JSHK_SLunits = ["O_officer_F", "O_Soldier_SL_F", "O_Soldier_TL_F"];
JSHK_SNunits = ["O_sniper_F", "O_spotter_F"];
//TODO Implement
JSHK_MGunits = ["O_Soldier_AR_F"];
//TODO Implement
JSHK_HGunits = ["O_HeavyGunner_F"];
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
