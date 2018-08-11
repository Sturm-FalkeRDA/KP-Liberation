// Mission spawn trop proche d'un secteur capture
params ['_markers'];
private _list=[];  

{
	private _item = true;
	private _position = getMarkerPos (_x select 0);
	{  
		if (getMarkerPos _x distance _position <= 500) exitWith {_item = false};
	} forEach blufor_sectors;
	if (_item) then {_list pushback _x};
} forEach _markers;

_list;
