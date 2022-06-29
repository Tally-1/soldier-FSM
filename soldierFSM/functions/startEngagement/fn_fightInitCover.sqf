params ["_man"];

private _radius        = SFSM_DodgeDistance;
private _unitPos       = getPos _man;
private _searchPos     = _unitPos;
private _dirToEnemy    = [_man] call Tcore_fnc_knownDirToEnemy;
private _getLateralPos = !(isNil '_dirToEnemy');


if(_getLateralPos)
then{
			private _randomDir     = selectRandom[90,-90];
			private _searchDir  = [(_dirToEnemy + _randomDir)] call Tcore_fnc_formatDir;
			
			_radius = SFSM_DodgeDistance / 2;
			_searchPos = [_unitPos#0, _unitPos#1, _searchDir, _radius] call Tcore_fnc_sinCosPos;
		};

private _coverPos = [_x, _searchPos, _radius] call SFSM_fnc_getCoverPos;

private _posFound = (!isNil "_coverPos" && {typeName _coverPos == "Array"});
if!(_posFound)
exitWith{
			[_man] spawn SFSM_fnc_eyelidTrench;
			// _coverPos call SFSM_fnc_debugMessage;
		};

[_man, _coverPos] spawn SFSM_fnc_takeCover;