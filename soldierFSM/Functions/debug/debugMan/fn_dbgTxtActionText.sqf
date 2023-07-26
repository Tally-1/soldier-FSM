params["_man", "_suppression"];
private _excluded     = _man getVariable ['SFSM_excluded', false];
private _action       = [_man] call SFSM_fnc_getAction;
private _flashAction  = [_man, "flashAction"] call SFSM_fnc_unitData;
private _excludedText = ["Excluded. Error: ", _action]joinString"";
private _actionTxt    = _action;

if(_excluded && {_action isEqualTo "none"})then{_actionTxt = "Excluded"};
if(_excluded && {_action != "none"})       then{_actionTxt = _excludedText};
if(isNil "_action")                           then{_actionTxt = "not initialized"};
if(_action isEqualTo "none")               then{_actionTxt = ""};
if(_suppression > SFSM_ProneTreshHold)     then{_actionTxt = "! Suppressed !"};
if(_flashAction isNotEqualTo "")           then{_actionTxt = _flashAction;};

if(fleeing _man
&&{(!("hunker" in  _action))
&&{_action isEqualTo "none"
&&{(! _unconscious)
&&{(!captive _man)}}}})then{
    _actionTxt = "Fleeing";
};

_actionTxt;