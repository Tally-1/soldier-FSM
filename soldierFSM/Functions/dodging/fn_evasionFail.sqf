params[
    "_man", 
    ["_msg", "Evasion failed"]
];

_msg call dbgmsg;
[_man, _msg] spawn SFSM_fnc_flashAction;

true;