params[["_includeSpecialists", false]];
private _units             = entities "caManBase";
private _woundedNoSelfHeal = [];
private _incapacitated     = [];
private _healers           = [];
private _medics            = [];
private _fipoMedics        = [];
private _availSpecialists  = [];
private _specialists       = [
	"AT-specialist", 
	"machineGunner", 
	"squad-leader", 
	"medic"
];

{
    if([_x] call SFSM_fnc_isRealMan)then{

        private _soldierClass = [_x] call SFSM_fnc_squadAsset;
        
        private _noSpecial    = _includeSpecialists || !(_soldierClass in _specialists);
        private _unconscious  = _x getVariable ["ace_isunconscious", false];
        private _wounded      = damage _x > 0.3;
        private _bleeding     = (_x getVariable ["ace_medical_woundbleeding", 0]) > 0.1;
        private _canHeal      = [_x] call SFSM_fnc_canSelfHeal &&
                               {[_x] call SFSM_fnc_getAction isEqualTo "none"};

        if(_unconscious
        &&{!("revived" in ([_x] call SFSM_fnc_getAction))})then{
            _incapacitated pushBack _x

        }else{
        if((_wounded || _bleeding) &&{! _canHeal})then{
            _woundedNoSelfHeal pushBack _x;

        }else{
        if(_noSpecial && {_canHeal})then{
            _healers pushBack _x;
            
        }else{
        if([_x] call SFSM_fnc_isFipoMedic)then{
            _fipoMedics pushBack _x;

        }else{
        if([_x] call SFSM_fnc_availableAiSoldier && {[_x] call SFSM_fnc_canSelfHeal})then{
            _availSpecialists pushBack _x;
        };

        }}}};
    };
    
} forEach _units;

//sorted return value
[
    _medics, 
    _fipoMedics, 
    _healers, 
    _availSpecialists,
    _woundedNoSelfHeal, 
    _incapacitated
];