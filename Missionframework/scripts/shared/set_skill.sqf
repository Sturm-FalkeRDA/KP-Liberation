params ["_unit"];

if (!(GRLIB_autodanger) && ((side _unit) == GRLIB_side_friendly)) then {
	_unit disableAI "AUTOCOMBAT";
};

(group _unit) allowFleeing 0;
// REVIEW No longer dynamically scales the AI's various skill values based on difficulty.
