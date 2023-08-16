// this function grabs an animation from the hashmap defined in fn_postConfig.sqf
// and plays it. the completion of the move can be grabbed using the "SFSM_animStanceDone" variable
// or the CBA eventhandler.

params["_man", "_indexAndMapName"];
private _index          = _indexAndMapName#0;
private _mapName        = _indexAndMapName#1;
private _animationMap   = missionNamespace getVariable _mapName;//[, "SFSM_animStances"];
private _data           = _animationMap get _index;
private _animation      = _data#0;
private _unitPos        = _data#1;
private _unitSpeed      = getAnimSpeedCoef _man;
private _verticalStance = _mapName isEqualTo "SFSM_animStances";
private _fipo           = [_man] call SFSM_fnc_getFipo;

_man setVariable ["SFSM_wantedAnim",      _animation];
_man setVariable ["SFSM_wantedAnimIndex", _index];
_man setVariable ["SFSM_animData",        _data];
_man setVariable ["SFSM_animSpeed",       _unitSpeed];

//Make sure the man is in position.
if(!isNil "_fipo")then{
    if(_verticalStance)
    then{
        _man attachTo [_fipo, [0,0,0]]
    }
    else{
        // [_man] spawn SFSM_fnc_tempPegToFipo;
        _man setDir (getDir _fipo);
    };
};

_man setAnimSpeedCoef 3;
_man disableAI "anim";
_man playMoveNow _animation;
_man setUnitPos  _unitPos;

_man addEventHandler ["AnimDone", {
    params ["_man", "_anim"];
    private _anim        = toLowerANSI _anim;
    private _wantedAnim  = toLowerANSI (_man getVariable "SFSM_wantedAnim");
    private _wantedIndex = _man getVariable "SFSM_wantedAnimIndex";
    private _animSpeed   = _man getVariable "SFSM_animSpeed";
    // private _data     = _man getVariable "SFSM_animData";

    if(_wantedAnim in _anim)
    then{
        // return to normal.
        _man setAnimSpeedCoef _animSpeed;
        _man enableAI "anim";
        detach _man;
        [_man] call SFSM_fnc_setFipoAnimOfset;

        // notify dependant functions.
        _man removeEventHandler [_thisEvent, _thisEventHandler];
        _man setVariable ["SFSM_animStanceDone", true];
        ["animStanceDone", [_man, _anim, _wantedIndex]] call CBA_fnc_localEvent;
        

        // delete the associated variables after ~1 second.
        _man spawn{
            sleep 0.75; 
            _this setVariable ["SFSM_animData",        nil];
            _this setVariable ["SFSM_animStanceDone",  nil];
            _this setVariable ["SFSM_wantedAnim",      nil];
            _this setVariable ["SFSM_wantedAnimIndex", nil];
            _this setVariable ["SFSM_animSpeed",       nil];
        };
    };
}];