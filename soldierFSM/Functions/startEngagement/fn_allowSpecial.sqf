params["_man", "_default"];
private _leader        = (leader group _man);
private _playerLead    = _leader in allPlayers;
private _mode          = unitCombatMode _man;

// check if dodging is allowed for player squad
if((!SFSM_PlayerGrpDodge)
&&{_playerLead})exitWith{
    "Specialist action blocked by 'no-player-squad-dodge' setting" call dbgmsg;
    false;
};

// Check if specialist action settings should be overwritten by combat-mode.
if(_mode == "WHITE")exitWith{true;};
if(_mode == "RED")  exitWith{true;};

// If none of the above is true, return the default value.
_default;