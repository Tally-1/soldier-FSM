params["_man"];
private _data        = ([_man] call objScan_fnc_infGearData);
private _weaponData  = _data get "weaponData";
private _description = _data get "description";
private _weapon      = (_weaponData get "primary") get "description";
private _launcher    = secondaryWeapon _man;
private _versionName = ["soldier FSM V. ", SFSM_Version] joinString "";
private _name        = (name _man);
private _rank        = toLowerANSI(rank _man);
private _role        = [_man] call SFSM_fnc_squadAsset;

private _outLine     = "<t shadow='2'>";
private _smallTxt    = "<t size='0.75'>";
private _bigTxt      = "<t size='1.4'>";
private _aqua        = "<t color='#00ffff'>";
private _khaki       = "<t color='#acffa4'>";
private _green       = "<t color='#83ff7f'>";
private _red         = "<t color='#e32e2e'>";
private _end         = "</t>";


if!(_launcher == "")
then{
		private _hasAtAmmo = [_man, (secondaryWeapon _man)] call SFSM_fnc_hasAmmoForWeapon;
		_launcher          = (_weaponData get "secondary") get "description";
		_launcher          = [_launcher, " <br/>"] joinString "";
		if(_hasAtAmmo)then{_launcher = [_launcher,_aqua," Has launcher ammo <br/>", _end] joinString "";}
		              else{_launcher = [_launcher,_red, " No launcher ammo <br/>", _end] joinString "";};
	};


			
private _text = parseText([

							                      _outLine, _bigTxt,_aqua, 
							_rank, " ", _name,    _end, _end, "<br/>",  _green,
							_description,         "<br/>", "<br/>", 
							_weapon,              "<br/>",
							_launcher,            "<br/>",
							_role,                "<br/>", "<br/>",_end,  _smallTxt, 
							_versionName,         _end, _end

				]joinString "");
			
hint _text;

true;