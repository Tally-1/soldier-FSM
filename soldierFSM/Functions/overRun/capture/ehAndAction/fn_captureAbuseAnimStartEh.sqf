params["_captor"];
_captor addEventHandler ["AnimChanged", {
    params ["_captor", "_anim"];
    private _victim     = _captor getVariable "SFSM_myExecVictim";
    private _victimAnim = [_anim] call SFSM_fnc_captorAbuseMirrorAnim;
	// private _msg        = _anim;
    if(!isNil "_victimAnim")
    then{
		[_victim, _victimAnim] call SFSM_fnc_doVictimAbuseAnim;
		// _msg = parseText ([_anim,"<br/> --- <br/>", _victimAnim]joinString"");
    };
    // hint _msg;
}];