params ["_class"];
if(_class == 0) 	exitWith{"undefined ammoType"};
if(_class == 0.2) 	exitWith{"undefined sub-ammoType"};
if(_class == 0.8) 	exitWith{"blank round"};
if(_class == 0.9) 	exitWith{"non-lethal round"};

if(_class < 1
&&{_class > 0}) 	exitWith{"undefined bullet / shell "};

if(_class == 1) 	exitWith{"Pistol round"};

if(_class == 2) 	    exitWith{"~ 5.56 / 5.8"};					/*Light Rifle round */
if(_class == 2.1)	exitWith{"~ 6.5 / 7.62x39"};				/*Light medium Rifle round */
if(_class == 2.2)	exitWith{"~ 7.62x51"};						/*Medium Rifle round */
if(_class == 2.3)	exitWith{"~ 9.3x64 - .338"};				/*Medium heavy Rifle round */
if(_class == 2.4)	exitWith{"~ 12.7x108"};						/*Heavy Rifle round */
if(_class == 2.5)	exitWith{"~ 12.7x108++ (Armor piercing)"};	/*Armor piercing round */

if(_class == 3)		exitWith{"grenade"};

if(_class == 4)		exitWith{"AutoCannon-round (~20mm - 40mm)"};
if(_class == 4.1)	exitWith{"~20mm-40mm HE"};
if(_class == 4.2)	exitWith{"~20mm-40mm AT"};
if(_class == 4.3)	exitWith{"~20mm-40mm HEAT"};

if(_class == 5)		exitWith{"~100-130mm canon-round"};
if(_class == 5.1)	exitWith{"~100-130mm HE"};
if(_class == 5.2)	exitWith{"~100-130mm AT"};
if(_class == 5.3)	exitWith{"~100-130mm HEAT"};

if(_class == 6) 	exitWith{"AT rocket"};
if(_class == 6.1) 	exitWith{"HEAT rocket"};
if(_class == 6.2) 	exitWith{"HE rocket"};

if(_class == 7) 	exitWith{"AT misile"};
if(_class == 7.1) 	exitWith{"HEAT misile"};
if(_class == 7.2) 	exitWith{"HE misile"};
if(_class == 7.3) 	exitWith{"AA misile"};

if(_class == 8) 	exitWith{"HE shell ~mortar"};
if(_class == 8.1)	exitWith{"HE shell ~artillery"};


if(_class == 9)   exitWith{"Bomb / high-explosive (~GBU / IED)"};
if(_class == 9.1) exitWith{"Flare"};
if(_class == 9.2) exitWith{"Projectile / shell containing smoke(s)"};
if(_class == 9.3) exitWith{"Projectile / shell containing mine(s)"};
if(_class == 9.4) exitWith{"Cluster shell"};
if(_class == 9.5) exitWith{"Shotgun pellets"};

"undefined ammoType"