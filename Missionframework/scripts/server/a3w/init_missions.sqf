//--- A3W_Missions
// Stolen from A3 Wasteland by AgenRev
// tweaked to fit in Liberation

cityList = compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\towns.sqf";
fn_startsWith = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\fn_startsWith.sqf";
fn_selectRandomWeighted = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\fn_selectRandomWeighted.sqf";
fn_refillbox  = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\fn_refillbox.sqf";
fn_findString = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\fn_findString.sqf";
fn_vehSafeDistance = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\fn_vehSafeDistance.sqf";

generateMissionWeights = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_generateMissionWeights.sqf";
setMissionState = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_setMissionState.sqf";
setLocationState = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_setLocationState.sqf";
attemptCompileMissions = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_attemptCompileMissions.sqf";
cleanlocationobjects = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_cleanLocationObjects.sqf";
createMissionMarker = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createMissionMarker.sqf";
processItems = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_processItems.sqf";
createCustomGroup = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_customGroup.sqf";
moveIntoBuildings = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_moveIntoBuildings.sqf";
defendArea = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_defendArea.sqf";
getBallMagazine = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_getBallMagazine.sqf";
missionHint = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_missionHint.sqf";
checkSpawn = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_checkSpawn.sqf";
updateMissionsList = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_updateMissionsList.sqf";

waitUntil { !isNil "blufor_sectors" };
waitUntil { !isNil "sectors_allSectors" };
waitUntil { !isNil "save_is_loaded" };

diag_log "- A3W Initializing Missions-";
[] call compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\setupMissionArrays.sqf";
[] call compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\masterController.sqf";
