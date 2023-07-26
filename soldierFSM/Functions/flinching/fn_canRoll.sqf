params["_man"];
private _hasLauncher  = secondaryWeapon _man != "";
if(_hasLauncher)exitWith{false};

private _backPackSize = getContainerMaxLoad backpack _man;
if(_backPackSize isEqualTo 0)exitWith{false};
if(_backPackSize > 200)exitWith{false};

true;