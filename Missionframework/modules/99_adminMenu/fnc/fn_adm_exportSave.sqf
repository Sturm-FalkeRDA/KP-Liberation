/*
    KPLIB_fnc_adm_exportSave

    File: fn_adm_exportSave.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-07-27
    Last Update: 2018-08-02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Stores the current save data of the running Liberation campaign in the profile vars of the player.

    Parameter(s):
    NONE

    Returns:
    BOOL
*/

if (isServer) then {
    // If it's local hosted we can directly access the save data
    profileNamespace setVariable [KPLIB_save_key + "_export", KPLIB_save_data];
    saveProfileNamespace;
    hint localize "STR_ADMINDIALOG_EXPDONE";
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
} else {
    // Otherwise request it from the server
    KPLIB_save_data = nil;
    ["KPLIB_save_data"] remoteExecCall ["publicVariable", 2];

    // Wait until we have the data from the server, store it, show a hint and remove the hint after 3 seconds
    [
        {!isNil "KPLIB_save_data"},
        {
            profileNamespace setVariable [KPLIB_save_key + "_export", KPLIB_save_data];
            saveProfileNamespace;
            hint localize "STR_ADMINDIALOG_EXPDONE";
            [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
        }
    ] call CBA_fnc_waitUntilAndExecute;
};

// Enable Import button
findDisplay 75802 displayCtrl 758021 ctrlEnable true;

true
