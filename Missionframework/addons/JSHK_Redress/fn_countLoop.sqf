/*////////////////////////////////////

Author: J.Shock

Function File: fn_countLoop.sqf

Parameters:
	1- Side (EAST, WEST, CIV, GUER)
	2- Use of special units (true/false)

Description: A loop that counts all units, then the new units are 
			 pushed back, and fn_Redress.sqf is called.
			 
Return: None

**DISCLAIMER**
Do not remove the header from this file. Any reproduced portions of this code
must include credits to the author (J.Shock).

*////////////////////////////////////

private ["_side","_special","_toBeDressed","_faction"];

_side = (_this select 0);
_special = (_this select 1);
_faction = (_this select 2);
_toBeDressed = [];

sleep 5;

{
	if (!(_x getVariable ["JSHK_doneRedress",false]) && {side _x isEqualTo _side} && {!((faction _x) in _faction)}) then
	{
		_toBeDressed pushBack _x;
	};
} forEach allUnits;
	
[_toBeDressed,_special,_side,true,_faction] call JSHK_fnc_Redress;