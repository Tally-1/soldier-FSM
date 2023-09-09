params ["_marksman", "_target", "_firePos"];

private _action       = "...";
private _canShoot     = [_marksman, _target, 0.2] call SFSM_fnc_targetVisible;
private _validFirePos = ((!isNil "_firePos") &&{[_marksman, _target, _firePos] call SFSM_fnc_isFirePos});
private _inPosition   = _marksman distance _firePos < 2;


//if LOS is blocked but firepos works.
if((!_canShoot) 
&& {_validFirePos
&& {_marksman distance _firePos > 5}})then{

    // private _move = 
    [_marksman, _target, _firePos] call SFSM_fnc_MoveToSnipePos;
    // waitUntil{sleep 1; scriptDone _move;};
    _canShoot = [_marksman, _target, 0.2] call SFSM_fnc_targetVisible;
};

//if LOS is blocked and firepos is not valid then change position
if((!_canShoot)
&&{(!_validFirePos)})
then{

    _firePos = [_marksman, _target, true] call SFSM_fnc_snipingPos;
    if(isNil "_firePos")exitWith{_action = "No firePos found";};

    _marksman setVariable ["SFSM_myFirePos", _firePos,  true];
    _marksman setVariable ["SFSM_marksmanAction", "Changing position", true];
    // private _move = 
    [_marksman, _target, _firePos] call SFSM_fnc_MoveToSnipePos;
    // sleep 0.1;

    
    // waitUntil{sleep 0.5; scriptDone _move;};

    _canShoot = [_marksman, _target, 0.2] call SFSM_fnc_targetVisible;
};

//Open fire
if(_canShoot)then{
    // private _shooting = 
    [_marksman, _target] spawn SFSM_fnc_marksmanFireAtTarget;
    // waitUntil {sleep 0.3; scriptDone _shooting; };
};

_marksman setVariable ["SFSM_marksmanAction", _action, true];

true;