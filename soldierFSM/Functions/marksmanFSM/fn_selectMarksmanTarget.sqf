params ["_marksman", "_targets"];
private _side       = side _marksman;
private _target     = objNull;
private _targets    = _targets select {_side knowsAbout _x > 3};

if(_targets isEqualTo [])exitWith{_target;};

private _newTargets = _targets select {isNull (_x getVariable ["SFSM_myAssasin", objNull])};

if(_newTargets isEqualTo [])then{
    _newTargets = _targets;
};

//categorize HVT`s according to value
private _squadLeaders   = _newTargets select {[_x]           call SFSM_fnc_squadAsset isEqualTo "squad-leader";};
private _ATs            = _newTargets select {[_x]           call SFSM_fnc_squadAsset isEqualTo "AT-specialist";};
private _machinegunners = _newTargets select {[_x]           call SFSM_fnc_squadAsset isEqualTo "machineGunner";};
private _hmgGunners     = _newTargets select {[(vehicle _x)] call SFSM_fnc_isTurret;};
private _marksMen       = _newTargets select {[_x]           call SFSM_fnc_isMarksman;};
private _medics         = _newTargets select {[_x]           call SFSM_fnc_squadAsset isEqualTo "medic";};


// loop through all targets ordered by priority
{
    _target = [_marksman, _x] call SFSM_fnc_selectTarget;
    if(!isNull _target) exitWith{};
    
} forEach [
    _hmgGunners,     //1st pri
    _marksMen,       //2nd pri
    _ATs,            //3rd pri
    _medics,         //4th pri 
    _machinegunners, //5th pri
    _squadLeaders    //6th pri
];

_target;