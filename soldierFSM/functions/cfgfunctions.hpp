class CfgFunctions
{
	class SFSM
	{
		class misc
		{
			class HandleSuppression 	{file = "\SoldierFSM\functions\misc\fn_HandleSuppression.sqf"};
			class TaskManager 			{file = "\SoldierFSM\functions\misc\fn_TaskManager.sqf"};
			class StoreSuppression		{file = "\SoldierFSM\functions\misc\fn_StoreSuppression.sqf"};
			class onSuppression			{file = "\SoldierFSM\functions\misc\fn_onSuppression.sqf"};
			class Roll					{file = "\SoldierFSM\functions\misc\fn_Roll.sqf"};
			class unitData				{file = "\SoldierFSM\functions\misc\fn_unitData.sqf"};
			class sinCosPos				{file = "\SoldierFSM\functions\misc\fn_sinCosPos.sqf"};
			
			class initReaction			{file = "\SoldierFSM\functions\misc\fn_initReaction.sqf"};
			class groupData				{file = "\SoldierFSM\functions\misc\fn_groupData.sqf"};
			class manAvailable          {file = "\SoldierFSM\functions\misc\fn_manAvailable.sqf"};
			class soundReaction         {file = "\SoldierFSM\functions\misc\fn_soundReaction.sqf"};
			class forceMoveToPos		{file = "\SoldierFSM\functions\misc\fn_forceMoveToPos.sqf"};
			class manLoaded             {file = "\SoldierFSM\functions\misc\fn_manLoaded.sqf"};
		};

		class projectileHandling
		{
			class reactToExplosion      {file = "\SoldierFSM\functions\projectileHandling\fn_reactToExplosion.sqf"};
			class addCrater             {file = "\SoldierFSM\functions\projectileHandling\fn_addCrater.sqf"};
			class handleBulletImpact    {file = "\SoldierFSM\functions\projectileHandling\fn_handleBulletImpact.sqf"};
			class handleExplosion       {file = "\SoldierFSM\functions\projectileHandling\fn_handleExplosion.sqf"};
		};

		class curator
		{
			class zWPplaced             {file = "\SoldierFSM\functions\curator\fn_zWPplaced.sqf"};
			class zWPdeleted            {file = "\SoldierFSM\functions\curator\fn_zWPdeleted.sqf"};
		};
		
		class eventHandlers
		{
			class SuppressedEH			{file = "\SoldierFSM\functions\eventHandlers\fn_SuppressedEH.sqf"};
			class hitEH					{file = "\SoldierFSM\functions\eventHandlers\fn_hitEH.sqf"};
			class firedEH				{file = "\SoldierFSM\functions\eventHandlers\fn_firedEH.sqf"};
			class endHealEH				{file = "\SoldierFSM\functions\eventHandlers\fn_endHealEH.sqf"};
			class curatorEH             {file = "\SoldierFSM\functions\eventHandlers\fn_curatorEH.sqf"};
			class spottedCustomEH		{file = "\SoldierFSM\functions\eventHandlers\fn_spottedCustomEH.sqf"};
			class enemySpotted          {file = "\SoldierFSM\functions\eventHandlers\fn_enemySpotted.sqf"};
			class unitKilled            {file = "\SoldierFSM\functions\eventHandlers\fn_unitKilled.sqf"};
			class unitCreated           {file = "\SoldierFSM\functions\eventHandlers\fn_unitCreated.sqf"};
			class projectileEH			{file = "\SoldierFSM\functions\eventHandlers\fn_projectileEH.sqf"};
			class explosionEH			{file = "\SoldierFSM\functions\eventHandlers\fn_explosionEH.sqf"};
			class bulletEH			    {file = "\SoldierFSM\functions\eventHandlers\fn_bulletEH.sqf"};
			class vehicleFiredEh        {file = "\SoldierFSM\functions\eventHandlers\fn_vehicleFiredEh.sqf"};
			class enemyDetected			{file = "\SoldierFSM\functions\eventHandlers\fn_enemyDetected.sqf"};
		};

		class dodging
		{
			class dodgeEnded			{file = "\SoldierFSM\functions\dodging\fn_dodgeEnded.sqf"};
			class EndDodge				{file = "\SoldierFSM\functions\dodging\fn_EndDodge.sqf"};
			class Dodge					{file = "\SoldierFSM\functions\dodging\fn_Dodge.sqf"};
			class GetDodgePos			{file = "\SoldierFSM\functions\dodging\fn_GetDodgePos.sqf"};
			class canDodge				{file = "\SoldierFSM\functions\dodging\fn_canDodge.sqf"};
			class getLateralPos			{file = "\SoldierFSM\functions\dodging\fn_getLateralPos.sqf"};
			class groupCanDodge         {file = "\SoldierFSM\functions\dodging\fn_groupCanDodge.sqf"};
			class forceCoverDodge       {file = "\SoldierFSM\functions\dodging\fn_forceCoverDodge.sqf"};
			
			
		};
		
		class flinching 
		{
			class canFlinch				{file = "\SoldierFSM\functions\flinching\fn_canFlinch.sqf"};
			class endFlinch				{file = "\SoldierFSM\functions\flinching\fn_endFlinch.sqf"};
			class flinch 				{file = "\SoldierFSM\functions\flinching\fn_flinch.sqf"};
			class bigBulletFlinch		{file = "\SoldierFSM\functions\flinching\fn_BigBulletFlinch.sqf"};
			class standardFlinch		{file = "\SoldierFSM\functions\flinching\fn_standardFlinch.sqf"};
			class execStandardFlinch	{file = "\SoldierFSM\functions\flinching\fn_execStandardFlinch.sqf"};
			class normalizeStance		{file = "\SoldierFSM\functions\flinching\fn_normalizeStance.sqf"};
			class bigFlinchCover        {file = "\SoldierFSM\functions\flinching\fn_bigFlinchCover.sqf"};
			
		};

		class reactiveFire
		{
			class canReactFire			{file = "\SoldierFSM\functions\reactiveFire\fn_canReactFire.sqf"};
			class reactFire				{file = "\SoldierFSM\functions\reactiveFire\fn_reactFire.sqf"};
			class endReactiveFire		{file = "\SoldierFSM\functions\reactiveFire\fn_endReactiveFire.sqf"};
			class directReactFire		{file = "\SoldierFSM\functions\reactiveFire\fn_directReactFire.sqf"};
			class unitTounitForcedFire	{file = "\SoldierFSM\functions\reactiveFire\fn_unitTounitForcedFire.sqf"};
			class unitAimedAtTarget		{file = "\SoldierFSM\functions\reactiveFire\fn_unitAimedAtTarget.sqf"};
			class unitWeaponDir			{file = "\SoldierFSM\functions\reactiveFire\fn_unitWeaponDir.sqf"};
			class multiplyReactionFire	{file = "\SoldierFSM\functions\reactiveFire\fn_multiplyReactionFire.sqf"};
		};

		class startEngagement
		{
			//cover-folder
			class getCoverPos            {file = "\SoldierFSM\functions\startEngagement\takeCover\fn_getCoverPos.sqf"};
			class fightInitCover		 {file = "\SoldierFSM\functions\startEngagement\takeCover\fn_fightInitCover.sqf"};
			class takeCover				 {file = "\SoldierFSM\functions\startEngagement\takeCover\fn_takeCover.sqf"};
			class endTakeCover        	 {file = "\SoldierFSM\functions\startEngagement\takeCover\fn_endTakeCover.sqf"};
			class selectCoverPos         {file = "\SoldierFSM\functions\startEngagement\takeCover\fn_selectCoverPos.sqf"};
			class postCoverActions       {file = "\SoldierFSM\functions\startEngagement\takeCover\fn_postCoverActions.sqf"};
			class initTakeCover          {file = "\SoldierFSM\functions\startEngagement\takeCover\fn_initTakeCover.sqf"};
			class stayInCover            {file = "\SoldierFSM\functions\startEngagement\takeCover\fn_stayInCover.sqf"};
			class endStayInCover         {file = "\SoldierFSM\functions\startEngagement\takeCover\fn_endStayInCover.sqf"};
			class eventTriggeredCover    {file = "\SoldierFSM\functions\startEngagement\takeCover\fn_eventTriggeredCover.sqf"};

			//hide-folder
			class findHidePos            {file = "\SoldierFSM\functions\startEngagement\hide\fn_findHidePos.sqf"};
			class hideFromVehicle        {file = "\SoldierFSM\functions\startEngagement\hide\fn_hideFromVehicle.sqf"};
			class initHideFromVeh        {file = "\SoldierFSM\functions\startEngagement\hide\fn_initHideFromVeh.sqf"};
			class moveToHidePos          {file = "\SoldierFSM\functions\startEngagement\hide\fn_moveToHidePos.sqf"};

			//this-folder
			class AtSpecialistInitFight  {file = "\SoldierFSM\functions\startEngagement\fn_AtSpecialistInitFight.sqf"};
			class targetInfWithLauncher  {file = "\SoldierFSM\functions\startEngagement\fn_targetInfWithLauncher.sqf"};
			class reactTovehicles        {file = "\SoldierFSM\functions\startEngagement\fn_reactTovehicles.sqf"};
			class unkillableEnemyVehicle {file = "\SoldierFSM\functions\startEngagement\fn_unkillableEnemyVehicle.sqf"};
			class eyelidTrench			 {file = "\SoldierFSM\functions\startEngagement\fn_eyelidTrench.sqf"};
			class getEnemyVehicles       {file = "\SoldierFSM\functions\startEngagement\fn_getEnemyVehicles.sqf"};
			class specialInitFightActions{file = "\SoldierFSM\functions\startEngagement\fn_specialInitFightActions.sqf"};
			class machineGunInitFight    {file = "\SoldierFSM\functions\startEngagement\fn_machineGunInitFight.sqf"};
			class supressPositions       {file = "\SoldierFSM\functions\startEngagement\fn_supressPositions.sqf"};
		}

		class init
		{
			class serverInit			{file = "\SoldierFSM\functions\init\fn_serverInit.sqf"};
			class initSettings			{file = "\SoldierFSM\functions\init\fn_initSettings.sqf"};
			class postConfig			{file = "\SoldierFSM\functions\init\fn_postConfig.sqf"};
			class initClient			{file = "\SoldierFSM\functions\init\fn_initClient.sqf"};
			class initSFSM				{file = "\SoldierFSM\functions\init\fn_initSFSM.sqf"; 		postInit = 1};
			class InitMan				{file = "\SoldierFSM\functions\init\fn_InitMan.sqf"};
			class initGroup             {file = "\SoldierFSM\functions\init\fn_initGroup.sqf"};
		};

		class debug
		{
			class 3dDebug				{file = "\SoldierFSM\functions\debug\fn_3dDebug.sqf"};
			class 3DdebugText			{file = "\SoldierFSM\functions\debug\fn_3DdebugText.sqf"};
			class actionColor			{file = "\SoldierFSM\functions\debug\fn_actionColor.sqf"};
			class drawObjectMarker      {file = "\SoldierFSM\functions\debug\fn_drawObjectMarker.sqf"};
			class multiple3dmarkers     {file = "\SoldierFSM\functions\debug\fn_multiple3dmarkers.sqf"};
			class battlefield3d			{file = "\SoldierFSM\functions\debug\fn_battlefield3d.sqf"};
			class man3dInfo             {file = "\SoldierFSM\functions\debug\fn_man3dInfo.sqf"};
			class debugMessage			{file = "\SoldierFSM\functions\debug\fn_debugMessage.sqf"};
			class hunkerObj3d			{file = "\SoldierFSM\functions\debug\fn_hunkerObj3d.sqf"};
			class manInfo               {file = "\SoldierFSM\functions\debug\fn_manInfo.sqf"};
			class logSettings           {file = "\SoldierFSM\functions\debug\fn_logSettings.sqf"};
			class deleteWarning         {file = "\SoldierFSM\functions\debug\fn_deleteWarning.sqf"};
		};
		
		class healing
		{
			class proneHeal				{file = "\SoldierFSM\functions\healing\fn_proneHeal.sqf"};
			class endSelfHeal			{file = "\SoldierFSM\functions\healing\fn_endSelfHeal.sqf"};
			class canSelfHeal			{file = "\SoldierFSM\functions\healing\fn_canSelfHeal.sqf"};
		};
		class battlefield
		{
			class InitBattlefield		  {file = "\SoldierFSM\functions\battlefield\fn_InitBattlefield.sqf"};
			class battlefieldPostInit	  {file = "\SoldierFSM\functions\battlefield\fn_battlefieldPostInit.sqf"};
			class battlefieldEnd		  {file = "\SoldierFSM\functions\battlefield\fn_battlefieldEnd.sqf"};
			class getZones				  {file = "\SoldierFSM\functions\battlefield\fn_getZones.sqf"};
			class getZone				  {file = "\SoldierFSM\functions\battlefield\fn_getZone.sqf"};
			class getCoverPositionsLight  {file = "\SoldierFSM\functions\battlefield\fn_getCoverPositionsLight.sqf"};
			class clusterCoverPosLight    {file = "\SoldierFSM\functions\battlefield\fn_clusterCoverPosLight.sqf"};
			class battlefieldRadius       {file = "\SoldierFSM\functions\battlefield\fn_battlefieldRadius.sqf"};
			class nearestBattle			  {file = "\SoldierFSM\functions\battlefield\fn_nearestBattle.sqf"};
			class battleInitType          {file = "\SoldierFSM\functions\battlefield\fn_battleInitType.sqf"};
			class battlefieldVariables    {file = "\SoldierFSM\functions\battlefield\fn_battlefieldVariables.sqf"};
			class updateBattlefield       {file = "\SoldierFSM\functions\battlefield\fn_updateBattlefield.sqf"};
			class sidesFromString         {file = "\SoldierFSM\functions\battlefield\fn_sidesFromString.sqf"};
			class battlingUnits           {file = "\SoldierFSM\functions\battlefield\fn_battlingUnits.sqf"};
			class battleEnded             {file = "\SoldierFSM\functions\battlefield\fn_battleEnded.sqf"};
			class battleFieldUpdater      {file = "\SoldierFSM\functions\battlefield\fn_battleFieldUpdater.sqf"};
			class triggerBattleOnShot	  {file = "\SoldierFSM\functions\battlefield\fn_triggerBattleOnShot.sqf"};
			class canTriggerBattleShot	  {file = "\SoldierFSM\functions\battlefield\fn_canTriggerBattleShot.sqf"};
			class canSpotInitBattle       {file = "\SoldierFSM\functions\battlefield\fn_canSpotInitBattle.sqf"};
			class excludeCpos  			  {file = "\SoldierFSM\functions\battlefield\fn_excludeCpos.sqf"};
			class getBattlefield		  {file = "\SoldierFSM\functions\battlefield\fn_getBattlefield.sqf"};
			class getEnemyPositions		  {file = "\SoldierFSM\functions\battlefield\fn_getEnemyPositions.sqf"};
			class updateHunkerObjects	  {file = "\SoldierFSM\functions\battlefield\fn_updateHunkerObjects.sqf"};
			class initGrid                {file = "\SoldierFSM\functions\battlefield\fn_initGrid.sqf"};
			class updateGrid              {file = "\SoldierFSM\functions\battlefield\fn_updateGrid.sqf"};
			class AddWeaponsToBattlefield {file = "\SoldierFSM\functions\battlefield\fn_AddWeaponsToBattlefield.sqf"};
			class emergencyRearm          {file = "\SoldierFSM\functions\battlefield\fn_emergencyRearm.sqf"};
			class getBattlefieldWeapon    {file = "\SoldierFSM\functions\battlefield\fn_getBattlefieldWeapon.sqf"};
			class pickUpWeapon            {file = "\SoldierFSM\functions\battlefield\fn_pickUpWeapon.sqf"};
			class canPickUpWeapon         {file = "\SoldierFSM\functions\battlefield\fn_canPickUpWeapon.sqf"};
			class endWeaponPickup         {file = "\SoldierFSM\functions\battlefield\fn_endWeaponPickup.sqf"};
			class useLightScan            {file = "\SoldierFSM\functions\battlefield\fn_useLightScan.sqf"};
		};
		
		class markers
		{
			class posMarker				{file = "\SoldierFSM\functions\markers\fn_posMarker.sqf"};
			class drawCircle			{file = "\SoldierFSM\functions\markers\fn_drawCircle.sqf"};
			class bfDebugMarkers		{file = "\SoldierFSM\functions\markers\fn_bfDebugMarkers.sqf"};
			class drawCoverPositions	{file = "\SoldierFSM\functions\markers\fn_drawCoverPositions.sqf"};
		};

		class objectData
		{
			class glRifle				{file = "\SoldierFSM\functions\objectData\fn_glRifle.sqf"};
			class ObjStance				{file = "\SoldierFSM\functions\objectData\fn_ObjStance.sqf"};
			class areaData				{file = "\SoldierFSM\functions\objectData\fn_areaData.sqf"};
			class getMapObjects			{file = "\SoldierFSM\functions\objectData\fn_getMapObjects.sqf"};
			class excludedMapObject		{file = "\SoldierFSM\functions\objectData\fn_excludedMapObject.sqf"};
			class filterMapObjects		{file = "\SoldierFSM\functions\objectData\fn_filterMapObjects.sqf"};
			class terrainObjData		{file = "\SoldierFSM\functions\objectData\fn_terrainObjData.sqf"};
			class squadAsset			{file = "\SoldierFSM\functions\objectData\fn_squadAsset.sqf"};
			class hasAmmoForWeapon      {file = "\SoldierFSM\functions\objectData\fn_hasAmmoForWeapon.sqf"};
		};
		class hunkerDown
		{
			class getHunkerObject		{file = "\SoldierFSM\functions\hunkerDown\fn_getHunkerObject.sqf"};
			class initHunker			{file = "\SoldierFSM\functions\hunkerDown\fn_initHunker.sqf"};
			class isHunkerObject        {file = "\SoldierFSM\functions\hunkerDown\fn_isHunkerObject.sqf"};
			class hunkAvailable			{file = "\SoldierFSM\functions\hunkerDown\fn_hunkAvailable.sqf"};
			class getAvHunkObject		{file = "\SoldierFSM\functions\hunkerDown\fn_getAvHunkObject.sqf"};
			class filterHunkerObjects	{file = "\SoldierFSM\functions\hunkerDown\fn_filterHunkerObjects.sqf"};
			class hunkObjHash	        {file = "\SoldierFSM\functions\hunkerDown\fn_hunkObjHash.sqf"};
			class hunkerFSM				{file = "\SoldierFSM\functions\hunkerDown\fn_hunkerFSM.sqf"};
			class hunkerFsmStatus		{file = "\SoldierFSM\functions\hunkerDown\fn_hunkerFsmStatus.sqf"};
			class addHunkerObjData		{file = "\SoldierFSM\functions\hunkerDown\fn_addHunkerObjData.sqf"};
			class setHobjPositions		{file = "\SoldierFSM\functions\hunkerDown\fn_setHobjPositions.sqf"};
			class moveToHunkerPos		{file = "\SoldierFSM\functions\hunkerDown\fn_moveToHunkerPos.sqf"};
			class endHunker				{file = "\SoldierFSM\functions\hunkerDown\fn_endHunker.sqf"};
			class initHunkerFSM			{file = "\SoldierFSM\functions\hunkerDown\fn_initHunkerFSM.sqf"};
			class handleHunkerStatus	{file = "\SoldierFSM\functions\hunkerDown\fn_handleHunkerStatus.sqf"};
			class randomHunkerInit		{file = "\SoldierFSM\functions\hunkerDown\fn_randomHunkerInit.sqf"};

		};
	};

	class Tcore
	{
		class core
		{
			
			
			class average				{file = "\SoldierFSM\functions\core\fn_average.sqf"};
			class decimals				{file = "\SoldierFSM\functions\core\fn_decimals.sqf"};
			class addZ					{file = "\SoldierFSM\functions\core\fn_addZ.sqf"};
			class roundPos				{file = "\SoldierFSM\functions\core\fn_roundPos.sqf"};
			class avgPos				{file = "\SoldierFSM\functions\core\fn_avgPos.sqf"};
			class get360Positions		{file = "\SoldierFSM\functions\core\fn_get360Positions.sqf"};
			class nearestPos			{file = "\SoldierFSM\functions\core\fn_nearestPos.sqf"};
			class getMidpoint           {file = "\SoldierFSM\functions\core\fn_getMidpoint.sqf"};
			class sinCosPos				{file = "\SoldierFSM\functions\core\fn_sinCosPos.sqf"};
			
			class formatDir 			{file = "\SoldierFSM\functions\core\fn_formatDir.sqf"};
			class avgRelDir				{file = "\SoldierFSM\functions\core\fn_avgRelDir.sqf"};
			class inDirRange 			{file = "\SoldierFSM\functions\core\fn_inDirRange.sqf"};
			
			class object3DShape			{file = "\SoldierFSM\functions\core\fn_object3DShape.sqf"};
			class objPosData			{file = "\SoldierFSM\functions\core\fn_objPosData.sqf"};
			class simpleObjectType		{file = "\SoldierFSM\functions\core\fn_simpleObjectType.sqf"};

			class clusterPos			{file = "\SoldierFSM\functions\core\fn_clusterPos.sqf"};
			class allClustersInRadius	{file = "\SoldierFSM\functions\core\fn_allClustersInRadius.sqf"};
			class ClusterTerrainObjects	{file = "\SoldierFSM\functions\core\fn_ClusterTerrainObjects.sqf"};
			class positionsClusterArr	{file = "\SoldierFSM\functions\core\fn_positionsClusterArr.sqf"};
			class clusterSize			{file = "\SoldierFSM\functions\core\fn_clusterSize.sqf"};
			class clusterMarker			{file = "\SoldierFSM\functions\core\fn_clusterMarker.sqf"};
			class ClusterSides			{file = "\SoldierFSM\functions\core\fn_ClusterSides.sqf"};
			
			class ClusterUnits			{file = "\SoldierFSM\functions\core\fn_ClusterUnits.sqf"};
			class ClusterVehicles		{file = "\SoldierFSM\functions\core\fn_ClusterVehicles.sqf"};
			class clusterGroups         {file = "\SoldierFSM\functions\core\fn_clusterGroups.sqf"};

			class unitCoverPosArr		{file = "\SoldierFSM\functions\core\fn_unitCoverPosArr.sqf"};
			class posCoverPosArr		{file = "\SoldierFSM\functions\core\fn_posCoverPosArr.sqf"};
			class coverPosStance		{file = "\SoldierFSM\functions\core\fn_coverPosStance.sqf"};
			class objCoverPosLight		{file = "\SoldierFSM\functions\core\fn_objCoverPosLight.sqf"};
			class coverPosSimple		{file = "\SoldierFSM\functions\core\fn_coverPosSimple.sqf"};
			class visibleFromPositions	{file = "\SoldierFSM\functions\core\fn_visibleFromPositions.sqf"};
			
			class debugMessage			{file = "\SoldierFSM\functions\core\fn_debugMessage.sqf"};
			class closestLocationName	{file = "\SoldierFSM\functions\core\fn_closestLocationName.sqf"};
			class getLocationNamePos	{file = "\SoldierFSM\functions\core\fn_getLocationNamePos.sqf"};
			
			class describeDir			{file = "\SoldierFSM\functions\core\fn_describeDir.sqf"};
			class describeDistance		{file = "\SoldierFSM\functions\core\fn_describeDistance.sqf"};
			class stringToVarName		{file = "\SoldierFSM\functions\core\fn_stringToVarName.sqf"};
			class areaName				{file = "\SoldierFSM\functions\core\fn_areaName.sqf"};			
			
			class toArrFromArr			{file = "\SoldierFSM\functions\core\fn_toArrFromArr.sqf"};
			
			class nearKnownEnemies      {file = "\SoldierFSM\functions\core\fn_nearKnownEnemies.sqf"};
			class knownDirToEnemy       {file = "\SoldierFSM\functions\core\fn_knownDirToEnemy.sqf"};
			class getLosTarget			{file = "\SoldierFSM\functions\core\fn_getLosTarget.sqf"};
			class deadCrew				{file = "\SoldierFSM\functions\core\fn_deadCrew.sqf"};
			class grid100Pos            {file = "\SoldierFSM\functions\core\fn_grid100Pos.sqf"};
			class substringsPresent     {file = "\SoldierFSM\functions\core\fn_substringsPresent.sqf"};
			class playerLedGrp          {file = "\SoldierFSM\functions\core\fn_playerLedGrp.sqf"};
			class isPlayer				{file = "\SoldierFSM\functions\core\fn_isPlayer.sqf"};

			class toggleAiMoveInhibitors{file = "\SoldierFSM\functions\core\fn_toggleAiMoveInhibitors.sqf"};
			class deadMenInArea         {file = "\SoldierFSM\functions\core\fn_deadMenInArea.sqf"};
			class nearSoldiers          {file = "\SoldierFSM\functions\core\fn_nearSoldiers.sqf"};
		};
	};
};