params ["_man"]; 
private _hasKit = false;
private _inventory = items _man;

private _vanillaKits = [
	"FirstAidKit",
	"Medikit"
];

{
	if(_x in _inventory)exitWith{
		_hasKit = true;
	};
	
} forEach _vanillaKits;

if!(SFSM_aceLoaded)exitWith{_hasKit;};

_hasKit = false;

private _allKits = [
	"FirstAidKit",
	"Medikit",
	"vn_b_item_firstaidkit",
	"vn_o_item_firstaidkit",
	"PiR_bint",
	"vn_b_item_medikit_01",
	"ACE_fieldDressing",
	"ACE_packingBandage",
	"ACE_elasticBandage",
	"ACE_packingBandage",
	"ACE_fieldDressing",
	"ACE_quikclot"
];

{
	if(_x in _inventory)exitWith{
		_hasKit = true;
	};
	
} forEach _allKits;

_hasKit;