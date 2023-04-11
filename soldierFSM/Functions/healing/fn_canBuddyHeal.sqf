private _ignoreAction = false;
private _maxDistance  = SFSM_DodgeDistance;
private _excludeConscious = false;
params["_healer", "_woundedMan", "_ignoreAction", "_maxDistance", "_excludeConscious"];
private _hSide = side _healer;
private _wSide = side (group _woundedMan);

if!(alive _healer)                                                                exitWith{false;};//dead healer
if!(alive _woundedMan)								                              exitWith{false;};//wounded man died 
if(_healer in allPlayers)                                                         exitWith{false;};//non ai cannot be forced to heal
if!([_healer] call SFSM_fnc_canSelfHeal)                                          exitWith{false;};//healer cannot heal
if([_healer] call PrMed_fnc_isUnconscious)                                        exitWith{false;};//unconscious people cannot heal
if(_hSide != _wSide && {_wSide != civilian})                                      exitWith{false;};//wounded is enemy
if(_healer distance2D _woundedMan > _maxDistance)                                 exitWith{false;};//to far away 
if!([_healer, "pathEnabeled"] call SFSM_fnc_unitData)                             exitWith{false;};//path disabeled
if(_excludeConscious && {!(_woundedMan getVariable ["ace_isunconscious", false])})exitWith{false;};//Wounded does not need revive
if(_healer getVariable ["dam_ignore_injured0",false])                             exitWith{false;};//PIR compatibility
if(_woundedMan getVariable ["dam_ignore_injured0",false])                         exitWith{false;};//PIR compatibility
if(_ignoreAction)exitWith{true;};//all conditions except actions have been met, if toggled then conditions are true

if!([_healer, "action"] call SFSM_fnc_unitData isEqualTo "none")                  exitWith{false;};//healer is busy.
if!([_woundedMan, "action"] call SFSM_fnc_unitData isEqualTo "none")              exitWith{false;};//wounded is busy.


true;