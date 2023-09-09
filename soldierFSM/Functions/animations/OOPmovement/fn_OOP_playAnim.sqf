params["_man", "_animNick"];
private _anim = ((_self get _animNick) get "animName");
[_man, _anim] remoteExecCall ["playMoveNow", _man];
true;