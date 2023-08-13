// The purpose of this function is to keep flank-sectors from overLapping the fire-sector.
// Because this would cause a logical contradiction where An enemy could both be a valid target
// and at the same time outflanking the position, thus promting two different states is the Finite State Machine.
params[
    "_fipo",
    ["_setVar", false]
];
private _maxWidth = 180;
private _coefR    = _fipo getVariable "sfsm_rightflankwidth";
private _coefC    = _fipo getVariable "fireSectorWidth";
private _coefL    = _fipo getVariable "sfsm_leftflankwidth";

private _widthR   = round (_maxWidth*_coefR);
private _widthC   = round (_maxWidth*_coefC);
private _widthL   = round (_maxWidth*_coefL);

private _centerNeeded = _fipo getVariable "dynamicFipo";
if(_centerNeeded isEqualTo false)exitWith{[_widthR, _widthC, _widthL];};

_coefR    = [_coefC, _coefR, _setVar] call FIPO_fnc_adjustFlankCoef;
_coefL    = [_coefC, _coefL, _setVar] call FIPO_fnc_adjustFlankCoef;

_widthR   = round (_maxWidth*_coefR);
_widthL   = round (_maxWidth*_coefL);


if(_setVar)then{
    _fipo setVariable ["sfsm_rightflankwidth", _coefR];
    _fipo setVariable ["sfsm_leftflankwidth",  _coefL];
};


[_widthR, _widthC, _widthL];