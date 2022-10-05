Params ["_PosArr"];
Private _Heights = [];
private _AverageHeight = 0;


if (Count _PosArr > 1) then {
								{
										private _elevation = (round getTerrainHeightASL _x);
										If (TypeName _elevation == "SCALAR") then {_Heights Pushback _elevation};
										 
								}forEach _PosArr;

								If (Count _Heights > 0) then {_AverageHeight = (round ([_Heights] call Tcore_Fnc_average))};
							};

If (IsNil "_AverageHeight") then {_AverageHeight = 0;};

_AverageHeight;