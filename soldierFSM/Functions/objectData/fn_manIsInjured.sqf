params["_man", ["_injuryLevel", 0.75]];
private _injuries      = damage _man;
private _legDamage     = getAllHitPointsDamage _man#2#10;
private _injured       = (selectMax [_injuries, _legDamage]) > _injuryLevel;

_injured;