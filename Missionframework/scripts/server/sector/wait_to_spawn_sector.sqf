/*
	author: tajin, chiefowens

	Speeds up spawing of ai in sectors
*/

params [ "_sector", "_opforcount" ];
private [ "_unitscount", "_corrected_size", "_sectorpos" ];

_corrected_size = [ _opforcount ] call F_getCorrectedSectorRange;
_sectorpos = getmarkerpos _sector;

sleep 0.1;
_unitscount = [ _sectorpos , _corrected_size , GRLIB_side_friendly ] call F_getUnitsCount;

if (_unitscount isEqualTo 0) then {
	sleep 1;
};

waitUntil {
	_last = _unitscount;
	sleep 3;
	_unitscount = [ _sectorpos , _corrected_size , GRLIB_side_friendly ] call F_getUnitsCount;
	_unitscount >= _last
};
