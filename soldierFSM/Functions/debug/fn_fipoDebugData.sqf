params["_fipo"];
private _pos         = getPosATLVisual _fipo;
private _color       = [0,1,0.9,0.3];
private _text        = "Fighting Position";
private _icon        = "\a3\UI_F_Enoch\Data\CfgMarkers\circle1_ca.paa";
private _size        = 1.5;
private _name        = _fipo getVariable "posname";
private _manAssigned = (synchronizedObjects _fipo) isNotEqualTo [];

// Set a side-color to the icon if there is a man assigned to the position.
if(_manAssigned)then{
    private _man = [_fipo] call SFSM_fnc_fipoMan; 
    _color = [(side _man)] call SFSM_fnc_sideColor;
};

//Default data-set.
private _data  = [_pos, _color, _text, _icon, _size];

// Exit with default data, only text is changed
if(_name isNotEqualTo "")exitWith{
	_text = _name;
	[_pos, _color, _text, _icon, _size];
};

// Exit with knockout data(timer included).
private _knockOutT = [_fipo] call SFSM_fnc_timeSinceFipoKnockOut;
if(_knockOutT < SFSM_fipoKnockOutTime)exitWith{
    private _cooldown = SFSM_fipoKnockOutTime - _knockOutT;
    _icon  = "\a3\Ui_F_Curator\Data\CfgMarkers\minefieldAP_ca.paa";
    _text  = ["FUBAR FIPO ", _cooldown, " seconds left."] joinString "";

	if!(_manAssigned)then{
		_color = [0.64,0.16,0.16,0.8];
	};

	[_pos, _color, _text, _icon, _size];
};


//Destruction-data 
if(_fipo getVariable ["destroyed", false])exitWith{
	_icon  = "\A3\ui_f\data\map\markers\handdrawn\objective_CA.paa";
    _text  = "Fipo disabled.";

	if!(_manAssigned)then{
		_color = [0.64,0.16,0.16,0.8];
	};

	[_pos, _color, _text, _icon, _size];
};

// Exit with hit and run data(timer included).
if(_fipo getVariable "hitAndRun")exitWith{
    _text = [_fipo] call SFSM_fnc_fipoHRDbgTxt;
	_icon = "\A3\ui_f\data\map\markers\military\pickup_CA.paa";

	[_pos, _color, _text, _icon, _size];
};


// Exit with hit dynamic data.
if(_fipo getVariable "dynamicFipo")exitWith{
    _text = "Dynamic FIPO";
	_icon = "\A3\ui_f\data\map\markers\military\start_CA.paa";

	if(_manAssigned
	&&{_fipo getVariable "active"})then{
		_icon = "\A3\ui_f\data\map\markers\military\warning_CA.paa";
	};

	[_pos, _color, _text, _icon, _size];
};

// Exit with default data.
_data;