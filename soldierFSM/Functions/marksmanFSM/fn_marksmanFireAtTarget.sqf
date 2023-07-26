params ["_marksman", "_target"];
private _accuracy    = _marksman skill "aimingAccuracy";
private _shake       = _marksman skill "aimingShake";
private _speed       = _marksman skill "aimingSpeed";
private _reload      = _marksman skill "reloadSpeed";
private _aimDistance = _marksman skill "spotDistance";

// private _skill = skill _marksman;

// _marksman setSkill 1;

_marksman setSkill ["aimingAccuracy", 1];
_marksman setSkill ["aimingShake",    1];
_marksman setSkill ["aimingSpeed",    1];
_marksman setSkill ["reloadSpeed",    1];
_marksman setSkill ["spotDistance",   1];

private _timer = time +60;
_marksman disableAI "path";
_marksman disableAI "AIMINGERROR";
_marksman setUnitCombatMode "RED";


private _keepShooting = true;
private _shootingStatus = "Engaging target";
_marksman setVariable ["SFSM_marksmanAction", _shootingStatus, true];

_marksman reveal _target;


while{_keepShooting}do{

    _marksman doTarget _target;
    _marksman dofire   _target;
    _marksman reveal   _target;
    
    _shootingStatus = [_marksman, _target, _timer] call SFSM_fnc_mrkMnKeepShooting;
    
    _keepShooting = _shootingStatus isEqualTo "true";
    
    sleep 2;
};

_marksman setVariable ["SFSM_marksmanAction", _shootingStatus, true];

sleep 1;

_marksman setUnitCombatMode "WHITE";
_marksman enableAI "path";
_marksman enableAI "AIMINGERROR";

_marksman setSkill ["aimingAccuracy", _accuracy];
_marksman setSkill ["aimingShake",    _shake];
_marksman setSkill ["aimingSpeed",    _speed];
_marksman setSkill ["reloadSpeed",    _reload];
_marksman setSkill ["spotDistance",   _aimDistance];