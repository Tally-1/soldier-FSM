
[FIGHTING POSITION]
<!-- * Description:
  - Allow AI to snap into "Fighting positions" that enables AI groups to gain realistic advantages of using entrenched positions in combat. -->

<!-- ** Activation 
  - a logic is placed in editor with the "FiPo" in the name.
  - if an ai is synced to the logic he will snap into it on mission-start -->

  <!-- - if the position is available and within "dodging-distance" of squad-leader he will move close and snap into position
    the same way he would on a turret. -->

- If a player is within param distance AI will not teleport into position.



2
*** Behaviour:
  - Ai "scans" his surroundings by poping his head out of cover.
  <!-- - Path is disabeled while in FIPO -->
  <!-- - No other actions are executed while holding a fighting position. -->
  <!-- - If SL is outside "dodging-distance" of the FIPO, ai detaches and re-groups. -->
  - If in combat the soldier stay prone or crouched.
  - If NOT in combat, the soldier will play idle animations.
  <!-- - If suppression == 0: -->
  
    <!-- 1) peek-coolDown = 5 -> 15 seconds
    2) peeking time = 1 -> 2 seconds (based on ai`s skill-level)

  - If suppression > 0 && <= 0.5:
    1) peeking time = 0.5 -> 1 seconds (based on ai`s general skill-level see below) -->

<!-- - if suppression > 0.5 while peeking the soldier aborts the peeking. -->

<!-- - General skill modifier on timings:
- Experienced units will peek more often, but do shorter pops:

0.5 = Default value. 
1 = Double peek speed and and half cooldown time.
0 = Half the peek speed and twice the cooldown time. -->


**** Engaging enemies
- If the unit gains LOS && suppression == 0:
  1) 1 second is added to the peek time.
  2) Soldier shoots at target.

- If a target is known, but no LOS gained:
  1) Supressive fire towards enemy position.

***** OverRun (see Overrun.md)