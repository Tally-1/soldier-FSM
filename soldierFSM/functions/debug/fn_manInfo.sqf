params["_man"];
private _data        = ([_man] call objScan_fnc_infGearData);
private _weaponData  = _data get "weaponData";
private _description = _data get "description";
private _weapon      = (_weaponData get "primary") get "description";
private _launcher    = secondaryWeapon _man;
private _versionName = ["soldier FSM V. ", SFSM_Version] joinString "";
private _name        = (name _man);
private _rank        = toLowerANSI(rank _man);

if!(_launcher == "")
then{
		_launcher = (_weaponData get "secondary") get "description";
		_launcher = [_launcher, " <br/>"] joinString "";
	};

private _outLine  = "<t shadow='2'>";
private _smallTxt = "<t size='0.75'>";
private _bigTxt   = "<t size='1.4'>";
private _aqua     = "<t color='#00ffff'>";
private _khaki    = "<t color='#acffa4'>";
private _green    = "<t color='#83ff7f'>";
private _end      = "</t>";
			
private _text = parseText([

							                      _outLine, _bigTxt,_aqua, 
							_rank, " ", _name,    _end, _end, "<br/>",  _green,
							_description,         "<br/>", "<br/>", 
							_weapon,              "<br/>",
							_launcher,            "<br/>", "<br/>",_end,  _smallTxt, 
							_versionName,         _end, _end

				]joinString "");
			
hint _text;

true;