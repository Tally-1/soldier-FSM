params["_man"];
private _abilities = [];

//get all abilities currently in use.
{
	if(_man checkAIFeature _x)then{_abilities pushBack _x};

}forEach SFSM_aiAbilities;

_abilities;