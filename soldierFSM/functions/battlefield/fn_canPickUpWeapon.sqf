params["_man", "_weaponObject"];

private _canPickUp =
((!isNil "_man")
&& {(!isNil "_weaponObject")
&& {(!isNull _weaponObject)
&& {alive _man}}});

_canPickUp;