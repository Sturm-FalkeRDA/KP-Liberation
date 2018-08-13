player spawn {
  while { true } do {
        waitUntil { sleep 3; alive _this };
        _this setVariable ["defcamo", _this getUnitTrait "camouflageCoef", true];
        while { alive _this } do {
            if (stance _this=="PRONE") then {
                _surfaceType=(surfaceType getPosATL _this) select [1];
                _grassCover=getNumber(configfile >> "CfgSurfaces" >> _surfaceType >> "grassCover");
                _newCamo=1 max 500 * _grassCover;
                _this setUnitTrait ["camouflageCoef", _newCamo];
            } else {
                _this setUnitTrait ["camouflageCoef", _this getVariable "defcamo"];
            };
            sleep 1;
        };
    };
};
