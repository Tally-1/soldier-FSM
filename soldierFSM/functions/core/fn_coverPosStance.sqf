params ["_coverPos", "_targetPos"];
// private _isCover        = true;
private _exposed         = false;
private _counter         = 0;
private _visibility     = 1000;
private _stance         = "none";
private _targetPos      = AGLToASL _targetPos;
private _standPos       = AGLToASL [_coverPos # 0, _coverPos # 1, 1.75];
private _crouchPos      = AGLToASL [_coverPos # 0, _coverPos # 1, 1.1];
private _pronePos       = AGLToASL [_coverPos # 0, _coverPos # 1, 0.4];
private _coverPositions = [_standPos, _crouchPos, _pronePos];
private _stances         = ["ERECT", "CROUCH", "PRONE"];
private _ignoreObj      = (nearestObjects [_coverPos, ["CAManBase"], 5]) # 0;
private _ignoreObj2     = (nearestObjects [_coverPos, ["CAManBase"], 5]) # 0;

if(isNil "_ignoreObj")then {_ignoreObj = objNull};
if(isNil "_ignoreObj2")then{_ignoreObj2 = objNull};


{
    private _tLos = terrainIntersect [ASLToAGL _x, ASLToAGL _targetPos];
    if(_tLos)
    exitWith {
        _stance = (_stances # _counter); 
        // diag_log "terrain";
        };


    private _objs = lineIntersectsObjs [_x, _targetPos, _ignoreObj, _ignoreObj2, false, 32];
    
    // diag_log [_objs] joinString "";
    
    private _exposed = (_objs isEqualTo []);
    if!(_exposed)exitWith{_stance = (_stances # _counter)};

    _counter = _counter + 1;
}forEach _coverPositions;

_stance