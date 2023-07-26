[OVERRUN]
----comment by tally----

* you cannot have 2 distances for the same reaction, 
  making them surrender at 100 but fight at 50m will cause them to always surrender and vice versa, the solution is to have one distance
  for all courses of action.
  Then once within said distance the decision is made based on available data.

-----coment end-------


- Overrun cancels the following states:
---> Fleeing units
---> Fighting position

- Overrun has 3 reactions:
--> Fight (Aggressive push towards nearest known enemy)
--> Flee (Disables tgt and runs away from nearest enemy)
--> Surrender (Drops weapon & puts hands over head) 

- Each reaction has unique conditions: 
--> Fight conditions: 
       - Knowledge > 2
       - Distance < 50
       - Enemy Number < Friendly Number 
       - Has ammo & can move.

--> Flee conditions:  
      - Enemy Number > Friendly Number
      - > 50% Causalities /incapacitated 
      - No ammo
      - Knowledge > 2 
      - Can move.

--> Surrender conditions:
       - Distance < 100
       - Knowledge > 4
       - Enemy Numbers > Friendly Number
       - No ammo
       - Has injuries.

- Condition Modifiers:
--> Movement speed & posture modifies AI Kna check. 
--> Courage affects: 
       - Threat assessment
       - Friendly loss effect.

- Behavior actions: 

--> Fight behavior: 
    - Set CombatMode "Danger";
    - Movementspeed "FULL";
    - Set stance "up" 
    - DoMove towards nearest known enemy.
    - Enables "path"

--> Flee behavior:
    - Set Combatmode "Aware"(this is useless unless a new group is made)
    - Set stance "Up"
    - DisableAI "Autotarget"/"Target"/"suppression"
    - 30% chance of dropping weapons.

--> Surrender behavior:
    - Set Combatmode "careless"
    - Set side "civilian"
    - Drop all weapons and grenades
    - Play surrender animations
    - Add arrest option to action menu. 
    - Add execution option to action menu.

--> General:
    - Send status to GPT so it knows its status.