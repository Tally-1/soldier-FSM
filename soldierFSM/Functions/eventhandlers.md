[CBA-EVENTS]

---------------------------------------------------

/*BATTLEFIELD EVENTS*\
**When the battle has started but before all objects are loaded**
["new_battle", _battlefield]         call CBA_fnc_localEvent; 

_id = ["new_battle", {
private _battlefield = _this;
}] call CBA_fnc_addEventHandler;


**Once the BFF has initialized properly and all objects are loaded**
["battle_initialized", _battlefield] call CBA_fnc_localEvent;

_id = ["battle_initialized", {
private _battlefield = _this;
}] call CBA_fnc_addEventHandler;


**Every time the update loop has updated the battlefield hashmap**
["battle_updated", _battlefield]     call CBA_fnc_localEvent;

_id = ["battle_updated", {
private _battlefield = _this;
}] call CBA_fnc_addEventHandler;

**When the battle ends, but before hashmap is deleted**
["battle_ended", _battlefield]       call CBA_fnc_localEvent;

_id = ["battle_ended", {
private _battlefield = _this;
}] call CBA_fnc_addEventHandler;

-----------------------------------------------------

/*INFANTRY ACTIONS*\
**When a vehicle is about to be hijacked**
["vehicle_hijack", [_vehicle, _units]] call CBA_fnc_localEvent;

**When a man is throwing back a grenade(nearest = the man throwing it back)**
["grenade_throwback", [_nearest, _grenade]] call CBA_fnc_localEvent;

**When a man is running away from a grenade**
["grenade_evade", [_man, _grenade]] call CBA_fnc_localEvent;

**When a man is moving to mount a turret**
["mounting_turret", [_man, _turret]]   call CBA_fnc_localEvent;

**When a man has mounted a turret**
["turret_mounted", [_man, _turret]]   call CBA_fnc_localEvent;

**When a machineGunner starts suppressing the enemy**
["mg_suppression", [_man, _ASL_positions]]   call CBA_fnc_localEvent;

**When a machineGunner stops suppressing the enemy**
["mg_suppressionEnd", [_man]]   call CBA_fnc_localEvent;

**When a AT-specialist starts hunting a vehicle**
["AT_huntStart", [_man, _targetVehicle]]   call CBA_fnc_localEvent;

**When a AT-specialist has LOS on target**
["AT_huntKillTry", [_man, _targetVehicle]]   call CBA_fnc_localEvent;

**When AT-specialist stops hunting for a vehicle**
["AT_huntEnd", [_man, _targetVehicle]]   call CBA_fnc_localEvent;

**When a man is hiding from a vehicle**
["hiding_start", [_man, _enemyVehicle]]   call CBA_fnc_localEvent;

**when a man stops hiding from a vehicle**
["hiding_end", [_man, _enemyVehicle]]   call CBA_fnc_localEvent;


**When a man executes a standard flinch (reacting to incoming fire)**
["flinch", [_man]]   call CBA_fnc_localEvent;

**When a man flinches due to heavy munitions coming in**
["flinch_big", [_man]]   call CBA_fnc_localEvent;

**When a man is evading an enemy while outdoors**
["dodge_outdoor", [_man, _dodgePos, _enemy]]   call CBA_fnc_localEvent;

**When a man is moving indoors to evade an enemy**
["dodge_indoor", [_man, _house, _enemy]]   call CBA_fnc_localEvent;


**When a man is about to run for cover (when the battle starts)**
["take_cover_init", [_man, _endPos]] call CBA_fnc_localEvent;

**If the cover position was already taken**
["take_cover_Aborted", [_man, _coverPos]] call CBA_fnc_localEvent;

**Take cover ended**
["take_cover_end", [_man, _coverPos]] call CBA_fnc_localEvent;
----------------------------------------------------------


/*MEDICAL ACTIONS*\
**When a man is about to revive a unconscious ally**
["buddy_revive_init", [_healer, _unconscious]] call CBA_fnc_localEvent;

**When a man starts dragging another**
["dragman_start", [_dragger, _draggedMan, _targetPos]] call CBA_fnc_localEvent;

**When a man stops dragging another**
["dragman_end", [_dragger, _draggedMan]] call CBA_fnc_localEvent;

**When healing animation is being played**
["revie_anim", [_healer, _unconscious]] call CBA_fnc_localEvent;

**When revive has ended.**
["revive_done", [_healer, _unconscious, _success]] call CBA_fnc_localEvent;

**When a man is meeting a wounded unit to heal him**
["buddy_heal", [_healer, _wounded, _coverPos]] call CBA_fnc_localEvent;

**When healing has ended**
["healing_done", [_healer, _wounded, _success]] call CBA_fnc_localEvent;

**When a man is healing himself prone (emergency heal)**
["emergency_heal", [_man]]   call CBA_fnc_localEvent;

---------------------------------------------------

/*CQB*\
**When a man is about to launch a rpg at a house**
["CQB_rpg", [_man, _targetHouse]] call CBA_fnc_localEvent;

**When a man has fired a misile at a house**
["CQB_rpgFire", [_man, _building]] call CBA_fnc_localEvent;

**When a man is about to blow up a house using explosives**
["CQB_explosive", [_man, _targetHouse]] call CBA_fnc_localEvent;

**When a man has placed explosives inside a house**
["CQB_explosivePlaced", [_man, _building]] call CBA_fnc_localEvent;

**When a man has set off explosives inside a house**
["CQB_exploded", [_man, _building]] call CBA_fnc_localEvent;

**When a man is about to clear a house for enemies**
["CQB_clearing", [_man, _targetHouse, _target]] call CBA_fnc_localEvent;

**When the targetbuilding is clear of enemies, but before the man has exited**
["CQB_houseClear", [_man, _building]] call CBA_fnc_localEvent;

**When a man has stopped clearing a house**
["CQB_clearingEnded", [_man, _building]] call CBA_fnc_localEvent;


/*New eventhandlers*\

**When unitData updates**
//eh-name        unit    type   prev-value  new-value
["new_unitData", [_man, _item, _returnVal, _value]] call CBA_fnc_localEvent;

[Example]
_id = ["new_unitData", {
params["_man", "_dataCategory", "_previousValue", "_newValue"];

}] call CBA_fnc_addEventHandler;

[Info]
To see all dataCategories read initMan.sqf, in the init-folder.
The most important category is "action", since that is the one that signals the SFSMs current intention with said man.

-----------------------------------------------------------------

**When a man is available after doing something**
//when "action" is set to "none" in the unitData
["man_available", [_man]] call CBA_fnc_localEvent;

[Example]
_id = ["man_available", {
params["_man"];

}] call CBA_fnc_addEventHandler;

[Info]
Usefull for getting a unit as soon as he finishes doing something.

-------------------------------------------------------------------

**When sprinting**
//start-sprint EH
["sprint_start", [_man, _pos]]   call CBA_fnc_localEvent;

[Example]
_id = ["sprint_start", {
params["_man", "_destination"];

}] call CBA_fnc_addEventHandler;

-------------------------------------------------------------------

//end-sprint EH
["sprint_end", [_man, _destination]] call CBA_fnc_localEvent;

[Example]
_id = ["sprint_end", {
params["_man", "_destination"];

}] call CBA_fnc_addEventHandler;

-------------------------------------------------------------------

**When getting in / out of Fighting positions**
["fipo_getOut", [_man, _fipo]] call CBA_fnc_localEvent;
["fipo_getIn",  [_man, _fipo]] call CBA_fnc_localEvent;

[Example]
_id = ["fipo_getIn", {
params["_man", "_fipo"];

}] call CBA_fnc_addEventHandler;

-------------------------------------------------------------------

**When a soldier starts moving towards a fighting position**
["fipo_moveIn",  [_man, _fipo]] call CBA_fnc_localEvent;

[Example]
_id = ["fipo_moveIn", {
params["_man", "_fipo"];

}] call CBA_fnc_addEventHandler;

-------------------------------------------------------------------

**When a man is overRun**
["overrun",  [_man, _enemies]] call CBA_fnc_localEvent;

[Example]
_id = ["fipo_moveIn", {
params["_man", "_enemies"];

}] call CBA_fnc_addEventHandler;

-------------------------------------------------------------------

// When surrendering
["overrun_surrender",  [_man]] call CBA_fnc_localEvent;

[Example]
_id = ["overrun_surrender", {
params["_man"];

}] call CBA_fnc_addEventHandler;

-------------------------------------------------------------------

// When Counter Attacking (overrun)
["overrun_attack",  [_man, _enemies]] call CBA_fnc_localEvent;

[Example]
_id = ["overrun_attack", {
params["_man", "_enemies"];

}] call CBA_fnc_addEventHandler;

--------------------------------------------------------------------

// When Fleeing (overrun / vanilla)
["overrun_flee",  [_man, _enemies]] call CBA_fnc_localEvent;

[Example]
_id = ["overrun_flee", {
params["_man", "_enemies"];

}] call CBA_fnc_addEventHandler;

--------------------------------------------------------------------

**When a man is being captured**
["capture",  [_man, _captor]] call CBA_fnc_localEvent;

[Example]
_id = ["capture", {
params["_captive", "_captor"];

}] call CBA_fnc_addEventHandler;

--------------------------------------------------------------------

**When a man is being executed**
["execution",  [_man, _killer]] call CBA_fnc_localEvent;

[Example]
_id = ["execution", {
params["_victim", "_executioner"];

}] call CBA_fnc_addEventHandler;

--------------------------------------------------------------------

**When a Fighting position has been temporarily knocked out**
**(Man died or got incapacitated while inside the FIPO)**
["FIPO_knockedOut", [_man, _fipo]] call CBA_fnc_localEvent;

[Example]
_id = ["FIPO_knockedOut", {
params["_man", "_fipo"];

}] call CBA_fnc_addEventHandler;

--------------------------------------------------------------------

**When a mans "brain" is reset due to inaction**
["brain_reset", [_man]] call CBA_fnc_localEvent;

[Example]
_id = ["brain_reset", {
params["_man"];

}] call CBA_fnc_addEventHandler;

--------------------------------------------------------------------

**Action is flashed on man in debug-mode**
["flash_action", [_man, _flashText]] call CBA_fnc_localEvent;

[Example]
_id = ["flash_action", {
params["_man", "_action"];

}] call CBA_fnc_addEventHandler;


--------------------------------------------------------------------

**When a soldier is about to blow himself up while being captured**
["pre_bomb_on_capture",  [_man, _captor, _bombType]] call CBA_fnc_localEvent;
["post_bomb_on_capture", [_man, _captor, _bombType]] call CBA_fnc_localEvent;

[Example](before he blows up)
_id = ["pre_bomb_on_capture", {
params["_man", "_captor"];

// set this variable to stop the explosion:
// _man setVariable ["SFSM_stopCapBomb", true];
// That variable will be deleted after the suicide is stopped
// To never get blown up set this variable:
// _man setVariable ["SFSM_stopCapBombAlways", true];


}] call CBA_fnc_addEventHandler;

[Example](after the explosive has spawned, but before it blows up)
_id = ["post_bomb_on_capture", {
params["_man", "_captor", "_explosive"];

// You can set this variable to change the wait before the explosive blows up:
// _explosive setVariable ["SFSM_fuseTime", 1];
// (Will only work for IEDs, mines and explosive-charges)

}] call CBA_fnc_addEventHandler;


--------------------------------------------------------------------