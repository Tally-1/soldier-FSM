params["_player"];
private _healers = (units group _player) select {
    _x != _player
    && {("FirstAidKit" in items _x || {"Medikit" in (items _x)})
    && {[_x] call SFSM_fnc_getAction isEqualTo "none"
    && {[_x] call SFSM_fnc_canRun;
    }}}};

if(_healers isEqualTo [])exitWith{};

private _medics = _healers select {"Medikit" in (items _x)};

if(_medics isNotEqualTo [])exitWith{
    private _healer = [_player, _medics] call SFSM_fnc_getNearest;
    _healer;
};

private _healer = [_player, _healers] call SFSM_fnc_getNearest;

_healer;