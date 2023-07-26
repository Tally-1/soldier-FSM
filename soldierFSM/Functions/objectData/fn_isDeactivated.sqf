//checks if all ai abilities on a man is deactivated
//also returns true if the checked object is not a man.

params["_man"]; 
if!(_man isKindOf "CaManBase")exitWith{};

private _deactivated = true;
{
	if(_man checkAIFeature _x)exitWith{_deactivated = false};

} forEach SFSM_aiAbilities;

_deactivated;