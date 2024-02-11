params[
    ["_man",            nil, [objNull]],
    ["_shootingStance", nil,      [[]]],
    ["_coverStance",    nil,      [[]]]
];
private _mapVar        = _coverStance#1;
private _index         = _coverStance#0;
private _data          = (missionNamespace getVariable _mapVar) get _index;
private _coverAnim     = _data#0;
private _unitPos       = _data#1;
private _peekTime      = ([_man] call SFSM_fnc_fipoPeekTime)+0.1;
private _stepRight     = "right" in (_shootingStance#1);
private _startPos      = getPosATLVisual _man;

[_man, "peekCooldown", time+10]          call SFSM_fnc_unitData;
[_man, _unitPos, _stepRight, _coverAnim] call SFSM_fnc_fipoSideStepStart;  sleep 2;
[_man, _peekTime]                        call SFSM_fnc_peekActions;

private _distance = _startPos distance (getPosATLVisual _man);
private _hasMoved = _distance > 1;

if(_hasMoved)then{
    [_man, _unitPos, !(_stepRight), _coverAnim] call SFSM_fnc_fipoSideStepReturn;
    sleep 2;
};

[_man, _coverStance]call SFSM_fnc_endFipoSideStep;



true;